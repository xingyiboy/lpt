/*
 * @Date: 2025-03-16 16:12:47
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-17 19:21:37
 * @FilePath: \react-ui\src\pages\User\Login\index.tsx
 */
import Footer from '@/components/Footer';
import { login } from '@/services/system/auth';
import { getFakeCaptcha } from '@/services/ant-design-pro/login';
import {
  AlipayCircleOutlined,
  LockOutlined,
  MobileOutlined,
  TaobaoCircleOutlined,
  UserOutlined,
  WeiboCircleOutlined,
} from '@ant-design/icons';
import {
  LoginForm,
  ProFormCaptcha,
  ProFormCheckbox,
  ProFormText,
} from '@ant-design/pro-components';
import { useEmotionCss } from '@ant-design/use-emotion-css';
import { FormattedMessage, history, SelectLang, useIntl, useModel, Helmet } from '@umijs/max';
import { Alert, Col, message, Row, Tabs, Image, Button, Modal } from 'antd';
import Settings from '../../../../config/defaultSettings';
import React, { useEffect, useState, useRef, useCallback } from 'react';
import { flushSync } from 'react-dom';
import { clearSessionToken, setSessionToken } from '@/access';
import ImageInputValidation from './components/ImageInputValidation';
import MailboxValidation from './components/MailboxValidation';

const ActionIcons = () => {
  const langClassName = useEmotionCss(({ token }) => {
    return {
      marginLeft: '8px',
      color: 'rgba(0, 0, 0, 0.2)',
      fontSize: '24px',
      verticalAlign: 'middle',
      cursor: 'pointer',
      transition: 'color 0.3s',
      '&:hover': {
        color: token.colorPrimaryActive,
      },
    };
  });

  return (
    <>
      <AlipayCircleOutlined key="AlipayCircleOutlined" className={langClassName} />
      <TaobaoCircleOutlined key="TaobaoCircleOutlined" className={langClassName} />
      <WeiboCircleOutlined key="WeiboCircleOutlined" className={langClassName} />
    </>
  );
};

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
  const [codeImgData, setCodeImgData] = useState('');
  const [loading, setLoading] = useState(false);
  const [open, setOpen] = useState(false);
  const [userLoginState, setUserLoginState] = useState<API.LoginResult>({ code: 200 });
  const [type, setType] = useState<string>('account');
  const { initialState, setInitialState } = useModel('@@initialState');
  const [captchaInput, setCaptchaInput] = useState('');
  const [showImageInputValidation, setShowImageInputValidation] = useState(false);
  const [showMailboxValidation, setShowMailboxValidation] = useState(false);

  // 使用 useRef 替代 useState 来存储最新值
  const loginValuesRef = useRef<API.LoginParams>();

  //处理下一步操作
  const handleSubmitCaptcha = async (step: string, values?: API.LoginParams = null) => {
    setUserLoginState({ code: 200 });
    showModal();
    const currentValues = values || loginValuesRef.current;
    if (currentValues == null) {
      return;
    }
    console.log(step);
    switch (step) {
      case '1':
        //执行字符校验

        message.success('验证成功，开始字符校验');
        getCodeDataAndVerify(currentValues);
        setShowImageInputValidation(true);
        break;
      case '2':
        //执行数字计算校验
        message.success('验证成功，开始数字校验');
        getCodeDataAndVerify(currentValues);
        setShowImageInputValidation(true);
        break;
      case '3':
        //执行邮箱校验
        message.success('验证成功，开始邮箱校验');
        getCodeDataAndVerify(currentValues);
        setShowMailboxValidation(true);
        break;
      default:
        //错误重新获取验证码不能进行下一步
        message.error(response.data);
        getCodeDataAndVerify(currentValues);
        break;
    }
  };

  //处理点击校验
  const handleSubmitVarify = useCallback(() => {
    getCodeDataAndVerify(null, true);
  }, [captchaInput]);
  //处理点击验证码
  const handleClickVarify = useCallback(() => {
    getCodeDataAndVerify();
  }, [captchaInput]);

  //获取验证码/校验验证码
  const getCodeDataAndVerify = useCallback(
    async (values?: API.LoginParams, isVerify) => {
      if (isVerify == true) {
        //校验
        const currentValues = values || loginValuesRef.current;
        if (currentValues == null) {
          return;
        }
        const response = await login({ ...loginValuesRef.current, code: captchaInput });
        if (response.code === 200) {
          //执行下一步操作
          if (response.data != '验证码错误') {
            handleSubmitCaptcha(response.data);
          } else {
            message.error(response.data);
            getCodeDataAndVerify();
          }
        } else {
          console.log(1111111);
          clearSessionToken();
          // 如果失败去设置用户错误信息
          setUserLoginState({ ...response, type });
        }
      } else {
        console.log(3333);
        //获取验证码
        try {
          // 优先使用传入值，没有则使用存储的值
          const currentValues = values || loginValuesRef.current;
          if (!currentValues) {
            message.error('请先填写登录信息');
            return;
          }

          const response = await login({ ...currentValues });
          if (response.code === 200) {
            setCodeImgData(response.data);
            // 存储到 ref
            loginValuesRef.current = currentValues;
          }
        } catch (error) {
          message.error('获取验证码失败');
        }
      }
    },
    [captchaInput],
  );

  const showModal = () => {
    setOpen(true);
  };

  const handleOk = () => {
    setLoading(true);
  };

  const handleCancel = () => {
    setOpen(false);
  };

  const containerClassName = useEmotionCss(() => {
    return {
      display: 'flex',
      flexDirection: 'column',
      height: '100vh',
      overflow: 'auto',
      backgroundImage:
        "url('https://mdn.alipayobjects.com/yuyan_qk0oxh/afts/img/V-_oS6r-i7wAAAAAAAAAAAAAFl94AQBr')",
      backgroundSize: '100% 100%',
    };
  });

  const intl = useIntl();

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

  const handleSubmit = async (values: API.LoginParams) => {
    try {
      // 登录
      const response = await login({ ...values, step: 0 });

      if (response.code === 200) {
        handleSubmitCaptcha(response.data, values);
      } else {
        console.log(response.msg);
        clearSessionToken();
        // 如果失败去设置用户错误信息
        setUserLoginState({ ...response, type });
      }
    } catch (error) {
      const defaultLoginFailureMessage = intl.formatMessage({
        id: 'pages.login.failure',
        defaultMessage: '登录失败，请重试！',
      });
      console.log(error);
      message.error(defaultLoginFailureMessage);
    }
  };
  const { code } = userLoginState;
  const loginType = type;

  useEffect(() => {}, []);

  return (
    <div className={containerClassName}>
      <Helmet>
        <title>
          {intl.formatMessage({
            id: 'menu.login',
            defaultMessage: '登录页',
          })}
          - {Settings.title}
        </title>
      </Helmet>
      <Lang />
      <div
        style={{
          flex: '1',
          padding: '32px 0',
        }}
      >
        <LoginForm
          contentStyle={{
            minWidth: 280,
            maxWidth: '75vw',
          }}
          logo={<img alt="logo" src="/logo.svg" />}
          title="Ant Design"
          subTitle={intl.formatMessage({ id: 'pages.layouts.userLayout.title' })}
          initialValues={{
            autoLogin: true,
          }}
          actions={[
            <FormattedMessage
              key="loginWith"
              id="pages.login.loginWith"
              defaultMessage="其他登录方式"
            />,
            <ActionIcons key="icons" />,
          ]}
          onFinish={async (values) => {
            await handleSubmit(values as API.LoginParams);
          }}
        >
          <Tabs
            activeKey={type}
            onChange={setType}
            centered
            items={[
              {
                key: 'account',
                label: intl.formatMessage({
                  id: 'pages.login.accountLogin.tab',
                  defaultMessage: '账户密码登录',
                }),
              },
              {
                key: 'mobile',
                label: intl.formatMessage({
                  id: 'pages.login.phoneLogin.tab',
                  defaultMessage: '手机号登录',
                }),
              },
            ]}
          />

          {code !== 200 && loginType === 'account' && (
            <LoginMessage
              content={intl.formatMessage({
                id: 'pages.login.accountLogin.errorMessage',
                defaultMessage: '账户或密码错误(admin/admin123)',
              })}
            />
          )}
          {type === 'account' && (
            <>
              <ProFormText
                name="username"
                initialValue="admin"
                fieldProps={{
                  size: 'large',
                  prefix: <UserOutlined />,
                }}
                placeholder={intl.formatMessage({
                  id: 'pages.login.username.placeholder',
                  defaultMessage: '用户名: admin',
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
                initialValue="admin123"
                fieldProps={{
                  size: 'large',
                  prefix: <LockOutlined />,
                }}
                placeholder={intl.formatMessage({
                  id: 'pages.login.password.placeholder',
                  defaultMessage: '密码: admin123',
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
            </>
          )}

          {code !== 200 && loginType === 'mobile' && <LoginMessage content="验证码错误" />}
          {type === 'mobile' && (
            <>
              <ProFormText
                fieldProps={{
                  size: 'large',
                  prefix: <MobileOutlined />,
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
                  prefix: <LockOutlined />,
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
                  message.success('获取验证码成功！验证码为：1234');
                }}
              />
            </>
          )}
          <div
            style={{
              marginBottom: 24,
            }}
          >
            <ProFormCheckbox noStyle name="autoLogin">
              <FormattedMessage id="pages.login.rememberMe" defaultMessage="自动登录" />
            </ProFormCheckbox>
            <a
              style={{
                float: 'right',
              }}
            >
              <FormattedMessage id="pages.login.forgotPassword" defaultMessage="忘记密码" />
            </a>
          </div>
        </LoginForm>
      </div>
      <Modal
        open={open}
        title="安全校验"
        width={400}
        onCancel={handleCancel}
        destroyOnClose
        footer={[
          <Button key="back" onClick={handleCancel}>
            取消
          </Button>,
          <Button key="submit" type="primary" loading={loading} onClick={handleSubmitVarify}>
            提交验证
          </Button>,
        ]}
      >
        {showImageInputValidation && (
          <ImageInputValidation
            codeImgData={codeImgData}
            handleClickVarify={handleClickVarify}
            captchaInput={captchaInput}
            setCaptchaInput={setCaptchaInput}
          />
        )}
        {showMailboxValidation && (
          <MailboxValidation
            mail={codeImgData}
            handleClickVarify={handleClickVarify}
            captchaInput={captchaInput}
            setCaptchaInput={setCaptchaInput}
          />
        )}
      </Modal>
      <Footer />
    </div>
  );
};

export default Login;
