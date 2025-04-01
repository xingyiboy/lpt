package lpt;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

/**
 * @Description: 令牌通邮箱工具类
 * @author: huangguoshan
 * @date: 2025年03月15日 19:11
 */
public class LptMailboxUtil {

    public static void main(String[] args) throws Exception {
        send("smtp.qq.com",465,true,"28329142***@qq.com","zedgqax******","2416820386@qq.com","令牌通验证码"," \"\\n\" +\n" +
                "                        \"您正在进行邮箱验证操作，您的验证码是：\\n\" +\n" +
                "                        \"\\n\" +\n" +
                "                        \"\"+code+\"\\n\" +\n" +
                "                        \"\\n\" +\n" +
                "                        \"该验证码仅有效5分钟，请尽快完成验证。如果您没有进行相关操作，可能是有人误操作，请忽略此邮件。\\n\" +\n" +
                "                        \"\\n\" +\n" +
                "                        \"感谢您的使用！\\n\" +\n" +
                "                        \"\\n\" +\n" +
                "                        \"若有任何疑问，请联系我们的客服团队，我们将竭诚为您服务。\\n\" +\n" +
                "                        \"\\n\" +\n" +
                "                        \"祝您使用愉快！\\n\" +\n" +
                "                        \"\\n\" +\n" +
                "                        \"【令牌通】团队\"");
    }


    public static void send(String host,int port,boolean auth,String user,String code,String toUser,String emailTitle,String emailContent) throws Exception {
        LptIpVerification.isIp();
        // 创建Properties对象，用于设置邮件服务器的主机名和端口
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", auth);
        properties.put("mail.smtp.ssl.enable", "true"); // 启用 SSL
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        //发送邮件
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, code);
            }
        });
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user)); // 设置发件人
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toUser)); // 设置收件人
            message.setSubject(emailTitle); // 设置邮件标题
            message.setText(emailContent); // 设置邮件内容
            Transport.send(message);
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
}
