package com.ruoyi.system.domain.lpt.dto;

import com.ruoyi.system.domain.UserVerification;

import java.util.List;

/**
 * @Description: 登录校验
 * @author: huangguoshan
 * @date: 2025年03月16日 16:45
 */

public class LoginVerify {

    private String username;

    private String password;

    private Integer step;

    private String code;

    private String token;

    private String uuid;

    private List<UserVerification> userVerifications;

    private String ip;

    private String device;

    private Long userId;

    private Long riskNumber;

    private Double longitude;

    private Double latitude;

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Long getRiskNumber() {
        return riskNumber;
    }

    public void setRiskNumber(Long riskNumber) {
        this.riskNumber = riskNumber;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

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

    public List<UserVerification> getUserVerifications() {
        return userVerifications;
    }

    public void setUserVerifications(List<UserVerification> userVerifications) {
        this.userVerifications = userVerifications;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public LoginVerify(String username, String password, Integer step,List<UserVerification> userVerifications,String token)  {
        this.username = username;
        this.password = password;
        this.step = step;
        this.userVerifications = userVerifications;
        this.token = token;
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
