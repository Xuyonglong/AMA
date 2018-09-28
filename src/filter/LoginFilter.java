package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import object.User;


public class LoginFilter implements Filter {
	// FilterConfig可用于访问Filter的配置信息
	private String loginPage ="/login.jsp";
	private String loginServlet = "/LoginServlet";

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest serlvetRequest,
			ServletResponse serlvetResponse, FilterChain filterChain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) serlvetRequest;
		HttpServletResponse response = (HttpServletResponse) serlvetResponse;
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");

		// 获取客户请求的页面
		String requestPath = request.getServletPath();
		//过滤掉附加的参数传递
		requestPath = requestPath.substring(requestPath.lastIndexOf("?") + 1);
//		System.out.println("当前请求："+requestPath);

		if (loginUser == null && !requestPath.endsWith(loginPage) && !requestPath.endsWith(loginServlet) && !requestPath.endsWith(".css")) {
//			System.out.println("filter拦截：用户未登录");
//			String url = response.encodeRedirectURL(request.getContextPath()
//					+ request.getServletPath().toString());
//			response.sendRedirect("/AMA/login.jsp?returnUrl=" + url);
			//不返回其请求页面
			response.sendRedirect("/AMA/login.jsp");
		} else {
//			if(loginUser!=null)System.out.println("filter未拦截：用户："+loginUser.getId());
			filterChain.doFilter(serlvetRequest, serlvetResponse);
		}

	}

}
