package lpt;


import lpt.application.ImageCaptchaApplication;
import lpt.application.TACBuilder;
import lpt.application.vo.CaptchaResponse;
import lpt.application.vo.ImageCaptchaVO;
import lpt.cache.CacheStore;
import lpt.cache.impl.LocalCacheStore;
import lpt.common.response.ApiResponse;
import lpt.resource.common.model.dto.Resource;
import lpt.validator.common.model.dto.ImageCaptchaTrack;
import lpt.validator.common.model.dto.MatchParam;

/**
 * @Description: TODO
 * @author: huangguoshan
 * @date: 2025年03月15日 21:36
 */
public class LptSlideUtil {
    public static void main(String[] args) {
        ImageCaptchaApplication application = TACBuilder.builder()
                .addDefaultTemplate() // 添加默认模板
                // 给滑块验证码 添加背景图片，宽高为600*360, Resource 参数1为 classpath/file/url , 参数2 为具体url
                //此为令牌通的该pom自动引入的图片，后续有需求可继续添加
                .addResource("SLIDER", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg")) // 滑块验证的背景图
                .addResource("WORD_IMAGE_CLICK", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg")) // 文字点选的背景图
                .addResource("ROTATE", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg")) // 旋转验证的背景图
                .build();
        // 生成验证码数据， 可以将该数据直接返回给前端 ，
        // 支持生成 滑动验证码(SLIDER)、旋转验证码(ROTATE)、滑动还原验证码(CONCAT)、文字点选验证码(WORD_IMAGE_CLICK)
        CaptchaResponse<ImageCaptchaVO> res = application.generateCaptcha("SLIDER");
        System.out.println(res);

        // 校验验证码， ImageCaptchaTrack 和 id 均为前端传开的参数， 可将 valid数据直接返回给 前端
        // 注意: 该项目只负责生成和校验验证码数据， 至于二次验证等需要自行扩展
        String id = res.getId();
        ImageCaptchaTrack imageCaptchaTrack = null;
        ApiResponse<?> valid = application.matching(id, new MatchParam(imageCaptchaTrack));
        System.out.println(valid.isSuccess());
    }
    public static void getSlideVerification(){
        ImageCaptchaApplication application = TACBuilder.builder()
                .addDefaultTemplate() // 添加默认模板
                // 给滑块验证码 添加背景图片，宽高为600*360, Resource 参数1为 classpath/file/url , 参数2 为具体url
                //此为令牌通的该pom自动引入的图片，后续有需求可继续添加
                .addResource("SLIDER", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg")) // 滑块验证的背景图
                .addResource("WORD_IMAGE_CLICK", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg")) // 文字点选的背景图
                .addResource("ROTATE", new lpt.resource.common.model.dto.Resource("classpath", "META-INF/cut-image/resource/1.jpg")) // 旋转验证的背景图
                .build();
        // 生成验证码数据， 可以将该数据直接返回给前端
        // 支持生成 滑动验证码(SLIDER)、旋转验证码(ROTATE)、滑动还原验证码(CONCAT)、文字点选验证码(WORD_IMAGE_CLICK)
        CaptchaResponse<ImageCaptchaVO> res = application.generateCaptcha("SLIDER");
        System.out.println(res);
        // 校验验证码， ImageCaptchaTrack 和 id 均为前端传开的参数， 可将 valid数据直接返回给 前端
        // 注意: 该项目只负责生成和校验验证码数据， 至于二次验证等需要自行扩展
        String id = res.getId();
        ImageCaptchaTrack imageCaptchaTrack = null;
        ApiResponse<?> valid = application.matching(id, new MatchParam(imageCaptchaTrack));
        System.out.println(valid.isSuccess());

    }

}
