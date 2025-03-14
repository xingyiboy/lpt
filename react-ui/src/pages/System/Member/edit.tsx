import {
  ProForm,
  ProFormDigit,
  ProFormRadio,
  ProFormText,
  ProFormTextArea,
} from '@ant-design/pro-components';
import { FormattedMessage, useIntl } from '@umijs/max';
import { Form, Modal } from 'antd';
import React, { useEffect } from 'react';

export type MemberFormData = Record<string, unknown> & Partial<API.System.LptMember>;

export type MemberFormProps = {
  onCancel: (flag?: boolean, formVals?: MemberFormData) => void;
  onSubmit: (values: MemberFormData) => Promise<void>;
  open: boolean;
  values: Partial<API.System.LptMember>;
};

const MemberForm: React.FC<MemberFormProps> = (props) => {
  const [form] = Form.useForm();

  useEffect(() => {
    form.resetFields();
    form.setFieldsValue({
      id: props.values.id,
      username: props.values.username,
      password: props.values.password,
      mailbox: props.values.mailbox,
      isRelease: props.values.isRelease || 0,
      riskNumber: props.values.riskNumber,
      remark: props.values.remark,
    });
  }, [form, props]);

  const intl = useIntl();
  const handleOk = () => {
    form.submit();
  };
  const handleCancel = () => {
    props.onCancel();
  };
  const handleFinish = async (values: Record<string, any>) => {
    props.onSubmit(values as MemberFormData);
  };

  return (
    <Modal
      width={640}
      title={intl.formatMessage({
        id: 'system.member.title',
        defaultMessage: '编辑成员信息',
      })}
      open={props.open}
      forceRender
      destroyOnClose
      onOk={handleOk}
      onCancel={handleCancel}
    >
      <ProForm
        form={form}
        grid={true}
        submitter={false}
        layout="horizontal"
        onFinish={handleFinish}
      >
        <ProFormDigit
          name="id"
          label={intl.formatMessage({
            id: 'system.member.id',
            defaultMessage: '编号',
          })}
          placeholder="请输入编号"
          disabled
          hidden={true}
        />
        <ProFormText
          name="username"
          label={intl.formatMessage({
            id: 'system.member.username',
            defaultMessage: '用户名',
          })}
          placeholder="请输入用户名"
          rules={[
            {
              required: true,
              message: <FormattedMessage id="请输入用户名！" defaultMessage="请输入用户名！" />,
            },
          ]}
        />
        <ProFormText.Password
          name="password"
          label={intl.formatMessage({
            id: 'system.member.password',
            defaultMessage: '密码',
          })}
          placeholder="默认初始密码:123456@lpt"
          disabled
        />
        {/* <ProFormText
          name="salt"
          label={intl.formatMessage({
            id: 'system.member.salt',
            defaultMessage: '盐值',
          })}
          placeholder="请输入盐值"
          disabled
        /> */}
        <ProFormRadio.Group
          name="isRelease"
          label={intl.formatMessage({
            id: 'system.member.isRelease',
            defaultMessage: '是否放通',
          })}
          options={[
            { label: '是', value: 1 },
            { label: '否', value: 0 },
          ]}
          rules={[
            {
              required: true,
              message: <FormattedMessage id="请选择是否放通！" defaultMessage="请选择是否放通！" />,
            },
          ]}
        />
        <ProFormText
          name="mailbox"
          label={intl.formatMessage({
            id: 'system.member.mailbox',
            defaultMessage: '邮箱',
          })}
          placeholder="请输入邮箱"
          rules={[
            {
              type: 'email',
              message: (
                <FormattedMessage
                  id="请输入正确的邮箱地址！"
                  defaultMessage="请输入正确的邮箱地址！"
                />
              ),
            },
          ]}
        />
        {/* <ProFormText
          name="loginIp"
          label={intl.formatMessage({
            id: 'system.member.loginIp',
            defaultMessage: '用户登录IP',
          })}
          placeholder="请输入用户登录IP"
          disabled
        />
        <ProFormText
          name="facility"
          label={intl.formatMessage({
            id: 'system.member.facility',
            defaultMessage: '登录设备',
          })}
          placeholder="请输入登录设备"
          disabled
        /> */}
        <ProFormDigit
          name="riskNumber"
          label={intl.formatMessage({
            id: 'system.member.riskNumber',
            defaultMessage: '风险因子',
          })}
          placeholder="请输入风险因子"
          rules={[
            {
              required: true,
              message: <FormattedMessage id="请输入风险因子！" defaultMessage="请输入风险因子！" />,
            },
          ]}
        />
        <ProFormTextArea
          name="remark"
          label={intl.formatMessage({
            id: 'system.member.remark',
            defaultMessage: '备注',
          })}
          placeholder="请输入备注"
        />
      </ProForm>
    </Modal>
  );
};

export default MemberForm;
