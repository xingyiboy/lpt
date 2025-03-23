import React, { useState } from 'react';
import { Form, message, Row, Button, Avatar, Upload } from 'antd';
import { FormattedMessage, useIntl } from '@umijs/max';
import { ProForm, ProFormRadio, ProFormText } from '@ant-design/pro-components';
import { updateUserProfile } from '@/services/system/user';
import { CameraOutlined, UploadOutlined, DeleteOutlined } from '@ant-design/icons';

export type BaseInfoProps = {
  values: Partial<API.CurrentUser> | undefined;
};

const BaseInfo: React.FC<BaseInfoProps> = (props) => {
  const [form] = Form.useForm();
  const intl = useIntl();
  const [previewImage, setPreviewImage] = useState<string>();

  const handleUpload = (file: File) => {
    return new Promise<string>((resolve, reject) => {
      const reader = new FileReader();
      reader.onload = (e) => {
        const img = new Image();
        img.src = e.target?.result as string;

        img.onload = () => {
          // 创建canvas进行压缩
          const canvas = document.createElement('canvas');
          const ctx = canvas.getContext('2d')!;

          // 设置最大尺寸
          const MAX_WIDTH = 800;
          const MAX_HEIGHT = 800;
          let width = img.width;
          let height = img.height;

          // 等比例缩放
          if (width > height) {
            if (width > MAX_WIDTH) {
              height *= MAX_WIDTH / width;
              width = MAX_WIDTH;
            }
          } else {
            if (height > MAX_HEIGHT) {
              width *= MAX_HEIGHT / height;
              height = MAX_HEIGHT;
            }
          }

          canvas.width = width;
          canvas.height = height;

          // 绘制压缩后的图片
          ctx.drawImage(img, 0, 0, width, height);

          // 转换为高质量JPEG（0.7质量系数）
          const compressedBase64 = canvas.toDataURL('image/jpeg', 0.7);
          setPreviewImage(compressedBase64);
          resolve(compressedBase64); // 返回纯base64
        };

        img.onerror = () => reject(new Error('图片加载失败'));
      };
      reader.readAsDataURL(file);
    });
  };

  const handleFinish = async (values: Record<string, any>) => {
    const data = {
      ...props.values,
      ...values,
      faceBase64: values.faceBase64,
    };

    if (!data.faceBase64) {
      message.error('请上传人脸照片');
      return;
    }

    const resp = await updateUserProfile(data);
    if (resp.code === 200) {
      message.success('修改成功');
    } else {
      message.warning(resp.msg);
    }
  };

  return (
    <>
      <ProForm
        form={form}
        onFinish={handleFinish}
        initialValues={{
          ...props.values,
          faceBase64: props.values?.faceBase64?.startsWith('data:image')
            ? props.values.faceBase64
            : `data:image/jpeg;base64,${props.values?.faceBase64 || ''}`,
        }}
      >
        <Row style={{ marginBottom: 24 }}>
          <Form.Item
            name="faceBase64"
            label="人脸照片"
            rules={[{ required: true, message: '请上传人脸照片' }]}
          >
            <Upload
              name="avatar"
              showUploadList={false}
              beforeUpload={(file) => {
                const isImage = file.type.startsWith('image/');
                if (!isImage) message.error('仅支持图片格式');
                return isImage;
              }}
              customRequest={async ({ file }) => {
                const base64 = await handleUpload(file as File);
                form.setFieldValue('faceBase64', base64);
              }}
            >
              <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                <div>
                  {previewImage && (
                    <div style={{ position: 'relative' }}>
                      <img
                        src={previewImage}
                        style={{ maxWidth: 100, maxHeight: 100 }}
                        alt="人脸图片"
                      />
                      <Button
                        type="link"
                        danger
                        icon={<DeleteOutlined />}
                        onClick={(e) => {
                          e.stopPropagation();
                          setPreviewImage(undefined);
                          form.setFieldValue('faceBase64', undefined);
                        }}
                        style={{
                          position: 'absolute',
                          right: -8,
                          top: -8,
                          padding: 0,
                        }}
                      />
                    </div>
                  )}
                </div>
                <div style={{ marginTop: 8 }}>
                  <UploadOutlined /> 点击上传/拍照
                </div>
              </div>
            </Upload>
          </Form.Item>
        </Row>
        <Row>
          <ProFormText
            name="nickName"
            label={intl.formatMessage({
              id: 'system.user.nick_name',
              defaultMessage: '用户昵称',
            })}
            width="xl"
            placeholder="请输入用户昵称"
            rules={[
              {
                required: true,
                message: (
                  <FormattedMessage id="请输入用户昵称！" defaultMessage="请输入用户昵称！" />
                ),
              },
            ]}
          />
        </Row>
        <Row>
          <ProFormText
            name="phonenumber"
            label={intl.formatMessage({
              id: 'system.user.phonenumber',
              defaultMessage: '手机号码',
            })}
            width="xl"
            placeholder="请输入手机号码"
            rules={[
              {
                required: false,
                message: (
                  <FormattedMessage id="请输入手机号码！" defaultMessage="请输入手机号码！" />
                ),
              },
            ]}
          />
        </Row>
        <Row>
          <ProFormText
            name="email"
            label={intl.formatMessage({
              id: 'system.user.email',
              defaultMessage: '邮箱',
            })}
            width="xl"
            placeholder="请输入邮箱"
            rules={[
              {
                type: 'email',
                message: '无效的邮箱地址!',
              },
              {
                required: false,
                message: <FormattedMessage id="请输入邮箱！" defaultMessage="请输入邮箱！" />,
              },
            ]}
          />
        </Row>
        <Row>
          <ProFormRadio.Group
            options={[
              {
                label: '男',
                value: '0',
              },
              {
                label: '女',
                value: '1',
              },
            ]}
            name="sex"
            label={intl.formatMessage({
              id: 'system.user.sex',
              defaultMessage: 'sex',
            })}
            width="xl"
            rules={[
              {
                required: false,
                message: <FormattedMessage id="请输入性别！" defaultMessage="请输入性别！" />,
              },
            ]}
          />
        </Row>
      </ProForm>
    </>
  );
};

export default BaseInfo;
