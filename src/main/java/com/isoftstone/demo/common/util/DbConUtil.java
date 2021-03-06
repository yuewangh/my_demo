package com.isoftstone.demo.common.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;


public class DbConUtil {
	public static Connection getcon(){
		String propertyPath = "config/jdbc.properties";
		Thread trd= Thread.currentThread();
		ClassLoader cld = trd.getContextClassLoader();
		InputStream inputStream = cld.getResourceAsStream(propertyPath);
		Properties propertie = new Properties();
		try {
			propertie.load(inputStream);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		String driverClassName = propertie.getProperty("jdbc.driverClassName");
		String username = propertie.getProperty("jdbc.username");
		String password = propertie.getProperty("jdbc.password");
		String url = propertie.getProperty("jdbc.url")+"?characterEncoding=utf-8";
		Connection conn = null;
		try {
			Class.forName(driverClassName);
			conn = DriverManager.getConnection(url, username, password);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	public static void closeCone(Connection con){
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	// 测试
	public static void main(String[] args) throws Exception {
		Connection con = getcon();
		if (con != null) {
			System.out.println("测试成功！");
		}
	}
}
