package com.doctoravailable.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import com.doctoravailable.model.DravailableService;
import com.doctoravailable.model.DravailableVO;

public class HandleDravailable {
	public static List<Map> GetSameDravailable(String drno) {
		DravailableService ds = new DravailableService();
		List<DravailableVO> list = ds.getSameDravailable(drno);
		List<Map> avaTime = new ArrayList<Map>(); // 長度會是當月天數*3;裝的是map
		for (DravailableVO dvo : list) {
			String dravano = dvo.getDravano();
			String drava = dvo.getDrava();
			Date draym = dvo.getDraym();
			String year = draym.toString().substring(0, 4);
			String month = draym.toString().substring(5, 7);
			// 這個月有幾天
			GregorianCalendar cal = new GregorianCalendar();
			cal.setTime(draym);
			int dayInthisMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			// 取得drava字串,用迴圈分析，每個0或1分析出來的結果用map裝，再把每個map裝進list
			for (int i = 0; i < dayInthisMonth * 3; i++) {
				Map<String, String> map = new Hashtable<String, String>();
				map.put("dravano", dravano);
				map.put("drno", drno);
				map.put("year", year);
				map.put("month", month);
				map.put("index", Integer.toString(i)); //之後做修改時用
				String str = drava.substring(i, i + 1);
				if (str.equals("1")) {
//					System.out.println(i);
//					System.out.println("可預約");
					int j = i / 3 + 1; // j代表日期是幾號
					String date = Integer.toString(j);
					map.put("日期", date);
					int k = i % 3; // k代表時段(早;中;晚)

					switch (k) {
					case 0: {
						map.put("時段", "9:00~12:00");
						break;
					}
					case 1: {
						map.put("時段", "13:00~16:00");
						break;
					}
					case 2: {
						map.put("時段", "17:00~20:00");
						break;
					}
					default:
						break;
					}
					avaTime.add(map);
				}
			}
		}
//		測試map
//		for(Map items : avaTime) {
//			System.out.println(items.get("日期"));
//			System.out.println(items.get("時段"));
//			System.out.println("=========================================");
//		}
		return avaTime;
	}

//	--------------------------------------------------------------------------------------------
//只看當月和下個月，沒設定就產生全部為0的字串
	public static List<Map> GetSameDrschedule(String drno) {  
		DravailableService ds = new DravailableService();
		List<DravailableVO> list = ds.getSameDravailable(drno);
		if(list.size() == 0) {
			Date draym = new Date(new java.util.Date().getTime());
			int nextMonthInt = draym.getMonth() + 1;
			if(nextMonthInt == 12) {
				nextMonthInt = 0;
			}
			Date nextMonth = new Date(draym.getYear(), nextMonthInt, 1);
			String drava = GenerateDrava.set93Zero();
			ds.addDravailable(drno, draym, drava);
			ds.addDravailable(drno, nextMonth, drava);
			list = ds.getSameDravailable(drno);
		}
		
		if(list.size() == 1) {
			Date draym = new Date(new java.util.Date().getTime());
			int nextMonthInt = draym.getMonth() + 1;
			if(nextMonthInt == 12) {
				nextMonthInt = 0;
			}
			Date nextMonth = new Date(draym.getYear(), nextMonthInt, 1);
			String drava = GenerateDrava.set93Zero();
			ds.addDravailable(drno, nextMonth, drava);
			list = ds.getSameDravailable(drno);
		}
		
		List<Map> avaTime = new ArrayList<Map>(); // 長度會是當月天數*3;裝的是map
		for (DravailableVO dvo : list) {
			String dravano = dvo.getDravano();
//			System.out.println(dravano);
			String drava = dvo.getDrava();
			Date draym = dvo.getDraym();
			String year = draym.toString().substring(0, 4);
			String month = draym.toString().substring(5, 7);
			// 這個月有幾天
			GregorianCalendar cal = new GregorianCalendar();
			cal.setTime(draym);
			int dayInthisMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			// 取得drava字串,用迴圈分析，每個0或1分析出來的結果用map裝，再把每個map裝進list
			for (int i = 0; i < dayInthisMonth * 3; i++) {
				Map<String, String> map = new Hashtable<String, String>();
				map.put("dravano", dravano);
				map.put("drno", drno);
				map.put("year", year);
				map.put("month", month);
				map.put("index", Integer.toString(i)); //之後做修改時用
	
				int j = i / 3 + 1; // j代表日期是幾號
				String date = Integer.toString(j);
				map.put("日期", date);
				int k = i % 3; // k代表時段(早;中;晚)

				switch (k) {
				case 0: {
					map.put("時段", "9:00~12:00");
					break;
				}
				case 1: {
					map.put("時段", "13:00~16:00");
					break;
				}
				case 2: {
					map.put("時段", "17:00~20:00");
					break;
				}
				default:
					break;
				}
				
				String str = drava.substring(i, i + 1);
				if(str.equals("1")) {
					map.put("可否預約", "V");
				}else {
					map.put("可否預約", "X");
				}
				avaTime.add(map);

			}
		}

		return avaTime;
	}
// ------------------------------------------------------------------------------------------
// 只看這個月，沒設定就產生全部為0的字串
	public static List<Map> GetDravaThismonthByDrno(String drno) {  
		DravailableService ds = new DravailableService();
		DravailableVO dvo = ds.getDravaInThismonthByDrno(drno);
		if(dvo == null) {
			Date draym = new Date(new java.util.Date().getTime());
			String drava = GenerateDrava.set93Zero();
			ds.addDravailable(drno, draym, drava);
			dvo = ds.getDravaInThismonthByDrno(drno);
		}
				
		List<Map> avaTime = new ArrayList<Map>(); // 長度會是當月天數*3;裝的是map
			String dravano = dvo.getDravano();
			String drava = dvo.getDrava();
			Date draym = dvo.getDraym();
			String year = draym.toString().substring(0, 4);
			String month = draym.toString().substring(5, 7);
			// 這個月有幾天
			GregorianCalendar cal = new GregorianCalendar();
			cal.setTime(draym);
			int dayInthisMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			// 取得drava字串,用迴圈分析，每個0或1分析出來的結果用map裝，再把每個map裝進list
			for (int i = 0; i < dayInthisMonth * 3; i++) {
				Map<String, String> map = new Hashtable<String, String>();
				map.put("dravano", dravano);
				map.put("drno", drno);
				map.put("year", year);
				map.put("month", month);
				map.put("index", Integer.toString(i)); //之後做修改時用
	
				int j = i / 3 + 1; // j代表日期是幾號
				String date = Integer.toString(j);
				map.put("日期", date);
				int k = i % 3; // k代表時段(早;中;晚)

				switch (k) {
				case 0: {
					map.put("時段", "9:00~12:00");
					break;
				}
				case 1: {
					map.put("時段", "13:00~16:00");
					break;
				}
				case 2: {
					map.put("時段", "17:00~20:00");
					break;
				}
				default:
					break;
				}
				
				String str = drava.substring(i, i + 1);
				if(str.equals("1")) {
					map.put("可否預約", "V");
				}else {
					map.put("可否預約", "X");
				}
				avaTime.add(map);

			}

		return avaTime;
	}
//----------------------------------------------------------------------------------------
	// 只看下個月，沒設定就產生全部為0的字串
		public static List<Map> GetDravaNextmonthByDrno(String drno) {  
			DravailableService ds = new DravailableService();
			DravailableVO dvo = ds.getDravaNextmonthByDrno(drno);
			if(dvo == null) {
				Date draym = new Date(new java.util.Date().getTime());
				int nextMonthInt = draym.getMonth() + 1;
				if(nextMonthInt == 12) {
					nextMonthInt = 0;
				}
				Date nextMonth = new Date(draym.getYear(), nextMonthInt, 1);
				System.out.println(nextMonth);
				String drava = GenerateDrava.set93Zero();
				ds.addDravailable(drno, nextMonth, drava);
				dvo = ds.getDravaNextmonthByDrno(drno);
			}
					
			List<Map> avaTime = new ArrayList<Map>(); // 長度會是當月天數*3;裝的是map
				String dravano = dvo.getDravano();
				String drava = dvo.getDrava();
				Date draym = dvo.getDraym();
				String year = draym.toString().substring(0, 4);
				String month = draym.toString().substring(5, 7);
				// 這個月有幾天
				GregorianCalendar cal = new GregorianCalendar();
				cal.setTime(draym);
				int dayInthisMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				// 取得drava字串,用迴圈分析，每個0或1分析出來的結果用map裝，再把每個map裝進list
				for (int i = 0; i < dayInthisMonth * 3; i++) {
					Map<String, String> map = new Hashtable<String, String>();
					map.put("dravano", dravano);
					map.put("drno", drno);
					map.put("year", year);
					map.put("month", month);
					map.put("index", Integer.toString(i)); //之後做修改時用
		
					int j = i / 3 + 1; // j代表日期是幾號
					String date = Integer.toString(j);
					map.put("日期", date);
					int k = i % 3; // k代表時段(早;中;晚)

					switch (k) {
					case 0: {
						map.put("時段", "9:00~12:00");
						break;
					}
					case 1: {
						map.put("時段", "13:00~16:00");
						break;
					}
					case 2: {
						map.put("時段", "17:00~20:00");
						break;
					}
					default:
						break;
					}
					
					String str = drava.substring(i, i + 1);
					if(str.equals("1")) {
						map.put("可否預約", "V");
					}else {
						map.put("可否預約", "X");
					}
					avaTime.add(map);

				}

			return avaTime;
		}
}
