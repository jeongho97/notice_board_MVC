package db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public static void initConnection() {
		Connection conn=null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("MySQL Connection success");
		} catch (Exception e) {
			e.printStackTrace();
			}
}
	public static Connection getConnection() {
		Connection conn=null;
		
		try {
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","1234");
			System.out.println("MySQL Connection success");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}
