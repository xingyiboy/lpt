package lpt.interceptor.impl;

import lpt.common.AnyMap;
import lpt.common.response.ApiResponse;
import lpt.common.util.CollectionUtils;
import lpt.common.util.ObjectUtils;
import lpt.interceptor.CaptchaInterceptor;
import lpt.interceptor.Context;
import lpt.validator.common.model.dto.ImageCaptchaTrack;
import lpt.validator.common.model.dto.MatchParam;

/**
 * @Author: 天爱有情
 * @date 2023/1/4 10:10
 * @Description 轨迹参数校验， 如果轨迹参数为空抛异常
 */
public class ParamCheckCaptchaInterceptor implements CaptchaInterceptor {
    @Override
    public ApiResponse<?> beforeValid(Context context, String type, MatchParam matchParam, AnyMap validData) {
        checkParam(matchParam.getTrack());
        return ApiResponse.ofSuccess();
    }

    @Override
    public String getName() {
        return "param_check";
    }

    public void checkParam(ImageCaptchaTrack imageCaptchaTrack) {
        if (ObjectUtils.isEmpty(imageCaptchaTrack.getBgImageWidth())) {
            throw new IllegalArgumentException("bgImageWidth must not be null");
        }
        if (ObjectUtils.isEmpty(imageCaptchaTrack.getBgImageHeight())) {
            throw new IllegalArgumentException("bgImageHeight must not be null");
        }
        if (ObjectUtils.isEmpty(imageCaptchaTrack.getStartTime())) {
            throw new IllegalArgumentException("startTime must not be null");
        }
        if (ObjectUtils.isEmpty(imageCaptchaTrack.getStopTime())) {
            throw new IllegalArgumentException("stopTime must not be null");
        }
        if (CollectionUtils.isEmpty(imageCaptchaTrack.getTrackList())) {
            throw new IllegalArgumentException("trackList must not be null");
        }
        for (ImageCaptchaTrack.Track track : imageCaptchaTrack.getTrackList()) {
            Float x = track.getX();
            Float y = track.getY();
            Float t = track.getT();
            String type = track.getType();
            if (x == null || y == null || t == null || ObjectUtils.isEmpty(type)) {
                throw new IllegalArgumentException("track[x,y,t,type] must not be null");
            }
        }
    }
}
