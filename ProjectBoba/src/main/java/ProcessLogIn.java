import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
/**

 * Servlet implementation class ProcessLogIn

 */

@WebServlet("/ProcessLogIn")
public class ProcessLogIn extends HttpServlet {
     private static final long serialVersionUID = 1L;

    /**

     * @see HttpServlet#HttpServlet()

     */
    public ProcessLogIn() {
        super();
        // TODO Auto-generated constructor stub 
        }
     /**

      * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)

      */

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 // TODO Auto-generated method stub
	 //response.getWriter().append("Served at: ").append(request.getContextPath());
	 String uName = request.getParameter("admin_name");
	String pass = request.getParameter("password");
	
	 System.out.println("uName:"+ uName);
	 String dbUname = null, dbPassword=null;
	 //PrintWriter pw = response.getWriter();
	 String sql;
	 try {
		 Class.forName("com.mysql.cj.jdbc.Driver");
		 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/boba", "root","1234");
		 Statement stmt = con.createStatement();
		 sql = "SELECT * FROM admin WHERE admin_name='" + uName + "'" + " AND " + " password='" + pass +"'"; 
		 ResultSet rs = stmt.executeQuery(sql); 
	
		 while (rs.next()) {
			 dbUname = rs.getString(1).toString();
			 dbPassword = rs.getString(2).toString();
		 }
		 con.close();
	
	 } catch (Exception e) {System.out.println(e); }
	 if (uName.equals(dbUname) && dbPassword.equals(pass)) {
		 response.sendRedirect("dashb.jsp");
	 }
	 else {
		 response.sendRedirect("login.jsp");
	 }
 }
     /**

      * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)

      */
     protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          // TODO Auto-generated method stub
          doGet(request, response);

     }
}