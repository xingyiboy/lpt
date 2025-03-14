package com.ruoyi.system.util;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Objects;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.security.crypto.bcrypt.BCrypt;

public class SaltUtils {

    // 默认的盐的长度
    private static final int DEFAULT_SALT_LENGTH = 16;

    // SecureRandom 实例，用于生成高质量的随机盐
    private static final SecureRandom secureRandom = new SecureRandom();

    // 密码哈希使用的盐
    private static final String PBKDF2_ALGORITHM = "PBKDF2WithHmacSHA256";

    // 私有构造函数，防止实例化
    private SaltUtils() {}

    /**
     * 生成指定长度的盐
     * @param saltLength 盐的长度
     * @return 盐字符串
     */
    public static String generateSalt(int saltLength) {
        byte[] salt = new byte[saltLength];
        secureRandom.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);  // 使用 Base64 编码以便存储
    }

    /**
     * 使用默认长度生成盐
     * @return 默认长度的盐
     */
    public static String generateSalt() {
        return generateSalt(DEFAULT_SALT_LENGTH);
    }

    /**
     * 将密码与盐结合后进行SHA-256哈希
     * @param password 密码
     * @param salt 盐
     * @return 哈希后的密码
     */
    public static String hashPasswordWithSHA256(String password, String salt) {
        Objects.requireNonNull(password, "Password cannot be null");
        Objects.requireNonNull(salt, "Salt cannot be null");
        return DigestUtils.sha256Hex(password + salt);
    }
    /**
     * 校验密码是否与哈希密码匹配
     * @param plainPassword 明文密码
     * @param salt 盐
     * @param hashedPassword 哈希后的密码
     * @return 是否匹配
     */
    public static boolean verifyPasswordWithSHA256(String plainPassword, String salt, String hashedPassword) {
        String hashedInputPassword = hashPasswordWithSHA256(plainPassword, salt);
        return hashedInputPassword.equals(hashedPassword);
    }

    /**
     * 使用BCrypt算法加密密码与盐
     * @param password 密码
     * @param salt 盐
     * @return 加密后的密码
     */
    public static String hashPasswordWithBCrypt(String password, String salt) {
        Objects.requireNonNull(password, "Password cannot be null");
        Objects.requireNonNull(salt, "Salt cannot be null");
        return BCrypt.hashpw(password + salt, BCrypt.gensalt());  // 生成基于盐的哈希
    }

    /**
     * 验证BCrypt哈希密码是否匹配
     * @param plainPassword 明文密码
     * @param hashedPassword 哈希后的密码
     * @param salt 盐
     * @return 是否匹配
     */
    public static boolean verifyPasswordWithBCrypt(String plainPassword, String hashedPassword, String salt) {
        Objects.requireNonNull(plainPassword, "Password cannot be null");
        Objects.requireNonNull(hashedPassword, "Hashed password cannot be null");
        Objects.requireNonNull(salt, "Salt cannot be null");
        return BCrypt.checkpw(plainPassword + salt, hashedPassword);  // 验证是否匹配
    }

    /**
     * 使用 SHA-256 和盐结合进行加密，并返回盐与加密后的密码
     * @param password 明文密码
     * @return 返回盐与加密后的密码
     */
    public static String[] generateSaltedPassword(String password) {
        String salt = generateSalt();
        String hashedPassword = hashPasswordWithSHA256(password, salt);
        return new String[] { salt, hashedPassword };
    }


}
