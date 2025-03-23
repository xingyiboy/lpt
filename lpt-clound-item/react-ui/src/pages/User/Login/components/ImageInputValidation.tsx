import { Image, Button } from 'antd';
import { ProFormText } from '@ant-design/pro-components';

// 添加类型定义
interface ImageInputProps {
  codeImgData: string;
  handleClickVarify: () => void;
  captchaInput?: string;
  setCaptchaInput?: (value: string) => void;
}

// 使用 React.FC 声明方式，规范 props 接收方式
const ImageInputValidation: React.FC<ImageInputProps> = ({
  codeImgData,
  handleClickVarify,
  captchaInput,
  setCaptchaInput,
}) => {
  return (
    <div
      style={{
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        gap: 24,
        padding: '20px 0',
      }}
    >
      <Image
        preview={false}
        onClick={handleClickVarify}
        width={200}
        height={80}
        src={codeImgData}
        style={{
          cursor: 'pointer',
          border: '1px solid #eee',
          borderRadius: 4,
        }}
      />

      <ProFormText
        fieldProps={{
          size: 'large',
          placeholder: '请输入图片验证码',
          value: captchaInput,
          onChange: (e) => setCaptchaInput?.(e.target.value),
          style: { width: 200 },
        }}
        rules={[{ required: true, message: '请输入验证码' }]}
      />

      <div
        style={{
          color: '#666',
          fontSize: 12,
          textAlign: 'center',
          marginTop: -12,
        }}
      >
        点击图片刷新验证码
      </div>
    </div>
  );
};

export default ImageInputValidation;
