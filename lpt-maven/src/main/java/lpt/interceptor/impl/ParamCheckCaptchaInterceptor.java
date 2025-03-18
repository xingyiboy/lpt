package lpt.interceptor.impl;

import lpt.common.AnyMap;
import lpt.common.response.LptApiResponse;
import lpt.common.util.CollectionUtils;
import lpt.common.util.ObjectUtils;
import lpt.interceptor.CaptchaInterceptor;
import lpt.interceptor.Context;
import lpt.validator.common.model.dto.LptImageCaptchaTrack;
import lpt.validator.common.model.dto.MatchParam;

/**
 * @Author: 天爱有情
 * @date 2023/1/4 10:10
 * @Description 轨迹参数校验， 如果轨迹参数为空抛异常
 */
public class ParamCheckCaptchaInterceptor implements CaptchaInterceptor {
    @Override
    public LptApiResponse<?> beforeValid(Context context, String type, MatchParam matchParam, AnyMap validData) {
        checkParam(matchParam.getTrack());
        return LptApiResponse.ofSuccess();
    }

    @Override
    public String getName() {
        return "param_check";
    }

    public void checkParam(LptImageCaptchaTrack lptImageCaptchaTrack) {
        if (ObjectUtils.isEmpty(lptImageCaptchaTrack.getBgImageWidth())) {
            throw new IllegalArgumentException("bgImageWidth must not be null");
        }
        if (ObjectUtils.isEmpty(lptImageCaptchaTrack.getBgImageHeight())) {
            throw new IllegalArgumentException("bgImageHeight must not be null");
        }
        if (ObjectUtils.isEmpty(lptImageCaptchaTrack.getStartTime())) {
            throw new IllegalArgumentException("startTime must not be null");
        }
        if (ObjectUtils.isEmpty(lptImageCaptchaTrack.getStopTime())) {
            throw new IllegalArgumentException("stopTime must not be null");
        }
        if (CollectionUtils.isEmpty(lptImageCaptchaTrack.getTrackList())) {
            throw new IllegalArgumentException("trackList must not be null");
        }
        for (LptImageCaptchaTrack.Track track : lptImageCaptchaTrack.getTrackList()) {
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
