/*
 *  1. 萬用複合查詢-可由客戶端隨意增減任何想查詢的欄位
 *  2. 為了避免影響效能:
 *        所以動態產生萬用SQL的部份,本範例無意採用MetaData的方式,也只針對個別的Table自行視需要而個別製作之
 * */


package com.activity.model;

import java.util.*;

public class jdbcUtil_CompositeQuery_Emp2 {

		public static String get_aCondition_For_Oracle(String columnName, String value) {

		String aCondition = null;

		if ("actMax".equals(columnName) || "actLimit".equals(columnName) || "timeCheck".equals(columnName) || "actPic".equals(columnName)) // 用於其他
			aCondition = columnName + "=" + value;
		else if ("actNo".equals(columnName) || "memNo".equals(columnName)|| "actName".equals(columnName)|| "actLoc".equals(columnName)|| "actStatus".equals(columnName)|| "actDesc".equals(columnName)) // 用於varchar
			aCondition = columnName + " like '%" + value + "%'";
		else if("startTime".equals(columnName))                         // 用於Oracle的date
			aCondition = "acttime >= to_date('" + value + "','yyyy-mm-dd')";
		else if("endTime".equals(columnName))
			aCondition = "acttime <= to_date('" + value + "','yyyy-mm-dd')";
		return aCondition + " ";
	}

	public static String get_WhereCondition(Map<String, String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for (String key : keys) {
			String value = map.get(key)[0];
			if (value != null && value.trim().length() != 0	&& !"action".equals(key)) {
				count++;
				String aCondition = get_aCondition_For_Oracle(key, value.trim());

				if (count == 1)
					whereCondition.append(" where " + aCondition);
				else
					whereCondition.append(" and " + aCondition);

				System.out.println("有送出查詢資料的欄位數count =" + count);
			}
		}
		
		return whereCondition.toString();
	}

	public static void main(String argv[]) {

		// 配合 req.getParameterMap()方法 回傳 java.util.Map<java.lang.String,java.lang.String[]> 之測試
		Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("actMax", new String[] { "1" });
		map.put("actLimit", new String[] { "1" });
		map.put("timeCheck", new String[] { "1" });
		map.put("actPic", new String[] { "" });
		map.put("actNo", new String[] { "ACT0001" });
		map.put("memNo", new String[] { "M0001" });
		map.put("actName", new String[] { "" });
		map.put("actLoc", new String[] { "桃園" });
		map.put("actStatus", new String[] { "募集中" });
		map.put("actDesc", new String[] { "" });
		map.put("actTime", new String[] { "1970-01-01" });
		map.put("action", new String[] { "getXXX" }); // 注意Map裡面會含有action的key

		String finalSQL = "select * from activity "
				          + jdbcUtil_CompositeQuery_Emp2.get_WhereCondition(map)
				          + "order by actNo";
		System.out.println("●●finalSQL = "+ finalSQL);

	}
}
