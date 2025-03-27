package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.core.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.LptTeachingMapper;
import com.ruoyi.system.domain.LptTeaching;
import com.ruoyi.system.service.ILptTeachingService;

/**
 * 官网教程Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-03-28
 */
@Service
public class LptTeachingServiceImpl implements ILptTeachingService 
{
    @Autowired
    private LptTeachingMapper lptTeachingMapper;

    /**
     * 查询官网教程
     * 
     * @param id 官网教程主键
     * @return 官网教程
     */
    @Override
    public LptTeaching selectLptTeachingById(Long id)
    {
        return lptTeachingMapper.selectLptTeachingById(id);
    }

    /**
     * 查询官网教程列表
     * 
     * @param lptTeaching 官网教程
     * @return 官网教程
     */
    @Override
    public List<LptTeaching> selectLptTeachingList(LptTeaching lptTeaching)
    {
        return lptTeachingMapper.selectLptTeachingList(lptTeaching);
    }

    /**
     * 新增官网教程
     * 
     * @param lptTeaching 官网教程
     * @return 结果
     */
    @Override
    public int insertLptTeaching(LptTeaching lptTeaching)
    {
        lptTeaching.setCreateTime(DateUtils.getNowDate());
        return lptTeachingMapper.insertLptTeaching(lptTeaching);
    }

    /**
     * 修改官网教程
     * 
     * @param lptTeaching 官网教程
     * @return 结果
     */
    @Override
    public int updateLptTeaching(LptTeaching lptTeaching)
    {
        lptTeaching.setUpdateTime(DateUtils.getNowDate());
        return lptTeachingMapper.updateLptTeaching(lptTeaching);
    }

    /**
     * 批量删除官网教程
     * 
     * @param ids 需要删除的官网教程主键
     * @return 结果
     */
    @Override
    public int deleteLptTeachingByIds(Long[] ids)
    {
        return lptTeachingMapper.deleteLptTeachingByIds(ids);
    }

    /**
     * 删除官网教程信息
     * 
     * @param id 官网教程主键
     * @return 结果
     */
    @Override
    public int deleteLptTeachingById(Long id)
    {
        return lptTeachingMapper.deleteLptTeachingById(id);
    }
}
