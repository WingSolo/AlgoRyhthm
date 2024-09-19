package common;
import common.Intro;
import common.IntroDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;

@WebServlet("/submitIntro")  // 클라이언트에서 요청하는 URL 패턴
public class IntroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. POST 요청으로 받은 파라미터 값들 처리
        String cust_name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String comp_name = request.getParameter("company");
        String data_type = request.getParameter("data_type");
        String coun_type = request.getParameter("coun_type");
        String visit_path = request.getParameter("visit_path");
        String content = request.getParameter("content");

        // 2. 입력 데이터 검증 (간단한 유효성 체크, 추가 가능)
        if (cust_name == null || cust_name.isEmpty()) {
            response.getWriter().println("<script>alert('이름을 입력해 주세요.'); history.back();</script>");
            return;
        }

        // 3. 현재 시간의 Timestamp 생성
        Timestamp time = new Timestamp(new Date().getTime());

        // 4. Intro 객체 생성
        Intro intro = new Intro(0, cust_name, email, phone, comp_name, data_type, coun_type, visit_path, time, content);

        // 5. IntroDao를 사용하여 데이터베이스에 저장
        IntroDao dao = new IntroDao();
        try {
            int result = dao.insertIntro(intro);

            if (result > 0) {
                // 성공 시 성공 메시지 출력 후 리다이렉트
                response.getWriter().println("<script>alert('문의 사항이 정상적으로 제출되었습니다.'); location.href='success.jsp';</script>");
            } else {
                // 삽입 실패 시 오류 메시지 출력
                response.getWriter().println("<script>alert('문의 사항 제출에 실패하였습니다.'); history.back();</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // 데이터베이스 처리 중 예외 발생 시 오류 메시지 출력
            response.getWriter().println("<script>alert('DB 처리 중 오류가 발생했습니다.'); history.back();</script>");
        }
    }

    // GET 요청이 필요하다면 처리할 수 있음 (선택 사항)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().println("<script>alert('잘못된 요청 방식입니다.'); history.back();</script>");
    }
}
