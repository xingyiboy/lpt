package com.ruoyi.system.domain.lpt.dto;


import lpt.validator.common.model.dto.LptImageCaptchaTrack;

import javax.servlet.http.HttpSession;

/**
 * 用户登录对象
 *
 * @author ruoyi
 */
public class LoginBody {
    /**
     * 用户名
     */
    private String username;

    private HttpSession session;

    /**
     * 用户密码
     */
    private String password;

    private Long userId;

    /**
     * 登录步骤
     */
    private Integer step;

    private String uuid;

    private String id;

    private LptImageCaptchaTrack data;

    private String faceBase64;

    /**
     * 验证码
     */
    private String code;

    private String token;

    /**
     * ip
     */
    private String ip;
    /**
     * 设备
     */
    private String device;


    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getDevice() {
        return device;
    }

    public void setDevice(String device) {
        this.device = device;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getFaceBase64() {
        return faceBase64;
    }

    public void setFaceBase64(String faceBase64) {
        this.faceBase64 = faceBase64;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public LptImageCaptchaTrack getData() {
        return data;
    }

    public void setData(LptImageCaptchaTrack data) {
        this.data = data;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public HttpSession getSession() {
        return session;
    }

    public void setSession(HttpSession session) {
        this.session = session;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getStep() {
        return step;
    }

    public void setStep(Integer step) {
        this.step = step;
    }
}
