package com.ruoyi.web.controller.system;

import com.ruoyi.framework.web.Util.LptSignUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.model.RegisterBody;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.framework.web.service.SysRegisterService;
import com.ruoyi.system.service.ISysConfigService;

import java.util.HashMap;
import java.util.Map;

/**
 * 注册验证
 *
 * @author ruoyi
 */
@RestController
public class SysRegisterController extends BaseController
{
    @Autowired
    private SysRegisterService registerService;

    @Autowired
    private ISysConfigService configService;

    private final String appSecret;
    private final String aesIv;
    private final Long userId;

    public SysRegisterController(
            @Value("${lpt.appSecret}") String appSecret,
            @Value("${lpt.aesIv}") String aesIv,
            @Value("${lpt.userId}") Long userId
    ) {
        this.appSecret = appSecret;
        this.aesIv = aesIv;
        this.userId = userId;
    }

    @PostMapping("/register")
    public AjaxResult register(@RequestBody RegisterBody user)
    {
        String msg = registerService.register(user);
        //更新接口端用户信息
        Map<String, Object> map = new HashMap<>();
        map.put("userId", userId);
        map.put("username", user.getUsername());
        map.put("password", user.getPassword());
        LptSignUtil.sendAdd(map);
        return StringUtils.isEmpty(msg) ? success() : error(msg);
    }
}
