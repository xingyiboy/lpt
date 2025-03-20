import DictTag from '@/components/DictTag';
import { getDictValueEnum } from '@/services/system/dict';
import {
  addVerification,
  getVerificationList,
  removeVerification,
  updateVerification,
} from '@/services/system/verification';
import { PlusOutlined } from '@ant-design/icons';
import {
  ActionType,
  FooterToolbar,
  PageContainer,
  ProColumns,
  ProTable,
} from '@ant-design/pro-components';
import { FormattedMessage, useAccess } from '@umijs/max';
import { Button, message, Modal } from 'antd';
import React, { useEffect, useRef, useState } from 'react';
import UpdateForm from './edit';

/**
 * 添加节点
 */
const handleAdd = async (fields: API.System.Verification) => {
  const hide = message.loading('正在添加');
  try {
    const resp = await addVerification({ ...fields });
    hide();
    if (resp.code === 200) {
      message.success('添加成功');
    } else {
      message.error(resp.msg);
    }
    return true;
  } catch (error) {
    hide();
    message.error('添加失败请重试！');
    return false;
  }
};

/**
 * 更新节点
 */
const handleUpdate = async (fields: API.System.Verification) => {
  const hide = message.loading('正在更新');
  try {
    const resp = await updateVerification(fields);
    hide();
    if (resp.code === 200) {
      message.success('更新成功');
    } else {
      message.error(resp.msg);
    }
    return true;
  } catch (error) {
    hide();
    message.error('配置失败请重试！');
    return false;
  }
};

/**
 * 删除节点
 */
const handleRemove = async (selectedRows: API.System.Verification[]) => {
  const hide = message.loading('正在删除');
  if (!selectedRows) return true;
  try {
    const resp = await removeVerification(selectedRows.map((row) => row.id).join(','));
    hide();
    if (resp.code === 200) {
      message.success('删除成功，即将刷新');
    } else {
      message.error(resp.msg);
    }
    return true;
  } catch (error) {
    hide();
    message.error('删除失败，请重试');
    return false;
  }
};

const VerificationTableList: React.FC = () => {
  const [modalVisible, setModalVisible] = useState<boolean>(false);
  const [currentRow, setCurrentRow] = useState<API.System.Verification>();
  const [selectedRows, setSelectedRows] = useState<API.System.Verification[]>([]);
  const [riskTypeOptions, setRiskTypeOptions] = useState<any>({});
  const [verificationTypeOptions, setVerificationTypeOptions] = useState<any>({});

  const actionRef = useRef<ActionType>();
  const access = useAccess();

  useEffect(() => {
    getDictValueEnum('risk_type').then((data) => {
      setRiskTypeOptions(data);
    });
    getDictValueEnum('member_verification').then((data) => {
      setVerificationTypeOptions(data);
    });
  }, []);

  const columns: ProColumns<API.System.Verification>[] = [
    {
      title: <FormattedMessage id="system.verification.riskType" defaultMessage="风险类型" />,
      dataIndex: 'riskType',
      valueType: 'select',
      valueEnum: riskTypeOptions,
      render: (_, record) => {
        return <DictTag enums={riskTypeOptions} value={record.riskType} />;
      },
    },
    {
      title: <FormattedMessage id="system.verification.verificationId" defaultMessage="验证类型" />,
      dataIndex: 'verificationId',
      valueType: 'select',
      valueEnum: verificationTypeOptions,
      render: (_, record) => {
        return <DictTag enums={verificationTypeOptions} value={record.verificationId} />;
      },
    },
    // {
    //   title: <FormattedMessage id="system.verification.id" defaultMessage="编号" />,
    //   dataIndex: 'id',
    //   valueType: 'text',
    // },
    {
      title: <FormattedMessage id="system.verification.sort" defaultMessage="排序" />,
      dataIndex: 'sort',
      valueType: 'digit',
    },
    {
      title: <FormattedMessage id="pages.searchTable.titleOption" defaultMessage="操作" />,
      dataIndex: 'option',
      width: '220px',
      valueType: 'option',
      render: (_, record) => [
        <Button
          type="link"
          size="small"
          key="edit"
          hidden={!access.hasPerms('system:verification:edit')}
          onClick={() => {
            setModalVisible(true);
            setCurrentRow(record);
          }}
        >
          编辑
        </Button>,
        <Button
          type="link"
          size="small"
          danger
          key="delete"
          hidden={!access.hasPerms('system:verification:remove')}
          onClick={() => {
            Modal.confirm({
              title: '删除',
              content: '确定删除该项吗？',
              okText: '确认',
              cancelText: '取消',
              onOk: async () => {
                const success = await handleRemove([record]);
                if (success) {
                  actionRef.current?.reload();
                }
              },
            });
          }}
        >
          删除
        </Button>,
      ],
    },
  ];

  return (
    <PageContainer>
      <ProTable<API.System.Verification>
        headerTitle="查询列表"
        actionRef={actionRef}
        rowKey="id"
        search={{
          labelWidth: 120,
        }}
        toolBarRender={() => [
          <Button
            type="primary"
            key="add"
            hidden={!access.hasPerms('system:verification:add')}
            onClick={() => {
              setModalVisible(true);
              setCurrentRow(undefined);
            }}
          >
            <PlusOutlined /> <FormattedMessage id="pages.searchTable.new" defaultMessage="新建" />
          </Button>,
        ]}
        request={(params) =>
          getVerificationList({ ...params } as API.System.VerificationListParams).then((res) => {
            return {
              data: res.rows,
              total: res.total,
              success: true,
            };
          })
        }
        columns={columns}
        rowSelection={{
          onChange: (_, selectedRows) => {
            setSelectedRows(selectedRows);
          },
        }}
      />
      {selectedRows?.length > 0 && (
        <FooterToolbar
          extra={
            <div>
              <FormattedMessage id="pages.searchTable.chosen" defaultMessage="已选择" />
              <a style={{ fontWeight: 600 }}>{selectedRows.length}</a>
              <FormattedMessage id="pages.searchTable.item" defaultMessage="项" />
            </div>
          }
        >
          <Button
            key="remove"
            hidden={!access.hasPerms('system:verification:remove')}
            onClick={async () => {
              Modal.confirm({
                title: '删除',
                content: '确定删除这些项吗？',
                okText: '确认',
                cancelText: '取消',
                onOk: async () => {
                  const success = await handleRemove(selectedRows);
                  if (success) {
                    setSelectedRows([]);
                    actionRef.current?.reloadAndRest?.();
                  }
                },
              });
            }}
          >
            <FormattedMessage id="pages.searchTable.batchDeletion" defaultMessage="批量删除" />
          </Button>
        </FooterToolbar>
      )}
      <UpdateForm
        onSubmit={async (values) => {
          let success = false;
          if (values.id) {
            success = await handleUpdate({ ...values } as API.System.Verification);
          } else {
            success = await handleAdd({ ...values } as API.System.Verification);
          }
          if (success) {
            setModalVisible(false);
            setCurrentRow(undefined);
            if (actionRef.current) {
              actionRef.current.reload();
            }
          }
        }}
        onCancel={() => {
          setModalVisible(false);
          setCurrentRow(undefined);
        }}
        open={modalVisible}
        values={currentRow || {}}
        riskTypeOptions={riskTypeOptions}
        verificationTypeOptions={verificationTypeOptions}
      />
    </PageContainer>
  );
};

export default VerificationTableList;
