declare namespace API.System {
  // 成员信息对象
  export interface LptMember {
    id: number;
    username: string;
    password: string;
    salt: string;
    isRelease: number;
    mailbox: string;
    loginIp: string;
    facility: string;
    riskNumber: number;
    createBy?: string;
    createTime?: Date;
    updateBy?: string;
    updateTime?: Date;
    remark?: string;
  }

  // 成员列表参数
  export interface LptMemberListParams {
    id?: number;
    username?: string;
    isRelease?: number;
    mailbox?: string;
    loginIp?: string;
    facility?: string;
    riskNumber?: number;
    pageSize?: number;
    current?: number;
  }

  // 成员信息查询结果
  export interface LptMemberInfoResult {
    code: number;
    msg: string;
    data: LptMember;
  }

  // 成员分页查询结果
  export interface LptMemberPageResult {
    code: number;
    msg: string;
    total: number;
    rows: LptMember[];
  }
}
