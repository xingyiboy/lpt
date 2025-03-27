package com.ruoyi.system.domain.lpt.dto;

/**
 * @Description: TODO
 * @author: huangguoshan
 * @date: 2025年03月21日 11:48
 */
public class LptData {

    private String timestamp;

    private String data;

    private String userId;

    private String sign;

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }
}
