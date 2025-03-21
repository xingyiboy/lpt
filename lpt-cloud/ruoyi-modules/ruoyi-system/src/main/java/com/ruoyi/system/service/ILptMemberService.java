package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.LptMember;
import com.ruoyi.system.domain.dto.LoginBody;

import javax.servlet.http.HttpSession;

/**
 * 成员Service接口
 *
 * @author xingyi
 * @date 2025-03-14
 */
public interface ILptMemberService
{
    /**
     * 查询成员
     *
     * @param id 成员主键
     * @return 成员
     */
    public LptMember selectLptMemberById(Long id);

    /**
     * 查询成员列表
     *
     * @param lptMember 成员
     * @return 成员集合
     */
    public List<LptMember> selectLptMemberList(LptMember lptMember);

    /**
     * 新增成员
     *
     * @param lptMember 成员
     * @return 结果
     */
    public int insertLptMember(LptMember lptMember);

    /**
     * 修改成员
     *
     * @param lptMember 成员
     * @return 结果
     */
    public int updateLptMember(LptMember lptMember);

    /**
     * 批量删除成员
     *
     * @param ids 需要删除的成员主键集合
     * @return 结果
     */
    public int deleteLptMemberByIds(Long[] ids);

    /**
     * 删除成员信息
     *
     * @param id 成员主键
     * @return 结果
     */
    public int deleteLptMemberById(Long id);

    /**
     * 重置成员密码
     * @param lptMember
     * @return
     */
    public int resetLptMemberPwd(LptMember lptMember);

    /**
     * 登录
     * @param loginBody
     * @param username
     * @param session
     * @return
     */
    Object login(LoginBody loginBody, String username, HttpSession session);
}
