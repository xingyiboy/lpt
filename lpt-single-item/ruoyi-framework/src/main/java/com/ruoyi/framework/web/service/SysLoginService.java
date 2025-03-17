package com.ruoyi.framework.web.service;

import com.ruoyi.common.core.domain.model.LoginBody;
import com.ruoyi.framework.web.Enum.VerificationTypeEnum;
import com.ruoyi.framework.web.domain.LoginVerify;
import jakarta.annotation.Resource;
import lpt.LptCharacterUtil;
import lpt.LptDigitalCountUtil;
import lpt.LptMailboxUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.RedisServer;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.exception.user.BlackListException;
import com.ruoyi.common.exception.user.CaptchaException;
import com.ruoyi.common.exception.user.CaptchaExpireException;
import com.ruoyi.common.exception.user.UserNotExistsException;
import com.ruoyi.common.exception.user.UserPasswordNotMatchException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.MessageUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.ip.IpUtils;
import com.ruoyi.framework.manager.AsyncManager;
import com.ruoyi.framework.manager.factory.AsyncFactory;
import com.ruoyi.framework.security.context.AuthenticationContextHolder;
import com.ruoyi.system.service.ISysConfigService;
import com.ruoyi.system.service.ISysUserService;

import java.util.Map;
import java.util.Random;

/**
 * 登录校验方法
 *
 * @author ruoyi
 */
@Component
public class SysLoginService
{
    @Autowired
    private TokenService tokenService;

    @Resource
    private AuthenticationManager authenticationManager;

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private ISysUserService userService;

    @Autowired
    private ISysConfigService configService;

    private final String LPT_PREFIX = "LoginVerify-";

    /**
     * 登录验证
     *
     * @return 结果
     */
    public String login(LoginBody loginBody)
    {
        VerificationTypeEnum verificationTypeEnum = null;
        //获取redis的数据
        LoginVerify loginVerify = null;
        //当传过来的step == 0 时，表示主动要求密码校验
        if(loginBody.getStep()!=null&&loginBody.getStep()==VerificationTypeEnum.PASSWORD_VALIDATION.getCode()){
            //主动要求密码校验 处理刷新页面的情况
            loginVerify = null;
        }else {
            loginVerify = redisCache.getCacheObject(LPT_PREFIX + loginBody.getUsername());
        }
        if(loginVerify==null){
            //第一次请求 直接设为密码校验
            verificationTypeEnum = VerificationTypeEnum.fromCode(VerificationTypeEnum.PASSWORD_VALIDATION.getCode());
        }else {
            verificationTypeEnum = VerificationTypeEnum.fromCode(loginVerify.getStep());
        }
        switch (verificationTypeEnum) {
            case PASSWORD_VALIDATION:
                return handlePasswordValidation(loginBody);
            case CHARACTER_VALIDATION:
                return handleCharacterValidation(loginBody,loginVerify);
            case CALCULATION_VALIDATION:
                return handleCalculationValidation(loginBody,loginVerify);
            case EMAIL_VALIDATION:
                return handleEmailValidation(loginBody,loginVerify);
            case SLIDING_VALIDATION:
                return handleSlidingValidation(loginBody,loginVerify);
            case ROTATION_VALIDATION:
                return handleRotationValidation(loginBody,loginVerify);
            case CLICK_VALIDATION:
                return handleClickValidation(loginBody,loginVerify);
            default:
                throw new ServiceException("不支持的校验类型: " + verificationTypeEnum);
        }
    }

    private String handleClickValidation(LoginBody loginBody,LoginVerify loginVerify) {
        return null;
    }

    private String handleRotationValidation(LoginBody loginBody,LoginVerify loginVerify) {
        return null;
    }

    private String handleSlidingValidation(LoginBody loginBody,LoginVerify loginVerify) {
        return null;
    }

    /**
     * 密码校验处理
     * @param loginBody
     * @return
     */
    private String handlePasswordValidation(LoginBody loginBody) {
        // 登录前置校验 校验账号和密码
        loginPreCheck(loginBody.getUsername(), loginBody.getPassword());
        // 用户验证
        Authentication authentication = null;
        try
        {
            UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(loginBody.getUsername(), loginBody.getPassword());
            AuthenticationContextHolder.setContext(authenticationToken);
            // 该方法会去调用UserDetailsServiceImpl.loadUserByUsername
            authentication = authenticationManager.authenticate(authenticationToken);
        }
        catch (Exception e)
        {
            if (e instanceof BadCredentialsException)
            {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(loginBody.getUsername(), Constants.LOGIN_FAIL, MessageUtils.message("user.password.not.match")));
                throw new UserPasswordNotMatchException();
            }
            else
            {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(loginBody.getUsername(), Constants.LOGIN_FAIL, e.getMessage()));
                throw new ServiceException(e.getMessage());
            }
        }
        finally
        {
            AuthenticationContextHolder.clearContext();
        }
        AsyncManager.me().execute(AsyncFactory.recordLogininfor(loginBody.getUsername(), Constants.LOGIN_SUCCESS, MessageUtils.message("user.login.success")));
        LoginUser loginUser = (LoginUser) authentication.getPrincipal();
        recordLoginInfo(loginUser.getUserId());


        //存入redis 进行下一步
        LoginVerify loginVerify = new LoginVerify(loginBody.getUsername(),loginBody.getPassword(),VerificationTypeEnum.CHARACTER_VALIDATION.getCode());
        // 生成token
        loginVerify.setToken(tokenService.createToken(loginUser));
        redisCache.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify);
        //返回下一步码
        return String.valueOf(VerificationTypeEnum.CHARACTER_VALIDATION.getCode());
    }

    /**
     * 字符校验处理
     * @param loginBody
     * @param loginVerify
     * @return
     */
    private String handleCharacterValidation(LoginBody loginBody,LoginVerify loginVerify) {
        //判断是否开始校验
        if(loginBody.getCode()!=null){
            //校验字符 是否和redis存入的一样
            if(loginBody.getCode().equals(loginVerify.getCode())){
                //校验成功 进行下一步
                loginVerify.setStep(VerificationTypeEnum.CALCULATION_VALIDATION.getCode());
                loginVerify.setCode(null);
                redisCache.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify);
                //返回下一步码
                return String.valueOf(VerificationTypeEnum.CALCULATION_VALIDATION.getCode());
            }else {
                //校验失败 继续生成字符校验图片
                return "验证码错误";
            }
        }
        //生成字符校验图片
        Map<String, Object> verification = LptCharacterUtil.getLineNumberVerification(6, 17, 4,200,80);
        String image = (String) verification.get("image");
        String code = (String) verification.get("code");
        //记录正确结果
        loginVerify.setCode(code);
        //信息存入redis step代表当前步骤
        redisCache.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify);
        return image;
    }

    /**
     * 计算校验
     * @param loginBody
     * @param loginVerify
     * @return
     */
    private String handleCalculationValidation(LoginBody loginBody,LoginVerify loginVerify) {
        //判断是否开始校验
        if(loginBody.getCode()!=null){
            //校验字符 是否和redis存入的一样
            if(loginBody.getCode().equals(loginVerify.getCode())){
                //校验成功 进行下一步
                loginVerify.setStep(VerificationTypeEnum.EMAIL_VALIDATION.getCode());
                redisCache.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify);
                //返回下一步码
                return String.valueOf(VerificationTypeEnum.EMAIL_VALIDATION.getCode());
            }else {
                //校验失败 继续生成字符校验图片
            }
        }
        //生成字符校验图片
        Map<String, Object> verification = LptDigitalCountUtil.getShearVerification(6, 17, 200,80);
        String image = (String) verification.get("image");
        String code = verification.get("code").toString();
        //记录正确结果
        loginVerify.setCode(code);
        //信息存入redis step代表当前步骤
        redisCache.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify);
        return image;
    }

    private String handleEmailValidation(LoginBody loginBody,LoginVerify loginVerify) {
        //判断是否开始校验
        if(loginBody.getCode()!=null){
            //校验字符 是否和redis存入的一样
            if(loginBody.getCode().equals(loginVerify.getCode())){
                //校验成功 进行下一步
                loginVerify.setStep(VerificationTypeEnum.SLIDING_VALIDATION.getCode());
                redisCache.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify);
                //返回下一步码
                return String.valueOf(VerificationTypeEnum.SLIDING_VALIDATION.getCode());
            }else {
                //校验失败 继续生成字符校验图片
            }
        }
        //发送邮箱验证码
        String code = generateCaptcha(6);
        LptMailboxUtil.send("smtp.qq.com",465,true,"2832914238@qq.com","zedgqaxuwhnldgab","2416820386@qq.com","令牌通验证码","尊敬的用户，您好！\n" +
                "\n" +
                "您正在进行邮箱验证操作，您的验证码是：\n" +
                "\n" +
                ""+code+"\n" +
                "\n" +
                "该验证码仅有效5分钟，请尽快完成验证。如果您没有进行相关操作，可能是有人误操作，请忽略此邮件。\n" +
                "\n" +
                "感谢您的使用！\n" +
                "\n" +
                "若有任何疑问，请联系我们的客服团队，我们将竭诚为您服务。\n" +
                "\n" +
                "祝您使用愉快！\n" +
                "\n" +
                "【令牌通】团队");
//        记录正确结果
        loginVerify.setCode(code);
        //信息存入redis step代表当前步骤
        redisCache.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify);
        return "2416820386@qq.com-验证码:"+code;
    }

    /**
     * 随机生成验证码
     * @param length
     * @return
     */
    public static String generateCaptcha(int length) {
        String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder captcha = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(CHARACTERS.length());  // 获取随机字符的索引
            captcha.append(CHARACTERS.charAt(index));  // 获取字符并添加到验证码中
        }

        return captcha.toString();
    }



    /**
     * 登录成功返回token
     * @param username
     * @param password
     * @return
     */
    public String loginSuccess(String username, String password){
        return null;
    }


    /**
     * 登录前置校验
     * @param username 用户名
     * @param password 用户密码
     */
    public void loginPreCheck(String username, String password)
    {
        // 用户名或密码为空 错误
        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password))
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("not.null")));
            throw new UserNotExistsException();
        }
        // 密码如果不在指定范围内 错误
        if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
                || password.length() > UserConstants.PASSWORD_MAX_LENGTH)
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.password.not.match")));
            throw new UserPasswordNotMatchException();
        }
        // 用户名不在指定范围内 错误
        if (username.length() < UserConstants.USERNAME_MIN_LENGTH
                || username.length() > UserConstants.USERNAME_MAX_LENGTH)
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.password.not.match")));
            throw new UserPasswordNotMatchException();
        }
        // IP黑名单校验
        String blackStr = configService.selectConfigByKey("sys.login.blackIPList");
        if (IpUtils.isMatchedIp(blackStr, IpUtils.getIpAddr()))
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("login.blocked")));
            throw new BlackListException();
        }
    }

    /**
     * 记录登录信息
     *
     * @param userId 用户ID
     */
    public void recordLoginInfo(Long userId)
    {
        SysUser sysUser = new SysUser();
        sysUser.setUserId(userId);
        sysUser.setLoginIp(IpUtils.getIpAddr());
        sysUser.setLoginDate(DateUtils.getNowDate());
        userService.updateUserProfile(sysUser);
    }
}
