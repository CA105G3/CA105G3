package com.medicalorder.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.print.attribute.standard.RequestingUserName;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.doctor.model.DoctorService;
import com.doctor.model.DoctorVO;
import com.doctoravailable.controller.HandleDravailable;
import com.medicalorder.model.MedicalOrderDAO;
import com.medicalorder.model.MedicalOrderService;
import com.medicalorder.model.MedicalOrderVO;
import com.member.model.*;


@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class MedicalOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);	
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		//測試存Session
		HttpSession session = req.getSession();
		
		//從ScanDoctor查詢醫生資料去displayDrInfo.jsp
		if("findDr".equals(action)) {
			String drno = req.getParameter("drno");

			DoctorService drsvc = new DoctorService();
			DoctorVO drVO = drsvc.getOneDoctor(drno);
			req.setAttribute("dvo", drVO);
			
			
			//設定請求參數給include哪一支jsp判斷
			String month = "thismonth";
			req.setAttribute("month", month);
			
			RequestDispatcher successView = req.getRequestDispatcher("displayDrInfo.jsp");
			successView.forward(req, res);
			
		}
		
		
		//病患查看醫生當月可預約時間（月曆版）
		if ("calendarMonthThisView".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String drno = req.getParameter("drno");
				List<Map> avaTime = HandleDravailable.GetDravaThismonthByDrno(drno);				
				req.setAttribute("avaTime", avaTime);
				
				String month = "thismonth";
				req.setAttribute("month", month);
				
				RequestDispatcher successView = req.getRequestDispatcher("displayDrInfo.jsp");
				successView.forward(req, res);
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage()); 
				RequestDispatcher failureView = req.getRequestDispatcher("/doctoravailable/selectDoctorAvailable_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		//病患查看醫生下個月可預約時間（月曆版）	
		if ("calendarMonthNextView".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
		
//			try {
				String drno = req.getParameter("drno");
				DoctorService drsvc = new DoctorService();
				DoctorVO drVO = drsvc.getOneDoctor(drno);
				req.setAttribute("dvo", drVO);
				
				List<Map> avaTime = HandleDravailable.GetDravaNextmonthByDrno(drno);		
				req.setAttribute("avaTime", avaTime);
				
				String month = "nextmonth";
				req.setAttribute("month", month);
				
				RequestDispatcher successView = req.getRequestDispatcher("displayDrInfo.jsp");
				successView.forward(req, res);
//			} catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage()); 
//				RequestDispatcher failureView = req.getRequestDispatcher("/doctoravailable/selectDoctorAvailable_page.jsp");
//				failureView.forward(req, res);
//			}
		}
		
		
		//病患查看醫生月曆版回到上個月可預約時間
		if ("getSameDrschedule_By_Drno_Back".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
//			try {
				String drno = req.getParameter("drno");
				DoctorService drsvc = new DoctorService();
				DoctorVO drVO = drsvc.getOneDoctor(drno);
				req.setAttribute("dvo", drVO);
				
				List<Map> avaTime = HandleDravailable.GetDravaThismonthByDrno(drno);		
				req.setAttribute("avaTime", avaTime);
					
				String month = "thismonth";
				req.setAttribute("month", month);
				
				RequestDispatcher successView = req.getRequestDispatcher("displayDrInfo.jsp");
				successView.forward(req, res);
//			} catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage()); 
//				RequestDispatcher failureView = req.getRequestDispatcher("/doctoravailable/selectDoctorAvailable_page.jsp");
//				failureView.forward(req, res);
//			}
		}
		
		
		
		//從getMedicalOrderFromMember.jsp取消預約
		if("cancelMO".equals(action)) {

		//接收請求參數
		String moCancelReason = req.getParameter("moCancelReason");
		String moNo = req.getParameter("moNo");
		
		//永續層存取
		MedicalOrderService medicalOrderService = new MedicalOrderService();
		medicalOrderService.cancelMedicalOrder(moNo, moCancelReason);
			
		//修改成功回原本頁面
		String url = "/front-end/medicalOrder/getMedicalOrderFromMember.jsp";
		RequestDispatcher successData = req.getRequestDispatcher(url);
		successData.forward(req, res);
		
		}
		
		//從checkReserve.jsp新增一筆預約訂單資料
		if("insertMo".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				//接收請求參數
				MemberVO memberVO = (MemberVO)session.getAttribute("memberVO");
				String memNo = memberVO.getMemNo();		
				String drNo = req.getParameter("drno");
				String moStatus = "等待問診";
				Integer moCost = new Integer(req.getParameter("fee"));
				
				String year = req.getParameter("year");
				String month = req.getParameter("month");
				String date = req.getParameter("date");
			
			
				java.sql.Date moTime = java.sql.Date.valueOf(year+ "-" + month + "-" +date); 
				
				String hour = req.getParameter("hour");
				Integer moHour = null;
					switch(hour) {
					case "9:00~12:00":
						moHour = 9;
						break;
					case "13:00~16:00":
						moHour = 13;
						break;
					case "17:00~20:00":
						moHour = 17;
						break;
					}
				
				String moIntro = req.getParameter("moIntro");
				String moCancelReason = null;
				byte[] moVideo = null;
				String moText = null;
				
				MedicalOrderVO medicalOrderVO = new MedicalOrderVO();
				medicalOrderVO.setMemNo(memNo);
				medicalOrderVO.setDrNo(drNo);
				medicalOrderVO.setMoStatus(moStatus);
				medicalOrderVO.setMoCost(moCost);
				medicalOrderVO.setMoTime(moTime);
				medicalOrderVO.setMoHour(moHour);
				medicalOrderVO.setMoIntro(moIntro);
				medicalOrderVO.setMoCancelReason(moCancelReason);
				medicalOrderVO.setMoVideo(moVideo);
				medicalOrderVO.setMoText(moText);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("medicalOrderVO", medicalOrderVO);
					RequestDispatcher failureData = req
							.getRequestDispatcher("/front-end/medicalOrder/addMedicalOrder.jsp");
					failureData.forward(req, res);
					return;
			}
			/*************************** 2.開始新增資料 ***************************************/
			MedicalOrderService MedicalOrderSvc = new MedicalOrderService();
			medicalOrderVO = MedicalOrderSvc.addMedicalOrder(memNo, drNo, moStatus, moCost, moTime, moHour, moIntro,
					moCancelReason , moVideo ,moText);
			/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
			req.setAttribute("medicalOrderVO", medicalOrderVO);
			String url = "/front-end/medicalOrder/getMedicalOrderFromMember.jsp";
			RequestDispatcher successData = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
			successData.forward(req, res);
			/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureData = req.getRequestDispatcher("/front-end/medicalOrder/checkReserve.jsp");
				failureData.forward(req, res);
			}
			
		}
		
		//從月曆版行事曆存資料轉到basicRecord.jsp
		if("reserve2".equals(action)){	
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
			//接收請求參數，裝入HashMap備用
			String drno = req.getParameter("drno");
			String year = req.getParameter("year");
			String month = req.getParameter("month");
			String date = req.getParameter("date");
			String hour = req.getParameter("hour");

			HashMap reserveMap = new HashMap();
			reserveMap.put("drno", drno);
			reserveMap.put("year", year);
			reserveMap.put("month", month);
			reserveMap.put("date", date);
			reserveMap.put("hour", hour);
			
			//將HashMap存到session
			session.setAttribute("reserveMap", reserveMap);
			
			String url = "/front-end/medicalOrder/basicRecord.jsp";
			RequestDispatcher successData = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
			successData.forward(req, res);
			
			/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureData = req.getRequestDispatcher("/front-end/medicalOrder/basicRecord.jsp");
				failureData.forward(req, res);
			}		
		}			
		
		
		
		//從listAllDrAvailable.jsp存資料轉到basicRecord.jsp
		if("reserve".equals(action)){	
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
			//接收請求參數，裝入HashMap備用
			String drno = req.getParameter("drno");
			String year = req.getParameter("year");
			String month = req.getParameter("month");
			String date = req.getParameter("date");
			String hour = req.getParameter("hour");

			HashMap reserveMap = new HashMap();
			reserveMap.put("drno", drno);
			reserveMap.put("year", year);
			reserveMap.put("month", month);
			reserveMap.put("date", date);
			reserveMap.put("hour", hour);
			
			//將HashMap存到session
			session.setAttribute("reserveMap", reserveMap);
			
			String url = "/front-end/medicalOrder/basicRecord.jsp";
			RequestDispatcher successData = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
			successData.forward(req, res);
			
			/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureData = req.getRequestDispatcher("/front-end/medicalOrder/basicRecord.jsp");
				failureData.forward(req, res);
			}		
		}			
		
		//從basicRecord.jsp修改資料，然後轉交到checkReserve.jsp
		if("updateBasicRecord".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/			

//			String memId = req.getParameter("memId");	//整合版
//			String memId = "David";	//測試版
			MemberVO memberVO = (MemberVO)session.getAttribute("memberVO");
			String memId = memberVO.getMemId();		
			
			String bloodType = req.getParameter("bloodType");
			if(bloodType == null) {
				errorMsgs.add("請選擇血型");
			}
			 
			String smoking = req.getParameter("smoking");
			if(smoking == null) {
				errorMsgs.add("請選擇是否抽菸");
			}
			
			String allergy = req.getParameter("allergy");
			if (allergy == null || allergy.trim().length() == 0) {
				errorMsgs.add("請填寫是否有藥物過敏，若無請填寫「無」");
			}
			
			String medHistory = req.getParameter("medHistory");
			if (allergy == null || allergy.trim().length() == 0) {
				errorMsgs.add("請填寫是否有過往病史，若無請填寫「無」");
			}
			
			String famHistory = req.getParameter("famHistory");
			if (allergy == null || allergy.trim().length() == 0) {
				errorMsgs.add("請填寫是否有家族病史，若無請填寫「無」");
			}
			
			memberVO.setBloodType(bloodType);
			memberVO.setSmoking(smoking);
			memberVO.setAllergy(allergy);
			memberVO.setMedHistory(medHistory);
			memberVO.setFamHistory(famHistory);
			memberVO.setMemId(memId);
			
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("memberVO", memberVO);
				RequestDispatcher failureData = req
						.getRequestDispatcher("/front-end/medicalOrder/basicRecord.jsp");
				failureData.forward(req, res);
				return;
			}
			/*************************** 2.開始新增資料 ***************************************/
			MemberService memSvc = new MemberService();
			memberVO = memSvc.UpdateForBasicRecord(memId, bloodType, smoking, allergy, medHistory, famHistory);
			/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
			req.setAttribute("memberVO", memberVO);
			String url = "/front-end/medicalOrder/checkReserve.jsp";
			RequestDispatcher successData = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
			successData.forward(req, res);
			/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureData = req.getRequestDispatcher("/front-end/medicalOrder/basicRecord.jsp");
				failureData.forward(req, res);
			}		
		}
		

//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑以上為會用到的↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑//		
		
//		// 新增一筆資料
//		if ("insert".equals(action)) {
//
//			List<String> errorMsgs = new LinkedList<String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//			try {
//				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
//				// 會員編號
//				String memNo = req.getParameter("memNo");
//				String memNoReq = "^[(M)(0-9)] {5}$";
//				if (memNo == null || memNo.trim().length() == 0) {
//					errorMsgs.add("會員編號請勿空白");
//				}
////				else if(!memNo.trim().matches(memNoReq)) {
////					errorMsgs.add("會員編號請輸入大寫M開頭再加4個數字");
////				}
//				// 醫療人員編號
//				String drNo = req.getParameter("drNo");
//				String drNoReq = "^[(D)(0-9)] {5}$";
//				if (memNo == null || memNo.trim().length() == 0) {
//					errorMsgs.add("醫療人員編號請勿空白");
//				}
////				else if(!memNo.trim().matches(memNoReq)) {
////					errorMsgs.add("醫療人員編號請輸入大寫D開頭再加4個數字");
////				}
//				// 診療狀態
//				String moStatus = req.getParameter("moStatus");
//
//				// 診療費用
//				Integer moCost = null;
//				try {
//					moCost = new Integer(req.getParameter("moCost").trim());
//				} catch (NumberFormatException e) {
//					moCost = 0;
//					errorMsgs.add("診療費用請填數字");
//				}
//
//				// 約診時間
//				java.sql.Date moTime = null;
//				try {
//					moTime = java.sql.Date.valueOf(req.getParameter("moTime").trim());
//				} catch (Exception e) {
//					moTime = new java.sql.Date(System.currentTimeMillis());
//					errorMsgs.add("請輸入約診日期");
//				}
//
//				// 病況說明
//				String moIntro = req.getParameter("moIntro").trim();
//				if (moIntro == null || moIntro.trim().length() == 0) {
//					errorMsgs.add("病況說明請勿空白");
//				}
//
//				//取消理由
//				String moCancelReason = req.getParameter("moCancelReason");
//				
//				// 問診影音紀錄
//				
//				byte[] moVideo = null;
//				
//				Part part = req.getPart("moVideo");
//				if(part.getSubmittedFileName().equals("")||part.getSubmittedFileName().trim().length()==0) {
//					errorMsgs.add("請上傳圖片");
//					moVideo = null;
//				}else {
//					InputStream in = part.getInputStream();
//					moVideo = new byte[in.available()];
//					in.read(moVideo);
//					in.close();
//				}
//					
//				// 問診文字紀錄
//				String moText = req.getParameter("moText").trim();
//				if (moText == null || moText.trim().length() == 0) {
//					errorMsgs.add("問診文字紀錄請勿空白");
//				}
//
//				MedicalOrderVO medicalOrderVO = new MedicalOrderVO();
//				medicalOrderVO.setMemNo(memNo);
//				medicalOrderVO.setDrNo(drNo);
//				medicalOrderVO.setMoStatus(moStatus);
//				medicalOrderVO.setMoCost(moCost);
//				medicalOrderVO.setMoTime(moTime);
//				medicalOrderVO.setMoVideo(moVideo);
//				medicalOrderVO.setMoCancelReason(moCancelReason);
//				medicalOrderVO.setMoIntro(moIntro);
//				medicalOrderVO.setMoText(moText);
//
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("medicalOrderVO", medicalOrderVO);
//					RequestDispatcher failureData = req
//							.getRequestDispatcher("/front-end/medicalOrder/addMedicalOrder.jsp");
//					failureData.forward(req, res);
//					return;
//				}
//				/*************************** 2.開始新增資料 ***************************************/
//				MedicalOrderService MedicalOrderSvc = new MedicalOrderService();
//				medicalOrderVO = MedicalOrderSvc.addMedicalOrder(memNo, drNo, moStatus, moCost, moTime, moIntro,
//						moCancelReason , moVideo ,moText);
//				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
//				req.setAttribute("medicalOrderVO", medicalOrderVO);
//				String url = "/front-end/medicalOrder/listAllMedicalOrder.jsp";
//				RequestDispatcher successData = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
//				successData.forward(req, res);
//				/*************************** 其他可能的錯誤處理 **********************************/
//			} catch (Exception e) {
//				errorMsgs.add(e.getMessage());
//				RequestDispatcher failureData = req.getRequestDispatcher("/front-end/medicalOrder/addMedicalOrder.jsp");
//				failureData.forward(req, res);
//			}
//		}

		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
System.out.println("333333333333333333333333");
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("moNo");

//				if (str == null || (str.trim()).length() == 0) {
//					errorMsgs.add("請輸入員工編號");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("front-end/medicalOrder/select_page.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}

				/*************************** 2.開始查詢資料 *****************************************/
				MedicalOrderService moSvc = new MedicalOrderService();
				MedicalOrderVO medicalOrderVO = moSvc.getOneMedicalOrder(str);

				if (medicalOrderVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("front-end/medicalOrder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("medicalOrderVO", medicalOrderVO); // 資料庫取出的empVO物件,存入req

				String url = "/front-end/medicalOrder/listOneMedicalOrder.jsp";

				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("front-end/medicalOrder/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String moNo = req.getParameter("moNo");

				/*************************** 2.開始查詢資料 ****************************************/
				MedicalOrderService moSvc = new MedicalOrderService();
				MedicalOrderVO medicalOrderVO = moSvc.getOneMedicalOrder(moNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("medicalOrderVO", medicalOrderVO); // 資料庫取出的empVO物件,存入req
				String url = "/front-end/medicalOrder/update_medicalOrder_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/medicalOrder/listAllMedicalOrder.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String moNo = req.getParameter("moNo");

				// 會員編號
				String memNo = req.getParameter("memNo");
				String memNoReq = "^[(M)(0-9)] {5}$";
				if (memNo == null || memNo.trim().length() == 0) {
					errorMsgs.add("會員編號請勿空白");
				}
				// else if(!memNo.trim().matches(memNoReq)) {
				// errorMsgs.add("會員編號請輸入大寫M開頭再加4個數字");
				// }
				// 醫療人員編號
				String drNo = req.getParameter("drNo");
				String drNoReq = "^[(D)(0-9)] {5}$";
				if (memNo == null || memNo.trim().length() == 0) {
					errorMsgs.add("醫療人員編號請勿空白");
				}
				// else if(!memNo.trim().matches(memNoReq)) {
				// errorMsgs.add("醫療人員編號請輸入大寫D開頭再加4個數字");
				// }
				// 診療狀態
				String moStatus = req.getParameter("moStatus");

				// 診療費用
				Integer moCost = null;
				try {
					moCost = new Integer(req.getParameter("moCost").trim());
				} catch (NumberFormatException e) {
					moCost = 0;
					errorMsgs.add("診療費用請填數字");
				}

				// 約診時間
				java.sql.Date moTime = null;
				try {
					moTime = java.sql.Date.valueOf(req.getParameter("moTime").trim());
				} catch (Exception e) {
					moTime = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入約診日期");
				}

				// 病況說明
				String moIntro = req.getParameter("moIntro").trim();
				if (moIntro == null || moIntro.trim().length() == 0) {
					errorMsgs.add("病況說明請勿空白");
				}

				// 取消原因
				String moCancelReason = req.getParameter("moCancelReason");
				
				// 問診影音紀錄
				// Part moVideo = req.getPart("moVideo");
				// if(moVideo.getSubmittedFileName().equals(null)||moVideo.getSubmittedFileName().trim().length()==0)
				// errorMsgs.add("請上傳PPT");
				// InputStream fileContent = moVideo.getInputStream();
				// byte[] moVideoUp=readFully(fileContent);

				// 問診文字紀錄
				String moText = req.getParameter("moText").trim();
				if (moText == null || moText.trim().length() == 0) {
					errorMsgs.add("問診文字紀錄請勿空白");
				}

				MedicalOrderVO medicalOrderVO = new MedicalOrderVO();
				medicalOrderVO.setMoNo(moNo);
				medicalOrderVO.setMemNo(memNo);
				medicalOrderVO.setDrNo(drNo);
				medicalOrderVO.setMoStatus(moStatus);
				medicalOrderVO.setMoCost(moCost);
				medicalOrderVO.setMoTime(moTime);
				medicalOrderVO.setMoVideo(null);
				medicalOrderVO.setMoIntro(moIntro);
				medicalOrderVO.setMoText(moText);
				medicalOrderVO.setMoCancelReason(moCancelReason);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("medicalOrderVO", medicalOrderVO);
					RequestDispatcher failureData = req
							.getRequestDispatcher("/front-end/medicalOrder/update_medicalOrder_input.jsp");
					failureData.forward(req, res);
					return;
				}
				/*************************** 2.開始修改資料 ***************************************/
				MedicalOrderService MedicalOrderSvc = new MedicalOrderService();
				medicalOrderVO = MedicalOrderSvc.updateMedicalOrder(moNo, memNo, drNo, moStatus, moCost, moTime, moIntro, moCancelReason, null, moText);

				/*************************** 3.修改完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("medicalOrderVO", medicalOrderVO);
				String url = "/front-end/medicalOrder/listAllMedicalOrder.jsp";
				RequestDispatcher successData = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successData.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureData = req.getRequestDispatcher("/front-end/medicalOrder/update_medicalOrder_input.jsp");
				failureData.forward(req, res);
			}

		}
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				String moNo = req.getParameter("moNo");
			
				/***************************2.開始刪除資料***************************************/
				MedicalOrderService moSvc = new MedicalOrderService();
				moSvc.deleteMedicalOrder(moNo);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/medicalOrder/listAllMedicalOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/medicalOrder/listAllMedicalOrder.jsp");
				failureView.forward(req, res);
			}
		}

	}

	public static byte[] readFully(InputStream input) throws IOException {
		byte[] buffer = new byte[8192];
		int bytesRead;
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		while ((bytesRead = input.read(buffer)) != -1) {
			output.write(buffer, 0, bytesRead);
		}
		return output.toByteArray();
	}

}
