package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.UserVerification;

/**
 * 用户验证模式Service接口
 * 
 * @author ruoyi
 * @date 2025-03-14
 */
public interface IUserVerificationService 
{
    /**
     * 查询用户验证模式
     * 
     * @param id 用户验证模式主键
     * @return 用户验证模式
     */
    public UserVerification selectUserVerificationById(Long id);

    /**
     * 查询用户验证模式列表
     * 
     * @param userVerification 用户验证模式
     * @return 用户验证模式集合
     */
    public List<UserVerification> selectUserVerificationList(UserVerification userVerification);

    /**
     * 新增用户验证模式
     * 
     * @param userVerification 用户验证模式
     * @return 结果
     */
    public int insertUserVerification(UserVerification userVerification);

    /**
     * 修改用户验证模式
     * 
     * @param userVerification 用户验证模式
     * @return 结果
     */
    public int updateUserVerification(UserVerification userVerification);

    /**
     * 批量删除用户验证模式
     * 
     * @param ids 需要删除的用户验证模式主键集合
     * @return 结果
     */
    public int deleteUserVerificationByIds(Long[] ids);

    /**
     * 删除用户验证模式信息
     * 
     * @param id 用户验证模式主键
     * @return 结果
     */
    public int deleteUserVerificationById(Long id);
}
