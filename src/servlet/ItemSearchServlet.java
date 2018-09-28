package servlet;

/*
 * 加载物品查询页面
 */

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import object.LeafNode;
import object.ShelfNode;
import object.SupNode;
import db.DB;
import db.DBMethods;

public class ItemSearchServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public ItemSearchServlet() {
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
		//刷新页面的ztree
		HttpSession session = request.getSession();
		DB db = new DBMethods();
		ArrayList<SupNode> supNodes = db.getNodes();
		ArrayList<LeafNode> leafNodes = new ArrayList<LeafNode>();
		ArrayList<ShelfNode> shelfNodes = new ArrayList<ShelfNode>();
		classifyNodes(supNodes, leafNodes, shelfNodes);
		session.setAttribute("leafNodes", leafNodes);
		session.setAttribute("shelfNodes", shelfNodes);
		response.sendRedirect("/AMA/jsp/itemSearch.jsp");
		
	}
	
	private static void classifyNodes(ArrayList<SupNode> supNodes, 
			ArrayList<LeafNode> leafNodes, ArrayList<ShelfNode> shelfNodes){
		if(supNodes==null||supNodes.size()==0)
			return;
		for(int i=0;i<supNodes.size();i++){
			SupNode node = supNodes.get(i);
			if(node.isLeaf())
				leafNodes.add((LeafNode)node);
			else
				shelfNodes.add((ShelfNode)node);
		}
//		System.out.println("结点分类完毕");
	}
	
}
