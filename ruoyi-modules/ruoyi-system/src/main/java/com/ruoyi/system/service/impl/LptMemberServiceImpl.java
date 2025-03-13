package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.core.utils.DateUtils;
import com.ruoyi.common.security.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.LptMemberMapper;
import com.ruoyi.system.domain.LptMember;
import com.ruoyi.system.service.ILptMemberService;

/**
 * 成员Service业务层处理
 *
 * @author ruoyi
 * @date 2025-03-13
 */
@Service
public class LptMemberServiceImpl implements ILptMemberService
{
    @Autowired
    private LptMemberMapper lptMemberMapper;

    /**
     * 查询成员
     *
     * @param id 成员主键
     * @return 成员
     */
    @Override
    public LptMember selectLptMemberById(Long id)
    {
        return lptMemberMapper.selectLptMemberById(id);
    }

    /**
     * 查询成员列表
     *
     * @param lptMember 成员
     * @return 成员
     */
    @Override
    public List<LptMember> selectLptMemberList(LptMember lptMember)
    {
        lptMember.setCreateBy(SecurityUtils.getUserId().toString());
        return lptMemberMapper.selectLptMemberList(lptMember);
    }

    /**
     * 新增成员
     *
     * @param lptMember 成员
     * @return 结果
     */
    @Override
    public int insertLptMember(LptMember lptMember)
    {
        lptMember.setCreateTime(DateUtils.getNowDate());
        lptMember.setCreateBy(SecurityUtils.getUserId().toString());
        return lptMemberMapper.insertLptMember(lptMember);
    }

    /**
     * 修改成员
     *
     * @param lptMember 成员
     * @return 结果
     */
    @Override
    public int updateLptMember(LptMember lptMember)
    {
        lptMember.setUpdateTime(DateUtils.getNowDate());
        return lptMemberMapper.updateLptMember(lptMember);
    }

    /**
     * 批量删除成员
     *
     * @param ids 需要删除的成员主键
     * @return 结果
     */
    @Override
    public int deleteLptMemberByIds(Long[] ids)
    {
        return lptMemberMapper.deleteLptMemberByIds(ids);
    }

    /**
     * 删除成员信息
     *
     * @param id 成员主键
     * @return 结果
     */
    @Override
    public int deleteLptMemberById(Long id)
    {
        return lptMemberMapper.deleteLptMemberById(id);
    }
}
