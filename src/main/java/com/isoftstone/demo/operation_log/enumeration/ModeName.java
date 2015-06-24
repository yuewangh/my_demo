package com.isoftstone.demo.operation_log.enumeration;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 业务类型 DATADICT 数据字典 XIAOXI 消息管理
 * 
 * @author ywang
 */
public enum ModeName {
	APPOINTMENT("APPOINTMENT", "预约单管理"), 
	RESERVATION("RESERVATION", "预订单管理"),
	BUILDING("BUILDING", "办公楼管理"), 
	OFFICE("OFFICE", "办公室管理"),
	DESK("DESK", "办公桌管理"),
	MESSAGE("MESSAGE", "通知公告管理"),
	USER("USER", "用户管理"),
	ACTIVITY("ACTIVITY", "活动管理"),
	ROLE("ROLE", "角色管理"),
	LOGIN("LOGIN", "登录管理"),
	APP_LOGIN("APP_LOGIN", "移动端登录管理"),
	MEMBER("MEMBER", "会员管理"),
	;
	public String value;
	public String displayCode;

	ModeName(String value, String displayCode) {
		this.value = value;
		this.displayCode = displayCode;
	}
	public static List<Map<String,Object>> getListMap(){
		List<Map<String,Object>> maplist = new ArrayList<Map<String,Object>>();
		for (ModeName s : ModeName.values()) {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("id",s.value);
			map.put("name", s.displayCode);
			maplist.add(map);
		}
		return maplist;
	}
	public static void main() {
		for (ModeName s : ModeName.values()) {
			System.out.println(s + ", ordinal " + s.ordinal());
			System.out.println(s.displayCode);
			System.out.println(s.value);
		}
	}
}
