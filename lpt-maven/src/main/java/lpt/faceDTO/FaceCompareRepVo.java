package lpt.faceDTO;


import java.io.Serializable;

public class FaceCompareRepVo implements Serializable {
    /**向量的距离**/
//    @ApiModelProperty(value="向量欧式距离:>=0", position = 1, required = true)
    private Float distance;
    /**转换后的置信度**/
//    @ApiModelProperty(value="余弦距离转换后的置信度:[-100,100]，值越大，相似度越高。", position = 2, required = true)
    private Float confidence;
    /**人脸信息**/
//    @ApiModelProperty(value="人脸信息,参数needFaceInfo=false时，值为null", position = 3, required = false)
    private CompareFace faceInfo;

    private String message;

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Float getDistance() {
        return distance;
    }

    public void setDistance(Float distance) {
        this.distance = distance;
    }

    public Float getConfidence() {
        return confidence;
    }

    public void setConfidence(Float confidence) {
        this.confidence = confidence;
    }

    public CompareFace getFaceInfo() {
        return faceInfo;
    }

    public void setFaceInfo(CompareFace faceInfo) {
        this.faceInfo = faceInfo;
    }
}
