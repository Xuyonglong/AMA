package servlet;
/*
 * 加载记录查询
 */
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import object.ItemChange;
import object.MemberChange;
import object.ShelfChange;
import db.DB;
import db.DBMethods;

public class ChangeServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public ChangeServlet() {
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
		DB db = new DBMethods();
		ArrayList<MemberChange> memberChanges = new ArrayList<MemberChange>();
		ArrayList<ShelfChange> shelfChanges = new ArrayList<ShelfChange>();
		ArrayList<ItemChange> itemChanges = new ArrayList<ItemChange>();
		boolean flag = db.getChanges(memberChanges, shelfChanges, itemChanges);
		if(flag){
			session.setAttribute("memberChanges", memberChanges);
			session.setAttribute("shelfChanges", shelfChanges);
			session.setAttribute("itemChanges", itemChanges);
			response.sendRedirect("/AMA/jsp/record.jsp");
		}
		else{
			System.out.println("record error");
			response.sendRedirect("/AMA/jsp/record.jsp");
		}
		
	}

}
