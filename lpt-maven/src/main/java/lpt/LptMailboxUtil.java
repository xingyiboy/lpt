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

    public static void send(String host,int port,boolean auth,String user,String code,String toUser,String emailTitle,String emailContent) {
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
