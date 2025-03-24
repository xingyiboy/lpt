package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.LptMemberRecord;

/**
 * 会员登录记录Service接口
 * 
 * @author ruoyi
 * @date 2025-03-24
 */
public interface ILptMemberRecordService 
{
    /**
     * 查询会员登录记录
     * 
     * @param id 会员登录记录主键
     * @return 会员登录记录
     */
    public LptMemberRecord selectLptMemberRecordById(Long id);

    /**
     * 查询会员登录记录列表
     * 
     * @param lptMemberRecord 会员登录记录
     * @return 会员登录记录集合
     */
    public List<LptMemberRecord> selectLptMemberRecordList(LptMemberRecord lptMemberRecord);

    /**
     * 新增会员登录记录
     * 
     * @param lptMemberRecord 会员登录记录
     * @return 结果
     */
    public int insertLptMemberRecord(LptMemberRecord lptMemberRecord);

    /**
     * 修改会员登录记录
     * 
     * @param lptMemberRecord 会员登录记录
     * @return 结果
     */
    public int updateLptMemberRecord(LptMemberRecord lptMemberRecord);

    /**
     * 批量删除会员登录记录
     * 
     * @param ids 需要删除的会员登录记录主键集合
     * @return 结果
     */
    public int deleteLptMemberRecordByIds(Long[] ids);

    /**
     * 删除会员登录记录信息
     * 
     * @param id 会员登录记录主键
     * @return 结果
     */
    public int deleteLptMemberRecordById(Long id);
}
