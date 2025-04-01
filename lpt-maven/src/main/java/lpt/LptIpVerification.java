package lpt;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

/**
 * @Description: 验证本机IP是否在允许列表中
 * @author: huangguoshan
 * @date: 2025年04月01日 23:15
 */
public class LptIpVerification {

    public static void main(String[] args) throws Exception {
        List<String> localIPs = LptIpVerification.getLocalIPs();
    }





    private static final String IPCONFIG_URL = "https://113.45.31.128/.well-known/pki-validation/ipconfig.txt";

    /**
     * 验证本机IP是否在允许列表中
     * @throws Exception 如果IP不在允许列表中或发生其他错误
     */
    public static void isIp() throws Exception {
        // 获取允许的IP列表
        List<String> allowedIps = getIpListFromUrl();
        // 获取本机IP列表
        List<String> localIps = LptIpVerification.getLocalIPs();

        // 检查本机IP是否在允许列表中
        boolean isAllowed = false;
        for (String localIp : localIps) {
            if (allowedIps.contains(localIp)) {
                isAllowed = true;
                break;
            }
        }

        if (!isAllowed) {
            throw new RuntimeException("当前IP未授权使用");
        }
    }

    /**
     * 从URL获取IP列表
     */
    private static List<String> getIpListFromUrl() throws Exception {
        List<String> ipList = new ArrayList<>();
        URL url = new URL(IPCONFIG_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setConnectTimeout(5000);
        conn.setReadTimeout(5000);

        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(conn.getInputStream()))) {
            String line = reader.readLine();
            if (line != null) {
                String[] ips = line.split(",");
                for (String ip : ips) {
                    ipList.add(ip.trim());
                }
            }
        } finally {
            conn.disconnect();
        }

        return ipList;
    }

    /**
     * 获取本机所有IP地址
     */
    public static List<String> getLocalIPs() throws Exception {
        List<String> ipList = new ArrayList<>();
        Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();

        while (interfaces.hasMoreElements()) {
            NetworkInterface ni = interfaces.nextElement();
            Enumeration<InetAddress> addresses = ni.getInetAddresses();

            while (addresses.hasMoreElements()) {
                InetAddress addr = addresses.nextElement();
                // 排除回环地址和IPv6地址
                if (!addr.isLoopbackAddress() && addr.getHostAddress().indexOf(':') == -1) {
                    ipList.add(addr.getHostAddress());
                }
            }
        }

        return ipList;
    }
}
