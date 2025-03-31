package com.ruoyi.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.hutool.json.JSONUtil;
import com.alibaba.druid.support.json.JSONUtils;
import com.alibaba.fastjson2.JSON;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.security.utils.SecurityUtils;
import com.ruoyi.system.api.domain.SysUser;
import com.ruoyi.system.api.model.LoginUser;
import com.ruoyi.system.domain.lpt.dto.LoginBody;
import com.ruoyi.system.domain.lpt.dto.LptData;
import com.ruoyi.system.domain.lpt.dto.LptSginDTO;
import com.ruoyi.system.mapper.SysUserMapper;
import com.ruoyi.system.util.LptSignUtil;
import lpt.LptMailboxUtil;
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
    public String login(@RequestBody LptData lptData,HttpSession session){
        try{
            long currentTime = System.currentTimeMillis();  // 获取当前时间的时间戳
            long timestamp = Long.parseLong(lptData.getTimestamp());  // 获取 lptData 中的时间戳
            // 判断时间戳是否在10分钟内
            if (currentTime - timestamp <= 10 * 60 * 1000) {
                SysUser sysUser = sysUserMapper.selectUserById(Long.valueOf(lptData.getUserId()));
                //解密
                String decrypt = LptSignUtil.decrypt(lptData.getData(), sysUser.getSecretKey(), sysUser.getOffset());
                //解密后转换成对象
                LoginBody loginBody = JSON.parseObject(decrypt, LoginBody.class);
                //判断签名是否正确
                // 3. 构建请求参数Map
                Map<String, String> params = new HashMap<>();
                params.put("timestamp", lptData.getTimestamp());
                params.put("data", decrypt);
                params.put("userId", lptData.getUserId());
                // 4. 判断签名是否正确
                if(!LptSignUtil.generateSign(params,sysUser.getSecretKey()).equals(lptData.getSign())){
                    throw new RuntimeException("签名错误");
                }
                //完成
                if(StringUtils.isBlank(loginBody.getUserId().toString())){
                    throw new RuntimeException("用户id不能为空");
                }
                //将token带上前缀
                if(loginBody.getToken()!=null){
                    loginBody.setToken("token:"+loginBody.getToken());
                }

                String jsonString = JSONUtil.toJsonStr(lptMemberService.login(loginBody, session));
                return LptSignUtil.encrypt(jsonString, sysUser.getSecretKey(), sysUser.getOffset());

            }else{
                throw new RuntimeException("时间戳过期");
            }
        }catch (Exception e){
            throw new RuntimeException(e);
        }
    }

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
    @Log(title = "成员", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody LptMember lptMember)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        lptMember.setUserId(loginUser.getUserid());
        return toAjax(lptMemberService.insertLptMember(lptMember));
    }

    /**
     * 新增成员 接口
     */
    @Log(title = "成员", businessType = BusinessType.INSERT)
    @PostMapping("/addHttp")
    public String addHttp(@RequestBody LptData lptData)
    {
        try{
            long currentTime = System.currentTimeMillis();  // 获取当前时间的时间戳
            long timestamp = Long.parseLong(lptData.getTimestamp());  // 获取 lptData 中的时间戳
            // 判断时间戳是否在10分钟内
            if (currentTime - timestamp <= 10 * 60 * 1000) {
                SysUser sysUser = sysUserMapper.selectUserById(Long.valueOf(lptData.getUserId()));
                //解密
                String decrypt = LptSignUtil.decrypt(lptData.getData(), sysUser.getSecretKey(), sysUser.getOffset());
                //解密后转换成对象
                LptMember lptMember = JSON.parseObject(decrypt, LptMember.class);
                //判断签名是否正确
                // 3. 构建请求参数Map
                Map<String, String> params = new HashMap<>();
                params.put("timestamp", lptData.getTimestamp());
                params.put("data", decrypt);
                params.put("userId", lptData.getUserId());
                // 4. 判断签名是否正确
                if(!LptSignUtil.generateSign(params,sysUser.getSecretKey()).equals(lptData.getSign())){
                    throw new RuntimeException("签名错误");
                }
                //完成
                lptMember.setRiskNumber(0L);
                if(lptMember.getUserId() == null){
                    throw new RuntimeException("用户id不能为空");
                }
                LptMember search = new LptMember();
                search.setUsername(lptMember.getUsername());
                search.setUserId(lptMember.getUserId());
                List<LptMember> lptMembers = lptMemberService.selectLptMemberList(search);
                if (lptMembers.size() > 0) {
                    throw new RuntimeException("用户名已存在");
                }
                String jsonString = JSONUtil.toJsonStr(toAjax(lptMemberService.insertLptMember(lptMember)));
                return LptSignUtil.encrypt(jsonString, sysUser.getSecretKey(), sysUser.getOffset());

            }else{
                throw new RuntimeException("时间戳过期");
            }
        }catch (Exception e){
            throw new RuntimeException(e);
        }

    }


    /**
     * 修改成员
     */
    @RequiresPermissions("system:member:edit")
    @Log(title = "成员", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody LptMember lptMember)
    {
        LptMember lptMember1 = lptMemberService.selectLptMemberById(lptMember.getId());
        lptMember.setUsername(lptMember1.getUsername());
        lptMember.setUserId(SecurityUtils.getLoginUser().getUserid());
        return toAjax(lptMemberService.updateLptMember(lptMember));
    }

    /**
     * 修改成员 接口
     */
    @Log(title = "成员", businessType = BusinessType.UPDATE)
    @PutMapping("/editHttp")
    public String editHttp(@RequestBody LptData lptData)
    {
        try{
            long currentTime = System.currentTimeMillis();  // 获取当前时间的时间戳
            long timestamp = Long.parseLong(lptData.getTimestamp());  // 获取 lptData 中的时间戳
            // 判断时间戳是否在10分钟内
            if (currentTime - timestamp <= 10 * 60 * 1000) {
                SysUser sysUser = sysUserMapper.selectUserById(Long.valueOf(lptData.getUserId()));
                //解密
                String decrypt = LptSignUtil.decrypt(lptData.getData(), sysUser.getSecretKey(), sysUser.getOffset());
                //解密后转换成对象
                LptMember lptMember = JSON.parseObject(decrypt, LptMember.class);
                //判断签名是否正确
                // 3. 构建请求参数Map
                Map<String, String> params = new HashMap<>();
                params.put("timestamp", lptData.getTimestamp());
                params.put("data", decrypt);
                params.put("userId", lptData.getUserId());
                // 4. 判断签名是否正确
                if(!LptSignUtil.generateSign(params,sysUser.getSecretKey()).equals(lptData.getSign())){
                    throw new RuntimeException("签名错误");
                }
                //完成
                if (lptMember.getUserId() == null) {
                    throw new RuntimeException("用户id不能为空");
                }
                if (lptMember.getUsername() == null) {
                    throw new RuntimeException("会员账号不能为空");
                }
                String jsonString = JSONUtil.toJsonStr(toAjax(lptMemberService.updateLptMember(lptMember)));
                return LptSignUtil.encrypt(jsonString, sysUser.getSecretKey(), sysUser.getOffset());

            }else{
                throw new RuntimeException("时间戳过期");
            }
        }catch (Exception e){
            throw new RuntimeException(e);
        }
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
