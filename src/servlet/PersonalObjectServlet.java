package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import object.PersonObject;
import object.User;
import db.DBMethods;

public class PersonalObjectServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;


	/**
	 * Constructor of the object.
	 */
	public PersonalObjectServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		if(loginUser==null)
			response.sendRedirect(request.getServletContext().getContextPath() +"/login.jsp");
		else{
//			User loginUser = new User("2162005061");
	        String id = loginUser.getId();
	        DBMethods db = new DBMethods();
	        ArrayList<PersonObject> personalObject = db.getMyLeafNodes(id); 
			session.setAttribute("PersonObject", personalObject);
			//跳转信息页
			response.sendRedirect(request.getServletContext().getContextPath() +"/jsp/personalObject.jsp");
		}

		
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
