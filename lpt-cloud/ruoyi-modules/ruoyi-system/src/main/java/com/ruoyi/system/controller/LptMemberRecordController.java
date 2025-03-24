package com.ruoyi.system.controller;

import java.util.List;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.security.utils.SecurityUtils;
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
import com.ruoyi.system.domain.LptMemberRecord;
import com.ruoyi.system.service.ILptMemberRecordService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 会员登录记录Controller
 *
 * @author ruoyi
 * @date 2025-03-24
 */
@RestController
@RequestMapping("/memberRecord")
public class LptMemberRecordController extends BaseController
{
    @Autowired
    private ILptMemberRecordService lptMemberRecordService;

    /**
     * 查询会员登录记录列表
     */
    @RequiresPermissions("system:memberRecord:list")
    @GetMapping("/list")
    public TableDataInfo list(LptMemberRecord lptMemberRecord)
    {
        startPage();
        lptMemberRecord.setUserId(SecurityUtils.getUserId());
        List<LptMemberRecord> list = lptMemberRecordService.selectLptMemberRecordList(lptMemberRecord);
        return getDataTable(list);
    }

    /**
     * 导出会员登录记录列表
     */
    @RequiresPermissions("system:memberRecord:export")
    @Log(title = "会员登录记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, LptMemberRecord lptMemberRecord)
    {
        List<LptMemberRecord> list = lptMemberRecordService.selectLptMemberRecordList(lptMemberRecord);
        ExcelUtil<LptMemberRecord> util = new ExcelUtil<LptMemberRecord>(LptMemberRecord.class);
        util.exportExcel(response, list, "会员登录记录数据");
    }

    /**
     * 获取会员登录记录详细信息
     */
    @RequiresPermissions("system:memberRecord:query")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(lptMemberRecordService.selectLptMemberRecordById(id));
    }

    /**
     * 新增会员登录记录
     */
    @RequiresPermissions("system:memberRecord:add")
    @Log(title = "会员登录记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody LptMemberRecord lptMemberRecord)
    {
        return toAjax(lptMemberRecordService.insertLptMemberRecord(lptMemberRecord));
    }

    /**
     * 修改会员登录记录
     */
    @RequiresPermissions("system:memberRecord:edit")
    @Log(title = "会员登录记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody LptMemberRecord lptMemberRecord)
    {
        return toAjax(lptMemberRecordService.updateLptMemberRecord(lptMemberRecord));
    }

    /**
     * 删除会员登录记录
     */
    @RequiresPermissions("system:memberRecord:remove")
    @Log(title = "会员登录记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(lptMemberRecordService.deleteLptMemberRecordByIds(ids));
    }
}
