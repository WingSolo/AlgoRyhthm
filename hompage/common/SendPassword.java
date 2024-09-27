package common;

import java.io.IOException;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.mail.*;
import javax.mail.internet.*;
import common.EmpUser;
import common.EmpUserDao;
import java.util.Random;

@WebServlet("/SendPassword")
public class SendPassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empId = request.getParameter("empId");
        String email = request.getParameter("email");

        EmpUserDao userDao = new EmpUserDao();
        EmpUser user = userDao.findUserByEmpIdAndEmail(empId, email);

        if (user != null) {
            // 새로운 비밀번호 생성
            String newPassword = generateRandomPassword();
            // 사용자 비밀번호 업데이트
            userDao.updatePassword02(user.getEmp_id(), newPassword);

            // 새로운 비밀번호 이메일 전송
            sendEmail(email, newPassword);

            // 비밀번호가 성공적으로 전송되었으면 성공 메시지 페이지로 리다이렉트
            response.sendRedirect("passwordSuccess.jsp");
        } else {
            // 실패 시 다시 비밀번호 찾기 페이지로 이동하면서 에러 메시지 전달
            response.sendRedirect("findPassword.jsp?error=아이디 또는 이메일이 일치하지 않습니다.");
        }
    }

    // 임의의 비밀번호 생성 메소드
    private String generateRandomPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder password = new StringBuilder();
        Random rnd = new Random();
        for (int i = 0; i < 8; i++) {
            password.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return password.toString();
    }

    // 이메일 전송 메소드 (네이버 SMTP 설정 적용)
    private void sendEmail(String to, String newPassword) {
        final String username = "jfm1014@naver.com";  // 네이버 이메일 계정
        final String password = "609745k!"; // 
        // 네이버 SMTP 설정
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");                    // SMTP 인증 사용
        props.put("mail.smtp.starttls.enable", "true");         // TLS 사용
        props.put("mail.smtp.host", "smtp.naver.com");          // 네이버 SMTP 서버
        props.put("mail.smtp.port", "587");                     // SMTP 포트 (TLS)

        // 이메일 전송을 위한 세션 설정
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);  // 네이버 계정 인증
            }
        });

        try {
            // 이메일 메시지 구성
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));  // 발신자 주소 설정 (인증된 네이버 계정)
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));  // 수신자 주소 설정
            message.setSubject("새로운 비밀번호");  // 이메일 제목 설정
            message.setText("새로운 비밀번호는 " + newPassword + " 입니다.");  // 이메일 본문 설정

            // 이메일 전송
            Transport.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
            throw new RuntimeException(e);  // 예외 발생 시 처리
        }
    }
}
