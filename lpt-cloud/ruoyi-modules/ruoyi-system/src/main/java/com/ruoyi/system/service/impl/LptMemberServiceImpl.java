package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.constant.UserConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.utils.DateUtils;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.core.utils.ip.IpUtils;
import com.ruoyi.common.redis.service.RedisService;
import com.ruoyi.common.security.utils.SecurityUtils;
import com.ruoyi.system.api.model.LoginUser;
import com.ruoyi.system.domain.LptMember;
import com.ruoyi.system.domain.UserVerification;
import com.ruoyi.system.domain.lpt.Enum.RiskTypeEnum;
import com.ruoyi.system.domain.lpt.dto.LoginBody;
import com.ruoyi.system.domain.lpt.dto.LoginVerify;
import com.ruoyi.system.domain.lpt.Enum.VerificationTypeEnum;
import com.ruoyi.system.mapper.LptMemberMapper;
import com.ruoyi.system.mapper.UserVerificationMapper;
import com.ruoyi.system.service.ILptMemberService;
import com.ruoyi.system.service.ISysConfigService;
import com.ruoyi.system.util.SaltUtils;
import lpt.LptCharacterUtil;
import lpt.LptDigitalCountUtil;
import lpt.LptFaceComparisonUtil;
import lpt.LptMailboxUtil;
import lpt.application.LptImageCaptchaApplication;
import lpt.application.LptTACBuilder;
import lpt.application.vo.LptCaptchaResponse;
import lpt.application.vo.LptImageCaptchaVO;
import lpt.common.response.LptApiResponse;
import lpt.faceDTO.LptFaceCompareRepVo;
import lpt.faceDTO.LptFaceCompareReqVo;
import lpt.validator.common.model.dto.MatchParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpSession;

/**
 * 成员Service业务层处理
 *
 * @author xingyi
 * @date 2025-03-14
 */
@Service
public class LptMemberServiceImpl implements ILptMemberService
{
    @Autowired
    private LptMemberMapper lptMemberMapper;
    @Autowired
    private RedisService redisService;
    @Autowired
    private ISysConfigService configService;
    @Autowired
    private UserVerificationMapper userVerificationMapper;

    private final String LPT_PREFIX = "LoginVerify-";

    private final Long TIME_OUT = 10L;

    /**
     * 查询成员
     *
     * @param id 成员主键
     * @return 成员
     */
    @Override
    public LptMember selectLptMemberById(Long id)
    {
        return lptMemberMapper.selectLptMemberById(id);
    }

    /**
     * 查询成员列表
     *
     * @param lptMember 成员
     * @return 成员
     */
    @Override
    public List<LptMember> selectLptMemberList(LptMember lptMember)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        Long userid = loginUser.getUserid();
        lptMember.setUserId(userid);
        return lptMemberMapper.selectLptMemberList(lptMember);
    }

    /**
     * 新增成员
     *
     * @param lptMember 成员
     * @return 结果
     */
    @Override
    public int insertLptMember(LptMember lptMember)
    {
        lptMember.setCreateTime(DateUtils.getNowDate());
        // 生成随机盐值
        String salt = SaltUtils.generateSalt();
        // 设置初始密码为123456@lpt并加密

        if(lptMember.getPassword() == null){
            String password = SaltUtils.hashPasswordWithSHA256("123456@lpt", salt);
            lptMember.setPassword(password);
        }else {
            String password = SaltUtils.hashPasswordWithSHA256(lptMember.getPassword(), salt);
            lptMember.setPassword(password);
        }
        lptMember.setSalt(salt);
        return lptMemberMapper.insertLptMember(lptMember);
    }

    /**
     * 修改成员
     *
     * @param lptMember 成员
     * @return 结果
     */
    @Override
    public int updateLptMember(LptMember lptMember)
    {
        lptMember.setUpdateTime(DateUtils.getNowDate());
        return lptMemberMapper.updateLptMember(lptMember);
    }

    /**
     * 批量删除成员
     *
     * @param ids 需要删除的成员主键
     * @return 结果
     */
    @Override
    public int deleteLptMemberByIds(Long[] ids)
    {
        return lptMemberMapper.deleteLptMemberByIds(ids);
    }

    /**
     * 删除成员信息
     *
     * @param id 成员主键
     * @return 结果
     */
    @Override
    public int deleteLptMemberById(Long id)
    {
        return lptMemberMapper.deleteLptMemberById(id);
    }

    /**
     * 重置成员密码
     *
     * @param lptMember
     * @return
     */
    @Override
    public int resetLptMemberPwd(LptMember lptMember) {
        LptMember updateMember = lptMemberMapper.selectLptMemberById(lptMember.getId());
        updateMember.setPassword(SaltUtils.hashPasswordWithSHA256(lptMember.getPassword(), updateMember.getSalt()));
        return lptMemberMapper.updateLptMember(updateMember);
    }

    /**
     * 登录
     *
     * @param loginBody
     * @return
     */
    @Override
    public Object login(LoginBody loginBody, HttpSession session) {
        VerificationTypeEnum verificationTypeEnum = null;
        //获取redis的数据
        LoginVerify loginVerify = null;
        //当传过来的step == 0 时，表示主动要求密码校验
        if(loginBody.getStep()!=null&&loginBody.getStep()==VerificationTypeEnum.PASSWORD_VALIDATION.getCode()){
            //主动要求密码校验 处理刷新页面的情况
            loginVerify = null;
        }else {
            loginVerify = redisService.getCacheObject(LPT_PREFIX + loginBody.getUsername());
        }
        if(loginVerify==null){
            //第一次请求 直接设为密码校验
            verificationTypeEnum = VerificationTypeEnum.fromCode(VerificationTypeEnum.PASSWORD_VALIDATION.getCode());
        }else {
            verificationTypeEnum = VerificationTypeEnum.fromCode(loginVerify.getUserVerifications().get(loginVerify.getStep()).getVerificationId());
        }
        switch (verificationTypeEnum) {
            case PASSWORD_VALIDATION:
                return R.ok(handlePasswordValidation(loginBody)); //密码校验处理
            case CHARACTER_VALIDATION:
                return R.ok(handleCharacterValidation(loginBody,loginVerify)); //字符校验处理
            case CALCULATION_VALIDATION:
                return R.ok(handleCalculationValidation(loginBody,loginVerify)); //计算校验处理
            case EMAIL_VALIDATION:
                return R.ok(handleEmailValidation(loginBody,loginVerify)); //邮件校验处理
            case SLIDING_VALIDATION:
                return handleSlidingValidation(loginBody,loginVerify,session); //滑动校验处理
            case ROTATION_VALIDATION:
                return handleRotationValidation(loginBody,loginVerify,session); //旋转校验处理
            case CLICK_VALIDATION:
                return handleClickValidation(loginBody,loginVerify,session); //点击校验处理
            case CONCAT_VALIDATION:
                return handleConcatValidation(loginBody,loginVerify,session); //滑动还原验证码
            case FACE_VALIDATION:
                return handleFaceValidation(loginBody,loginVerify); //人脸校验处理
            default:
                throw new ServiceException("不支持的校验类型: " + verificationTypeEnum);
        }
    }

    /**
     * 登录之前操作
     * @return
     */
    public String loginBefore(LoginVerify loginVerify) {
        //把登录IP和设备信息存入数据库 清空风险因子
        LptMember serach = new LptMember();
        serach.setUserId(loginVerify.getUserId());
        serach.setUsername(loginVerify.getUsername());
        LptMember lptMember = lptMemberMapper.selectLptMemberByUsername(serach);
        lptMember.setLoginIp(loginVerify.getIp());
        lptMember.setFacility(loginVerify.getDevice());
        lptMember.setRiskNumber(loginVerify.getRiskNumber()-10);
        lptMemberMapper.updateLptMember(lptMember);
        return loginVerify.getToken();
    }

    //人脸校验
    private  Object  handleFaceValidation(LoginBody loginBody, LoginVerify loginVerify) {
        LptMember getParmas = new LptMember();
        getParmas.setUserId(loginVerify.getUserId());
        getParmas.setUsername(loginBody.getUsername());
        LptMember lptMember = lptMemberMapper.selectLptMemberByUsername(getParmas);
        if(StringUtils.isNotBlank(lptMember.getFaceBase64())){
            //有人脸
            LptFaceCompareReqVo lptFaceCompareReqVo = new LptFaceCompareReqVo();
            lptFaceCompareReqVo.setImageBase64A(lptMember.getFaceBase64());
            lptFaceCompareReqVo.setImageBase64B(loginBody.getFaceBase64());
            LptFaceCompareRepVo lptFaceCompareRepVo = LptFaceComparisonUtil.compareFace(lptFaceCompareReqVo);
            if(lptFaceCompareRepVo.getMessage()==null){
                //校验成功 大于50的概率认为他是本人
                if(lptFaceCompareRepVo.getConfidence()>50){
                    //关掉redis
                    redisService.deleteObject(LPT_PREFIX + loginVerify.getUsername());
                    //验证成功
                    //判断
                    if(loginVerify.getStep()+1==loginVerify.getUserVerifications().size()){
                        //校验完成
                        return R.ok(loginBefore(loginVerify),"success");
                    }else {
                        //还有下一步
                        loginVerify.setStep(loginVerify.getStep()+1);
                        //存redis
                        redisService.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify, TIME_OUT, TimeUnit.MINUTES);
                        //返回下一步码
                        return R.ok(String.valueOf(loginVerify.getUserVerifications().get(loginVerify.getStep()).getVerificationId()),"success");
                    }

                }else {
                    return R.ok("人脸相似度太低，请重新上传");
                }
            }else {
                //校验异常
                if(lptFaceCompareRepVo.getMessage().equals("Image B is not face")){
                    return R.ok("此照片不是人脸，请重新上传");
                }
                return R.ok(lptFaceCompareRepVo.getMessage());
            }
        }else {
            //没有人脸 直接验证通过
            //验证成功
            //判断
            if(loginVerify.getStep()+1==loginVerify.getUserVerifications().size()){
                //校验完成
                return R.ok(loginBefore(loginVerify),"success");
            }else {
                //还有下一步
                loginVerify.setStep(loginVerify.getStep()+1);
                //存redis
                redisService.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify, TIME_OUT, TimeUnit.MINUTES);
                //返回下一步码
                return R.ok(String.valueOf(loginVerify.getUserVerifications().get(loginVerify.getStep()).getVerificationId()),"success");
            }
        }
    }

    //滑动还原验证码
    private Object handleConcatValidation(LoginBody loginBody, LoginVerify loginVerify, HttpSession session) {
        //判断是否开始校验
        if(loginBody.getId()!=null){
            //校验
            LptImageCaptchaApplication application = (LptImageCaptchaApplication) session.getAttribute("captchaApplication-"+loginBody.getUsername());
            LptApiResponse<?> valid = application.matching(loginBody.getId(), new MatchParam(loginBody.getData()));
            if(valid.isSuccess()){
                if(loginVerify.getStep()+1==loginVerify.getUserVerifications().size()){
                    //校验完成
                    valid.setMsg(loginBefore(loginVerify));
                }else {
                    //还有下一步
                    loginVerify.setStep(loginVerify.getStep()+1);
                    //删除校验码
                    loginVerify.setCode(null);
                    redisService.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify, TIME_OUT, TimeUnit.MINUTES);
                    //返回下一步码
                    valid.setMsg(String.valueOf(loginVerify.getUserVerifications().get(loginVerify.getStep()).getVerificationId()));
                }
                return valid;
            }else {
                return valid;
            }
        }
        //生成字符校验图片
        LptImageCaptchaApplication application = LptTACBuilder.builder()
                .addDefaultTemplate()
                // expire 设置验证码的过期时间 ， default 为默认过期时间 为 10秒, WORD_IMAGE_CLICK文字点选验证码的过期时间为 60秒
                .expire("default", 10000L)
                .expire("WORD_IMAGE_CLICK", 60000L)
                // 设置背景图， 这里为 SLIDER WORD_IMAGE_CLICK ROTATE CONCAT 各设置了一张背景图
                .addResource("SLIDER", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .addResource("WORD_IMAGE_CLICK", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .addResource("ROTATE", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .addResource("CONCAT", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .build();
        // 生成验证码数据， 可以将该数据直接返回给前端 ，
        // 支持生成 滑动验证码(SLIDER)、旋转验证码(ROTATE)、滑动还原验证码(CONCAT)、文字点选验证码(WORD_IMAGE_CLICK)
        LptCaptchaResponse<LptImageCaptchaVO> res = application.generateCaptcha("CONCAT");
        //记录session
        session.setAttribute("captchaApplication-"+loginBody.getUsername(), application);
        return res;
    }

    //点击校验处理
    private Object handleClickValidation(LoginBody loginBody,LoginVerify loginVerify,HttpSession session) {
        //判断是否开始校验
        if(loginBody.getId()!=null){
            //校验
            LptImageCaptchaApplication application = (LptImageCaptchaApplication) session.getAttribute("captchaApplication-"+loginBody.getUsername());
            LptApiResponse<?> valid = application.matching(loginBody.getId(), new MatchParam(loginBody.getData()));
            if(valid.isSuccess()){
                if(loginVerify.getStep()+1==loginVerify.getUserVerifications().size()){
                    //校验完成
                    valid.setMsg(loginBefore(loginVerify));
                }else {
                    //还有下一步
                    loginVerify.setStep(loginVerify.getStep()+1);
                    //删除校验码
                    loginVerify.setCode(null);
                    redisService.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify, TIME_OUT, TimeUnit.MINUTES);
                    //返回下一步码
                    valid.setMsg(String.valueOf(loginVerify.getUserVerifications().get(loginVerify.getStep()).getVerificationId()));
                }
                return valid;
            }else {
                return valid;
            }
        }
        //生成字符校验图片
        LptImageCaptchaApplication application = LptTACBuilder.builder()
                .addDefaultTemplate()
                // expire 设置验证码的过期时间 ， default 为默认过期时间 为 10秒, WORD_IMAGE_CLICK文字点选验证码的过期时间为 60秒
                .expire("default", 10000L)
                .expire("WORD_IMAGE_CLICK", 60000L)
                // 设置背景图， 这里为 SLIDER WORD_IMAGE_CLICK ROTATE CONCAT 各设置了一张背景图
                .addResource("SLIDER", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .addResource("WORD_IMAGE_CLICK", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .addResource("ROTATE", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .addResource("CONCAT", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .build();
        // 生成验证码数据， 可以将该数据直接返回给前端 ，
        // 支持生成 滑动验证码(SLIDER)、旋转验证码(ROTATE)、滑动还原验证码(CONCAT)、文字点选验证码(WORD_IMAGE_CLICK)
        LptCaptchaResponse<LptImageCaptchaVO> res = application.generateCaptcha("WORD_IMAGE_CLICK");
        //记录session
        session.setAttribute("captchaApplication-"+loginBody.getUsername(), application);
        return res;
    }

    //旋转校验处理
    private Object handleRotationValidation(LoginBody loginBody,LoginVerify loginVerify,HttpSession session) {
        //判断是否开始校验
        if(loginBody.getId()!=null){
            //校验
            LptImageCaptchaApplication application = (LptImageCaptchaApplication) session.getAttribute("captchaApplication-"+loginBody.getUsername());
            LptApiResponse<?> valid = application.matching(loginBody.getId(), new MatchParam(loginBody.getData()));
            if(valid.isSuccess()){
                if(loginVerify.getStep()+1==loginVerify.getUserVerifications().size()){
                    //校验完成
                    valid.setMsg(loginBefore(loginVerify));
                }else {
                    //还有下一步
                    loginVerify.setStep(loginVerify.getStep()+1);
                    //删除校验码
                    loginVerify.setCode(null);
                    redisService.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify, TIME_OUT, TimeUnit.MINUTES);
                    //返回下一步码
                    valid.setMsg(String.valueOf(loginVerify.getUserVerifications().get(loginVerify.getStep()).getVerificationId()));
                }
                return valid;
            }else {
                return valid;
            }
        }
        //生成字符校验图片
        LptImageCaptchaApplication application = LptTACBuilder.builder()
                .addDefaultTemplate()
                // expire 设置验证码的过期时间 ， default 为默认过期时间 为 10秒, WORD_IMAGE_CLICK文字点选验证码的过期时间为 60秒
                .expire("default", 10000L)
                .expire("WORD_IMAGE_CLICK", 60000L)
                // 设置背景图， 这里为 SLIDER WORD_IMAGE_CLICK ROTATE CONCAT 各设置了一张背景图
                .addResource("SLIDER", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .addResource("WORD_IMAGE_CLICK", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .addResource("ROTATE", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .addResource("CONCAT", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .build();
        // 生成验证码数据， 可以将该数据直接返回给前端 ，
        // 支持生成 滑动验证码(SLIDER)、旋转验证码(ROTATE)、滑动还原验证码(CONCAT)、文字点选验证码(WORD_IMAGE_CLICK)
        LptCaptchaResponse<LptImageCaptchaVO> res = application.generateCaptcha("ROTATE");
        //记录session
        session.setAttribute("captchaApplication-"+loginBody.getUsername(), application);
        return res;
    }

    /**
     * 处理滑动校验
     * @param loginBody
     * @param loginVerify
     * @return
     */
    private Object handleSlidingValidation(LoginBody loginBody,LoginVerify loginVerify,HttpSession session) {
        //判断是否开始校验
        if(loginBody.getId()!=null){
            //校验
            LptImageCaptchaApplication application = (LptImageCaptchaApplication) session.getAttribute("captchaApplication-"+loginBody.getUsername());
            LptApiResponse<?> valid = application.matching(loginBody.getId(), new MatchParam(loginBody.getData()));
            if(valid.isSuccess()){
                if(loginVerify.getStep()+1==loginVerify.getUserVerifications().size()){
                    //校验完成
                    valid.setMsg(loginBefore(loginVerify));
                }else {
                    //还有下一步
                    loginVerify.setStep(loginVerify.getStep()+1);
                    //删除校验码
                    loginVerify.setCode(null);
                    redisService.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify, TIME_OUT, TimeUnit.MINUTES);
                    //返回下一步码
                    valid.setMsg(String.valueOf(loginVerify.getUserVerifications().get(loginVerify.getStep()).getVerificationId()));
                }
                return valid;
            }else {
                return valid;
            }
        }
        //生成字符校验图片
        LptImageCaptchaApplication application = LptTACBuilder.builder()
                .addDefaultTemplate()
                // expire 设置验证码的过期时间 ， default 为默认过期时间 为 10秒, WORD_IMAGE_CLICK文字点选验证码的过期时间为 60秒
                .expire("default", 10000L)
                .expire("WORD_IMAGE_CLICK", 60000L)
                // 设置背景图， 这里为 SLIDER WORD_IMAGE_CLICK ROTATE CONCAT 各设置了一张背景图
                .addResource("SLIDER", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .addResource("WORD_IMAGE_CLICK", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .addResource("ROTATE", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .addResource("CONCAT", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .build();
        // 生成验证码数据， 可以将该数据直接返回给前端 ，
        // 支持生成 滑动验证码(SLIDER)、旋转验证码(ROTATE)、滑动还原验证码(CONCAT)、文字点选验证码(WORD_IMAGE_CLICK)
        LptCaptchaResponse<LptImageCaptchaVO> res = application.generateCaptcha("SLIDER");
        //记录session
        session.setAttribute("captchaApplication-"+loginBody.getUsername(), application);
        return res;
    }

    /**
     * 密码校验处理(所有的初始都要经过密码校验)
     * @param loginBody
     * @return
     */
    private Object handlePasswordValidation(LoginBody loginBody) {
        // 登录前置校验 校验账号和密码的非法性
        loginPreCheck(loginBody.getUsername(), loginBody.getPassword());
        //通过系统用户id和会员用户名查询会员信息
        LptMember search = new LptMember();
        search.setUserId(loginBody.getUserId());
        search.setUsername(loginBody.getUsername());
        LptMember lptMember = lptMemberMapper.selectLptMemberByUsername(search);
        //校验 盐值密码
        if(!SaltUtils.verifyPasswordWithSHA256(loginBody.getPassword(), lptMember.getSalt(), lptMember.getPassword())){
            throw new ServiceException("密码错误");
        }
        //校验密码完成
        //检测下一步 先默认全部低风险
        UserVerification userVerification = new UserVerification();
        userVerification.setUserId(loginBody.getUserId());
        //默认低风险
        userVerification.setRiskType(RiskTypeEnum.LOW.getCode());
        //判断IP
        if(StringUtils.isNoneBlank(lptMember.getLoginIp())){
            if(!loginBody.getIp().equals(lptMember.getLoginIp())){
                //不同IP直接是高风险 加40因子
                lptMember.setRiskNumber(lptMember.getRiskNumber()+20);
            }
        }
        //判断登录设备
        if(StringUtils.isNoneBlank(lptMember.getFacility())){
            if (!loginBody.getDevice().equals(lptMember.getFacility())){
                //不同设备直接是中风险 加20因子
                lptMember.setRiskNumber(lptMember.getRiskNumber()+20);
            }
        }
        if(lptMember.getRiskNumber()>=40){
            //高风险
            userVerification.setRiskType(RiskTypeEnum.HIGH.getCode());
        }else if(lptMember.getRiskNumber()>=20){
            //中风险
            userVerification.setRiskType(RiskTypeEnum.MEDIUM.getCode());
        }

        List<UserVerification> userVerifications = userVerificationMapper.selectUserVerificationList(userVerification);
        //创建loginVerify
        LoginVerify loginVerify = new LoginVerify(loginBody.getUsername(),loginBody.getPassword(),0,userVerifications,loginBody.getToken());
        //判断IP
        if(StringUtils.isNoneBlank(loginBody.getIp())){
            loginVerify.setIp(loginBody.getIp());
        }
        //判断登录设备
        if(StringUtils.isNoneBlank(loginBody.getDevice())){
            loginVerify.setDevice(loginBody.getDevice());
        }
        loginVerify.setRiskNumber(lptMember.getRiskNumber());
        //设置用户编号
        loginVerify.setUserId(loginBody.getUserId());
        //生成UUID
        loginVerify.setUuid(UUID.randomUUID().toString());
        //存入redis
        redisService.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify, TIME_OUT, TimeUnit.MINUTES);
        //返回下一步码
        Map<String, String> map = new HashMap<>();
        //用uuid存储然后最后登录成功再取出判断 防止有人直接请求最后结果导致直接登录
        map.put("uuid",loginVerify.getUuid());
        //设置验证类型步骤码
        if(userVerifications.size()==0){
            //直接通过
            map.put("step",loginBefore(loginVerify));
        }else {
            //下一步
            map.put("step",String.valueOf(loginVerify.getUserVerifications().get(loginVerify.getStep()).getVerificationId()));
        }
        return map;
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
                //校验成功 开始判断
                if(loginVerify.getStep()+1==loginVerify.getUserVerifications().size()){
                    //校验完成
                    return loginBefore(loginVerify);
                }else {
                    //还有下一步
                    loginVerify.setStep(loginVerify.getStep()+1);
                    //删除校验码
                    loginVerify.setCode(null);
                    redisService.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify, TIME_OUT, TimeUnit.MINUTES);
                    //返回下一步码
                    return String.valueOf(loginVerify.getUserVerifications().get(loginVerify.getStep()).getVerificationId());
                }
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
        //信息存入redis
        redisService.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify, TIME_OUT, TimeUnit.MINUTES);
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
                //校验成功 开始判断
                if(loginVerify.getStep()+1==loginVerify.getUserVerifications().size()){
                    //校验完成
                    return loginBefore(loginVerify);
                }else {
                    //还有下一步
                    loginVerify.setStep(loginVerify.getStep()+1);
                    //删除校验码
                    loginVerify.setCode(null);
                    redisService.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify, TIME_OUT, TimeUnit.MINUTES);
                    //返回下一步码
                    return String.valueOf(loginVerify.getUserVerifications().get(loginVerify.getStep()).getVerificationId());
                }
            }else {
                //校验失败 继续生成字符校验图片
                return "验证码错误";
            }
        }
        //生成字符校验图片
        Map<String, Object> verification = LptDigitalCountUtil.getShearVerification(6, 17, 200,80);
        String image = (String) verification.get("image");
        String code = verification.get("code").toString();
        //记录正确结果
        loginVerify.setCode(code);
        //信息存入redis step代表当前步骤
        redisService.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify, TIME_OUT, TimeUnit.MINUTES);
        return image;
    }

    private String handleEmailValidation(LoginBody loginBody,LoginVerify loginVerify) {
        //判断是否开始校验
        if(loginBody.getCode()!=null){
            //校验字符 是否和redis存入的一样
            if(loginBody.getCode().equals(loginVerify.getCode())){
                //校验成功 开始判断
                if(loginVerify.getStep()+1==loginVerify.getUserVerifications().size()){
                    //校验完成
                    return loginBefore(loginVerify);
                }else {
                    //还有下一步
                    loginVerify.setStep(loginVerify.getStep()+1);
                    //删除校验码
                    loginVerify.setCode(null);
                    redisService.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify, TIME_OUT, TimeUnit.MINUTES);
                    //返回下一步码
                    return String.valueOf(loginVerify.getUserVerifications().get(loginVerify.getStep()).getVerificationId());
                }
            }else {
                //校验失败 继续生成字符校验图片
                return "验证码错误";
            }
        }
        //生成6位验证码
        String code =  redisService.getCacheObject(LPT_PREFIX+"mailbox-"+loginBody.getUsername());
        LptMember getParmas = new LptMember();
        getParmas.setUserId(loginVerify.getUserId());
        getParmas.setUsername(loginBody.getUsername());
        LptMember lptMember = lptMemberMapper.selectLptMemberByUsername(getParmas);
        if(code == null){
            code  =  generateCaptcha(6);
            if (StringUtils.isNotBlank(lptMember.getMailbox())) {
                //邮箱不为空
                //发送邮箱验证码
                LptMailboxUtil.send("smtp.qq.com",465,true,"2832914238@qq.com","zedgqaxuwhnldgab",lptMember.getMailbox(),"令牌通验证码","尊敬的用户，您好！\n" +
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
            }
            redisService.setCacheObject(LPT_PREFIX+"mailbox-"+loginBody.getUsername(), code, 1L, TimeUnit.MINUTES);
        }
        //记录正确结果
        loginVerify.setCode(code);
        //信息存入redis step代表当前步骤
        redisService.setCacheObject(LPT_PREFIX+loginBody.getUsername(), loginVerify, TIME_OUT, TimeUnit.MINUTES);
        return (StringUtils.isNotBlank(lptMember.getMailbox()) ? lptMember.getMailbox():"该账号暂无填写邮箱")+"-验证码:"+code;
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
     * 登录前置校验
     * @param username 用户名
     * @param password 用户密码
     */
    public void loginPreCheck(String username, String password)
    {
        // 用户名或密码为空 错误
        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password))
        {
        }
        // 密码如果不在指定范围内 错误
        if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
                || password.length() > UserConstants.PASSWORD_MAX_LENGTH)
        {
        }
        // 用户名不在指定范围内 错误
        if (username.length() < UserConstants.USERNAME_MIN_LENGTH
                || username.length() > UserConstants.USERNAME_MAX_LENGTH)
        {
        }
        // IP黑名单校验
        String blackStr = configService.selectConfigByKey("sys.login.blackIPList");
        if (IpUtils.isMatchedIp(blackStr, IpUtils.getIpAddr()))
        {
        }
    }
}
