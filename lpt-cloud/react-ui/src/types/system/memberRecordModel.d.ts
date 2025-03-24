declare namespace API.System {
  type LptMemberRecord = {
    id: number;
    memberId?: number;
    userId?: number;
    loginIp?: string;
    decive?: string;
    latitude?: number;
    longitude?: number;
    createBy?: string;
    createTime?: Date;
    updateBy?: string;
    updateTime?: Date;
    remark?: string;
  };
}
