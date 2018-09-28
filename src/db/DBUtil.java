package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class DBUtil {
	// 数据库公用的方法，连接，断开连接，搜索，更新，插入等方法

	static final String URL = "jdbc:mysql://localhost:3306/AMA?useUnicode=true&amp;characterEncoding=UTF-8 "; // 登录路径
	static final String MySQLDriver = "com.mysql.jdbc.Driver"; // 加载驱动
	static final String user = "root";// mysql用户名
	static final String password = "xyl2161800124";// mysql密码

	private Connection conn;
	private Statement stmt;
	private ResultSet rs;

	// 构造函数，连接数据库，构造对象可使用函数获取数据库数据
	public DBUtil() {
		try {
			Class.forName(MySQLDriver); // 加载驱动，开启MySQL
			this.conn = DriverManager.getConnection(URL, user, password); // 连接MySQL
			this.stmt = conn.createStatement(); // 从连接流里创建statement，用于向数据库发送操作命令
		} catch (ClassNotFoundException e) {
			System.out.println("加载驱动异常");
		} catch (SQLException e) {
			System.out.println("连接数据库异常");
		}
	}

	// 关闭连接
	public void closeConnection() {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/*
	 * 执行搜索语句
	 */
	public ResultSet getRs(String sql) {
		try {
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("信息获取失败!");
			e.printStackTrace();
		}
		return rs;
	}

	/*
	 * 执行插入、删除、更新语句
	 */
	public int executeSQL(String sql) {
		try {
			stmt.execute(sql);
			return 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			return 0;
		}
	}

	/*
	 * 用于把结果集保存到ArrayList中
	 */
	public ArrayList<ArrayList<String>> getResult(ResultSet rs, int length) {// rs为结果集,length为结果集每行的元素个数
		ArrayList<ArrayList<String>> tempArr = new ArrayList<ArrayList<String>>();
		try {
			while (rs.next()) {
				// 保存结果集每行的元素
				ArrayList<String> rowArr = new ArrayList<String>();
				for (int i = 0; i < length; i++) {
					rowArr.add(rs.getString(i + 1));
				}

				tempArr.add(rowArr);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.getMessage();
			tempArr = null;
		}
		return tempArr;
	}

	/*
	 * 获取时间戳
	 */
	public String getTime(){
		return Long.toString(System.currentTimeMillis());
	}
	
	/*
	 * 获取当前日期
	 */
	public String getDate(){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		Date tempDate=new Date();	
	    String nowDate= sdf.format(tempDate);  
		return nowDate;
	}
	
	/*
	 * 获取精确日期
	 */
	public String getDetailedDate(){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date tempDate=new Date();	
	    String nowDate= sdf.format(tempDate);  
		return nowDate;
	}
	
	/*
	 * 格式化时间
	 */
	public String formatDate(String date){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String result = null;
		Date formDate;
		try {
			formDate = sdf.parse(date);
			result = sdf.format(formDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}
