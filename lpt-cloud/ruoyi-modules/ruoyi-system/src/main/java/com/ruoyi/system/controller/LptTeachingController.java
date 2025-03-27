package com.ruoyi.system.controller;

import java.util.List;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.log.annotation.Log;
import com.ruoyi.common.log.enums.BusinessType;
import com.ruoyi.common.security.annotation.RequiresPermissions;
import com.ruoyi.system.domain.LptTeaching;
import com.ruoyi.system.service.ILptTeachingService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 官网教程Controller
 * 
 * @author ruoyi
 * @date 2025-03-28
 */
@RestController
@RequestMapping("/teaching")
public class LptTeachingController extends BaseController
{
    @Autowired
    private ILptTeachingService lptTeachingService;

    /**
     * 查询官网教程列表
     */
    @RequiresPermissions("system:teaching:list")
    @GetMapping("/list")
    public TableDataInfo list(LptTeaching lptTeaching)
    {
        startPage();
        List<LptTeaching> list = lptTeachingService.selectLptTeachingList(lptTeaching);
        return getDataTable(list);
    }

    /**
     * 导出官网教程列表
     */
    @RequiresPermissions("system:teaching:export")
    @Log(title = "官网教程", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, LptTeaching lptTeaching)
    {
        List<LptTeaching> list = lptTeachingService.selectLptTeachingList(lptTeaching);
        ExcelUtil<LptTeaching> util = new ExcelUtil<LptTeaching>(LptTeaching.class);
        util.exportExcel(response, list, "官网教程数据");
    }

    /**
     * 获取官网教程详细信息
     */
    @RequiresPermissions("system:teaching:query")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(lptTeachingService.selectLptTeachingById(id));
    }

    /**
     * 新增官网教程
     */
    @RequiresPermissions("system:teaching:add")
    @Log(title = "官网教程", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody LptTeaching lptTeaching)
    {
        return toAjax(lptTeachingService.insertLptTeaching(lptTeaching));
    }

    /**
     * 修改官网教程
     */
    @RequiresPermissions("system:teaching:edit")
    @Log(title = "官网教程", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody LptTeaching lptTeaching)
    {
        return toAjax(lptTeachingService.updateLptTeaching(lptTeaching));
    }

    /**
     * 删除官网教程
     */
    @RequiresPermissions("system:teaching:remove")
    @Log(title = "官网教程", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(lptTeachingService.deleteLptTeachingByIds(ids));
    }
}
