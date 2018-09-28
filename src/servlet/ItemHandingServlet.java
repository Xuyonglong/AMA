package servlet;

/*
 * 处理物品查询页面的查询和借出请求，并刷新页面
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

public class ItemHandingServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * Constructor of the object.
	 */
	public ItemHandingServlet() {
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
	//处理物品查询界面的查询和借出请求
	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//定义要传回页面的属性
		String borrowFlag = "";
		
		request.setCharacterEncoding("UTF-8");
		String type = request.getParameter("type");
		//模糊查询请求
		if(type!=null&&type.equals("search")){
			String queryString = request.getParameter("searchInput");
//			System.out.println(queryString);
			DB db = new DBMethods();
			ArrayList<LeafNode> nodes = db.getLeafNodes(queryString);
			String str = "<script>parent.showSearch(";
			if(nodes!=null&&nodes.size()>0){
//				System.out.println("nodes.size:"+nodes.size());
				for(int i=0;i<nodes.size();i++){
					str += nodes.get(i).getId();
					if(i!=nodes.size()-1){
						str += ",";
					}
				}
			}
			else{
				//返回未找到
				str += "-1";
			}
			str += ")</script>";
			response.getWriter().write(str);
		}
		else if(type!=null&&type.equals("borrow")){
			String userId = request.getParameter("userId");
			String itemId = request.getParameter("itemId");
			String shelfId = request.getParameter("shelfId");
			String number = request.getParameter("number");
			DB db = new DBMethods();
			boolean flag = db.borrowItems(userId, itemId, shelfId, number);
			//刷新准备的数据
			HttpSession session = request.getSession();
			ArrayList<SupNode> supNodes = db.getNodes();
			ArrayList<LeafNode> leafNodes = new ArrayList<LeafNode>();
			ArrayList<ShelfNode> shelfNodes = new ArrayList<ShelfNode>();
			classifyNodes(supNodes, leafNodes, shelfNodes);
			session.setAttribute("leafNodes", leafNodes);
			session.setAttribute("shelfNodes", shelfNodes);
			if(flag){
				 System.out.println(userId+" borrow "+ itemId + " for "+ number);
				 borrowFlag = "0";
			}
			else{
				borrowFlag = "-1";
			}
			session.setAttribute("borrowFlag", borrowFlag);
			response.sendRedirect("/AMA/jsp/itemSearch.jsp?isReadCookie=1");
		}
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
