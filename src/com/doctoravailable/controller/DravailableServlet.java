package com.doctoravailable.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.doctoravailable.model.DravailableService;
import com.doctoravailable.model.DravailableVO;

public class DravailableServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action	=  req.getParameter("action");

		if ("getSameDravailable_By_Drno".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String drno = req.getParameter("drno");
				List<Map> avaTime = HandleDravailable.GetSameDravailable(drno);				
				req.setAttribute("avaTime", avaTime);
				RequestDispatcher successView = req.getRequestDispatcher("listSameDravailable.jsp");
				successView.forward(req, res);
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage()); 
				RequestDispatcher failureView = req.getRequestDispatcher("/doctoravailable/selectDoctorAvailable_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
//		表格版
		if ("getSameDrschedule_By_Drno".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String drno = req.getParameter("drno");
				List<Map> avaTime = HandleDravailable.GetSameDrschedule(drno);		
				req.setAttribute("avaTime", avaTime);
				RequestDispatcher successView = req.getRequestDispatcher("getSameDrschedule_By_Drno.jsp");
				successView.forward(req, res);
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage()); 
				RequestDispatcher failureView = req.getRequestDispatcher("/doctoravailable/selectDoctorAvailable_page.jsp");
				failureView.forward(req, res);
			}
		}		
//		月曆版
		if ("getSameDrschedule_By_Drno_B".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String drno = req.getParameter("drno");
				List<Map> avaTime = HandleDravailable.GetDravaThismonthByDrno(drno);		
				req.setAttribute("avaTime", avaTime);
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/doctoravailable/calendarMonthPrintView.jsp");
				successView.forward(req, res);
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage()); 
				RequestDispatcher failureView = req.getRequestDispatcher("/doctoravailable/selectDoctorAvailable_page.jsp");
				failureView.forward(req, res);
			}
		}
//		醫生或病患查看下個月
		if ("getSameDrschedule_By_Drno_Nextmonth".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
//			try {
				String drno = req.getParameter("drno");
				System.out.println(drno);
				List<Map> avaTime = HandleDravailable.GetDravaNextmonthByDrno(drno);		
				req.setAttribute("avaTime", avaTime);
				RequestDispatcher successView = req.getRequestDispatcher("/front-end/doctoravailable/calendarNextMonthPrintView.jsp");
				successView.forward(req, res);
//			} catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage()); 
//				RequestDispatcher failureView = req.getRequestDispatcher("/doctoravailable/selectDoctorAvailable_page.jsp");
//				failureView.forward(req, res);
//			}
		}

		
		
	
		
		
		
		
//=========================== addDravailable.jsp送出請求======================================	
		if ("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***********************1.接收請求參數 *************************/
				String drno = req.getParameter("drno");
				Date draym = Date.valueOf(req.getParameter("draym")); //新增或修改時會用sql指令把日期改成每月1號
				String ym = draym.toString().substring(0, 7);
				String drava = GenerateDrava.set93Zero();
				String thisDay = req.getParameter("draym").substring(8, 10);
				int thisDayIndex = Integer.parseInt(thisDay) * 3 - 3;
				System.out.println(thisDayIndex);
				//先判斷這個月分是否設定過  (取出之前設定的年月  判斷是不是一樣),是的話就insert否的話就update
				DravailableService ds = new DravailableService();
				List<DravailableVO> list = ds.getSameDravailable(drno);
				//如果draym一樣，代表之前設定過，取出原本的drava
				boolean insert = true;
				String dravano = "";
				for(DravailableVO dvo : list) {
					if(dvo.getDraym().toString().substring(0, 7).equals(ym)) {  
						drava = dvo.getDrava();
						dravano = dvo.getDravano();
						insert = false;
						break;
					}
				}
			
				//時段處理
				//方法1:
				StringBuffer dravaSB = new StringBuffer(drava);	
				
				String drava1 =req.getParameter("drava1");
				if(drava1 != null) {
					dravaSB.setCharAt(thisDayIndex, drava1.charAt(0));
				}
				String drava2 =req.getParameter("drava2");
				if(drava2 != null) {
					dravaSB.setCharAt(thisDayIndex + 1 , drava2.charAt(0));
				}
				String drava3 =req.getParameter("drava3");
				if(drava3 != null) {
					dravaSB.setCharAt(thisDayIndex + 2 , drava3.charAt(0));
				}
				drava = dravaSB.toString();
// 方法2:
//				char[] dravaChars = drava.toCharArray();
//				dravaChars[thisDayIndex] = drava1.charAt(0);
//				dravaChars[thisDayIndex + 1] = drava2.charAt(0);
//				dravaChars[thisDayIndex + 2] = drava3.charAt(0);
//				drava = String.valueOf(dravaChars);
				
// 方法3:用兩個substring 再用串接英雄append
				
//剩下執行sql set進資料庫
				DravailableVO dvo = new DravailableVO();
				dvo.setDrno(drno);
				dvo.setDraym(draym);
				dvo.setDrava(drava);
				/***************************2.開始新增資料***************************************/
				if(insert) {
					ds.addDravailable(drno, draym, drava);
				}else {
					ds.updateDravailable(dravano, drava);
				}
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				List<Map> avaTime = HandleDravailable.GetSameDravailable(drno);
				req.setAttribute("avaTime", avaTime);
				String url = "/doctoravailable/listSameDravailable.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage()); 
				RequestDispatcher failureView = req.getRequestDispatcher("/doctoravailable/addDravailable.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				String dravano = req.getParameter("dravano");
				int index = Integer.parseInt(req.getParameter("index"));
				String vx = req.getParameter("可否預約");
				DravailableService ds = new DravailableService();
				DravailableVO dvo = ds.getOneDravailable(dravano);
				String drava = dvo.getDrava();
				StringBuffer dravaSB = new StringBuffer(drava);
				System.out.println(index);
				System.out.println(vx);
				if(vx.equals("V")) {
					dravaSB.setCharAt(index, '0');
				}else {
					dravaSB.setCharAt(index, '1');
				}
				drava = dravaSB.toString();
				dvo.setDrava(drava);
				ds.updateDravailable(dravano, drava);
				String drno = dvo.getDrno();
				List<Map> avaTime = HandleDravailable.GetSameDrschedule(drno);
				req.setAttribute("avaTime", avaTime);
				String url = "getSameDrschedule_By_Drno.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				errorMsgs.add("修改資料失敗" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("getSameDrschedule_By_Drno.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("updateByAjax".equals(action)) {
			System.out.println(action);
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				res.setContentType("text/plain");
				res.setCharacterEncoding("UTF-8");
				PrintWriter out = res.getWriter();
				JSONObject obj = new JSONObject();
				
				
				String dravano = req.getParameter("dravano");
				System.out.println(dravano);
				int index = Integer.parseInt(req.getParameter("index"));
				System.out.println(index);
				String vx = req.getParameter("vx");
				System.out.println(vx);
				//判斷一下如果點擊的時間如果是當天的話，有沒有超過該時段開始的時間
				int clock = Integer.valueOf(req.getParameter("clock")); //點到的時段
				
				System.out.println("點到的時段clock = " + clock);
				
				
				
				
				//現在時間
				Calendar currentCal = Calendar.getInstance();
				int hour = currentCal.get(Calendar.HOUR_OF_DAY);
				int date = currentCal.get(Calendar.DAY_OF_MONTH)-1;
				String currentMonth = req.getParameter("currentMonth");
				System.out.println(date);
				System.out.println(hour);//早上九點是09
				System.out.println(currentMonth);
				if(index / 3 == date && hour >= clock && "yes".equals(currentMonth) ) {
					System.out.println("今天已過此時段");
					obj.put("notToday", true);
					out.print(obj);
					out.flush();
					out.close();
					return;
				}
				
				
				System.out.println("dravano = " + dravano);
				System.out.println("index = " + index);
				System.out.println("可否預約 = " + vx);
				DravailableService ds = new DravailableService();
				DravailableVO dvo = ds.getOneDravailable(dravano);
				String drava = dvo.getDrava();
				StringBuffer dravaSB = new StringBuffer(drava);
				if(vx.equals("V")) {
					dravaSB.setCharAt(index, '0');
					vx = "X";
				}else {
					dravaSB.setCharAt(index, '1');
					vx = "V";
				}
				drava = dravaSB.toString();
				dvo.setDrava(drava);
				dvo = ds.updateDravailable(dravano, drava);
				

				obj.put("vx", vx);
				out.print(obj);
				out.flush();
				out.close();
				
//				List<Map> list = new ArrayList<Map>();
//				Map<String, String> map = new HashMap<String, String>();
//				map.put("key", "1");
//				map.put("key", "2");
//				list.add(map);
//				
//				JSONArray arr = new JSONArray();
//				for(Map<String, String> m: list) {
//					JSONObject obj = new JSONObject();
//					for(String key: m.keySet()) {
//						obj.put(key, m.get(key));
//					}
//					arr.put(obj);
//				}
				
			}catch(Exception e) {
				errorMsgs.add("修改資料失敗" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("getSameDrschedule_By_Drno.jsp");
//				failureView.forward(req, res);
			}
			
		}
	}

}
