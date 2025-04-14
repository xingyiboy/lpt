import { Button } from 'antd';
import { ProFormText } from '@ant-design/pro-components';

interface MailboxValidationProps {
  mail: string; // 邮箱地址
  handleClickVarify: () => void; // 发送验证码回调
  captchaInput?: string; // 验证码输入值
  setCaptchaInput?: (value: string) => void; // 验证码变化回调
}

const MailboxValidation: React.FC<MailboxValidationProps> = ({
  mail,
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
      {/* 邮箱地址展示 */}
      <div style={{ fontWeight: 500, fontSize: 16 }}>{mail}</div>

      {/* 发送验证码按钮 */}
      <Button type="primary" onClick={handleClickVarify} style={{ width: 200, height: 40 }}>
        发送验证码
      </Button>

      {/* 验证码输入框 */}
      <ProFormText
        fieldProps={{
          size: 'large',
          placeholder: '请输入邮箱验证码',
          value: captchaInput,
          onChange: (e) => setCaptchaInput?.(e.target.value),
          style: { width: 200 },
        }}
        rules={[{ required: true, message: '请输入邮箱验证码' }]}
      />

      {/* 操作提示 */}
      <div
        style={{
          color: '#666',
          fontSize: 12,
          textAlign: 'center',
          marginTop: -12,
        }}
      >
        验证码将发送至注册邮箱
      </div>
    </div>
  );
};

export default MailboxValidation;
