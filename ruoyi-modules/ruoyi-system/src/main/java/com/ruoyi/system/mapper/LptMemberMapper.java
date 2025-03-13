package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.LptMember;

/**
 * 成员Mapper接口
 * 
 * @author ruoyi
 * @date 2025-03-13
 */
public interface LptMemberMapper 
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
     * 删除成员
     * 
     * @param id 成员主键
     * @return 结果
     */
    public int deleteLptMemberById(Long id);

    /**
     * 批量删除成员
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteLptMemberByIds(Long[] ids);
}
