package servlet;
/*
 * 处理个人信息界面的信息修改
 */


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.DB;
import db.DBMethods;
import object.User;

public class ResetInfoServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public ResetInfoServlet() {
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
		User loginUser = (User) session.getAttribute("loginUser");
		String id = loginUser.getId();
		DB db = null;
		boolean isSucceed;
		
		String type = request.getParameter("type");
		//修改密码的请求
		if(type!=null&&type.equals("resetPassword")){
			String oldPwd = request.getParameter("oldPassword");
			String newPwd = request.getParameter("newPassword");
			db = new DBMethods();
			isSucceed = db.setPassword(id,oldPwd,newPwd);
			int flag = isSucceed?0:-6;
			response.getWriter().write("<script>parent.showError("+flag+")</script>");
		}
		//修改电话
		else if(type!=null&&type.equals("resetPhone")){
			String newPhone = request.getParameter("phone");
			db = new DBMethods();
			isSucceed = db.setPhone(id, newPhone);
			int flag = isSucceed?0:-4;
			response.getWriter().write("<script>parent.showError2("+flag+")</script>");
		}
		else System.out.println("reset error");

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
