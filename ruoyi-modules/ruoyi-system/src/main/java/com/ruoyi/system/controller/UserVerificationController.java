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
import com.ruoyi.system.domain.UserVerification;
import com.ruoyi.system.service.IUserVerificationService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 用户验证模式Controller
 * 
 * @author ruoyi
 * @date 2025-03-14
 */
@RestController
@RequestMapping("/verification")
public class UserVerificationController extends BaseController
{
    @Autowired
    private IUserVerificationService userVerificationService;

    /**
     * 查询用户验证模式列表
     */
    @RequiresPermissions("system:verification:list")
    @GetMapping("/list")
    public TableDataInfo list(UserVerification userVerification)
    {
        startPage();
        List<UserVerification> list = userVerificationService.selectUserVerificationList(userVerification);
        return getDataTable(list);
    }

    /**
     * 导出用户验证模式列表
     */
    @RequiresPermissions("system:verification:export")
    @Log(title = "用户验证模式", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, UserVerification userVerification)
    {
        List<UserVerification> list = userVerificationService.selectUserVerificationList(userVerification);
        ExcelUtil<UserVerification> util = new ExcelUtil<UserVerification>(UserVerification.class);
        util.exportExcel(response, list, "用户验证模式数据");
    }

    /**
     * 获取用户验证模式详细信息
     */
    @RequiresPermissions("system:verification:query")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(userVerificationService.selectUserVerificationById(id));
    }

    /**
     * 新增用户验证模式
     */
    @RequiresPermissions("system:verification:add")
    @Log(title = "用户验证模式", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody UserVerification userVerification)
    {
        return toAjax(userVerificationService.insertUserVerification(userVerification));
    }

    /**
     * 修改用户验证模式
     */
    @RequiresPermissions("system:verification:edit")
    @Log(title = "用户验证模式", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody UserVerification userVerification)
    {
        return toAjax(userVerificationService.updateUserVerification(userVerification));
    }

    /**
     * 删除用户验证模式
     */
    @RequiresPermissions("system:verification:remove")
    @Log(title = "用户验证模式", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(userVerificationService.deleteUserVerificationByIds(ids));
    }
}
