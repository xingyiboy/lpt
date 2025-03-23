package com.ruoyi.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.system.api.domain.SysUser;
import com.ruoyi.system.domain.lpt.dto.LoginBody;
import com.ruoyi.system.domain.lpt.dto.LptData;
import com.ruoyi.system.domain.lpt.dto.LptSginDTO;
import com.ruoyi.system.mapper.SysUserMapper;
import com.ruoyi.system.util.LptSignUtil;
import lpt.application.LptImageCaptchaApplication;
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
import com.ruoyi.system.domain.LptMember;
import com.ruoyi.system.service.ILptMemberService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 成员Controller
 *
 * @author xingyi
 * @date 2025-03-14
 */
@RestController
@RequestMapping("/member")
public class LptMemberController extends BaseController
{
    @Autowired
    private ILptMemberService lptMemberService;
    @Autowired
    private SysUserMapper sysUserMapper;

    /**
     * 成员登录接口
     * @param
     * @return
     */
    @PostMapping("/login")
    public Object login(@RequestBody LoginBody loginBody,HttpSession session){
        if(loginBody.getUserId()==null){
            throw new RuntimeException("用户id不能为空");
        }
        //TODO 后面加上签名 AES加密
        return lptMemberService.login(loginBody,session);
    }

//    private LptData getSignData(LptSginDTO lptSginDTO){
//        if(lptSginDTO.getUserId()==null||StringUtils.isEmpty(lptSginDTO.getUserId().toString())){
//            throw new RuntimeException("用户id不能为空");
//        }
//        SysUser sysUser = sysUserMapper.selectUserById(lptSginDTO.getUserId());
//        if(sysUser==null){
//            throw new RuntimeException("userId系统用户不存在");
//        }
//        String decryptString = null;
//        try {
//            decryptString = LptSignUtil.decrypt(lptSginDTO.getData(),sysUser.getSecretKey(),sysUser.getOffset())
//        } catch (Exception e) {
//            throw new RuntimeException("签名错误，解密失败:"+e);
//        }
//
//    }

    /**
     * 查询成员列表
     */
    @RequiresPermissions("system:member:list")
    @GetMapping("/list")
    public TableDataInfo list(LptMember lptMember)
    {
        startPage();
        List<LptMember> list = lptMemberService.selectLptMemberList(lptMember);
        return getDataTable(list);
    }

    /**
     * 导出成员列表
     */
    @RequiresPermissions("system:member:export")
    @Log(title = "成员", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, LptMember lptMember)
    {
        List<LptMember> list = lptMemberService.selectLptMemberList(lptMember);
        ExcelUtil<LptMember> util = new ExcelUtil<LptMember>(LptMember.class);
        util.exportExcel(response, list, "成员数据");
    }

    /**
     * 获取成员详细信息
     */
    @RequiresPermissions("system:member:query")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(lptMemberService.selectLptMemberById(id));
    }

    /**
     * 新增成员
     */
    @RequiresPermissions("system:member:add")
    @Log(title = "成员", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody LptMember lptMember)
    {
        return toAjax(lptMemberService.insertLptMember(lptMember));
    }

    /**
     * 修改成员
     */
    @RequiresPermissions("system:member:edit")
    @Log(title = "成员", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody LptMember lptMember)
    {
        return toAjax(lptMemberService.updateLptMember(lptMember));
    }

    /**
     * 重置密码
     */
    @RequiresPermissions("system:member:edit")
    @Log(title = "成员", businessType = BusinessType.UPDATE)
    @PutMapping("/resetPwd")
    public AjaxResult resetPwd(@RequestBody LptMember lptMember)
    {
        return toAjax(lptMemberService.resetLptMemberPwd(lptMember));
    }

    /**
     * 删除成员
     */
    @RequiresPermissions("system:member:remove")
    @Log(title = "成员", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(lptMemberService.deleteLptMemberByIds(ids));
    }
}
