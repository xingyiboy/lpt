package com.ruoyi.framework.web.service;

import com.alibaba.druid.support.json.JSONUtils;
import com.ruoyi.common.core.domain.model.LoginBody;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.framework.web.Util.LptSignUtil;
import com.ruoyi.system.mapper.SysUserMapper;
import com.ruoyi.system.service.ISysConfigService;
import com.ruoyi.system.service.ISysUserService;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * 登录校验方法
 *
 * @author ruoyi
 */
@Component
public class SysLoginService {
    @Autowired
    private TokenService tokenService;

    @Resource
    private AuthenticationManager authenticationManager;

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private SysUserMapper sysUserMapper;

    @Autowired
    private ISysUserService userService;

    @Autowired
    private ISysConfigService configService;

    private final String COOKIE_NAME = "lpt-cookie-";


    private final String appSecret;
    private final String aesIv;
    private final Long userId;

    public SysLoginService(
            @Value("${lpt.appSecret}") String appSecret,
            @Value("${lpt.aesIv}") String aesIv,
            @Value("${lpt.userId}") Long userId
    ) {
        this.appSecret = appSecret;
        this.aesIv = aesIv;
        this.userId = userId;
    }

    /**
     * 登录验证
     *
     * @return 结果
     */
    public Object login(LoginBody loginBody) {
        String cookie = redisCache.getCacheObject(COOKIE_NAME + loginBody.getUsername());
        //发请求
        loginBody.setUserId(userId);
        Map<String, String> data = LptSignUtil.sendLogin(loginBody, cookie);
        redisCache.setCacheObject(COOKIE_NAME + loginBody.getUsername(), data.get("cookie"), 60, TimeUnit.MINUTES);
        return JSONUtils.parse(data.get("response"));
    }
}
