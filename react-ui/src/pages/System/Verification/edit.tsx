import { DictValueEnumObj } from '@/components/DictTag';
import { ProForm, ProFormDigit, ProFormSelect } from '@ant-design/pro-components';
import { FormattedMessage, useIntl } from '@umijs/max';
import { Form, Modal } from 'antd';
import React, { useEffect } from 'react';

export type VerificationFormData = Record<string, unknown> & Partial<API.System.Verification>;

export type VerificationFormProps = {
  onCancel: (flag?: boolean, formVals?: VerificationFormData) => void;
  onSubmit: (values: VerificationFormData) => Promise<void>;
  open: boolean;
  values: Partial<API.System.Verification>;
  riskTypeOptions: DictValueEnumObj;
  verificationTypeOptions: DictValueEnumObj;
};

const VerificationForm: React.FC<VerificationFormProps> = (props) => {
  const [form] = Form.useForm();

  useEffect(() => {
    form.resetFields();
    form.setFieldsValue({
      id: props.values.id,
      userId: props.values.userId,
      riskType: props.values.riskType,
      verificationId: props.values.verificationId,
      sort: props.values.sort,
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
    props.onSubmit(values as VerificationFormData);
  };

  const { riskTypeOptions, verificationTypeOptions } = props;

  return (
    <Modal
      width={640}
      title={intl.formatMessage({
        id: 'system.verification.title',
        defaultMessage: '编辑验证模式',
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
            id: 'system.verification.id',
            defaultMessage: '编号',
          })}
          placeholder="请输入编号"
          disabled
          hidden={true}
        />

        <ProFormSelect
          name="riskType"
          label={intl.formatMessage({
            id: 'system.verification.riskType',
            defaultMessage: '风险类型',
          })}
          valueEnum={riskTypeOptions}
          rules={[
            {
              required: true,
              message: <FormattedMessage id="请选择风险类型！" defaultMessage="请选择风险类型！" />,
            },
          ]}
        />
        <ProFormSelect
          name="verificationId"
          label={intl.formatMessage({
            id: 'system.verification.verificationId',
            defaultMessage: '验证类型',
          })}
          valueEnum={verificationTypeOptions}
          rules={[
            {
              required: true,
              message: <FormattedMessage id="请选择验证类型！" defaultMessage="请选择验证类型！" />,
            },
          ]}
        />
        <ProFormDigit
          name="sort"
          label={intl.formatMessage({
            id: 'system.verification.sort',
            defaultMessage: '排序',
          })}
          placeholder="请输入排序"
          rules={[
            {
              required: true,
              message: <FormattedMessage id="请输入排序！" defaultMessage="请输入排序！" />,
            },
          ]}
        />
      </ProForm>
    </Modal>
  );
};

export default VerificationForm;
