package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import db.DB;
import db.DBMethods;
import object.Member;

public class AjaxGetMembersServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public AjaxGetMembersServlet() {
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

		//获取所有成员
		DB db = new DBMethods();
		ArrayList<Member> members = db.getMembers();
		ArrayList<Member> nowMembers = new  ArrayList<Member>();
		ArrayList<Member> outMembers = new  ArrayList<Member>();
		//分类封装
		classifyNodes(members,  nowMembers, outMembers);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("nowMembers", nowMembers);
        jsonObject.put("outMembers", outMembers);
		//将json返回原页面
        response.setCharacterEncoding("utf-8");
		response.getWriter().write(jsonObject.toString());
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}
	
	
	private static void classifyNodes(ArrayList<Member> members, 
			ArrayList<Member> nowMembers, ArrayList<Member> outMembers){
		if(members==null||members.size()<1)return;
		else{
			for(int i=0;i<members.size();i++){
				Member m = members.get(i);
				if(m.getOutTime().equals("9999-01-01")){
					nowMembers.add(m);
				}
				else{
					outMembers.add(m);
				}
			}
		}
	}

}
