package com.isoftstone.demo.common.util;

import java.io.File;
import java.io.IOException;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;

import org.apache.commons.io.FileUtils;




public class MysqlHelp {

	private static String rootPath = "com.isoftstone.demo";// 目录

	//自定义参数
	private static String lowerEntityName = "operation_log";//包名(同是类名，首先字母小写)
	private static String tablename="portal_sys_log";//表名
	
	private static String upperEntityName;//类名(默认首先字母大写)
	private static String path = System.getProperty("user.dir")+ "/src/main/java/";// 项目路径
	private static String[] sqlfields;
	private static String[] fields;
	private static String[] types;
	private static String[] remarks;
	public static void main(String[] args) {
		upperEntityName=upperStr(lowerEntityName);
		// 准备
		getFields(tablename);
		// 代码生成
		//createModel();// 生成model实体类
		//createDaoJava();
		//createDaoImplJava();
		//createServiceJava();
		//createServiceImplJava();
		createControllerJava();
	}
	/**
	 * 生成controllerjava
	 */
	public static void createControllerJava(){
		StringBuffer sb = new StringBuffer();
		sb.append("package " + rootPath+"."+lowerEntityName+ ".web.controller;\r\n\r\n");
		sb.append("import org.springframework.beans.factory.annotation.Autowired;\r\n");
		sb.append("import org.springframework.stereotype.Controller;\r\n");
		sb.append("import org.springframework.web.bind.annotation.RequestMapping;\r\n");
		sb.append("import " + rootPath+"."+lowerEntityName+ ".service."+upperEntityName+ "Service;\r\n\r\n");
		sb.append("@Controller\r\n");
		sb.append("@RequestMapping(\"/"+lowerEntityName+ "\")\r\n");
		sb.append("public class "+upperEntityName+"Controller {\r\n\r\n");
		sb.append("\t@Autowired\r\n");
		sb.append("\tprivate "+upperEntityName+"Service "+lowerEntityName+"Service;\r\n\r\n");
		sb.append("}");
		String content = sb.toString();
		
		String filepath = path + rootPath.replaceAll("\\.", "/")+"/"+lowerEntityName+"/web/controller";
		File file = new File(filepath);
		if (!file.exists()) {
			file.mkdirs();
		}
		String resPath = filepath + "/" + upperEntityName + "Controller.java";
		System.out.println("resPath=" + resPath);
		try {
			FileUtils.writeStringToFile(new File(resPath), content);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 获取字段信息
	 * @param tableName表名
	 * @return
	 */
	public static void getFields(String tableName) {
		try {
            DatabaseMetaData dbmd=DbConUtil.getcon().getMetaData();
            ResultSet rs = dbmd.getColumns(null, "%", tableName, "%");
            rs.last();
            int count = rs.getRow();
            fields = new String[count];
            types = new String[count];
            sqlfields = new String[count];
            remarks = new String[count];
            rs.beforeFirst();
            for(int i=0;i<count;i++){
            	rs.next();
            	String type = rs.getString("TYPE_NAME");//字段类型
            	String field = rs.getString("COLUMN_NAME");//字段名称
            	String remark = rs.getString("REMARKS");//字段注释
            	sqlfields[i] =field;
            	fields[i] = toCamelCase(field);
            	if(remark == null){
            		remarks[i]="";
            	}else{
            		remarks[i]=remark;
            	}
            	if(type.equals("VARCHAR") || type.equals("CHAR")){
            		types[i] = "String";
            	} else if(type.equals("INT")){
            		types[i] = "int";
            	} else if(type.equals("DATETIME") || type.equals("DATE") || type.equals("TIMESTAMP")){
            		types[i] = "Date";
            	} else if(type.equals("DECIMAL")){
            		types[i] = "BigDecimal";
            	}
            	
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	/**
	 * 生成Service.java
	 * @param packagePath//包名
	 * @param tableName//表名
	 * @param entityName//类名
	 * @param path//系统项目路径
	 */
	public static void createServiceImplJava(){
		StringBuffer sb = new StringBuffer();
		sb.append("package " + rootPath+"."+lowerEntityName+ ".service.impl;\r\n\r\n");
		sb.append("import java.util.List;\r\n");
		sb.append("import java.util.Map;\r\n");
		sb.append("import org.springframework.beans.factory.annotation.Autowired;\r\n");
		sb.append("import org.springframework.transaction.annotation.Transactional;\r\n");
		sb.append("import org.springframework.transaction.annotation.Propagation;\r\n");
		sb.append("import org.springframework.stereotype.Service;\r\n");
		sb.append("import "+ rootPath+"."+lowerEntityName+".model."+upperEntityName+";\r\n");
		sb.append("import "+ rootPath+"."+lowerEntityName+".dao."+upperEntityName+"Dao;\r\n");
		sb.append("import "+ rootPath+"."+lowerEntityName+".service."+upperEntityName+"Service;\r\n");
		sb.append("import " + rootPath+".common.exception.CustomException;\r\n");
		sb.append("import " + rootPath+".common.model.PageModel;\r\n\r\n");
		sb.append("@Service\r\n");
		sb.append("@Transactional(propagation= Propagation.NOT_SUPPORTED,readOnly=true)\r\n");
		sb.append("public class "+upperEntityName+"ServiceImpl implements "+upperEntityName+"Service {\r\n\r\n");
		sb.append("\t@Autowired\r\n");
		sb.append("\tprivate "+upperEntityName+"Dao "+lowerEntityName+"Dao;\r\n");
		sb.append("\t//新增\r\n");
		sb.append("\t@Transactional(propagation = Propagation.REQUIRED)\r\n");
		sb.append("\tpublic void insert("+upperEntityName+" "+lowerEntityName+") {\r\n");
		sb.append("\t\t"+lowerEntityName+"Dao.insert("+lowerEntityName+");\r\n");
		sb.append("\t}\r\n\r\n");
		
		sb.append("\t//修改\r\n");
		sb.append("\t@Transactional(propagation = Propagation.REQUIRED)\r\n");
		sb.append("\tpublic void updateObj("+upperEntityName+" "+lowerEntityName+") {\r\n");
		sb.append("\t\t"+lowerEntityName+"Dao.updateObj("+lowerEntityName+");\r\n");
		sb.append("\t}\r\n\r\n");
		
		sb.append("\t//删除\r\n");
		sb.append("\t@Transactional(propagation = Propagation.REQUIRED)\r\n");
		sb.append("\tpublic void delete(String id) {\r\n");
		sb.append("\t\t"+lowerEntityName+"Dao.delete(id);\r\n");
		sb.append("\t}\r\n\r\n");
		
		sb.append("\t//获取单条\r\n");
		sb.append("\tpublic "+upperEntityName+" getOne(String id) throws CustomException {\r\n");
		sb.append("\t\treturn "+lowerEntityName+"Dao.getOne(id);\r\n");
		sb.append("\t}\r\n\r\n");
		
		sb.append("\t//获取总数\r\n");
		sb.append("\tpublic int getCount(Map<String, Object> params){\r\n");
		sb.append("\t\treturn "+lowerEntityName+"Dao.getCount(params);\r\n");
		sb.append("\t}\r\n\r\n");
		
		sb.append("\t//分页查询\r\n");
		sb.append("\tpublic PageModel<"+upperEntityName+"> getList(Map<String, Object> params, int page,int size, Map<String, String> orders){\r\n");
		sb.append("\t\tPageModel<"+upperEntityName+"> pm = new PageModel<"+upperEntityName+">();\r\n");
		sb.append("\t\tint records = "+lowerEntityName+"Dao.getCount(params);\r\n");
		sb.append("\t\tpm.setRecords(records);\r\n");
		sb.append("\t\tpm.setPage(page);\r\n");
		sb.append("\t\tpm.setLimit(size);\r\n");
		sb.append("\t\tif (pm.getTotal() > 0) {\r\n");
		sb.append("\t\t\tList<"+upperEntityName+"> rows = "+lowerEntityName+"Dao.getList(params, page, size, orders);\r\n");
		sb.append("\t\t\tpm.setRows(rows);\r\n");
		sb.append("\t\t} else {\r\n");
		sb.append("\t\t\tpm.setPage(1);\r\n");
		sb.append("\t\t}\r\n");
		sb.append("\t\treturn pm;\r\n");
		sb.append("\t}\r\n\r\n");
		sb.append("}");
		String content = sb.toString();
		
		String filepath = path + rootPath.replaceAll("\\.", "/")+"/"+lowerEntityName+"/service/impl";
		File file = new File(filepath);
		if (!file.exists()) {
			file.mkdirs();
		}
		String resPath = filepath + "/" + upperEntityName + "ServiceImpl.java";
		System.out.println("resPath=" + resPath);
		try {
			FileUtils.writeStringToFile(new File(resPath), content);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 生成Service.java
	 * @param packagePath//包名
	 * @param tableName//表名
	 * @param entityName//类名
	 * @param path//系统项目路径
	 */
	public static void createServiceJava(){
		StringBuffer sb = new StringBuffer();
		sb.append("package " + rootPath+"."+lowerEntityName+ ".service;\r\n\r\n");
		sb.append("import java.util.Map;\r\n");
		sb.append("import "+ rootPath+"."+lowerEntityName+".model."+upperEntityName+";\r\n");
		sb.append("import " + rootPath+".common.exception.CustomException;\r\n");
		sb.append("import " + rootPath+".common.model.PageModel;\r\n\r\n");
		sb.append("public interface " + upperEntityName +"Service {\r\n");
		sb.append("\t//新增\r\n");
		sb.append("\tpublic void insert("+upperEntityName+" "+lowerEntityName+");\r\n");
		sb.append("\t//修改\r\n");
		sb.append("\tpublic void updateObj("+upperEntityName+" "+lowerEntityName+");\r\n");
		sb.append("\t//获取单条\r\n");
		sb.append("\tpublic "+upperEntityName+" getOne(String id) throws CustomException;\r\n");
		sb.append("\t//删除\r\n");
		sb.append("\tpublic void delete(String id);\r\n");
		sb.append("\t//获取总数\r\n");
		sb.append("\tpublic int getCount(Map<String, Object> params);\r\n");
		sb.append("\t//分页查询\r\n");
		sb.append("\tpublic PageModel<"+upperEntityName+"> getList(Map<String, Object> params, int page,int size, Map<String, String> orders);\r\n\r\n");
		sb.append("}\r\n");
		String content = sb.toString();
		
		String filepath = path + rootPath.replaceAll("\\.", "/")+"/"+lowerEntityName+"/service";
		File file = new File(filepath);
		if (!file.exists()) {
			file.mkdirs();
		}
		String resPath = filepath + "/" + upperEntityName + "Service.java";
		System.out.println("resPath=" + resPath);
		try {
			FileUtils.writeStringToFile(new File(resPath), content);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 生成daoImpl.java
	 * @param packagePath//包名
	 * @param tableName//表名
	 * @param entityName//类名
	 * @param path//系统项目路径
	 */
	public static void createDaoImplJava(){
		StringBuffer sb = new StringBuffer();
		sb.append("package " + rootPath+"."+lowerEntityName+ ".dao.impl;\r\n\r\n");
		sb.append("import java.util.List;\r\n");
		sb.append("import java.util.Map;\r\n");
		sb.append("import org.apache.commons.lang3.StringUtils;\r\n");
		sb.append("import org.springframework.stereotype.Repository;\r\n");
		sb.append("import "+rootPath+".common.dao.impl.BaseDaoSupport;\r\n");
		sb.append("import "+rootPath+".common.exception.CustomException;\r\n");
		sb.append("import "+rootPath+"."+lowerEntityName+".dao."+upperEntityName+"Dao;\r\n");
		sb.append("import "+rootPath+"."+lowerEntityName+".model."+upperEntityName+";\r\n\r\n");
		sb.append("@Repository\r\n");
		sb.append("public class "+upperEntityName+"DaoImpl extends BaseDaoSupport<"+upperEntityName+"> implements "+upperEntityName+"Dao{\r\n\r\n");
		
		
		
		sb.append("\t//新增\r\n");
		sb.append("\tpublic void insert("+upperEntityName+" "+lowerEntityName+") {\r\n");
		sb.append("\t\tsave("+lowerEntityName+");\r\n");
		sb.append("\t}\r\n");
		
		sb.append("\t//修改\r\n");
		sb.append("\tpublic void updateObj("+upperEntityName+" "+lowerEntityName+") {\r\n");
		sb.append("\t\tupdate("+lowerEntityName+");\r\n");
		sb.append("\t}\r\n");
		
		sb.append("\t//获取单条\r\n");
		sb.append("\tpublic "+upperEntityName+" getOne(String id) throws CustomException {\r\n");
		sb.append("\t\treturn load(id);\r\n");
		sb.append("\t}\r\n");
		
		sb.append("\t//删除\r\n");
		sb.append("\tpublic void delete(String id) {\r\n");
		sb.append("\t\tdelete(id);\r\n");
		sb.append("\t}\r\n");
		
		sb.append("\t//获取总数\r\n");
		sb.append("\tpublic int getCount(Map<String, Object> params) {\r\n");
		sb.append("\t\tStringBuilder hql = new StringBuilder();\r\n");
		sb.append("\t\thql.append(\"SELECT count(u.uuid) FROM "+upperEntityName+" u \");\r\n");
		sb.append("\t\thql.append(this.getWhereHql(params));\r\n");
		sb.append("\t\tint count = super.getTotalCount(hql.toString(), params);\r\n");
		sb.append("\t\treturn count;\r\n");
		sb.append("\t}\r\n");
		
		sb.append("\t//分页查询\r\n");
		sb.append("\tpublic List<"+upperEntityName+"> getList(Map<String, Object> params, int page, int size, Map<String, String> orders) {\r\n");
		sb.append("\t\tStringBuilder hql = new StringBuilder();\r\n");
		sb.append("\t\thql.append(\"SELECT u FROM "+upperEntityName+" u\");\r\n");
		sb.append("\t\thql.append(this.getWhereHql(params));\r\n");
		sb.append("\t\tif (orders != null && !orders.isEmpty()){\r\n");
		sb.append("\t\t\thql.append(this.getOrderSql(orders));\r\n");
		sb.append("\t\t}\r\n");
		sb.append("\t\tList<"+upperEntityName+"> list = (List<"+upperEntityName+">) super.find(hql.toString(), params, page, size);\r\n");
		sb.append("\t\treturn list;\r\n");
		sb.append("\t}\r\n");
		
		sb.append("\t//获取排序sql\r\n");
		sb.append("\tprivate StringBuilder getOrderSql(Map<String, String> params) {\r\n");
		sb.append("\t\tStringBuilder order = new StringBuilder();\r\n");
		sb.append("\t\tif (params != null && !params.isEmpty()) {\r\n");
		sb.append("\t\t\tif (StringUtils.isNotEmpty(params.get(\"ORDER_NAME\"))) {\r\n");
		sb.append("\t\t\t\t order.append(\" u.\");\r\n");
		sb.append("\t\t\t\torder.append(params.get(\"ORDER_NAME\"));\r\n");
		sb.append("\t\t\t\tif (StringUtils.isNotEmpty(params.get(\"ORDER_TYPE\"))) {\r\n");
		sb.append("\t\t\t\t\torder.append(\" \");\r\n");
		sb.append("\t\t\t\t\torder.append(params.get(\"ORDER_TYPE\"));\r\n");
		sb.append("\t\t\t\t\torder.append(\" \");\r\n");
		sb.append("\t\t\t\t} else {\r\n");
		sb.append("\t\t\t\t\torder.append(\" asc \");\r\n");
		sb.append("\t\t\t\t}\r\n");
		sb.append("\t\t\t} else {\r\n");
		sb.append("\t\t\t\torder.append(\" u.registerTime desc \");\r\n");
		sb.append("\t\t\t}\r\n");
		sb.append("\t\t}\r\n");
		sb.append("\t\tif (order.length() > 0) {\r\n");
		sb.append("\t\t\torder.insert(0, \" ORDER BY \");\r\n");
		sb.append("\t\t}\r\n");
		sb.append("\t\treturn order;\r\n");
		sb.append("\t}\r\n");
		
		sb.append("\t//获取条件sql\r\n");
		sb.append("\tprivate StringBuilder getWhereHql(Map<String, Object> params) {\r\n");
		sb.append("\t\tStringBuilder where = new StringBuilder();\r\n");
		sb.append("\t\tif (params != null && !params.isEmpty()) {\r\n");
		sb.append("\t\t}\r\n");
		sb.append("\t\tif (where.length() > 0) {\r\n");
		sb.append("\t\t\twhere.insert(0, \" WHERE \");\r\n");
		sb.append("\t\t}\r\n");
		sb.append("\t\treturn where;\r\n");
		sb.append("\t}\r\n\r\n");
		sb.append("}");
		String content = sb.toString();
		String filepath = path + rootPath.replaceAll("\\.", "/")+"/"+lowerEntityName+"/dao/impl";
		File file = new File(filepath);
		if (!file.exists()) {
			file.mkdirs();
		}
		String resPath = filepath + "/" + upperEntityName + "DaoImpl.java";
		System.out.println("resPath=" + resPath);
		try {
			FileUtils.writeStringToFile(new File(resPath), content);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 生成dao.java
	 * @param packagePath//包名
	 * @param tableName//表名
	 * @param entityName//类名
	 * @param path//系统项目路径
	 */
	public static void createDaoJava(){
		StringBuffer sb = new StringBuffer();
		sb.append("package " + rootPath+"."+lowerEntityName+ ".dao;\r\n\r\n");
		sb.append("import java.util.List;\r\n");
		sb.append("import java.util.Map;\r\n");
		sb.append("import "+ rootPath+"."+lowerEntityName+".model."+upperEntityName+";\r\n");
		sb.append("import " + rootPath+".common.exception.CustomException;\r\n\r\n");
		sb.append("public interface " + upperEntityName +"Dao {\r\n");
		sb.append("\t//新增\r\n");
		sb.append("\tpublic void insert("+upperEntityName+" "+lowerEntityName+");\r\n");
		sb.append("\t//修改\r\n");
		sb.append("\tpublic void updateObj("+upperEntityName+" "+lowerEntityName+");\r\n");
		sb.append("\t//获取单条\r\n");
		sb.append("\tpublic "+upperEntityName+" getOne(String id) throws CustomException;\r\n");
		sb.append("\t//删除\r\n");
		sb.append("\tpublic void delete(String id);\r\n");
		sb.append("\t//获取总数\r\n");
		sb.append("\tpublic int getCount(Map<String, Object> params);\r\n");
		sb.append("\t//分页查询\r\n");
		sb.append("\tpublic List<"+upperEntityName+"> getList(Map<String, Object> params, int page, int size, Map<String, String> orders);\r\n\r\n");
		sb.append("}");
		String content = sb.toString();
		
		String filepath = path + rootPath.replaceAll("\\.", "/")+"/"+lowerEntityName+"/dao";
		File file = new File(filepath);
		if (!file.exists()) {
			file.mkdirs();
		}
		String resPath = filepath + "/" + upperEntityName + "Dao.java";
		System.out.println("resPath=" + resPath);
		try {
			FileUtils.writeStringToFile(new File(resPath), content);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/*
	 * 创建model实体
	 */
	private static void createModel() {
		StringBuffer sb = new StringBuffer();
		sb.append("package " + rootPath+"."+lowerEntityName+ ".model;\r\n\r\n");
		sb.append("import java.util.Date;\r\n");
		sb.append("import javax.persistence.Column;\r\n");
		sb.append("import javax.persistence.Entity;\r\n");
		sb.append("import javax.persistence.Id;\r\n");
		sb.append("import javax.persistence.Table;\r\n");
		sb.append("import javax.persistence.GeneratedValue;\r\n");
		sb.append("import org.hibernate.annotations.GenericGenerator;\r\n");
		
		//定义属性
		sb.append("@Entity\r\n");
		sb.append("@Table(name=\""+tablename.toUpperCase()+"\")\r\n");
		sb.append("public class " + upperEntityName +"{\r\n\r\n");
		
		sb.append("\t@Id\r\n");
		sb.append("\t@GeneratedValue(generator = \"system-uuid\")\r\n");
		sb.append("\t@GenericGenerator(name = \"system-uuid\", strategy = \"uuid\")\r\n");
		sb.append("\t@Column(name = \"UUID\", length = 32)\r\n");
		sb.append("\tprivate String uuid;\r\n\r\n");
		
		
		for(int i=1;i<fields.length;i++){
			sb.append("\t//"+remarks[i]+"\r\n");
			sb.append("\t@Column(name = \""+sqlfields[i]+"\")\r\n");
			sb.append("\tprivate "+types[i]+" "+fields[i]+";\r\n");
		}
		sb.append("\r\n");
        //定义get/set方法
		sb.append("\tpublic String getUuid() { \r\n");
		sb.append("\t\treturn uuid;\r\n");
		sb.append("\t}\r\n\r\n");
		sb.append("\tpublic void setUuid(String uuid) {\r\n");
		sb.append("\t\tthis.uuid = uuid;\r\n");
		sb.append("\t}\r\n");
		for(int i=1;i<fields.length;i++){
			sb.append("\tpublic "+types[i]+" get"+upperStr(fields[i])+"() { \r\n");
			sb.append("\t\treturn "+fields[i]+";\r\n");
			sb.append("\t}\r\n\r\n");
			sb.append("\tpublic void set"+upperStr(fields[i])+"("+types[i]+" "+fields[i]+") {\r\n");
			sb.append("\t\tthis."+fields[i]+"= "+fields[i]+";\r\n");
			sb.append("\t}\r\n");
		}
		sb.append("}");
		
		String content = sb.toString();

		String filepath = path + rootPath.replaceAll("\\.", "/")+"/"+lowerEntityName+"/model";
		File file = new File(filepath);
		if (!file.exists()) {
			file.mkdirs();
		}
		String resPath = filepath + "/" + upperEntityName + ".java";
		System.out.println("resPath=" + resPath);
		try {
			FileUtils.writeStringToFile(new File(resPath), content);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 把输入字符串的首字母改成大写
	 * 
	 * @param str
	 * @return
	 */
	private static String upperStr(String str) {
		char[] ch = str.toCharArray();
		if (ch[0] >= 'a' && ch[0] <= 'z') {
			ch[0] = (char) (ch[0] - 32);
		}
		return new String(ch);
	}
	/**
	 * 下划线换驼峰
	 * @param str
	 * @return
	 */
	public static String toCamelCase(String s) {
		if (s == null) {
			return null;
		}
		s = s.toLowerCase();
		StringBuilder sb = new StringBuilder(s.length());
		boolean upperCase = false;
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (c == '_') {
				upperCase = true;
			} else if (upperCase) {
				sb.append(Character.toUpperCase(c));
				upperCase = false;
			} else {
				sb.append(c);
			}
		}
		return sb.toString();
	}
}
