package common;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
/**
 * Servlet implementation class Email_send
 */
@WebServlet("/Email_send")
public class Email_send extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// 메일 전송 클래스
	class MyAuthentication extends Authenticator {
	      
	    PasswordAuthentication pa;
	    public MyAuthentication(){
	         
	        String id = "jfm1014@naver.com";  //네이버 이메일 아이디
	        String pw = "609745k!";        //네이버 비밀번호
	 
	        // ID와 비밀번호를 입력한다.
	        pa = new PasswordAuthentication(id, pw);
	    }
	 
	    // 시스템에서 사용하는 인증정보
	    public PasswordAuthentication getPasswordAuthentication() {
	        return pa;
	    }
	} 
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Email_send() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Properties p = System.getProperties();
        p.put("mail.smtp.starttls.enable", "true");     
        p.put("mail.smtp.host", "smtp.naver.com");      // smtp 서버 주소
        p.put("mail.smtp.auth","true");                 
        p.put("mail.smtp.port", "587");                 // 네이버 포트
        p.put("mail.smtp.port", "587");                 // 네이버 포트
        p.put("mail.smtp.ssl.protocols", "TLSv1.2");
        
           
        Authenticator auth = new MyAuthentication();
        //session 생성 및  MimeMessage생성
        Session session = Session.getDefaultInstance(p, auth);
        MimeMessage msg = new MimeMessage(session);
        
        AnalysisDao AnaDao = new AnalysisDao();
        
        try{
        	
        	String ana_email = AnaDao.send_email();
        	String ana_result = AnaDao.send_result();
        	//편지보낸시간
            msg.setSentDate(new Date());
            InternetAddress from = new InternetAddress() ;
            from = new InternetAddress("jfm1014@naver.com"); //발신자 아이디
            // 이메일 발신자
            msg.setFrom(from);
            // 이메일 수신자
            InternetAddress to = new InternetAddress(ana_email);
            msg.setRecipient(Message.RecipientType.TO, to);
            // 이메일 제목
            msg.setSubject("Algorhythnm_분석 결과", "UTF-8");
            // 이메일 내용
            msg.setText(ana_result, "UTF-8");
            // 이메일 헤더
            msg.setHeader("content-Type", "text/html");
            //메일보내기
            javax.mail.Transport.send(msg, msg.getAllRecipients());
             
        }catch (AddressException addr_e) {
            addr_e.printStackTrace();
        }catch (MessagingException msg_e) {
            msg_e.printStackTrace();
        }catch (Exception msg_e) {
            msg_e.printStackTrace();
        }
	}
}
