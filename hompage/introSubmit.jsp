<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="common.Intro, common.IntroDao" %>
<%
    // 1. 사용자 입력 값을 request에서 받아옴
    String cust_name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String comp_name = request.getParameter("company");
    String data_type = request.getParameter("data_type");
    String coun_type = request.getParameter("coun_type");
    String visit_path = request.getParameter("visit_path");
    String content = request.getParameter("inquiry");

    // 2. Timestamp 생성 (현재 시간)
    Timestamp time = new Timestamp(new Date().getTime());

    // 3. Intro 객체 생성
    Intro intro = new Intro(0, cust_name, email, phone, comp_name, data_type, coun_type, visit_path, time, content);

    // 4. IntroDao를 통해 DB에 데이터 저장
    IntroDao dao = new IntroDao();
    try {
        int result = dao.insertIntro(intro);  // insertInquiry는 intro 객체를 DB에 저장하는 메서드
        
        if (result > 0) {
            out.println("<script>alert('문의 사항이 정상적으로 제출되었습니다.'); location.href='BA02.jsp';</script>");
        } else {
            out.println("<script>alert('문의 사항 제출에 실패하였습니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('DB 처리 중 오류가 발생했습니다.'); history.back();</script>");
    }
%>
