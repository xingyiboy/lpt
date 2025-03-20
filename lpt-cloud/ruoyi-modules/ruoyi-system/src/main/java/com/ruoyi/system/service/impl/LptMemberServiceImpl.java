package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.core.utils.DateUtils;
import com.ruoyi.common.security.utils.SecurityUtils;
import com.ruoyi.system.util.SaltUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.LptMemberMapper;
import com.ruoyi.system.domain.LptMember;
import com.ruoyi.system.service.ILptMemberService;

/**
 * 成员Service业务层处理
 *
 * @author xingyi
 * @date 2025-03-14
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
        lptMember.setUserId(SecurityUtils.getUserId());
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
        lptMember.setUserId(SecurityUtils.getUserId());
        // 生成随机盐值
        String salt = SaltUtils.generateSalt();
        // 设置初始密码为123456@lpt并加密
        String password = SaltUtils.hashPasswordWithSHA256("123456@lpt", salt);
        lptMember.setPassword(password);
        lptMember.setSalt(salt);
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

    /**
     * 重置成员密码
     *
     * @param lptMember
     * @return
     */
    @Override
    public int resetLptMemberPwd(LptMember lptMember) {
        LptMember updateMember = lptMemberMapper.selectLptMemberById(lptMember.getId());
        updateMember.setPassword(SaltUtils.hashPasswordWithSHA256(lptMember.getPassword(), updateMember.getSalt()));
        return lptMemberMapper.updateLptMember(updateMember);
    }
}
