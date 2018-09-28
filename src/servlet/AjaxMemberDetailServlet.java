package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.DB;
import db.DBMethods;
import object.PersonObject;
import net.sf.json.JSONObject;

public class AjaxMemberDetailServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public AjaxMemberDetailServlet() {
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
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}
	
	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        
        //获取ajax参数
        String id = request.getParameter("memberId");
        //创建返回的数组
		DB db = new DBMethods();
        ArrayList<PersonObject> arrList = db.getMyLeafNodes(id);
        //将返回的数组用json封装
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("memberItems", arrList);
        //将json返回原页面
        response.setCharacterEncoding("utf-8");
		response.getWriter().write(jsonObject.toString());
		
	}

}
