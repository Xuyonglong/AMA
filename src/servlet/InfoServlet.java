package servlet;
/*
 * 加载个人信息界面
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

public class InfoServlet extends HttpServlet {
	private String loginServlet = "/LoginServlet";

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public InfoServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		
	}
	
	
	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		//拦截未登录情况
		if(loginUser==null)
			response.sendRedirect(request.getServletContext().getContextPath() +"/login.jsp");
		else{
			//如果不是从登录跳转的，则数据库刷新当前用户的信息
			String requestPath = request.getServletPath();
			//过滤掉附加的参数传递
			requestPath = requestPath.substring(requestPath.lastIndexOf("?") + 1);
			if(!requestPath.endsWith(loginServlet)){
				String id = loginUser.getId();
				DB db = new DBMethods();
				User newUser = db.getUser(id);
				session.setAttribute("loginUser", newUser);
//				System.out.println("更新用户信息成功");
			}
			//跳转信息页
			response.sendRedirect(request.getServletContext().getContextPath() +"/jsp/info.jsp");
		}

		
	}

}
