package com.ruoyi.system.domain.dto;

/**
 * @Description: 登录校验
 * @author: huangguoshan
 * @date: 2025年03月16日 16:45
 */

public class LoginVerify {

    private String username;

    private String password;

    private Integer Step;

    private String code;

    private String token;

    private String uuid;


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

    public LoginVerify(String username, String password, Integer step) {
        this.username = username;
        this.password = password;
        Step = step;
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
        return Step;
    }

    public void setStep(Integer step) {
        Step = step;
    }
}
