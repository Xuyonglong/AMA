package servlet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class UploadServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public UploadServlet() {
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

	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		HttpSession session = request.getSession();
		// 得到上传文件的保存目录
		String savePath = request.getServletContext().getRealPath("/") + "img/upload/shelf";

		if (ServletFileUpload.isMultipartContent(request)) {

			try {
				// 1. 创建DiskFileItemFactory对象，设置缓冲区大小和临时文件目录
				DiskFileItemFactory factory = new DiskFileItemFactory();
				// System.out.println(System.getProperty("java.io.tmpdir"));//默认临时文件夹

				// 2. 创建ServletFileUpload对象，并设置上传文件的大小限制。
				ServletFileUpload sfu = new ServletFileUpload(factory);
				sfu.setSizeMax(10 * 1024 * 1024);// 以byte为单位 不能超过10M 1024byte =
				// 1kb 1024kb=1M 1024M = 1G
				sfu.setHeaderEncoding("utf-8");

				// 3.
				// 调用ServletFileUpload.parseRequest方法解析request对象，得到一个保存了所有上传内容的List对象。
				List<FileItem> fileItemList = sfu.parseRequest(request);
				for (FileItem file : fileItemList) {
					if (!file.isFormField()) {
						// 获取上传文件的名字
						String fileName = file.getName();
						System.out.println("文件名：" + fileName + " 文件大小："
								+ file.getSize());
						fileName = fileName.substring(fileName
								.lastIndexOf("\\") + 1);
						// 获取上传文件的后缀
						String extName = fileName.substring(fileName
								.lastIndexOf("."));
						// 申明UUID
						String uuid = UUID.randomUUID().toString()
								.replace("-", "");
						// 组成新的名称
						String newName = uuid + extName;
						// 上传文件
						// 设置文件上传的目标路径
						String filePath = savePath + "/" + newName;
						// 构建输入输出流
						InputStream in = file.getInputStream(); // 获取item中的上传文件的输入流
						OutputStream out = new FileOutputStream(filePath); // 创建一个文件输出流
						System.out.println("path:"+filePath);

						// 创建一个缓冲区
						byte b[] = new byte[1024];
						// 判断输入流中的数据是否已经读完的标识
						int len = -1;
						// 循环将输入流读入到缓冲区当中，(len=in.read(buffer))！=-1就表示in里面还有数据
						while ((len = in.read(b)) != -1) { // 没数据了返回-1
							// 使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath+"\\"+filename)当中
							out.write(b, 0, len);
						}
						out.flush();
						// 关闭流
						out.close();
						in.close();
						// // 封装
//						session.setAttribute("newName", newName);
						response.getWriter().write("<script>parent.callback('"+newName+"')</script>");
					}
				}

			} catch (FileUploadException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}

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
