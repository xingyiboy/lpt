import React, { useState, useRef, useEffect } from 'react';
import { Button, Modal } from 'antd';
import { message } from 'antd';
import { CameraOutlined, CheckOutlined, CloseOutlined } from '@ant-design/icons';
import { login } from '@/services/system/auth';

const FaceValidation = ({ onSuccess, username, uuid }: { onSuccess: (base64: string) => void }) => {
  const videoRef = useRef<HTMLVideoElement>(null);
  const [stream, setStream] = useState<MediaStream>();
  const [captured, setCaptured] = useState<string>();
  const [loading, setLoading] = useState(false);
  const [retryCount, setRetryCount] = useState(0);

  const handleClickOk = async (captured) => {
    //处理点击确认
    const response = await login({ username: username, uuid: uuid, faceBase64: captured });
    if (response.code === 200) {
      if (response.data.slice(0, 6) == 'token:') {
        //登录成功
        onSuccess(response.data);
      } else {
        //其他消息
        message.error(response.data);
      }
    } else {
      message.error('未知异常');
    }
  };

  // 初始化摄像头
  useEffect(() => {
    let isMounted = true;
    const initCamera = async () => {
      try {
        // 先停止原有流
        if (stream) {
          stream.getTracks().forEach((track) => track.stop());
        }

        const mediaStream = await navigator.mediaDevices.getUserMedia({
          video: { facingMode: 'user' },
        });

        if (isMounted) {
          setStream(mediaStream);
          if (videoRef.current) {
            videoRef.current.srcObject = mediaStream;
            // 添加用户手势处理
            const playVideo = () => {
              videoRef.current?.play().finally(() => {
                document.removeEventListener('click', playVideo);
              });
            };

            videoRef.current.play().catch(() => {
              console.log('需要用户交互才能播放');
              document.addEventListener('click', playVideo);
            });
          }
        }
      } catch (error) {
        console.error('摄像头访问失败:', error);
      }
    };

    initCamera();

    return () => {
      isMounted = false;
      if (stream) {
        stream.getTracks().forEach((track) => track.stop());
      }
    };
  }, [retryCount, onSuccess, username, uuid]);

  // 拍照处理
  const capturePhoto = () => {
    setLoading(true);
    const canvas = document.createElement('canvas');
    const video = videoRef.current;

    if (video) {
      // 暂停视频流而不是停止
      video.pause();

      // 设置压缩尺寸
      const maxWidth = 640;
      const scale = maxWidth / video.videoWidth;
      canvas.width = maxWidth;
      canvas.height = video.videoHeight * scale;

      const ctx = canvas.getContext('2d');
      ctx?.drawImage(video, 0, 0, canvas.width, canvas.height);

      // 压缩质量参数（0.7表示70%质量）
      const base64 = canvas.toDataURL('image/jpeg', 0.7).split(',')[1];
      setCaptured('data:image/jpeg;base64,' + base64);
      setLoading(false);
    }
  };

  // 完全重置的重拍处理
  const handleRetake = () => {
    setCaptured(undefined);
    setRetryCount((prev) => prev + 1);
  };

  useEffect(() => {
    const handleVisibilityChange = () => {
      if (document.visibilityState === 'visible' && videoRef.current && !captured) {
        videoRef.current.play().catch(console.error);
      }
    };

    document.addEventListener('visibilitychange', handleVisibilityChange);
    return () => document.removeEventListener('visibilitychange', handleVisibilityChange);
  }, [captured]);

  return (
    <div style={{ textAlign: 'center' }}>
      {!captured ? (
        <>
          <video
            ref={videoRef}
            autoPlay
            playsInline
            style={{
              width: '100%',
              maxHeight: '400px',
              border: '1px solid #ddd',
              borderRadius: 4,
            }}
          />
          <Button
            type="primary"
            icon={<CameraOutlined />}
            onClick={capturePhoto}
            loading={loading}
            style={{ marginTop: 16 }}
          >
            拍照
          </Button>
        </>
      ) : (
        <>
          <img
            src={captured}
            alt="预览"
            style={{
              width: '100%',
              maxHeight: '400px',
              border: '1px solid #ddd',
              borderRadius: 4,
            }}
          />
          <div style={{ marginTop: 16 }}>
            <Button
              type="primary"
              icon={<CheckOutlined />}
              onClick={() => handleClickOk(captured)}
              style={{ marginRight: 8 }}
            >
              确认
            </Button>
            <Button icon={<CloseOutlined />} onClick={handleRetake}>
              重拍
            </Button>
          </div>
        </>
      )}
    </div>
  );
};

export default FaceValidation;
