declare namespace API.System {
  // 用户验证模式对象
  export interface Verification {
    id: number;
    userId: number;
    riskType: number;
    verificationId: number;
    sort: number;
    createBy?: string;
    createTime?: Date;
    updateBy?: string;
    updateTime?: Date;
    remark?: string;
  }

  // 用户验证模式列表参数
  export interface VerificationListParams {
    id?: number;
    userId?: number;
    riskType?: number;
    verificationId?: number;
    sort?: number;
    pageSize?: number;
    current?: number;
  }

  // 用户验证模式信息查询结果
  export interface VerificationInfoResult {
    code: number;
    msg: string;
    data: Verification;
  }

  // 用户验证模式分页查询结果
  export interface VerificationPageResult {
    code: number;
    msg: string;
    total: number;
    rows: Verification[];
  }
}
