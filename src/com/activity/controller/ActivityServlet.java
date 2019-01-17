package com.activity.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.activity.model.ActivityService;
import com.activity.model.ActivityVO;
import com.impression.model.ImpressionService;
import com.impression.model.ImpressionVO;
import com.joinact.model.ChatRoomVO;
import com.joinact.model.JoinActService;
import com.joinact.model.JoinActVO;
import com.joinact.model.PersonActVO;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class ActivityServlet extends HttpServlet{
	
	public void doget(HttpServletRequest req, HttpServletResponse res) 
		throws ServletException ,IOException{
			doPost(req,res);
		}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) 
		throws ServletException ,IOException{
			
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
if ("getOne_For_Display".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 ****************************************/
				String actNo = new String(req.getParameter("actNo"));
				System.out.println(actNo);

				/*************************** 2.開始查詢資料****************************************/
				ActivityService activitySvc = new ActivityService();
				Set<ImpressionVO> set = activitySvc.getmembyactno(actNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("act_imp", set);    // 資料庫取出的impressionVO物件,存入req

				String url = null;
				if ("getOne_For_Display".equals(action))
					url = "/front-end/activity/act_imp.jsp";        // 成功轉交 act_imp.jsp
				
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}

		
if("Show_One".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/*****************1.接受請求參數-輸入格式錯誤處理*************/
				String actNo = req.getParameter("actNo");
				System.out.println(actNo);
				if(actNo==null||(actNo.trim()).length()==0) {
					errorMsgs.add("請輸入活動編號");
				}
				
				/***************************2.開始查詢資料*****************************************/
				ActivityService activitySvc = new ActivityService();
				ActivityVO activityVO = activitySvc.getOneAct(actNo);
				if (activityVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/activity/activitysearch.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("activityVO", activityVO); // 資料庫取出的impressionVO物件,存入req
				String url = "/front-end/activity/actone.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneImp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/activity/activitysearch.jsp");
				failureView.forward(req, res);
			}
		}
		
if ("getOne_For_Update".equals(action)) { // �來自actall.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				String actNo = req.getParameter("actNo");
				
				/***************************2.開始查詢資料****************************************/
				ActivityService activitySvc = new ActivityService();
				ActivityVO activityVO = activitySvc.getOneAct(actNo);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("activityVO", activityVO);         // 資料庫取出的activityVO物件,存入req
				String url = "/front-end/activity/update_act.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);//  成功轉交 update_act.jsp
				successView.forward(req, res);
		
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/activity/actall.jsp");
				failureView.forward(req, res);
			}
		}

if ("update".equals(action)) { //來自update_imp_input.jsp的請
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
//			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String actNo = req.getParameter("actNo").trim();			
				String memNo = req.getParameter("memNo").trim();

				String actName = req.getParameter("actName").trim();
					if (actName == null || actName.trim().length() == 0) {
						ActivityService actSvc = new ActivityService();
						actName = actSvc.getOneAct(actNo).getActName();
						errorMsgs.add("活動名稱請勿空白");
					}
				String actLoc = req.getParameter("actLoc").trim();				
					if (actLoc == null || actLoc.trim().length() == 0) {
						ActivityService actSvc = new ActivityService();
						actLoc = actSvc.getOneAct(actNo).getActLoc();
						errorMsgs.add("地點請勿空白");
					}
					java.sql.Date actTime = null;
					try {
						actTime = java.sql.Date.valueOf(req.getParameter("actTime").trim());
					} catch (IllegalArgumentException e) {
						ActivityService actSvc = new ActivityService();
						actTime = actSvc.getOneAct(actNo).getActTime();
						errorMsgs.add("請輸入日期!");
					}
				String actStatus = req.getParameter("actStatus").trim();				
				if (actStatus == null || actStatus.trim().length() == 0) {
					errorMsgs.add("活動狀態請勿空白");
				}	
				Integer actMax = null;				
				try {
					actMax = new Integer(req.getParameter("actMax").trim());
				} catch (NumberFormatException e) {
					ActivityService activitySvc = new ActivityService();
					actMax = activitySvc.getOneAct(actNo).getActMax();
					errorMsgs.add("人數上限格式錯誤");
				}
				Integer actLimit = null;				
				try {
					actLimit = new Integer(req.getParameter("actLimit").trim());
				} catch (NumberFormatException e) {
					ActivityService activitySvc = new ActivityService();
					actLimit = activitySvc.getOneAct(actNo).getActLimit();
					errorMsgs.add("人數下限格式錯誤");
				}
				Integer timeCheck = null;				
				try {
					timeCheck = new Integer(req.getParameter("timeCheck").trim());
				} catch (NumberFormatException e) {
					ActivityService activitySvc = new ActivityService();
					timeCheck = activitySvc.getOneAct(actNo).getTimeCheck();
					errorMsgs.add("確認時間格式錯誤");
				}
				String actDesc = req.getParameter("actDesc").trim();
				if(actDesc ==null || actDesc.trim().length()==0) {
					errorMsgs.add("活動敘述請勿空白");
				}
				
				byte[] actPic = null;
				Part part2 = req.getPart("actPic");
				if(part2.getSubmittedFileName() == (null)|| part2.getSubmittedFileName().trim().length() == 0) {
					ActivityService is2 = new ActivityService();
					actPic = is2.getOneAct(actNo).getActPic();
					System.out.println("123");
				}else {
					InputStream in2 = part2.getInputStream();
					actPic = toByteArray(in2);
					System.out.println("321");
				}				
				String latiTude = req.getParameter("latiTude").trim();
				String longtiTude = req.getParameter("longtiTude").trim();

				ActivityVO activityVO = new ActivityVO();
				activityVO.setActNo(actNo);
				activityVO.setMemNo(memNo);
				activityVO.setActName(actName);
				activityVO.setActLoc(actLoc);
				activityVO.setActTime(actTime);
				activityVO.setActStatus(actStatus);
				activityVO.setActMax(actMax);
				activityVO.setActLimit(actLimit);
				activityVO.setTimeCheck(timeCheck);
				activityVO.setActDesc(actDesc);
				activityVO.setActPic(actPic);
				activityVO.setLatiTude(latiTude);
				activityVO.setLongtiTude(longtiTude);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("activityVO", activityVO); // 資料庫取出的activityVO物件,存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/activity/update_act.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料�*****************************************/
				ActivityService activitySvc = new ActivityService();
				activityVO = activitySvc.updateAct(actNo, memNo, actName, actLoc, actTime, actStatus, actMax, actLimit, timeCheck,actDesc, actPic,latiTude,longtiTude);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("activityVO", activityVO); // 資料庫update成功後,正確的的impressionVO物件,存入req
				String url = "/front-end/activity/actone.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneImp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("修改資料失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front-end/activity/update_act.jsp");
//				failureView.forward(req, res);
//			}
		}
		
		
if ("insert".equals(action)) { // 來自addact.jsp的請求   
	
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
//			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				
				String memNo = req.getParameter("memNo").trim();
				System.out.println(memNo);
				if (memNo == null || memNo.trim().length() == 0) {
					errorMsgs.add("會員編號請勿空白");
				}
				String actName = req.getParameter("actName").trim();
				System.out.println(actName);
					if (actName == null || actName.trim().length() == 0) {
						errorMsgs.add("活動名稱請勿空白");
					}
				String actLoc = req.getParameter("actLoc").trim();
				System.out.println(actLoc);
					if (actLoc == null || actLoc.trim().length() == 0) {
						errorMsgs.add("地點請勿空白");
					}
					
				java.sql.Date actTime = null;
					try {
						actTime = java.sql.Date.valueOf(req.getParameter("actTime").trim());
						System.out.println(actTime);
					} catch (IllegalArgumentException e) {
						actTime = new java.sql.Date(System.currentTimeMillis());
						errorMsgs.add("請輸入日期!");
					}
				String actStatus = req.getParameter("actStatus").trim();				
						System.out.println(actStatus);
				Integer actMax = null;				
				try {
					actMax = new Integer(req.getParameter("actMax").trim());
					System.out.println(actMax);
					if (actMax == null || actMax == 0) {
						errorMsgs.add("人數上限不得為0");
					}
				} catch (NumberFormatException e) {
					actMax = 1;
					errorMsgs.add("人數上限格式錯誤");
				}
				Integer actLimit = null;				
				try {
					actLimit = new Integer(req.getParameter("actLimit").trim());
					System.out.println(actLimit);
					if (actLimit == null || actLimit == 0) {
						errorMsgs.add("人數下限不得為0");
					}
				} catch (NumberFormatException e) {		
					actLimit = 1;
					errorMsgs.add("人數下限格式錯誤");
				}
				Integer timeCheck = null;				
				try {
					timeCheck = new Integer(req.getParameter("timeCheck").trim());
					System.out.println(timeCheck);
					if (timeCheck == null || timeCheck == 0) {
						errorMsgs.add("時間設定不得為0");
					}
				} catch (NumberFormatException e) {
				
					timeCheck = 1;
					errorMsgs.add("確認時間格式錯誤");
				}
				String actDesc = req.getParameter("actDesc").trim();
				System.out.println(actDesc);
				byte[] actPic = null;
				Part part = req.getPart("actPic");
				InputStream in = part.getInputStream();
				actPic = toByteArray(in);
				System.out.println("321");
				
				String latiTude = req.getParameter("latiTude").trim();
				System.out.println(latiTude);
				String longtiTude = req.getParameter("longtiTude").trim();
				System.out.println(longtiTude);
				ActivityVO activityVO = new ActivityVO();
				activityVO.setMemNo(memNo);
				activityVO.setActName(actName);
				activityVO.setActLoc(actLoc);
				activityVO.setActTime(actTime);
				activityVO.setActStatus(actStatus);
				activityVO.setActMax(actMax);
				activityVO.setActLimit(actLimit);
				activityVO.setTimeCheck(timeCheck);
				activityVO.setActDesc(actDesc);
				activityVO.setActPic(actPic);
				activityVO.setLatiTude(latiTude);
				activityVO.setLongtiTude(longtiTude);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("activityVO", activityVO); // 資料庫取出的activityVO物件,存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/activity/addact.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ActivityService activitySvc = new ActivityService();
				activityVO = activitySvc.addAct(memNo, actName, actLoc, actTime, actStatus, actMax, actLimit, timeCheck,actDesc, actPic,latiTude,longtiTude);				
				List<ActivityVO> actlist = activitySvc.startact(actStatus);
				if (actlist == null) {
					errorMsgs.add("查無資料");
				}
				
				/***************************3..新增完成,準備轉交(Send the Success view)***********/
				req.setAttribute("actlist", actlist);
				String url = "/front-end/activity/join_actall2.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);			
				
				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e) {
//				errorMsgs.add(e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front-end/activity/addact.jsp");
//				failureView.forward(req, res);
//			}
		}

if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數***************************************/
				String actNo = new String(req.getParameter("actNo"));
				
				/***************************2.開始刪除資料***************************************/
				ActivityService activitySvc = new ActivityService();
				activitySvc.delete(actNo);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/activity/actall.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/activity/actall.jsp");
				failureView.forward(req, res);
			}
}

if("Show__join_act".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/*****************1.接受請求參數-輸入格式錯誤處理*************/
				String actNo = req.getParameter("actNo");
				if(actNo==null||(actNo.trim()).length()==0) {
					errorMsgs.add("請輸入活動編號");
				}
				String remaining = req.getParameter("remaining");
				System.out.println(remaining);
				/***************************2.開始查詢資料*****************************************/
				ActivityService activitySvc = new ActivityService();
				ActivityVO activityVO = activitySvc.getOneAct(actNo);
				if (activityVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/activity/joinactivity.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("activityVO", activityVO);
				req.setAttribute("remaining", remaining);
				String url = "/front-end/activity/joinpage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneImp.jsp
				successView.forward(req, res);
		
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/activity/joinactivity.jsp");
				failureView.forward(req, res);
			}
			
}
if ("Join_act".equals(action)) { 
	
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String actNo = req.getParameter("actNo").trim();
				System.out.println(actNo);
				String memNo = req.getParameter("memNo").trim();
				System.out.println(memNo);
				String actStatus = req.getParameter("actStatus").trim();
				System.out.println(actStatus);
				
				JoinActVO jvo = null;
				Set<PersonActVO> personactSet = null;
				List<ActivityVO> actlist = null;
				JoinActService joinSvc = new JoinActService();
				if (joinSvc.repeatact(actNo, memNo)==null) {
					jvo = joinSvc.addJoin(actNo, memNo);
					personactSet = joinSvc.getAll(memNo);
				}else {
					errorMsgs.add("已加入活動囉");
					ActivityService activitySvc = new ActivityService();
					actlist = activitySvc.startact(actStatus);
				}
				
				if (!errorMsgs.isEmpty()) {
					System.out.println("安安");
					req.setAttribute("actlist", actlist); // 資料庫取出的joinactVO物件,存入req
					RequestDispatcher failureView = req
					.getRequestDispatcher("/front-end/activity/join_actall2.jsp");
					failureView.forward(req, res);
					
					return; //程式中斷
				}
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("personactSet", personactSet);
				String url = "/front-end/activity/personact.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交personact.jsp
				successView.forward(req, res);
		
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				System.out.println("最下面");
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/activity/join_actall2.jsp");
				failureView.forward(req, res);
			}
}

if("Show_all".equals(action)) {
		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);
		
		try {
			/*****************1.接受請求參數-輸入格式錯誤處理*************/
			String actStatus = req.getParameter("actStatus");
			System.out.println(actStatus);

			/***************************2.開始查詢資料*****************************************/
			ActivityService activitySvc = new ActivityService();
			List<ActivityVO> actlist = activitySvc.startact(actStatus);
			if (actlist == null) {
				errorMsgs.add("查無資料");
			}
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/activity/joinactivity.jsp");
				failureView.forward(req, res);
				return;//程式中斷
			}
			
			/***************************3.查詢完成,準備轉交(Send the Success view)*************/
			req.setAttribute("actlist", actlist); // 資料庫取出的impressionVO物件,存入req
			String url = "/front-end/activity/join_actall2.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneImp.jsp
			successView.forward(req, res);
			
			/***************************其他可能的錯誤處理*************************************/
		} catch (Exception e) {
			errorMsgs.add("無法取得資料:" + e.getMessage());
			RequestDispatcher failureView = req
					.getRequestDispatcher("/front-end/activity/joinactivity.jsp");
			failureView.forward(req, res);
		}
	}

if ("actall_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求
	
	List<String> errorMsgs = new LinkedList<String>();
	// Store this set in the request scope, in case we need to
	// send the ErrorPage view.
	req.setAttribute("errorMsgs", errorMsgs);

	try {
		
		/***************************1.將輸入資料轉為Map**********************************/ 
		//採用Map<String,String[]> getParameterMap()的方法 
		//注意:an immutable java.util.Map 
		//Map<String, String[]> map = req.getParameterMap();
		HttpSession session = req.getSession();
		Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");//空值
		if (req.getParameter("whichPage") == null){
			HashMap<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
			session.setAttribute("map",map1);
			map = map1;
		} 
		
		/***************************2.開始複合查詢***************************************/
		ActivityService actSvc = new ActivityService();
		List<ActivityVO> list  = actSvc.getactall(map);
		
		/***************************3.查詢完成,準備轉交(Send the Success view)************/
		req.setAttribute("actall_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
		RequestDispatcher successView = req.getRequestDispatcher("/front-end/activity/actall_ByCompositeQuery.jsp"); // 成功轉交actall_ByCompositeQuery.jsp
		successView.forward(req, res);
		
		/***************************其他可能的錯誤處理**********************************/
	} catch (Exception e) {
		errorMsgs.add(e.getMessage());
		RequestDispatcher failureView = req
				.getRequestDispatcher("/front-end/activity/joinactivity.jsp");
		failureView.forward(req, res);
	}
		
		
}

	if("chat_room".equals(action)) {
		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);	
		try {
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			String actNo = req.getParameter("actNo").trim();
			System.out.println(actNo);
			String memNo = req.getParameter("memNo").trim();
			System.out.println(memNo);
			
			/***************************2.查詢資料**********************/
			JoinActService joinactSvc = new JoinActService();
			List<ChatRoomVO> listchat = joinactSvc.getchatmember(actNo);
			ActivityService activitySvc = new ActivityService();
			ActivityVO activityVO = activitySvc.getOneAct(actNo);
			/***************************3.查詢完成,準備轉交(Send the Success view)************/
			req.setAttribute("listchat", listchat);
			req.setAttribute("activityVO", activityVO);
			
			RequestDispatcher successView = req.getRequestDispatcher("/front-end/activity/chat_room.jsp");
			successView.forward(req, res);
		}catch (Exception e) {
			errorMsgs.add(e.getMessage());
			RequestDispatcher failureView = req
					.getRequestDispatcher("/front-end/activity/personact.jsp");
			failureView.forward(req, res);
		}
}	
}	
	public static byte[] toByteArray(InputStream input) throws IOException {
	    ByteArrayOutputStream output = new ByteArrayOutputStream();
	    byte[] buffer = new byte[4096];
	    int n = 0;
	    while (-1 != (n = input.read(buffer))) {
	        output.write(buffer, 0, n);
	    }
	    return output.toByteArray();
	}
}
