/*
 * @Date: 2025-03-16 16:12:47
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-04-06 23:35:53
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
  MedicineBoxOutlined,
} from '@ant-design/icons';
import {
  LoginForm,
  ProFormCaptcha,
  ProFormCheckbox,
  ProFormText,
} from '@ant-design/pro-components';
import { decrypt, encrypt } from '@/utils/crypto';
import { useEmotionCss } from '@ant-design/use-emotion-css';
import { FormattedMessage, history, SelectLang, useIntl, useModel, Helmet } from '@umijs/max';
import { Alert, Col, message, Row, Tabs, Image, Button, Modal, Checkbox } from 'antd';
import Settings from '../../../../config/defaultSettings';
import React, { useEffect, useState, useRef, useCallback, useMemo } from 'react';
import { flushSync } from 'react-dom';
import { clearSessionToken, setSessionToken } from '@/access';
import ImageInputValidation from './components/ImageInputValidation';
import MailboxValidation from './components/MailboxValidation';
import BehaviorValidation from './components/BehaviorValidation';
import load from './components/load.min.js';
import FaceValidation from './components/FaceValidation';
import { isMobile, isTablet, isDesktop, osVersion, browserName } from 'react-device-detect';

// Extend LoginParams to include additional properties used in the application
interface ExtendedLoginParams extends API.LoginParams {
  step?: number;
  ip?: string;
  device?: string;
  latitude?: number | null;
  longitude?: number | null;
  code?: string;
}

// Extend the LoginResult interface to include data property
interface ExtendedLoginResult extends API.LoginResult {
  data?: any;
}

// 验证步骤枚举
enum ValidationStep {
  CHARACTER = '1', // 字符校验
  NUMBER = '2', // 数字计算校验
  EMAIL = '3', // 邮箱校验
  SLIDE = '4', // 滑动校验
  ROTATE = '5', // 旋转校验
  CLICK = '6', // 点击校验
  SLIDE_RESTORE = '7', // 滑动还原校验
  FACE = '8', // 人脸校验
}

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
      <MedicineBoxOutlined key="MedicineBoxOutlined" className={langClassName} />
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
  const [userLoginState, setUserLoginState] = useState<ExtendedLoginResult>({ code: 200 });
  const [type, setType] = useState<string>('account');
  const { initialState, setInitialState } = useModel('@@initialState');
  const [captchaInput, setCaptchaInput] = useState('');
  const [ip, setIp] = useState('');
  const [location, setLocation] = useState({
    latitude: null,
    longitude: null,
    error: null,
  });
  const browserInfo = {
    name: navigator.appName,
    version: navigator.appVersion,
    userAgent: navigator.userAgent,
  };

  const [submitting, setSubmitting] = useState(false);

  // 字符，数字 校验 对话框
  const [showImageInputValidation, setShowImageInputValidation] = useState(false);
  // 邮箱校验 对话框
  const [showMailboxValidation, setShowMailboxValidation] = useState(false);
  // 滑动、旋转、滑动还原、文字点选校验 对话框
  const [showBehaviorValidation, setShowBehaviorValidation] = useState(false);
  // 人脸校验 对话框
  const [showFaceValidation, setShowFaceValidation] = useState(false);

  const [isRegister, setIsRegister] = useState(false);
  const [rememberMe, setRememberMe] = useState<boolean>(true);

  // 使用 useRef 替代 useState 来存储最新值
  const loginValuesRef = useRef<API.LoginParams | undefined>();

  const uuid = useRef<string>();

  const LoginSuccess = async (token: string) => {
    console.log(token);
    //完成登录
    const defaultLoginSuccessMessage = intl.formatMessage({
      id: 'pages.login.success',
      defaultMessage: '登录成功！',
    });
    if (token == null) {
      message.error('错误！请重新登录');
    }
    const current = new Date();
    const expireTime = current.setTime(current.getTime() + 1000 * 12 * 60 * 60);
    setSessionToken(token, token, expireTime);
    message.success(defaultLoginSuccessMessage);
    fetchUserInfo();
    const urlParams = new URL(window.location.href).searchParams;
    history.push(urlParams.get('redirect') || '/');
  };

  //关闭全部校验 对话框
  const closeAllValidation = () => {
    setShowImageInputValidation(false);
    setShowMailboxValidation(false);
    setShowBehaviorValidation(false);
    setShowFaceValidation(false);
  };

  useEffect(() => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          setLocation({
            latitude: position.coords.latitude,
            longitude: position.coords.longitude,
            error: null,
          });
        },
        (error) => {
          setLocation({
            latitude: null,
            longitude: null,
            error: error.message,
          });
        },
      );
    } else {
      setLocation({
        latitude: null,
        longitude: null,
        error: 'Geolocation is not supported by this browser.',
      });
    }
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

  const handleNextSetp = async (Step: string) => {
    setUserLoginState({ code: 200 });
    const currentValues = loginValuesRef.current;
    if (currentValues == null) {
      return;
    }
    setCaptchaInput('');
    switch (Step) {
      case ValidationStep.CHARACTER:
        //执行字符校验
        closeAllValidation();
        setShowImageInputValidation(true);
        getCodeDataAndVerify(false, ValidationStep.CHARACTER);
        message.success('验证成功，开始字符校验');
        break;
      case ValidationStep.NUMBER:
        //执行数字计算校验
        closeAllValidation();
        setShowImageInputValidation(true);
        getCodeDataAndVerify(false, ValidationStep.NUMBER);
        message.success('验证成功，开始数字计算校验');
        break;
      case ValidationStep.EMAIL:
        //执行邮箱校验
        closeAllValidation();
        setShowMailboxValidation(true);
        setTimeout(() => getCodeDataAndVerify(false, ValidationStep.EMAIL), 1500);
        message.success('验证成功，开始邮箱校验');
        break;
      case ValidationStep.SLIDE:
        closeAllValidation();
        setShowBehaviorValidation(true);
        message.success('验证成功，开始滑动校验');
        break;
      case ValidationStep.ROTATE:
        closeAllValidation();
        setShowBehaviorValidation(true);
        message.success('验证成功，开始旋转校验');
        break;
      case ValidationStep.CLICK:
        closeAllValidation();
        setShowBehaviorValidation(true);
        message.success('验证成功，开始点击校验');
        break;
      case ValidationStep.SLIDE_RESTORE:
        closeAllValidation();
        setShowBehaviorValidation(true);
        message.success('验证成功，开始滑动还原校验');
        break;
      case ValidationStep.FACE:
        closeAllValidation();
        setShowFaceValidation(true);
        message.success('验证成功，开始人脸校验');
        break;
      default:
        //登录成功
        if (Step.slice(0, 6) == 'token:') {
          LoginSuccess(Step.slice(6));
        }
        break;
    }
  };

  //处理点击提交
  const handleSubmitVarify = useCallback(async () => {
    await getCodeDataAndVerify(true);
  }, [captchaInput, codeImgData]);

  //处理点击验证码
  const handleClickVarify = useCallback(() => {
    if (submitting) {
      return;
    }
    getCodeDataAndVerify();
  }, [captchaInput, submitting, codeImgData]);

  //获取验证码/校验验证码
  const getCodeDataAndVerify = useCallback(
    async (isVerify = false, Step = '') => {
      if (isVerify == true) {
        //校验
        const currentValues = loginValuesRef.current;
        if (currentValues == null) {
          return;
        }
        const response = await login({ ...loginValuesRef.current, code: captchaInput }) as ExtendedLoginResult;
        if (response.code === 200) {
          //执行下一步操作
          if (response.data && response.data != '验证码错误') {
            handleNextSetp(response.data);
          } else {
            message.error(response.data || '验证码错误');
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
          const currentValues = loginValuesRef.current;
          if (!currentValues) {
            message.error('请先填写登录信息');
            return;
          }
          setSubmitting(true);
          const response = await login({ ...currentValues }) as ExtendedLoginResult;

          if (response.code === 200) {
            setCodeImgData(response.data);
            setSubmitting(false);
          }
        } catch (error) {
          message.error('获取验证码失败');
        }
      }
    },
    [captchaInput, codeImgData],
  );

  const showModal = () => {
    setOpen(true);
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
        "url('https://img.freepik.com/free-photo/medical-banner-with-stethoscope_23-2149611199.jpg')",
      backgroundSize: 'cover',
      backgroundPosition: 'center',
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
      // 如果选择记住密码，则加密存储
      if (rememberMe) {
        // Add proper type checks before calling encrypt
        if (values.username) {
          localStorage.setItem('rememberedUsername', encrypt(values.username));
        }
        if (values.password) {
          localStorage.setItem('rememberedPassword', encrypt(values.password));
        }
      } else {
        // 如果取消记住密码，则清除存储
        localStorage.removeItem('rememberedUsername');
        localStorage.removeItem('rememberedPassword');
      }
      const apiMethod = isRegister ? register : login;

      // Create extended params object with proper syntax
      const extendedParams: ExtendedLoginParams = {
        ...values,
        step: 0,
        ip: ip,
        device: browserInfo.userAgent,
        latitude: location.latitude,
        longitude: location.longitude
      };

      const response = await apiMethod(extendedParams) as ExtendedLoginResult;
      // 存储到 ref
      loginValuesRef.current = values;

      if (response.code === 200) {
        if (isRegister) {
          //注册
          message.success('注册成功，请登录');
          setIsRegister(false);
          return;
        }
        //登录
        uuid.current = response.data.uuid;
        showModal();
        handleNextSetp(response.data.step);
      } else {
        clearSessionToken();
        setUserLoginState({ ...response, type });
        message.error(response.msg);
      }
    } catch (error) {
      message.error(isRegister ? '注册失败，请重试！' : '登录失败，请重试！');
    }
  };

  const { code } = userLoginState;
  const loginType = type;

  const modalFooter = useMemo(() => {
    // 当显示验证码弹窗时隐藏底部按钮
    return showBehaviorValidation || showFaceValidation
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
  }, [submitting, handleCancel, handleSubmitVarify, showBehaviorValidation, showFaceValidation]); // 当showBehaviorValidation和showFaceValidation时关闭底部按钮

  // 修改注册状态切换逻辑
  const toggleRegister = () => {
    setIsRegister(!isRegister);
    setType('account'); // 强制切换到账户密码登录
  };

  const [showCameraCapture, setShowCameraCapture] = useState(false);
  const getRememberedUsername = () => {
    return decrypt(localStorage.getItem('rememberedUsername') || '');
  };
  const getRememberedPassword = () => {
    return decrypt(localStorage.getItem('rememberedPassword') || '');
  };

  // Add custom styling for login components
  const medicalStyleLoginForm = useEmotionCss(() => {
    return {
      '.ant-pro-form-login-header': {
        color: '#1890ff',
      },
      '.ant-btn-primary': {
        backgroundColor: '#1890ff',
        borderColor: '#1890ff',
      },
      '.ant-tabs-tab.ant-tabs-tab-active .ant-tabs-tab-btn': {
        color: '#1890ff !important',
      },
      '.ant-checkbox-checked .ant-checkbox-inner': {
        backgroundColor: '#1890ff',
        borderColor: '#1890ff',
      },
    };
  });

  return (
    <div className={containerClassName}>
      <Helmet>
        <title >
          {intl.formatMessage({
            id: 'menu.login',
            defaultMessage: '登录页',
          })}
          - 医疗管理系统
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
          className={medicalStyleLoginForm}
          contentStyle={{
            minWidth: 320,
            maxWidth: '75vw',
            backgroundColor: 'rgba(255, 255, 255, 0.95)',
            padding: '30px',
            borderRadius: '12px',
            boxShadow: '0 8px 24px rgba(0, 0, 0, 0.15)',
          }}
          logo={
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <MedicineBoxOutlined style={{ fontSize: '28px', color: '#1890ff', marginRight: '8px' }} />
              <img alt="logo" src="/favicon.ico" style={{ transform: 'scale(1.2)',marginRight: '20px'}} />
            </div>
          }
          title="医疗管理系统-demo"
          subTitle="体验登录验证流程体系示例项目"
          initialValues={{
            autoLogin: true,
            username: getRememberedUsername(),
            password: getRememberedPassword(),
          }}
          submitter={{
            searchConfig: {
              submitText: isRegister ? '注册' : '登录',
            },
            submitButtonProps: {
              block: true,
              size: 'large',
              style: { backgroundColor: '#1890ff', borderColor: '#1890ff' }
            },
          }}
          onFinish={async (values) => {
            await handleSubmit(values as API.LoginParams);
          }}
        >
          {/* Medical-themed image header */}
          <div style={{ textAlign: 'center', marginBottom: '24px' }}>
            <img
              src="https://img.freepik.com/free-vector/flat-hand-drawn-hospital-reception-scene_52683-54613.jpg"
              alt="Medical System"
              style={{ maxWidth: '100%', height: 'auto', borderRadius: '8px' }}
            />
          </div>

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
        title="医疗系统安全校验"
        width={400}
        onCancel={handleCancel}
        destroyOnClose
        footer={modalFooter}
        bodyStyle={{ backgroundColor: '#f5f7fa' }}
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
          <BehaviorValidation
            //成功回调
            onSuccess={handleNextSetp}
            //失败回调
            onClose={() => setOpen(false)}
            //用户名（可不传-根据自己代码决定）
            username={loginValuesRef.current?.username || ''}
            //uuid（可不传-根据自己代码决定）
            uuid={uuid.current}
          />
        )}
        {showFaceValidation && (
          <FaceValidation
            onSuccess={(token: string) => handleNextSetp(token)}
          />
        )}
      </Modal>
      <Footer />
    </div>
  );
};

export default Login;
