package lpt.validator.impl;

import lpt.common.AnyMap;
import lpt.common.response.LptApiResponse;
import lpt.common.response.CodeDefinition;
import lpt.common.util.CaptchaTypeClassifier;
import lpt.common.util.CollectionUtils;
import lpt.common.util.ObjectUtils;
import lpt.validator.common.model.dto.LptImageCaptchaTrack;

import java.util.List;

/**
 * @Author: 天爱有情
 * @date 2022/2/17 11:01
 * @Description 基本的行为轨迹校验
 */
public class BasicCaptchaTrackValidator extends SimpleImageCaptchaValidator {
    public static final CodeDefinition DEFINITION = new CodeDefinition(50001, "basic check fail");

    public BasicCaptchaTrackValidator() {
    }

    public BasicCaptchaTrackValidator(float defaultTolerant) {
        super(defaultTolerant);
    }

    @Override
    public LptApiResponse<?> beforeValid(LptImageCaptchaTrack lptImageCaptchaTrack, AnyMap captchaValidData, Float tolerant, String type) {
        // 校验参数
        checkParam(lptImageCaptchaTrack);
        return LptApiResponse.ofSuccess();
    }

    @Override
    public LptApiResponse<?> afterValid(Boolean basicValid, LptImageCaptchaTrack lptImageCaptchaTrack, AnyMap captchaValidData, Float tolerant, String type) {
        if (!basicValid){
            return LptApiResponse.ofSuccess();
        }
        if (!CaptchaTypeClassifier.isSliderCaptcha(type)) {
            // 不是滑动验证码的话暂时跳过，点选验证码行为轨迹还没做
            return LptApiResponse.ofSuccess();
        }
        // 进行行为轨迹检测
        long startSlidingTime = lptImageCaptchaTrack.getStartTime().getTime();
        long endSlidingTime = lptImageCaptchaTrack.getStopTime().getTime();
        Integer bgImageWidth = lptImageCaptchaTrack.getBgImageWidth();
        List<LptImageCaptchaTrack.Track> trackList = lptImageCaptchaTrack.getTrackList();
        // 这里只进行基本检测, 用一些简单算法进行校验，如有需要可扩展
        // 检测1: 滑动时间如果小于300毫秒 返回false
        // 检测2: 轨迹数据要是少于背10，或者大于背景宽度的五倍 返回false
        // 检测3: x轴和y轴应该是从0开始的，要是一开始x轴和y轴乱跑，返回false
        // 检测4: 如果y轴是相同的，必然是机器操作，直接返回false
        // 检测5： x轴或者y轴直接的区间跳跃过大的话返回 false
        // 检测6: x轴应该是由快到慢的， 要是速率一致，返回false
        // 检测7: 如果x轴超过图片宽度的频率过高，返回false

        // 检测1
        if (startSlidingTime + 300 > endSlidingTime) {
            return LptApiResponse.ofMessage(DEFINITION);
        }
        // 检测2
        if (trackList.size() < 10 || trackList.size() > bgImageWidth * 5) {
            return LptApiResponse.ofMessage(DEFINITION);
        }
        // 检测3
        LptImageCaptchaTrack.Track firstTrack = trackList.get(0);
        if (firstTrack.getX() > 10 || firstTrack.getX() < -10 || firstTrack.getY() > 10 || firstTrack.getY() < -10) {
            return LptApiResponse.ofMessage(DEFINITION);
        }
        int check4 = 0;
        int check7 = 0;
        for (int i = 1; i < trackList.size(); i++) {
            LptImageCaptchaTrack.Track track = trackList.get(i);
            float x = track.getX();
            float y = track.getY();
            // check4
            if (firstTrack.getY() == y) {
                check4++;
            }
            // check7
            if (x >= bgImageWidth) {
                check7++;
            }
            // check5
            LptImageCaptchaTrack.Track preTrack = trackList.get(i - 1);
            if ((track.getX() - preTrack.getX()) > 50 || (track.getY() - preTrack.getY()) > 50) {
                return LptApiResponse.ofMessage(DEFINITION);
            }
        }
        if (check4 == trackList.size() || check7 > 200) {
            return LptApiResponse.ofMessage(DEFINITION);
        }

        // check6
        int splitPos = (int) (trackList.size() * 0.7);
        LptImageCaptchaTrack.Track splitPostTrack = trackList.get(splitPos - 1);
        float posTime = splitPostTrack.getT();
        float startAvgPosTime = posTime / (float) splitPos;

        LptImageCaptchaTrack.Track lastTrack = trackList.get(trackList.size() - 1);
        double endAvgPosTime = lastTrack.getT() / (float) (trackList.size() - splitPos);

        boolean check = endAvgPosTime > startAvgPosTime;
        if (check) {
            return LptApiResponse.ofSuccess();
        }
        return LptApiResponse.ofMessage(DEFINITION);
    }

    public void checkParam(LptImageCaptchaTrack lptImageCaptchaTrack) {
        if (ObjectUtils.isEmpty(lptImageCaptchaTrack.getBgImageWidth())) {
            throw new IllegalArgumentException("bgImageWidth must not be null");
        }
        if (ObjectUtils.isEmpty(lptImageCaptchaTrack.getBgImageHeight())) {
            throw new IllegalArgumentException("bgImageHeight must not be null");
        }
        if (ObjectUtils.isEmpty(lptImageCaptchaTrack.getStartTime())) {
            throw new IllegalArgumentException("startSlidingTime must not be null");
        }
        if (ObjectUtils.isEmpty(lptImageCaptchaTrack.getStopTime())) {
            throw new IllegalArgumentException("endSlidingTime must not be null");
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
