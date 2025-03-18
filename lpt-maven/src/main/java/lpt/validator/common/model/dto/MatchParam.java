package lpt.validator.common.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author: 天爱有情
 * @date 2024/8/19 15:12
 * @Description 验证码匹配的对象
 */
@Data
@NoArgsConstructor
public class MatchParam {
    /** 轨迹信息. */
    private LptImageCaptchaTrack track;
    /** 检测到的设备信息. */
    private Drives drives;
    /** 留一个扩展属性. */
    private Object extendData;


    public MatchParam(LptImageCaptchaTrack track) {
        this.track = track;
    }

    public MatchParam(LptImageCaptchaTrack track, Drives drives) {
        this.track = track;
        this.drives = drives;
    }

}
