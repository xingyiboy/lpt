import { getUserInfo } from '@/services/session';
import {
  LockFilled,
  MailOutlined,
  ManOutlined,
  MobileOutlined,
  RiseOutlined,
  UserOutlined,
} from '@ant-design/icons';
import { PageLoading } from '@ant-design/pro-components';
import { useRequest } from '@umijs/max';
import { Card, Col, Divider, List, Row } from 'antd';
import React, { useState } from 'react';
import styles from './Center.less';
import AvatarCropper from './components/AvatarCropper';
import BaseInfo from './components/BaseInfo';
import ResetPassword from './components/ResetPassword';

const operationTabList = [
  {
    key: 'base',
    tab: <span>基本资料</span>,
  },
  {
    key: 'password',
    tab: <span>重置密码</span>,
  },
];

export type tabKeyType = 'base' | 'password';

const Center: React.FC = () => {
  const [tabKey, setTabKey] = useState<tabKeyType>('base');

  const [cropperModalOpen, setCropperModalOpen] = useState<boolean>(false);

  //  获取用户信息
  const { data: userInfo, loading } = useRequest(async () => {
    return { data: await getUserInfo() };
  });
  if (loading) {
    return <div>loading...</div>;
  }

  const currentUser = userInfo?.user;

  //  渲染用户信息
  const renderUserInfo = ({
    userName,
    phonenumber,
    email,
    sex,
    secretKey,
    offset,
  }: Partial<API.CurrentUser>) => {
    return (
      <List>
        <List.Item>
          <div>
            <UserOutlined
              style={{
                marginRight: 8,
              }}
            />
            用户名
          </div>
          <div>{userName}</div>
        </List.Item>
        <List.Item>
          <div>
            <ManOutlined
              style={{
                marginRight: 8,
              }}
            />
            性别
          </div>
          <div>{sex === '1' ? '女' : '男'}</div>
        </List.Item>
        <List.Item>
          <div>
            <MobileOutlined
              style={{
                marginRight: 8,
              }}
            />
            电话
          </div>
          <div>{phonenumber}</div>
        </List.Item>
        <List.Item>
          <div>
            <MailOutlined
              style={{
                marginRight: 8,
              }}
            />
            邮箱
          </div>
          <div>{email}</div>
        </List.Item>
        <List.Item>
          <div>
            <LockFilled
              style={{
                marginRight: 8,
              }}
            />
            密钥
          </div>
          <div>{secretKey}</div>
        </List.Item>
        <List.Item>
          <div>
            <RiseOutlined
              style={{
                marginRight: 8,
              }}
            />
            偏移量
          </div>
          <div>{offset}</div>
        </List.Item>
      </List>
    );
  };

  // 渲染tab切换
  const renderChildrenByTabKey = (tabValue: tabKeyType) => {
    if (tabValue === 'base') {
      return <BaseInfo values={currentUser} />;
    }
    if (tabValue === 'password') {
      return <ResetPassword />;
    }
    return null;
  };

  if (!currentUser) {
    return <PageLoading />;
  }

  return (
    <div>
      <Row gutter={[16, 24]}>
        <Col lg={8} md={24}>
          <Card title="个人信息" bordered={false} loading={loading}>
            {!loading && (
              <div style={{ textAlign: 'center' }}>
                <div
                  className={styles.avatarHolder}
                  onClick={() => {
                    setCropperModalOpen(true);
                  }}
                >
                  <img alt="" src={currentUser.avatar} />
                </div>
                {renderUserInfo(currentUser)}
                <Divider dashed />
              </div>
            )}
          </Card>
        </Col>
        <Col lg={16} md={24}>
          <Card
            bordered={false}
            tabList={operationTabList}
            activeTabKey={tabKey}
            onTabChange={(_tabKey: string) => {
              setTabKey(_tabKey as tabKeyType);
            }}
          >
            {renderChildrenByTabKey(tabKey)}
          </Card>
        </Col>
      </Row>
      <AvatarCropper
        onFinished={() => {
          setCropperModalOpen(false);
        }}
        open={cropperModalOpen}
        data={currentUser.avatar}
      />
    </div>
  );
};

export default Center;
