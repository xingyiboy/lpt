import { clearSessionToken, setSessionToken } from '@/access';
import Footer from '@/components/Footer';
import { getFakeCaptcha } from '@/services/ant-design-pro/login';
import { getCaptchaImg, login, register } from '@/services/system/auth';
import { LockOutlined, MobileOutlined, UserOutlined } from '@ant-design/icons';
import { LoginForm, ProFormCaptcha, ProFormText } from '@ant-design/pro-components';
import { useEmotionCss } from '@ant-design/use-emotion-css';
import { FormattedMessage, history, SelectLang, useIntl, useModel } from '@umijs/max';
import { Alert, Checkbox, Col, Form, Image, message, Row, Tabs } from 'antd';

import { decrypt, encrypt } from '@/utils/crypto';
import React, { useEffect, useState } from 'react';
import { flushSync } from 'react-dom';

const Lang = () => {
  const langClassName = useEmotionCss(({ token }) => {
    return {
      width: 42,
      height: 42,
      lineHeight: '42px',
      position: 'fixed',
      right: 16,
      borderRadius: token.borderRadius,
      ':hover': {
        backgroundColor: token.colorBgTextHover,
      },
    };
  });

  return (
    <div className={langClassName} data-lang>
      {SelectLang && <SelectLang />}
    </div>
  );
};

const LoginMessage: React.FC<{
  content: string;
}> = ({ content }) => {
  return (
    <Alert
      style={{
        marginBottom: 24,
      }}
      message={content}
      type="error"
      showIcon
    />
  );
};

const Login: React.FC = () => {
  const [userLoginState, setUserLoginState] = useState<API.LoginResult>({ code: 200 });
  const [type, setType] = useState<string>('account');
  const [isRegister, setIsRegister] = useState<boolean>(false);
  const { initialState, setInitialState } = useModel('@@initialState');
  const [captchaCode, setCaptchaCode] = useState<string>('');
  const [uuid, setUuid] = useState<string>('');
  const [form] = Form.useForm(); // 添加这行来创建表单实例
  const [rememberMe, setRememberMe] = useState<boolean>(true);

  const containerClassName = useEmotionCss(() => {
    return {
      display: 'flex',
      flexDirection: 'column',
      height: '100vh',
      overflow: 'auto',
      background: 'linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%)',
      backgroundSize: 'cover',
      justifyContent: 'center',
      alignItems: 'center',
    };
  });

  const intl = useIntl();

  const getCaptchaCode = async () => {
    const response = await getCaptchaImg();
    const imgdata = `data:image/png;base64,${response.img}`;
    setCaptchaCode(imgdata);
    setUuid(response.uuid);
  };

  const fetchUserInfo = async () => {
    const userInfo = await initialState?.fetchUserInfo?.();
    if (userInfo) {
      flushSync(() => {
        setInitialState((s) => ({
          ...s,
          currentUser: userInfo,
        }));
      });
    }
  };

  // 在组件加载时获取存储的账号密码
  useEffect(() => {
    const savedUsername = localStorage.getItem('rememberedUsername');
    const savedPassword = localStorage.getItem('rememberedPassword');

    if (savedUsername && savedPassword) {
      try {
        const decryptedUsername = decrypt(savedUsername);
        const decryptedPassword = decrypt(savedPassword);
        form.setFieldsValue({
          username: decryptedUsername,
          password: decryptedPassword,
        });
        setRememberMe(true);
      } catch (error) {
        console.error('解密失败:', error);
        localStorage.removeItem('rememberedUsername');
        localStorage.removeItem('rememberedPassword');
      }
    }
  }, []);

  const handleSubmit = async (values: API.LoginParams) => {
    try {
      const response = await (isRegister ? register : login)({ ...values, uuid });
      if (response.code === 200) {
        const defaultSuccessMessage = intl.formatMessage({
          id: isRegister ? 'pages.register.success' : 'pages.login.success',
          defaultMessage: isRegister ? '注册成功！' : '登录成功！',
        });
        message.success(defaultSuccessMessage);

        if (isRegister) {
          getCaptchaCode();
          setIsRegister(false);
          return;
        }

        const current = new Date();
        const expireTime = current.setTime(current.getTime() + 1000 * 12 * 60 * 60);
        setSessionToken(response.data?.access_token, response.data?.access_token, expireTime);
        await fetchUserInfo();
        const urlParams = new URL(window.location.href).searchParams;
        history.push(urlParams.get('redirect') || '/');

        // 如果选择记住密码，则加密存储
        if (rememberMe) {
          localStorage.setItem('rememberedUsername', encrypt(values.username));
          localStorage.setItem('rememberedPassword', encrypt(values.password));
        } else {
          // 如果取消记住密码，则清除存储
          localStorage.removeItem('rememberedUsername');
          localStorage.removeItem('rememberedPassword');
        }
        return;
      } else {
        console.log('登录失败:', response.msg);
        clearSessionToken();
        setUserLoginState({
          code: response.code,
          msg: response.msg,
          type,
        });
        getCaptchaCode();
      }
    } catch (error) {
      const defaultFailureMessage = intl.formatMessage({
        id: isRegister ? 'pages.register.failure' : 'pages.login.failure',
        defaultMessage: isRegister ? '注册失败，请重试！' : '登录失败，请重试！',
      });
      console.log(error);
      message.error(defaultFailureMessage);
    }
  };
  const { code } = userLoginState;
  const loginType = type;

  useEffect(() => {
    getCaptchaCode();
  }, []);

  // 替换原有的自动登录复选框
  const renderRememberPassword = () => (
    <div style={{ marginBottom: 24 }}>
      <Checkbox
        checked={rememberMe}
        onChange={(e) => {
          setRememberMe(e.target.checked);
          if (!e.target.checked) {
            localStorage.removeItem('rememberedUsername');
            localStorage.removeItem('rememberedPassword');
          }
        }}
      >
        记住账号密码
      </Checkbox>
      <a
        style={{
          float: 'right',
        }}
        onClick={() => setIsRegister(!isRegister)}
      >
        {isRegister ? '已有账号？去登录' : '没有账号？去注册'}
      </a>
    </div>
  );

  return (
    <div className={containerClassName}>
      <Lang />
      <div
        style={{
          flex: '1',
          padding: '32px 0',
          display: 'flex',
          justifyContent: 'center',
          alignItems: 'center',
          width: '100%',
        }}
      >
        <LoginForm
          contentStyle={{
            minWidth: 400,
            maxWidth: '90vw',
            background: '#ffffff',
            padding: '40px',
            borderRadius: '8px',
            boxShadow: '0 4px 12px rgba(0, 0, 0, 0.1)',
          }}
          logo={<img alt="logo" src="/favicon.ico" style={{ transform: 'scale(1.5)' }} />}
          title="令牌通"
          subTitle={intl.formatMessage({ id: 'pages.layouts.userLayout.title' })}
          initialValues={{
            autoLogin: true,
          }}
          submitter={{
            searchConfig: {
              submitText: isRegister ? '注册' : '登录',
            },
            submitButtonProps: {
              block: true,
              size: 'large',
              style: {
                background: '#1890ff',
                borderColor: '#1890ff',
              },
            },
          }}
          onFinish={async (values) => {
            await handleSubmit(values as API.LoginParams);
          }}
          form={form}
        >
          <Tabs
            activeKey={type}
            onChange={setType}
            centered
            items={[
              {
                key: 'account',
                label: isRegister ? '账户注册' : '账户密码登录',
              },
              ...(!isRegister ? [] : []),
            ]}
          />

          {code !== 200 && loginType === 'account' && (
            <LoginMessage
              content={
                userLoginState.msg ||
                intl.formatMessage({
                  id: 'pages.login.accountLogin.errorMessage',
                  defaultMessage: '账户或密码错误',
                })
              }
            />
          )}
          {type === 'account' && (
            <>
              <ProFormText
                name="username"
                initialValue=""
                fieldProps={{
                  size: 'large',
                  prefix: <UserOutlined style={{ color: '#1890ff' }} />,
                }}
                placeholder={intl.formatMessage({
                  id: 'pages.login.username.placeholder',
                  defaultMessage: '用户名: ',
                })}
                rules={[
                  {
                    required: true,
                    message: (
                      <FormattedMessage
                        id="pages.login.username.required"
                        defaultMessage="请输入用户名!"
                      />
                    ),
                  },
                ]}
              />
              <ProFormText.Password
                name="password"
                initialValue=""
                fieldProps={{
                  size: 'large',
                  prefix: <LockOutlined style={{ color: '#1890ff' }} />,
                }}
                placeholder={intl.formatMessage({
                  id: 'pages.login.password.placeholder',
                  defaultMessage: '密码: ',
                })}
                rules={[
                  {
                    required: true,
                    message: (
                      <FormattedMessage
                        id="pages.login.password.required"
                        defaultMessage="请输入密码！"
                      />
                    ),
                  },
                ]}
              />
              <Row>
                <Col flex={3}>
                  <ProFormText
                    style={{
                      float: 'right',
                    }}
                    name="code"
                    placeholder={intl.formatMessage({
                      id: 'pages.login.captcha.placeholder',
                      defaultMessage: '请输入验证',
                    })}
                    rules={[
                      {
                        required: true,
                        message: (
                          <FormattedMessage
                            id="pages.searchTable.updateForm.ruleName.nameRules"
                            defaultMessage="请输入验证啊"
                          />
                        ),
                      },
                    ]}
                  />
                </Col>
                <Col flex={2}>
                  <Image
                    src={captchaCode}
                    alt="验证码"
                    style={{
                      display: 'inline-block',
                      verticalAlign: 'top',
                      cursor: 'pointer',
                      paddingLeft: '10px',
                      width: '100px',
                    }}
                    preview={false}
                    onClick={() => getCaptchaCode()}
                  />
                </Col>
              </Row>
            </>
          )}

          {code !== 200 && loginType === 'mobile' && <LoginMessage content="验证码错误" />}
          {type === 'mobile' && (
            <>
              <ProFormText
                fieldProps={{
                  size: 'large',
                  prefix: <MobileOutlined style={{ color: '#1890ff' }} />,
                }}
                name="mobile"
                placeholder={intl.formatMessage({
                  id: 'pages.login.phoneNumber.placeholder',
                  defaultMessage: '手机号',
                })}
                rules={[
                  {
                    required: true,
                    message: (
                      <FormattedMessage
                        id="pages.login.phoneNumber.required"
                        defaultMessage="请输入手机号！"
                      />
                    ),
                  },
                  {
                    pattern: /^1\d{10}$/,
                    message: (
                      <FormattedMessage
                        id="pages.login.phoneNumber.invalid"
                        defaultMessage="手机号格式错误！"
                      />
                    ),
                  },
                ]}
              />
              <ProFormCaptcha
                fieldProps={{
                  size: 'large',
                  prefix: <LockOutlined style={{ color: '#1890ff' }} />,
                }}
                captchaProps={{
                  size: 'large',
                }}
                placeholder={intl.formatMessage({
                  id: 'pages.login.captcha.placeholder',
                  defaultMessage: '请输入验证码',
                })}
                captchaTextRender={(timing, count) => {
                  if (timing) {
                    return `${count} ${intl.formatMessage({
                      id: 'pages.getCaptchaSecondText',
                      defaultMessage: '获取验证码',
                    })}`;
                  }
                  return intl.formatMessage({
                    id: 'pages.login.phoneLogin.getVerificationCode',
                    defaultMessage: '获取验证码',
                  });
                }}
                name="captcha"
                rules={[
                  {
                    required: true,
                    message: (
                      <FormattedMessage
                        id="pages.login.captcha.required"
                        defaultMessage="请输入验证码！"
                      />
                    ),
                  },
                ]}
                onGetCaptcha={async (phone) => {
                  const result = await getFakeCaptcha({
                    phone,
                  });
                  if (!result) {
                    return;
                  }
                  message.error('暂未开发该功能');
                }}
              />
            </>
          )}
          {renderRememberPassword()}
        </LoginForm>
      </div>
      <Footer />
    </div>
  );
};

export default Login;
