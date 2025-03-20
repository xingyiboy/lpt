/*
 * @Date: 2025-03-16 16:12:47
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-20 16:49:08
 * @FilePath: \react-ui\src\pages\User\Login\index.tsx
 */
import Footer from '@/components/Footer';
import { login, register } from '@/services/system/auth';
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
import React, { useEffect, useState, useRef, useCallback, useMemo } from 'react';
import { flushSync } from 'react-dom';
import { clearSessionToken, setSessionToken } from '@/access';
import ImageInputValidation from './components/ImageInputValidation';
import MailboxValidation from './components/MailboxValidation';
import CaptchaModal from './components/CaptchaModal';
import load from './components/load.min.js';

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

  const [submitting, setSubmitting] = useState(false);

  // 字符，数字 校验 对话框
  const [showImageInputValidation, setShowImageInputValidation] = useState(false);
  // 邮箱校验 对话框
  const [showMailboxValidation, setShowMailboxValidation] = useState(false);
  //滑动、旋转、滑动还原、文字点选校验 对话框
  const [showBehaviorValidation, setShowBehaviorValidation] = useState(false);

  const [isRegister, setIsRegister] = useState(false);

  // 使用 useRef 替代 useState 来存储最新值
  const loginValuesRef = useRef<API.LoginParams>();

  const uuid = useRef<String>();

  //关闭全部校验 对话框
  const closeAllValidation = () => {
    setShowImageInputValidation(false);
    setShowMailboxValidation(false);
    setShowBehaviorValidation(false);
  };

  useEffect(() => {
    const script = document.createElement('script');
    script.src = load;
    script.async = true;
    script.onload = () => {
      // 加载完成后执行的初始化函数
      if (window.initLoadFunction) {
        window.initLoadFunction(); // 假设该脚本中有一个全局初始化函数
      }
    };
    document.body.appendChild(script);

    // Clean up: 组件卸载时移除脚本
    return () => {
      document.body.removeChild(script);
    };
  }, []); // 空依赖数组，确保只加载一次

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
        getCodeDataAndVerify(currentValues, false, '1');
        break;
      case '2':
        //执行数字计算校验
        message.success('验证成功，开始数字校验');
        getCodeDataAndVerify(currentValues, false, '2');
        break;
      case '3':
        //执行邮箱校验
        message.success('验证成功，开始邮箱校验');
        getCodeDataAndVerify(currentValues, false, '3');
        break;
      case '4':
        //执行滑动操作
        message.success('验证成功，开始滑动验证');
        getCodeDataAndVerify(currentValues, false, '4');
      default:
        //错误重新获取验证码不能进行下一步
        getCodeDataAndVerify(currentValues);
        break;
    }
  };

  //处理点击提交
  const handleSubmitVarify = useCallback(async () => {
    await getCodeDataAndVerify(null, true);
  }, [captchaInput]);

  //处理点击验证码
  const handleClickVarify = useCallback(() => {
    if (submitting) {
      return;
    }
    getCodeDataAndVerify();
  }, [captchaInput, submitting]);

  //获取验证码/校验验证码
  const getCodeDataAndVerify = useCallback(
    async (values?: API.LoginParams, isVerify = false, Step = '') => {
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
          clearSessionToken();
          // 如果失败去设置用户错误信息
          setUserLoginState({ ...response, type });
        }
      } else {
        //获取验证码
        try {
          // 优先使用传入值，没有则使用存储的值
          const currentValues = values || loginValuesRef.current;
          if (!currentValues) {
            message.error('请先填写登录信息');
            return;
          }
          setSubmitting(true);
          const response = await login({ ...currentValues });

          if (response.code === 200) {
            setCodeImgData(response.data);
            switch (Step) {
              case '1':
                //执行字符校验
                closeAllValidation();
                setShowImageInputValidation(true);
                break;
              case '2':
                //执行数字计算校验
                closeAllValidation();
                setShowImageInputValidation(true);
                break;
              case '3':
                //执行邮箱校验
                closeAllValidation();
                setShowMailboxValidation(true);
                break;
              case '4':
                //执行滑动校验
                closeAllValidation();
                setShowBehaviorValidation(true);
                break;
              default:
                break;
            }
            setSubmitting(false);
            // 存储到 ref
            loginValuesRef.current = currentValues;
          }
          //滑动校验复位
          if (response.id != null) {
            closeAllValidation();
            setShowBehaviorValidation(true);
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
      const apiMethod = isRegister ? register : login;
      const response = await apiMethod({ ...values, step: 0 });

      if (response.code === 200) {
        if (isRegister) {
          //注册
          message.success('注册成功，请登录');
          setIsRegister(false);
          return;
        }
        //登录
        uuid.current = response.data.uuid;
        handleSubmitCaptcha(response.data.step, values);
      } else {
        clearSessionToken();
        setUserLoginState({ ...response, type });
      }
    } catch (error) {
      message.error(isRegister ? '注册失败，请重试！' : '登录失败，请重试！');
    }
  };

  // 行为验证成功回调
  const handleCaptchaSuccess = (Step: string) => {
    switch (Step) {
      case '4':
        closeAllValidation();
        setShowBehaviorValidation(true);
        message.success('验证成功，开始滑动验证');
        break;
      case '5':
        //执行行为校验
        closeAllValidation();
        setShowBehaviorValidation(true);
        message.success('验证成功，开始滑动验证');
        break;
      case '6':
        //执行行为校验
        closeAllValidation();
        setShowBehaviorValidation(true);
        message.success('验证成功，开始滑动验证');
        break;
      case '7':
        //执行行为校验
        closeAllValidation();
        setShowBehaviorValidation(true);
        message.success('验证成功，开始滑动验证');
        break;
      default:
        //完成登录
        const defaultLoginSuccessMessage = intl.formatMessage({
          id: 'pages.login.success',
          defaultMessage: '登录成功！',
        });
        if(Step == null){
          message.error('错误！请重新登录');
        }
        
        const current = new Date();
        const expireTime = current.setTime(current.getTime() + 1000 * 12 * 60 * 60);
        setSessionToken(Step, Step, expireTime);
        message.success(defaultLoginSuccessMessage);
        fetchUserInfo();
        const urlParams = new URL(window.location.href).searchParams;
        history.push(urlParams.get('redirect') || '/');
        return;
        break;
    }
  };

  const { code } = userLoginState;
  const loginType = type;

  const modalFooter = useMemo(() => {
    // 当显示验证码弹窗时隐藏底部按钮
    return showBehaviorValidation
      ? null
      : [
          <Button key="back" onClick={handleCancel} disabled={submitting}>
            取消
          </Button>,
          <Button
            key="submit"
            type="primary"
            loading={submitting}
            disabled={submitting}
            onClick={handleSubmitVarify}
          >
            {submitting ? '请等待...' : '提交验证'}
          </Button>,
        ];
  }, [submitting, handleCancel, handleSubmitVarify, showBehaviorValidation]); // 当showBehaviorValidation时关闭底部按钮

  // 修改注册状态切换逻辑
  const toggleRegister = () => {
    setIsRegister(!isRegister);
    setType('account'); // 强制切换到账户密码登录
  };

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
            },
          }}
          onFinish={async (values) => {
            await handleSubmit(values as API.LoginParams);
          }}
        >
          <Tabs
            activeKey={type}
            onChange={(key) => {
              if (isRegister) {
                // 注册模式下禁止切换tab
                message.info('注册请使用账户密码方式');
                return;
              }
              setType(key);
            }}
            centered
            items={[
              {
                key: 'account',
                label: intl.formatMessage({
                  id: isRegister
                    ? 'pages.register.accountLogin.tab'
                    : 'pages.login.accountLogin.tab',
                  defaultMessage: isRegister ? '账户注册' : '账户密码登录', // 根据状态修改标签
                }),
              },
              {
                key: 'mobile',
                label: intl.formatMessage({
                  id: 'pages.login.phoneLogin.tab',
                  defaultMessage: '手机号登录',
                }),
                disabled: isRegister, // 注册时禁用手机登录
              },
            ]}
          />

          {code !== 200 && loginType === 'account' && (
            <LoginMessage
              content={intl.formatMessage({
                id: 'pages.login.accountLogin.errorMessage',
                defaultMessage: '账户或密码错误',
              })}
            />
          )}
          {type === 'account' && (
            <>
              <ProFormText
                name="username"
                initialValue=""
                fieldProps={{
                  size: 'large',
                  prefix: <UserOutlined />,
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
                  prefix: <LockOutlined />,
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
                  message.success('获取验证码成功！');
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
            <a style={{ float: 'right' }} onClick={toggleRegister}>
              {isRegister ? (
                <FormattedMessage id="pages.login.hasAccount" defaultMessage="已有账号？去登录" />
              ) : (
                <FormattedMessage id="pages.login.notAccount" defaultMessage="没有账号？去注册" />
              )}
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
        footer={modalFooter}
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
        {showBehaviorValidation && (
          <CaptchaModal
            onSuccess={handleCaptchaSuccess}
            onClose={() => setOpen(false)}
            username={loginValuesRef.current.username}
            uuid={uuid.current}
          />
        )}
      </Modal>
      <Footer />
    </div>
  );
};

export default Login;
