import { getDictValueEnum } from '@/services/system/dict'; // 导入获取字典值枚举的函数
import {
  addLptMember, // 导入添加成员的函数
  exportLptMember, // 导入导出成员的函数
  getLptMemberList, // 导入获取成员列表的函数
  removeLptMember, // 导入更新成员的函数
  resetLptMemberPwd, // 导入删除成员的函数
  updateLptMember, // 导入更新成员的函数
} from '@/services/system/iptmember';
import { DeleteOutlined, ExclamationCircleOutlined, PlusOutlined } from '@ant-design/icons'; // 导入Ant Design的图标
import {
  ActionType, // 导入ActionType类型
  FooterToolbar, // 导入FooterToolbar组件
  PageContainer, // 导入PageContainer组件
  ProColumns, // 导入ProColumns类型
  ProTable, // 导入ProTable组件
} from '@ant-design/pro-components';
import { FormattedMessage, useAccess, useIntl } from '@umijs/max'; // 导入国际化相关函数
import type { FormInstance } from 'antd'; // 导入FormInstance类型
import { Button, Form, Input, message, Modal, Switch } from 'antd'; // 导入Ant Design的组件
import React, { useEffect, useRef, useState } from 'react'; // 导入React相关函数
import UpdateForm from './edit'; // 导入编辑表单组件

/**
 * 添加节点
 */
const handleAdd = async (fields: API.System.LptMember) => {
  const hide = message.loading('正在添加'); // 显示加载消息
  try {
    const resp = await addLptMember({ ...fields }); // 调用添加成员的函数
    hide(); // 隐藏加载消息
    if (resp.code === 200) {
      message.success('添加成功'); // 显示成功消息
    } else {
      message.error(resp.msg); // 显示错误消息
    }
    return true;
  } catch (error) {
    hide(); // 隐藏加载消息
    message.error('添加失败请重试！'); // 显示错误消息
    return false;
  }
};

/**
 * 更新节点
 */
const handleUpdate = async (fields: API.System.LptMember) => {
  const hide = message.loading('正在更新'); // 显示加载消息
  try {
    const resp = await updateLptMember(fields); // 调用更新成员的函数
    hide(); // 隐藏加载消息
    if (resp.code === 200) {
      message.success('更新成功'); // 显示成功消息
    } else {
      message.error(resp.msg); // 显示错误消息
    }
    return true;
  } catch (error) {
    hide(); // 隐藏加载消息
    message.error('配置失败请重试！'); // 显示错误消息
    return false;
  }
};

/**
 * 删除节点
 */
const handleRemove = async (selectedRows: API.System.LptMember[]) => {
  const hide = message.loading('正在删除'); // 显示加载消息
  if (!selectedRows) return true; // 如果没有选中的行，直接返回true
  try {
    const resp = await removeLptMember(selectedRows.map((row) => row.id).join(',')); // 调用删除成员的函数
    hide(); // 隐藏加载消息
    if (resp.code === 200) {
      message.success('删除成功，即将刷新'); // 显示成功消息
    } else {
      message.error(resp.msg); // 显示错误消息
    }
    return true;
  } catch (error) {
    hide(); // 隐藏加载消息
    message.error('删除失败，请重试'); // 显示错误消息
    return false;
  }
};

const handleRemoveOne = async (selectedRow: API.System.LptMember) => {
  const hide = message.loading('正在删除'); // 显示加载消息
  if (!selectedRow) return true; // 如果没有选中的行，直接返回true
  try {
    const params = [selectedRow.id]; // 构造参数
    const resp = await removeLptMember(params.join(',')); // 调用删除成员的函数
    hide(); // 隐藏加载消息
    if (resp.code === 200) {
      message.success('删除成功，即将刷新'); // 显示成功消息
    } else {
      message.error(resp.msg); // 显示错误消息
    }
    return true;
  } catch (error) {
    hide(); // 隐藏加载消息
    message.error('删除失败，请重试'); // 显示错误消息
    return false;
  }
};

/**
 * 导出数据
 */
const handleExport = async () => {
  const hide = message.loading('正在导出'); // 显示加载消息
  try {
    await exportLptMember(); // 调用导出成员的函数
    hide(); // 隐藏加载消息
    message.success('导出成功'); // 显示成功消息
    return true;
  } catch (error) {
    hide(); // 隐藏加载消息
    message.error('导出失败，请重试'); // 显示错误消息
    return false;
  }
};

const MemberTableList: React.FC = () => {
  const formTableRef = useRef<FormInstance>(); // 创建表单引用

  const [modalVisible, setModalVisible] = useState<boolean>(false); // 控制模态框的显示
  const [resetPwdModalVisible, setResetPwdModalVisible] = useState<boolean>(false);
  const [resetPwdForm] = Form.useForm();
  const [selectedMember, setSelectedMember] = useState<API.System.LptMember>();

  const actionRef = useRef<ActionType>(); // 创建ActionType引用
  const [currentRow, setCurrentRow] = useState<API.System.LptMember>(); // 当前选中的行
  const [selectedRows, setSelectedRows] = useState<API.System.LptMember[]>([]); // 选中的行数组

  const [statusOptions, setStatusOptions] = useState<any>([]); // 状态选项

  const access = useAccess(); // 获取权限信息

  // 添加修改状态的处理函数
  const handleChangeStatus = async (record: API.System.LptMember) => {
    const hide = message.loading('正在修改');
    try {
      await updateLptMember({
        id: record.id,
        isRelease: record.isRelease === 1 ? 0 : 1,
      });
      hide();
      message.success('修改成功');
      actionRef.current.reload();
      return true;
    } catch (error) {
      hide();
      message.error('修改失败，请重试！');
      return false;
    }
  };
  // 添加状态修改确认框
  const showChangeStatusConfirm = (record: API.System.LptMember) => {
    Modal.confirm({
      title: '系统提示',
      content: `确认要${record.isRelease === 1 ? '不放通' : '放通'}该成员吗？`,
      onOk() {
        return handleChangeStatus(record);
      },
    });
  };

  /** 国际化配置 */
  const intl = useIntl(); // 获取国际化实例

  useEffect(() => {
    getDictValueEnum('sys_normal_disable').then((data) => {
      setStatusOptions(data); // 设置状态选项
    });
  }, []);

  const columns: ProColumns<API.System.LptMember>[] = [
    {
      title: <FormattedMessage id="system.member.id" defaultMessage="编号" />, // 国际化标题
      dataIndex: 'id',
      valueType: 'text',
      align: 'center',
    },
    {
      title: <FormattedMessage id="system.member.username" defaultMessage="用户名" />,
      dataIndex: 'username',
      valueType: 'text',
      align: 'center',
    },
    {
      title: <FormattedMessage id="system.member.password" defaultMessage="密码" />,
      dataIndex: 'password',
      valueType: 'password',
      align: 'center',
    },
    {
      title: <FormattedMessage id="system.member.salt" defaultMessage="盐值" />,
      dataIndex: 'salt',
      valueType: 'text',
      align: 'center',
    },
    {
      title: <FormattedMessage id="system.member.isRelease" defaultMessage="是否放通" />,
      dataIndex: 'isRelease',
      valueType: 'select',
      align: 'center',
      valueEnum: {
        0: { text: '否', status: 'Error' },
        1: { text: '是', status: 'Success' },
      },
      render: (_, record) => {
        return (
          <Switch
            checked={record.isRelease === 1}
            checkedChildren="否"
            unCheckedChildren="是"
            onClick={() => showChangeStatusConfirm(record)}
          />
        );
      },
    },
    {
      title: <FormattedMessage id="system.member.mailbox" defaultMessage="邮箱" />,
      dataIndex: 'mailbox',
      valueType: 'text',
      align: 'center',
    },
    {
      title: <FormattedMessage id="system.member.loginIp" defaultMessage="登录IP" />,
      dataIndex: 'loginIp',
      valueType: 'text',
      align: 'center',
    },
    {
      title: <FormattedMessage id="system.member.facility" defaultMessage="登录设备" />,
      dataIndex: 'facility',
      valueType: 'text',
      align: 'center',
    },
    {
      title: <FormattedMessage id="system.member.riskNumber" defaultMessage="风险因子" />,
      dataIndex: 'riskNumber',
      valueType: 'digit',
      align: 'center',
    },
    {
      title: <FormattedMessage id="pages.searchTable.titleOption" defaultMessage="操作" />,
      align: 'center',
      dataIndex: 'option',
      width: '220px',
      valueType: 'option',
      render: (_, record) => [
        <Button
          type="link"
          size="small"
          key="edit"
          hidden={!access.hasPerms('system:member:edit')}
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
          key="resetPwd"
          hidden={!access.hasPerms('system:member:edit')}
          onClick={() => {
            setSelectedMember(record);
            setResetPwdModalVisible(true);
            resetPwdForm.setFieldsValue({
              id: record.id,
            });
          }}
        >
          重置密码
        </Button>,
        <Button
          type="link"
          size="small"
          danger
          key="batchRemove"
          hidden={!access.hasPerms('system:member:remove')}
          onClick={async () => {
            Modal.confirm({
              title: '删除',
              content: '确定删除该项吗？',
              okText: '确认',
              cancelText: '取消',
              onOk: async () => {
                const success = await handleRemoveOne(record);
                if (success) {
                  if (actionRef.current) {
                    actionRef.current.reload();
                  }
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

  // 处理重置密码
  const handleResetPwd = async (values: { password: string; id: number }) => {
    try {
      const success = await resetLptMemberPwd({
        id: values.id,
        password: values.password,
      });
      if (success) {
        message.success('密码重置成功');
        setResetPwdModalVisible(false);
        resetPwdForm.resetFields();
        actionRef.current.reload();
      }
    } catch (error) {
      message.error('密码重置失败，请重试');
    }
  };

  return (
    <PageContainer>
      <div style={{ width: '100%', float: 'right' }}>
        <ProTable<API.System.LptMember>
          headerTitle={intl.formatMessage({
            id: 'pages.searchTable.title',
            defaultMessage: '信息',
          })}
          actionRef={actionRef}
          formRef={formTableRef}
          rowKey="id"
          key="memberList"
          search={{
            labelWidth: 120,
          }}
          toolBarRender={() => [
            <Button
              type="primary"
              key="add"
              hidden={!access.hasPerms('system:member:add')}
              onClick={async () => {
                setCurrentRow(undefined);
                setModalVisible(true);
              }}
            >
              <PlusOutlined /> <FormattedMessage id="pages.searchTable.new" defaultMessage="新建" />
            </Button>,
            <Button
              type="primary"
              key="remove"
              hidden={selectedRows?.length === 0 || !access.hasPerms('system:member:remove')}
              onClick={async () => {
                Modal.confirm({
                  title: '是否确认删除所选数据项?',
                  icon: <ExclamationCircleOutlined />,
                  content: '请谨慎操作',
                  async onOk() {
                    const success = await handleRemove(selectedRows);
                    if (success) {
                      setSelectedRows([]);
                      actionRef.current?.reloadAndRest?.();
                    }
                  },
                  onCancel() {},
                });
              }}
            >
              <DeleteOutlined />
              <FormattedMessage id="pages.searchTable.delete" defaultMessage="删除" />
            </Button>,
            <Button
              type="primary"
              key="export"
              hidden={!access.hasPerms('system:member:export')}
              onClick={async () => {
                handleExport();
              }}
            >
              <PlusOutlined />
              <FormattedMessage id="pages.searchTable.export" defaultMessage="导出" />
            </Button>,
          ]}
          request={(params) =>
            getLptMemberList({ ...params } as API.System.LptMember).then((res) => {
              const result = {
                data: res.rows,
                total: res.total,
                success: true,
              };
              return result;
            })
          }
          columns={columns}
          scroll={{ x: 'max-content' }}
          ellipsis={{ showTitle: true }}
          rowClassName={() => 'wrap'}
          rowSelection={{
            onChange: (_, selectedRows) => {
              setSelectedRows(selectedRows);
            },
          }}
        />
      </div>
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
            hidden={!access.hasPerms('system:member:remove')}
            onClick={async () => {
              Modal.confirm({
                title: '删除',
                content: '确定删除该项吗？',
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
            success = await handleUpdate({ ...values } as API.System.LptMember);
          } else {
            success = await handleAdd({ ...values } as API.System.LptMember);
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
        statusOptions={statusOptions}
      />
      <Modal
        title="重置密码"
        open={resetPwdModalVisible}
        onCancel={() => {
          setResetPwdModalVisible(false);
          resetPwdForm.resetFields();
        }}
        onOk={() => {
          resetPwdForm.submit();
        }}
      >
        <Form form={resetPwdForm} onFinish={handleResetPwd}>
          <Form.Item
            label="新密码"
            name="password"
            rules={[
              { required: true, message: '请输入新密码' },
              { min: 6, message: '密码长度不能小于6位' },
            ]}
          >
            <Input.Password placeholder="请输入新密码" />
          </Form.Item>
          <Form.Item name="id" hidden initialValue={selectedMember?.id}>
            <Input />
          </Form.Item>
        </Form>
      </Modal>
    </PageContainer>
  );
};

export default MemberTableList;
