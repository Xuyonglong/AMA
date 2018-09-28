package servlet;
/*
 * 处理登录请求
 */

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import object.User;
import db.DB;
import db.DBMethods;

public class LoginServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public LoginServlet() {
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
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();

		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String returnUrl = request.getParameter("returnUrl");

		int flag = 0;
		// check login
		if (id == null || id.trim().equals("")) {
			// 用户名为空
			flag = -1;
		} else if (password == null || password.trim().equals("")) {
			// 密码为空
			flag = -2;
			
		} else {
			DB db = new DBMethods();
			User loginUser = db.getUser(id, password);
			if (loginUser == null) {
				// 用户名或密码错误
				flag = -3;
			} else {
//				System.out.print(db.setName("22", "杨扬"));
				
				System.out.println("用户" + id + "登录成功！");
				session.setAttribute("loginUser", loginUser);
				if (returnUrl == null || returnUrl.trim().equals("")) {
					returnUrl = "/AMA/ItemSearchServlet";
				}
				session.setAttribute("oldId", id);
				session.setAttribute("oldPassword", password);
				session.setAttribute("errorFlag", 0);
				response.sendRedirect(response.encodeRedirectURL(returnUrl));

			}
		}
		// 登录不成功则返回登录界面,带上原有的返回地址
		if (flag < 0) {
			if (id != null && !id.trim().equals("")){
				//将已输入的学号返回
				session.setAttribute("oldId", id);
			}
			if (password != null && !password.trim().equals("")){
				//将已输入的密码返回
				session.setAttribute("oldPassword", password);
			}
			//将错误类型返回
			session.setAttribute("errorFlag", flag);
			//有返回地址时，将返回地址返回
			String strReturn = "";			
			if (returnUrl != null && returnUrl.trim().length() > 0) {
				//将原来访问的地址返回
				strReturn += "?returnUrl=" + returnUrl;
			}
			String path = request.getServletContext().getContextPath() + "/login.jsp" + strReturn;
			response.setContentType("text/html;charset=UTF-8");
			response.sendRedirect(path);
		}

	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
