package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.core.utils.DateUtils;
import com.ruoyi.common.security.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.UserVerificationMapper;
import com.ruoyi.system.domain.UserVerification;
import com.ruoyi.system.service.IUserVerificationService;

/**
 * 用户验证模式Service业务层处理
 *
 * @author ruoyi
 * @date 2025-03-14
 */
@Service
public class UserVerificationServiceImpl implements IUserVerificationService
{
    @Autowired
    private UserVerificationMapper userVerificationMapper;

    /**
     * 查询用户验证模式
     *
     * @param id 用户验证模式主键
     * @return 用户验证模式
     */
    @Override
    public UserVerification selectUserVerificationById(Long id)
    {
        return userVerificationMapper.selectUserVerificationById(id);
    }

    /**
     * 查询用户验证模式列表
     *
     * @param userVerification 用户验证模式
     * @return 用户验证模式
     */
    @Override
    public List<UserVerification> selectUserVerificationList(UserVerification userVerification)
    {
        userVerification.setUserId(SecurityUtils.getUserId());
        return userVerificationMapper.selectUserVerificationList(userVerification);
    }

    /**
     * 新增用户验证模式
     *
     * @param userVerification 用户验证模式
     * @return 结果
     */
    @Override
    public int insertUserVerification(UserVerification userVerification)
    {
        userVerification.setCreateTime(DateUtils.getNowDate());
        userVerification.setUserId(SecurityUtils.getUserId());
        return userVerificationMapper.insertUserVerification(userVerification);
    }

    /**
     * 修改用户验证模式
     *
     * @param userVerification 用户验证模式
     * @return 结果
     */
    @Override
    public int updateUserVerification(UserVerification userVerification)
    {
        userVerification.setUpdateTime(DateUtils.getNowDate());
        return userVerificationMapper.updateUserVerification(userVerification);
    }

    /**
     * 批量删除用户验证模式
     *
     * @param ids 需要删除的用户验证模式主键
     * @return 结果
     */
    @Override
    public int deleteUserVerificationByIds(Long[] ids)
    {
        return userVerificationMapper.deleteUserVerificationByIds(ids);
    }

    /**
     * 删除用户验证模式信息
     *
     * @param id 用户验证模式主键
     * @return 结果
     */
    @Override
    public int deleteUserVerificationById(Long id)
    {
        return userVerificationMapper.deleteUserVerificationById(id);
    }
}
