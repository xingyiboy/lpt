package lpt.interceptor;

import lombok.Getter;
import lombok.Setter;
import lpt.application.vo.LptCaptchaResponse;
import lpt.application.vo.LptImageCaptchaVO;
import lpt.common.AnyMap;
import lpt.common.response.LptApiResponse;
import lpt.generator.AbstractImageCaptchaGenerator;
import lpt.generator.common.model.dto.CaptchaExchange;
import lpt.generator.common.model.dto.GenerateParam;
import lpt.generator.common.model.dto.ImageCaptchaInfo;
import lpt.validator.common.model.dto.MatchParam;

import java.util.ArrayList;
import java.util.List;

public class CaptchaInterceptorGroup implements CaptchaInterceptor {


    private String name = "group_interceptor";

    @Getter
    @Setter
    private List<CaptchaInterceptor> validators = new ArrayList<>();

    public void addInterceptor(CaptchaInterceptor validator) {
        validators.add(validator);
    }

    public void addInterceptor(List<CaptchaInterceptor> validators) {
        this.validators.addAll(validators);
    }

    @Override
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public CaptchaInterceptorGroup() {
    }

    public CaptchaInterceptorGroup(String name) {
        this.name = name;
    }

    @Override
    public Context createContext() {
        return new Context(getName(), null, -1, validators.size(), this);
    }

    protected Context createContextIfNecessary(Context context) {
        if (context == null) {
            return createContext();
        }
        if (!context.getGroup().equals(this)) {
            Context innerContext = createContext();
            innerContext.setParent(context);
            context = innerContext;
        }
        return context;
    }

    @Override
    public LptCaptchaResponse<LptImageCaptchaVO> beforeGenerateCaptcha(Context context, String type, GenerateParam param) {
        context = createContextIfNecessary(context);
        LptCaptchaResponse<LptImageCaptchaVO> lptCaptchaResponse = null;
        while (context.next() < context.getCount()) {
            CaptchaInterceptor interceptor = validators.get(context.getCurrent());
            lptCaptchaResponse = interceptor.beforeGenerateCaptcha(context, type, param);
            context.setPreReturnData(lptCaptchaResponse);
        }
        return lptCaptchaResponse;
    }

    @Override
    public void afterGenerateCaptcha(Context context, String type, ImageCaptchaInfo imageCaptchaInfo, LptCaptchaResponse<LptImageCaptchaVO> lptCaptchaResponse) {
        context = createContextIfNecessary(context);
        while (context.next() < context.getCount()) {
            CaptchaInterceptor interceptor = validators.get(context.getCurrent());
            interceptor.afterGenerateCaptcha(context, type, imageCaptchaInfo, lptCaptchaResponse);
        }
    }

    @Override
    public LptApiResponse<?> beforeValid(Context context, String type, MatchParam matchParam, AnyMap validData) {
        context = createContextIfNecessary(context);
        LptApiResponse<?> beforeValid = null;
        while (context.next() < context.getCount()) {
            CaptchaInterceptor interceptor = validators.get(context.getCurrent());
            beforeValid = interceptor.beforeValid(context, type, matchParam, validData);
            context.setPreReturnData(beforeValid);
        }
        return beforeValid == null ? LptApiResponse.ofSuccess() : beforeValid;
    }

    @Override
    public LptApiResponse<?> afterValid(Context context, String type, MatchParam matchParam, AnyMap validData, LptApiResponse<?> basicValid) {
        context = createContextIfNecessary(context);
        LptApiResponse<?> valid = null;
        while (context.next() < context.getCount()) {
            CaptchaInterceptor interceptor = validators.get(context.getCurrent());
            valid = interceptor.afterValid(context, type, matchParam, validData, basicValid);
            context.setPreReturnData(valid);
        }
        return valid == null ? LptApiResponse.ofSuccess() : valid;
    }

    @Override
    public LptCaptchaResponse<LptImageCaptchaVO> beforeGenerateImageCaptchaValidData(Context context, String type, ImageCaptchaInfo imageCaptchaInfo) {
        context = createContextIfNecessary(context);
        LptCaptchaResponse<LptImageCaptchaVO> lptCaptchaResponse = null;
        while (context.next() < context.getCount()) {
            CaptchaInterceptor interceptor = validators.get(context.getCurrent());
            lptCaptchaResponse = interceptor.beforeGenerateImageCaptchaValidData(context, type, imageCaptchaInfo);
            context.setPreReturnData(lptCaptchaResponse);
        }
        return lptCaptchaResponse;


    }

    @Override
    public void afterGenerateImageCaptchaValidData(Context context, String type, ImageCaptchaInfo imageCaptchaInfo, AnyMap validData) {
        context = createContextIfNecessary(context);
        while (context.next() < context.getCount()) {
            CaptchaInterceptor interceptor = validators.get(context.getCurrent());
            interceptor.afterGenerateImageCaptchaValidData(context, type, imageCaptchaInfo, validData);
        }
    }

    @Override
    public ImageCaptchaInfo beforeGenerateCaptchaImage(Context context, CaptchaExchange captchaExchange, AbstractImageCaptchaGenerator generator) {
        context = createContextIfNecessary(context);
        ImageCaptchaInfo response = null;
        while (context.next() < context.getCount()) {
            CaptchaInterceptor interceptor = validators.get(context.getCurrent());
            response = interceptor.beforeGenerateCaptchaImage(context, captchaExchange, generator);
        }
        return response;
    }

    @Override
    public void beforeWrapImageCaptchaInfo(Context context, CaptchaExchange captchaExchange, AbstractImageCaptchaGenerator generator) {
        context = createContextIfNecessary(context);
        while (context.next() < context.getCount()) {
            CaptchaInterceptor interceptor = validators.get(context.getCurrent());
            interceptor.beforeWrapImageCaptchaInfo(context, captchaExchange, generator);
        }
    }

    @Override
    public void afterGenerateCaptchaImage(Context context, CaptchaExchange captchaExchange, ImageCaptchaInfo imageCaptchaInfo, AbstractImageCaptchaGenerator generator) {
        context = createContextIfNecessary(context);
        while (context.next() < context.getCount()) {
            CaptchaInterceptor interceptor = validators.get(context.getCurrent());
            interceptor.afterGenerateCaptchaImage(context, captchaExchange, imageCaptchaInfo, generator);
        }
    }


    public String printTree() {
        return doPrintTree(1);
    }

    private String doPrintTree(int index) {
        StringBuilder sb = new StringBuilder();
        StringBuilder start = new StringBuilder();

        for (int i = 0; i < index; i++) {
            start.append("|-----");
        }
        for (int i = 0; i < validators.size(); i++) {
            CaptchaInterceptor validator = validators.get(i);
            sb.append(start).append("[").append(validator.getName()).append("]").append("\n");
            if (validator instanceof CaptchaInterceptorGroup) {
                sb.append(((CaptchaInterceptorGroup) validator).doPrintTree(index + 1));
            }
        }
        return sb.toString();
    }
}
