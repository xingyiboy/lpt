package lpt;


import lpt.application.LptImageCaptchaApplication;
import lpt.application.LptTACBuilder;
import lpt.application.vo.LptCaptchaResponse;
import lpt.application.vo.LptImageCaptchaVO;
import lpt.common.response.LptApiResponse;
import lpt.resource.common.model.dto.Resource;
import lpt.validator.common.model.dto.LptImageCaptchaTrack;
import lpt.validator.common.model.dto.MatchParam;

/**
 * @Description: TODO
 * @author: huangguoshan
 * @date: 2025年03月15日 21:36
 */
public class Test {
    public static void main(String[] args) {
        LptImageCaptchaApplication application = LptTACBuilder.builder()
                .addDefaultTemplate()
                // expire 设置验证码的过期时间 ， default 为默认过期时间 为 10秒, WORD_IMAGE_CLICK文字点选验证码的过期时间为 60秒
                .expire("default", 10000L)
                .expire("WORD_IMAGE_CLICK", 60000L)
                // 设置背景图， 这里为 SLIDER WORD_IMAGE_CLICK ROTATE CONCAT 各设置了一张背景图
                .addResource("SLIDER", new Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .addResource("WORD_IMAGE_CLICK", new Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .addResource("ROTATE", new Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .addResource("CONCAT", new Resource("classpath", "META-INF/cut-image/resource/1.jpg"))
                .build();
        // 生成验证码数据， 可以将该数据直接返回给前端 ，
        // 支持生成 滑动验证码(SLIDER)、旋转验证码(ROTATE)、滑动还原验证码(CONCAT)、文字点选验证码(WORD_IMAGE_CLICK)
        LptCaptchaResponse<LptImageCaptchaVO> res = application.generateCaptcha("SLIDER");
        System.out.println(res);

        // 校验验证码， LptImageCaptchaTrack 和 id 均为前端传开的参数， 可将 valid数据直接返回给 前端
        // 注意: 该项目只负责生成和校验验证码数据， 至于二次验证等需要自行扩展
        String id = res.getId();
        LptImageCaptchaTrack lptImageCaptchaTrack = null;
        LptApiResponse<?> valid = application.matching(id, new MatchParam(lptImageCaptchaTrack));
        System.out.println(valid.isSuccess());
    }

}
