/*
 * @Date: 2025-03-17 20:21:01
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-18 17:51:59
 * @FilePath: \lpt-single-item\react-ui\src\pages\User\Login\components\CaptchaModal.tsx
 */
import { useEffect } from 'react';

declare global {
  interface Window {
    initTAC: any;
  }
}

interface CaptchaProps {
  onSuccess: (token: string) => void;
  onClose: () => void;
  username?: string;
}

const CaptchaModal = ({ onSuccess, onClose, username }: CaptchaProps) => {
  useEffect(() => {
    const initCaptcha = () => {
      const config = {
        requestCaptchaDataUrl: '/api/login?username=' + username,
        validCaptchaUrl: '/api/login?username=' + username,
        bindEl: '#captcha-box',
        validSuccess: (res: any, _: any, tac: any) => {
          onSuccess(res.msg);
          tac.reloadCaptcha();
        },
        validFail: (res: any, _: any, tac: any) => {
          console.error('验证失败:', res.msg);
          tac.reloadCaptcha();
        },
        btnCloseFun: (el: any, tac: any) => {
          tac.destroyWindow();
          onClose();
        },
      };

      window
        .initTAC('/tac', config, { logoUrl: null })
        .then((tac: any) => tac.init())
        .catch((e: any) => console.error('验证码初始化失败', e));
    };

    initCaptcha();
    return () => {
      const container = document.getElementById('captcha-box');
      if (container) container.innerHTML = '';
    };
  }, [onSuccess, onClose, username]);

  return <div id="captcha-box" style={{ width: 320, margin: '0 auto' }} />;
};

export default CaptchaModal;
