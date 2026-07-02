package uef.edu.vn.service;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;
import uef.edu.vn.model.Booking;
import uef.edu.vn.model.Payment;

/**
 * Service gui email tu dong qua Gmail SMTP.
 *
 * Cau hinh qua bien moi truong (Environment Variables):
 *   EMAIL_USER     = dia chi Gmail (vi du: youremail@gmail.com)
 *   EMAIL_PASSWORD = App Password cua Gmail (16 ky tu, khong phai mat khau thuong)
 *
 * Neu bien moi truong khong duoc dat, email se bi bo qua (silent skip).
 */
public class EmailService {

    private static final String FROM_EMAIL = getEnv("EMAIL_USER", "");
    private static final String APP_PASSWORD = getEnv("EMAIL_PASSWORD", "");
    private static final String FROM_NAME = "VoyagerElite Travel";

    // =========================================================================
    // Email 1: Xac nhan dat tour thanh cong
    // =========================================================================

    public void sendBookingConfirmation(Booking booking, String toEmail) {
        if (!isConfigured()) return;

        String subject = "[VoyagerElite] Xac nhan dat tour #BK-" + String.format("%06d", booking.getBookingId());

        String body = buildHtmlEmail(
            "Dat Tour Thanh Cong!",
            "Cam on ban da dat tour tai VoyagerElite.",
            new String[][]{
                {"Ma dat tour", "#BK-" + String.format("%06d", booking.getBookingId())},
                {"Ten tour", booking.getTourName() != null ? booking.getTourName() : "N/A"},
                {"So nguoi", String.valueOf(booking.getNumberOfPeople())},
                {"Tong tien", String.format("%,.0f VND", booking.getTotalPrice())},
                {"Trang thai", "Cho xac nhan (PENDING)"}
            },
            "Chung toi se lien he voi ban sau khi xac nhan dat cho.",
            "#0194F3"
        );

        sendHtml(toEmail, subject, body);
    }

    // =========================================================================
    // Email 2: Bien lai thanh toan
    // =========================================================================

    public void sendPaymentReceipt(Payment payment, String toEmail) {
        if (!isConfigured()) return;

        String subject = "[VoyagerElite] Bien lai thanh toan #PAY-" + String.format("%06d", payment.getPaymentId());

        String body = buildHtmlEmail(
            "Thanh Toan Thanh Cong!",
            "He thong da ghi nhan thanh toan cua ban.",
            new String[][]{
                {"Ma thanh toan", "#PAY-" + String.format("%06d", payment.getPaymentId())},
                {"Ma booking", "#BK-" + String.format("%06d", payment.getBookingId())},
                {"So tien", String.format("%,.0f VND", payment.getAmount())},
                {"Phuong thuc", payment.getPaymentMethod() != null ? payment.getPaymentMethod() : "N/A"},
                {"Trang thai", "Da thanh toan"}
            },
            "Cam on ban da su dung dich vu cua VoyagerElite!",
            "#00BA4A"
        );

        sendHtml(toEmail, subject, body);
    }

    // =========================================================================
    // Email 3: Dat lai mat khau
    // =========================================================================

    public void sendPasswordResetEmail(String toEmail, String resetLink) {
        if (!isConfigured()) return;

        String subject = "[VoyagerElite] Yeu cau dat lai mat khau";

        String body = "<div style='font-family:Inter,Arial,sans-serif;max-width:600px;margin:0 auto;background:#fff;border-radius:12px;overflow:hidden;box-shadow:0 4px 20px rgba(0,0,0,0.1);'>"
            + "<div style='background:#05285D;padding:32px;text-align:center;'>"
            + "<h1 style='color:white;margin:0;font-size:24px;'>VoyagerElite</h1>"
            + "<p style='color:#93c5fd;margin:8px 0 0;font-size:14px;'>He Thong Dat Tour Truc Tuyen</p>"
            + "</div>"
            + "<div style='padding:32px;'>"
            + "<h2 style='color:#05285D;margin:0 0 16px;font-size:20px;'>Dat Lai Mat Khau</h2>"
            + "<p style='color:#4b5563;line-height:1.6;'>Ban (hoac ai do) da yeu cau dat lai mat khau cho tai khoan nay. Nhan vao nut ben duoi de tiep tuc:</p>"
            + "<div style='text-align:center;margin:32px 0;'>"
            + "<a href='" + resetLink + "' style='background:#0194F3;color:white;padding:14px 32px;border-radius:8px;text-decoration:none;font-weight:bold;font-size:16px;display:inline-block;'>Dat Lai Mat Khau</a>"
            + "</div>"
            + "<p style='color:#9ca3af;font-size:13px;'>Neu ban khong yeu cau, hay bo qua email nay. Lien ket se het han sau 24 gio.</p>"
            + "</div>"
            + "<div style='background:#f9fafb;padding:20px;text-align:center;border-top:1px solid #e5e7eb;'>"
            + "<p style='color:#9ca3af;font-size:12px;margin:0;'>© 2025 VoyagerElite Travel. All rights reserved.</p>"
            + "</div></div>";

        sendHtml(toEmail, subject, body);
    }

    // =========================================================================
    // Core: Gui email HTML
    // =========================================================================

    private void sendHtml(final String toEmail, final String subject, final String htmlBody) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    Properties props = new Properties();
                    props.put("mail.smtp.host", "smtp.gmail.com");
                    props.put("mail.smtp.port", "465");
                    props.put("mail.smtp.auth", "true");
                    props.put("mail.smtp.ssl.enable", "true"); // Kích hoạt SSL cho cổng 465
                    props.put("mail.smtp.socketFactory.port", "465");
                    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                    props.put("mail.smtp.socketFactory.fallback", "false");
                    
                    // Thêm timeout để không bị treo vô hạn
                    props.put("mail.smtp.connectiontimeout", "5000"); // 5 giây kết nối
                    props.put("mail.smtp.timeout", "5000");           // 5 giây đọc dữ liệu

                    Session session = Session.getInstance(props, new Authenticator() {
                        @Override
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                        }
                    });

                    Message message = new MimeMessage(session);
                    message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME, "UTF-8"));
                    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
                    message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));

                    MimeBodyPart htmlPart = new MimeBodyPart();
                    htmlPart.setContent(htmlBody, "text/html; charset=UTF-8");

                    Multipart multipart = new MimeMultipart();
                    multipart.addBodyPart(htmlPart);
                    message.setContent(multipart);

                    Transport.send(message);
                    System.out.println("[EmailService] Email sent to: " + toEmail);

                } catch (Exception e) {
                    // Khong de email loi anh huong den luong chinh
                    System.err.println("[EmailService] Failed to send email to " + toEmail + ": " + e.getMessage());
                }
            }
        }).start();
    }

    // =========================================================================
    // Builder: Tao noi dung email HTML dep
    // =========================================================================

    private String buildHtmlEmail(String title, String subtitle,
                                   String[][] rows, String footer, String accentColor) {
        StringBuilder sb = new StringBuilder();
        sb.append("<div style='font-family:Inter,Arial,sans-serif;max-width:600px;margin:0 auto;background:#fff;border-radius:12px;overflow:hidden;box-shadow:0 4px 20px rgba(0,0,0,0.1);'>");

        // Header
        sb.append("<div style='background:#05285D;padding:32px;text-align:center;'>");
        sb.append("<h1 style='color:white;margin:0;font-size:24px;letter-spacing:1px;'>VoyagerElite</h1>");
        sb.append("<p style='color:#93c5fd;margin:8px 0 0;font-size:13px;'>He Thong Dat Tour Truc Tuyen</p>");
        sb.append("</div>");

        // Status banner
        sb.append("<div style='background:").append(accentColor).append(";padding:20px;text-align:center;'>");
        sb.append("<h2 style='color:white;margin:0;font-size:22px;'>").append(title).append("</h2>");
        sb.append("<p style='color:rgba(255,255,255,0.85);margin:6px 0 0;font-size:14px;'>").append(subtitle).append("</p>");
        sb.append("</div>");

        // Content
        sb.append("<div style='padding:32px;'>");
        sb.append("<table style='width:100%;border-collapse:collapse;'>");
        for (String[] row : rows) {
            sb.append("<tr style='border-bottom:1px solid #f3f4f6;'>");
            sb.append("<td style='padding:12px 0;font-weight:600;color:#374151;font-size:14px;width:160px;'>").append(row[0]).append("</td>");
            sb.append("<td style='padding:12px 0;color:#111827;font-size:14px;font-weight:500;'>").append(row[1]).append("</td>");
            sb.append("</tr>");
        }
        sb.append("</table>");
        sb.append("<p style='color:#6b7280;font-size:13px;margin-top:24px;line-height:1.6;'>").append(footer).append("</p>");
        sb.append("</div>");

        // Footer
        sb.append("<div style='background:#f9fafb;padding:20px;text-align:center;border-top:1px solid #e5e7eb;'>");
        sb.append("<p style='color:#9ca3af;font-size:12px;margin:0;'>© 2025 VoyagerElite Travel. All rights reserved.</p>");
        sb.append("<p style='color:#9ca3af;font-size:11px;margin:4px 0 0;'>Email nay duoc gui tu dong, vui long khong reply.</p>");
        sb.append("</div>");
        sb.append("</div>");

        return sb.toString();
    }

    // =========================================================================
    // Helpers
    // =========================================================================

    private boolean isConfigured() {
        return FROM_EMAIL != null && !FROM_EMAIL.isBlank()
            && APP_PASSWORD != null && !APP_PASSWORD.isBlank();
    }

    private static String getEnv(String key, String defaultValue) {
        String val = System.getProperty(key);
        if (val == null || val.isBlank()) val = System.getenv(key);
        return (val == null || val.isBlank()) ? defaultValue : val;
    }
}
