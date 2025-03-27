package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.LptTeaching;

/**
 * 官网教程Mapper接口
 * 
 * @author ruoyi
 * @date 2025-03-28
 */
public interface LptTeachingMapper 
{
    /**
     * 查询官网教程
     * 
     * @param id 官网教程主键
     * @return 官网教程
     */
    public LptTeaching selectLptTeachingById(Long id);

    /**
     * 查询官网教程列表
     * 
     * @param lptTeaching 官网教程
     * @return 官网教程集合
     */
    public List<LptTeaching> selectLptTeachingList(LptTeaching lptTeaching);

    /**
     * 新增官网教程
     * 
     * @param lptTeaching 官网教程
     * @return 结果
     */
    public int insertLptTeaching(LptTeaching lptTeaching);

    /**
     * 修改官网教程
     * 
     * @param lptTeaching 官网教程
     * @return 结果
     */
    public int updateLptTeaching(LptTeaching lptTeaching);

    /**
     * 删除官网教程
     * 
     * @param id 官网教程主键
     * @return 结果
     */
    public int deleteLptTeachingById(Long id);

    /**
     * 批量删除官网教程
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteLptTeachingByIds(Long[] ids);
}
