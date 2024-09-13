package common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;

/**
 * Servlet implementation class Analysis
 */
@WebServlet("/Analysis")
public class Analysis extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnalysisDao AnalysisDao;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Analysis() {
        super();
        AnalysisDao = new AnalysisDao(); 
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		request.setCharacterEncoding("UTF-8");
		String ana_email = request.getParameter("ana_email");
		String ana_sel = request.getParameter("ana_sel");
		
		AnaDo ana_info = new AnaDo();
		ana_info.setAna_email(ana_email);
		ana_info.setAna_sel(ana_sel);
		
		File batFile = new File("C:\\Users\\mit106\\Desktop\\project\\JAVA\\WokrSpace\\PROJECT\\src\\main\\java\\PROJECT_test\\test.bat");
        ProcessBuilder processBuilder = new ProcessBuilder(batFile.getAbsolutePath());
        processBuilder.directory(new File("C:\\Users\\mit106\\Desktop\\project\\JAVA\\WokrSpace\\PROJECT\\src\\main\\java\\PROJECT_test\\"));

        try {
            Process process = processBuilder.start();

            new Thread(() -> {
                try (var reader = new java.io.BufferedReader(new java.io.InputStreamReader(process.getInputStream()))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        System.out.println(line);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }).start();
            
            int exitCode = process.waitFor();
            System.out.println("Process exited with code: " + exitCode);

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }		
	}
}
