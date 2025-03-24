package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.core.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.LptMemberRecordMapper;
import com.ruoyi.system.domain.LptMemberRecord;
import com.ruoyi.system.service.ILptMemberRecordService;

/**
 * 会员登录记录Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-03-24
 */
@Service
public class LptMemberRecordServiceImpl implements ILptMemberRecordService 
{
    @Autowired
    private LptMemberRecordMapper lptMemberRecordMapper;

    /**
     * 查询会员登录记录
     * 
     * @param id 会员登录记录主键
     * @return 会员登录记录
     */
    @Override
    public LptMemberRecord selectLptMemberRecordById(Long id)
    {
        return lptMemberRecordMapper.selectLptMemberRecordById(id);
    }

    /**
     * 查询会员登录记录列表
     * 
     * @param lptMemberRecord 会员登录记录
     * @return 会员登录记录
     */
    @Override
    public List<LptMemberRecord> selectLptMemberRecordList(LptMemberRecord lptMemberRecord)
    {
        return lptMemberRecordMapper.selectLptMemberRecordList(lptMemberRecord);
    }

    /**
     * 新增会员登录记录
     * 
     * @param lptMemberRecord 会员登录记录
     * @return 结果
     */
    @Override
    public int insertLptMemberRecord(LptMemberRecord lptMemberRecord)
    {
        lptMemberRecord.setCreateTime(DateUtils.getNowDate());
        return lptMemberRecordMapper.insertLptMemberRecord(lptMemberRecord);
    }

    /**
     * 修改会员登录记录
     * 
     * @param lptMemberRecord 会员登录记录
     * @return 结果
     */
    @Override
    public int updateLptMemberRecord(LptMemberRecord lptMemberRecord)
    {
        lptMemberRecord.setUpdateTime(DateUtils.getNowDate());
        return lptMemberRecordMapper.updateLptMemberRecord(lptMemberRecord);
    }

    /**
     * 批量删除会员登录记录
     * 
     * @param ids 需要删除的会员登录记录主键
     * @return 结果
     */
    @Override
    public int deleteLptMemberRecordByIds(Long[] ids)
    {
        return lptMemberRecordMapper.deleteLptMemberRecordByIds(ids);
    }

    /**
     * 删除会员登录记录信息
     * 
     * @param id 会员登录记录主键
     * @return 结果
     */
    @Override
    public int deleteLptMemberRecordById(Long id)
    {
        return lptMemberRecordMapper.deleteLptMemberRecordById(id);
    }
}
