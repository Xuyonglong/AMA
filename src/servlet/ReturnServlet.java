package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import object.PersonObject;
import db.DBMethods;

public class ReturnServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public ReturnServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String uId = request.getParameter("userId");
		int returnNum = Integer.valueOf(request.getParameter("number"));
		String oId = request.getParameter("itemId");
		String itemName = request.getParameter("itemName");
		String shelfName = request.getParameter("shelfName");
		DBMethods db = new DBMethods();
		boolean success = db.returnObj(uId, oId, returnNum);
		if(success){
			session.setAttribute("itemName",itemName);
			session.setAttribute("shelfName",shelfName);
			session.setAttribute("returnNum", returnNum);
			session.setAttribute("isSucceed",success);
		}
		
        ArrayList<PersonObject> personalObject = db.getMyLeafNodes(uId); 
		session.setAttribute("PersonObject", personalObject);
		//跳转信息页
		response.sendRedirect(request.getServletContext().getContextPath() +"/jsp/personalObject.jsp");
		

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
