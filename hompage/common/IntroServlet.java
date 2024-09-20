package common;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;

@WebServlet("/submitIntro")
public class IntroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String cust_name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String comp_name = request.getParameter("company");
        String data_type = request.getParameter("data_type");
        String coun_type = request.getParameter("coun_type");
        String visit_path = request.getParameter("visit_path");
        String content = request.getParameter("content");

        // 유효성 검사 - 이름과 이메일, 전화번호 등 필수 입력 항목 확인
        if (cust_name == null || cust_name.isEmpty()) {
            response.getWriter().println("<script>alert('이름을 입력해 주세요.'); history.back();</script>");
            return;
        }
        if (email == null || email.isEmpty()) {
            response.getWriter().println("<script>alert('이메일을 입력해 주세요.'); history.back();</script>");
            return;
        }
        if (phone == null || phone.isEmpty()) {
            response.getWriter().println("<script>alert('전화번호를 입력해 주세요.'); history.back();</script>");
            return;
        }

        // 유효성 검사 - 이메일 형식 확인
        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            response.getWriter().println("<script>alert('유효한 이메일 형식을 입력해 주세요.'); history.back();</script>");
            return;
        }

        Timestamp time = new Timestamp(new Date().getTime());

        Intro intro = new Intro(0, cust_name, email, phone, comp_name, data_type, coun_type, visit_path, time, content);
        IntroDao dao = new IntroDao();

        try {
            int result = dao.insertIntro(intro);
            if (result > 0) {
                // 데이터 삽입 성공
                System.out.println("문의 사항이 정상적으로 DB에 삽입되었습니다.");
                response.getWriter().println("<script>alert('문의 사항이 정상적으로 제출되었습니다.'); location.href='BA02.jsp';</script>");
            } else {
                // 데이터 삽입 실패
                System.out.println("문의 사항 제출 실패");
                response.getWriter().println("<script>alert('문의 사항 제출에 실패하였습니다.'); history.back();</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // 구체적인 오류 메시지 전달
            response.getWriter().println("<script>alert('DB 처리 중 오류가 발생했습니다: " + e.getMessage() + "'); history.back();</script>");
        }
    }
}
