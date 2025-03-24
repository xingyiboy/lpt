import { getLptMemberRecordList } from '@/services/system/memberRecord';
import { ActionType, ProColumns, ProTable } from '@ant-design/pro-components';
import { FormattedMessage, useIntl } from '@umijs/max';
import { Modal } from 'antd';
import React, { useEffect, useRef } from 'react';

interface MemberRecordModalProps {
  open: boolean;
  onCancel: () => void;
  memberId?: number;
}

const MemberRecordModal: React.FC<MemberRecordModalProps> = (props) => {
  const { open, onCancel, memberId } = props;
  const intl = useIntl();
  const actionRef = useRef<ActionType>();

  useEffect(() => {
    if (open && memberId && actionRef.current) {
      actionRef.current.reload();
    }
  }, [open, memberId]);

  const columns: ProColumns<API.System.LptMemberRecord>[] = [
    {
      title: <FormattedMessage id="system.member.record.id" defaultMessage="编号" />,
      dataIndex: 'id',
      valueType: 'text',
      align: 'center',
      search: false,
    },
    {
      title: <FormattedMessage id="system.member.record.loginIp" defaultMessage="登录IP" />,
      dataIndex: 'loginIp',
      valueType: 'text',
      align: 'center',
      search: true,
    },
    {
      title: <FormattedMessage id="system.member.record.decive" defaultMessage="登录设备" />,
      dataIndex: 'decive',
      valueType: 'text',
      align: 'center',
      search: true,
    },
    {
      title: <FormattedMessage id="system.member.record.latitude" defaultMessage="经度" />,
      dataIndex: 'latitude',
      valueType: 'text',
      align: 'center',
      search: false,
    },
    {
      title: <FormattedMessage id="system.member.record.longitude" defaultMessage="纬度" />,
      dataIndex: 'longitude',
      valueType: 'text',
      align: 'center',
      search: false,
    },
    {
      title: <FormattedMessage id="system.member.record.createTime" defaultMessage="创建时间" />,
      dataIndex: 'createTime',
      valueType: 'dateTimeRange',
      align: 'center',
      search: true,
      render: (_, record) => record.createTime,
    },
  ];

  return (
    <Modal
      title={intl.formatMessage({
        id: 'system.member.record.title',
        defaultMessage: '登录记录',
      })}
      open={open}
      onCancel={onCancel}
      width={1200}
      footer={null}
      destroyOnClose
    >
      <ProTable<API.System.LptMemberRecord>
        actionRef={actionRef}
        headerTitle={intl.formatMessage({
          id: 'system.member.record.tableTitle',
          defaultMessage: '登录记录列表',
        })}
        search={{
          labelWidth: 120,
          defaultCollapsed: true,
          collapsed: true,
        }}
        options={{
          density: true,
          fullScreen: true,
          reload: true,
          setting: true,
        }}
        rowKey="id"
        params={{
          memberId,
        }}
        request={async (params) => {
          if (!memberId) {
            return {
              data: [],
              success: true,
              total: 0,
            };
          }
          const res = await getLptMemberRecordList({
            ...params,
            memberId,
            pageNum: params.current,
            pageSize: params.pageSize,
          } as API.System.LptMemberRecord);
          return {
            data: res.rows || [],
            success: true,
            total: res.total || 0,
          };
        }}
        columns={columns}
        pagination={{
          pageSize: 10,
          showQuickJumper: true,
          showSizeChanger: true,
          showTotal: (total) =>
            intl.formatMessage(
              { id: 'pages.table.pagination.total', defaultMessage: '共 {total} 条' },
              { total },
            ),
        }}
      />
    </Modal>
  );
};

export default MemberRecordModal;
