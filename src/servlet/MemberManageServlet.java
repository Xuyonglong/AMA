package servlet;
/*
 * 加载人员管理界面
 */
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;
import object.Member;
import db.DB;
import db.DBMethods;

public class MemberManageServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public MemberManageServlet() {
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
		HttpSession session = request.getSession();
		//获取所有成员
		DB db = new DBMethods();
		ArrayList<Member> members = db.getMembers();
		ArrayList<Member> nowMembers = new  ArrayList<Member>();
		ArrayList<Member> outMembers = new  ArrayList<Member>();
		//分类封装
		classifyNodes(members,  nowMembers, outMembers);
        JSONObject jsonObject1 = new JSONObject();
        jsonObject1.put("nowMembers", nowMembers);
		session.setAttribute("nowMembers", jsonObject1.toString());
        JSONObject jsonObject2 = new JSONObject();
        jsonObject2.put("outMembers", outMembers);
		session.setAttribute("outMembers", jsonObject2.toString());
		response.sendRedirect("/AMA/jsp/memberManage.jsp");
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
