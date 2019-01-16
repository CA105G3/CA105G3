package com.member.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.doctor.model.DoctorService;
import com.license.model.LicenseVO;
import com.member.model.MemberService;
import com.member.model.MemberVO;
import com.tools.transImage.TranslateImage;



/**
 * Servlet implementation class MemberServlet1
 */
@MultipartConfig
public class MemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("memno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入會員編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/member/index.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				String memno = null;
				try {
					memno = new String(str);
				} catch (Exception e) {
					errorMsgs.add("會員編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/member/index.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				MemberService memSvc = new MemberService();
				MemberVO memVO = memSvc.getOneMember(memno);
				if (memVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/member/index.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("memVO", memVO); // 資料庫取出的empVO物件,存入req
				String url = "/front-end/member/showonemember.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/index.jsp");
				failureView.forward(req, res);
			}
		}//End-point getOne_For_Display	
		

		if("delete".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String memno = new String(req.getParameter("memno"));
				
				MemberService memSvc = new MemberService();
				memSvc.deleteMember(memno);
				
				String url="/front-end/member/ListAllMember.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
			}catch(Exception e) {
				errorMsgs.add("刪除資料失敗"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/member/ListAllMember.jsp");
				failureView.forward(req, res);
			}
		}//End-point delete
		
		if ("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			MemberService memSvc_checkid= new MemberService();
			try {
				//ID:
				String memid=req.getParameter("memid");
				String memidReg = "^[(a-zA-Z0-9)]{1,20}$";
				if (memid == null || memid.trim().length() == 0) {
					errorMsgs.add("會員帳號: 請勿空白");
				} else if(!memid.trim().matches(memidReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員帳號: 只能是英文字母、數字 , 且長度必需為20內");
	            }
				List<MemberVO> check_list = memSvc_checkid.getAll();
				for(MemberVO memVO : check_list) {
					if(memid.equals(memVO.getMemName())) {
						errorMsgs.add("會員帳號已重複");
					}
				}
				//PWD:
				String mempsw =req.getParameter("mempsw");
				String mempswReg = "^[(a-zA-Z0-9)]{1,20}$";
				if (mempsw == null || mempsw.trim().length() == 0) {
					errorMsgs.add("會員密碼: 請勿空白");
				} else if(!mempsw.trim().matches(mempswReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員密碼: 只能是英文字母、數字 , 且長度必需為20內");
	            }
				//NAME
				String memname =req.getParameter("memname");
				String memnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9)]{1,20}$";
				if (memname == null || memname.trim().length() == 0) {
					errorMsgs.add("會員姓名: 請勿空白");
				} else if(!memname.trim().matches(memnameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員名稱: 只能是中文(6個字內)、英文字母、數字 , 且長度必需為20內");
	            }
				//Gender
				String gender=req.getParameter("gender");
				//Birth
				java.sql.Date birth=null;
				try {
					birth = java.sql.Date.valueOf(req.getParameter("birth").trim());
				} catch (IllegalArgumentException e) {
					birth=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入生日日期!");
				}
				//BloodType
				String bloodtype=req.getParameter("bloodtype");
				//E-mail
				String email=req.getParameter("email");
				String emailReg="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,50}$";
				if (email == null || email.trim().length() == 0) {
					errorMsgs.add("會員信箱: 請勿空白");
				} else if(!email.trim().matches(emailReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員信箱: 只能是英文字母、數字 , 且長度必需為50內");
	            }
				//Phone
				String phone=req.getParameter("phone");
				String phoneReg="^[(0-9)]{1,20}$";
				if (phone == null || phone.trim().length() == 0) {
					errorMsgs.add("會員電話: 請勿空白");
				} else if(!phone.trim().matches(phoneReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員電話: 只能是數字 , 且長度必需為20內");
	            }
				//LocNo
				Integer locno=null;
				String getlocno=req.getParameter("zipcode");
				String locnoReg="^[(0-9)]{1,5}$";
				if (getlocno == null || getlocno.trim().length() == 0) {
					errorMsgs.add("會員郵遞區號: 請勿空白");
				} else if(!getlocno.trim().matches(locnoReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員郵遞區號: 只能是數字 , 且長度必需為5內");
	            }
				locno=Integer.valueOf(getlocno);
				
				String county=req.getParameter("county");
				if (county == null || county.trim().length() == 0) {
					errorMsgs.add("城市: 請選擇城市");
				}
				
				String district=req.getParameter("district");
				if (district == null || district.trim().length() == 0) {
					errorMsgs.add("地區: 請選擇地區");
				}
				
				//地址
				String addr=req.getParameter("addr");
				String addrReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9)]{1,60}$";
				if (addr == null || addr.trim().length() == 0) {
					errorMsgs.add("地址: 請勿空白");
				} else if(!addr.trim().matches(addrReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("地址 只能是中文(20個字內)、英文字母、數字 , 且長度必需為60內");
	            }
				
				addr=county+district+addr;
				System.out.println(addr);
				
				//過去病史
				String medhistory=req.getParameter("medhistory");
				String medhistoryReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9)]{1,600}$";
				if (medhistory == null || medhistory.trim().length() == 0) {
					errorMsgs.add("過去病史: 請勿空白");
				} else if(!medhistory.trim().matches(medhistoryReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("過去病史: 只能是中文(200個字內)、英文字母、數字 , 且長度必需為600內");
	            }
				//家族病史
				String famhistory=req.getParameter("famhistory");
				String famhistoryReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9)]{1,600}$";
				if (famhistory == null || famhistory.trim().length() == 0) {
					errorMsgs.add("家族病史: 請勿空白");
				} else if(!famhistory.trim().matches(famhistoryReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("家族病史: 只能是中文(200個字內)、英文字母、數字 , 且長度必需為600內");
	            }
				//過敏記錄
				String allergy=req.getParameter("allergy");
				String allergyReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9)]{1,600}$";
				if (allergy == null || allergy.trim().length() == 0) {
					errorMsgs.add("過敏記錄: 請勿空白");
				} else if(!allergy.trim().matches(allergyReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("過敏記錄: 只能是中文(200個字內)、英文字母、數字 , 且長度必需為600內");
	            }
				//抽菸
				String smoking =req.getParameter("smoking");
				//會員狀態
				String memStatus=req.getParameter("memStatus");
				//會員身分
				String ident=req.getParameter("ident");
				//註冊日期
				java.sql.Date regdate = null;
				try {
					regdate = java.sql.Date.valueOf(req.getParameter("regdate").trim());
				} catch (IllegalArgumentException e) {
					regdate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入註冊日期!");
				}
				//最後登入時間
				java.sql.Timestamp stayTime=null;
				try {
					stayTime=java.sql.Timestamp.valueOf(req.getParameter("staytime").trim());
				} catch (IllegalArgumentException e) {
					stayTime=new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入登入日期!");
				}
				MemberVO memVO=new MemberVO();
				memVO.setAddr(addr);
				memVO.setAllergy(allergy);
				memVO.setBirth(birth);
				memVO.setBloodType(bloodtype);
				memVO.setEmail(email);
				memVO.setFamHistory(famhistory);
				memVO.setGender(gender);
				memVO.setIdent(ident);
				memVO.setLocNo(locno);
				memVO.setMedHistory(medhistory);
				memVO.setMemId(memid);
				memVO.setMemName(memname);
				memVO.setMemStatus(memStatus);
				memVO.setPhone(phone);
				memVO.setPwd(mempsw);
				memVO.setRegDate(regdate);
				memVO.setSmoking(smoking);
				memVO.setStayTime(stayTime);
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memVO",memVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/index.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始新增資料***************************************/
				MemberService memSvc = new MemberService();
				memVO = memSvc.addMember(memid, memname, mempsw, email, gender, birth, addr, allergy, bloodtype, phone, famhistory, ident, medhistory, memStatus, smoking, locno, regdate, stayTime);
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				
				String url = "/front-end/index.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			}catch(Exception e) {
				errorMsgs.add("新增資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/index.jsp");
				failureView.forward(req, res);
			}
		}// inset end
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			String memno;
			try {
				/***************************1.接收請求參數****************************************/
				
				if(req.getParameter("memno").equals(null)) {
					memno = (String)(req.getSession().getAttribute("memno"));
				}else {
					memno = new String(req.getParameter("memno"));
				}
				/***************************2.開始查詢資料****************************************/
				MemberService memSvc = new MemberService();
				MemberVO memVO  = memSvc.getOneMember(memno);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("memVO", memVO);         // 資料庫取出的empVO物件,存入req
				String url = "/front-end/member/updatemydata.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/member/showonemember.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				//number
				String memNo=req.getParameter("memno");
				//ID:
				String memid=req.getParameter("memid");
				String memidReg = "^[(a-zA-Z0-9)]{1,20}$";
				if (memid == null || memid.trim().length() == 0) {
					errorMsgs.add("會員帳號: 請勿空白");
				} else if(!memid.trim().matches(memidReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員帳號: 只能是英文字母、數字 , 且長度必需為20內");
	            }
				//PWD:
				String mempsw =req.getParameter("mempsw");
				String mempswReg = "^[(a-zA-Z0-9)]{1,20}$";
				if (mempsw == null || mempsw.trim().length() == 0) {
					errorMsgs.add("會員密碼: 請勿空白");
				} else if(!mempsw.trim().matches(mempswReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員密碼: 只能是英文字母、數字 , 且長度必需為20內");
	            }
				//NAME
				String memname =req.getParameter("memname");
				String memnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9)]{1,20}$";
				if (memname == null || memname.trim().length() == 0) {
					errorMsgs.add("會員姓名: 請勿空白");
				} else if(!memname.trim().matches(memnameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員名稱: 只能是中文(6個字內)、英文字母、數字 , 且長度必需為20內");
	            }
				//Gender
				String gender=req.getParameter("gender");
				//Birth
				java.sql.Date birth=null;
				try {
					birth = java.sql.Date.valueOf(req.getParameter("birth").trim());
				} catch (IllegalArgumentException e) {
					birth=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入生日日期!");
				}
				//BloodType
				String bloodtype=req.getParameter("bloodtype");
				//E-mail
				String email=req.getParameter("email");
				String emailReg="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,50}$";
				if (email == null || email.trim().length() == 0) {
					errorMsgs.add("會員信箱: 請勿空白");
				} else if(!email.trim().matches(emailReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員信箱: 只能是英文字母、數字 , 且長度必需為50內");
	            }
				//Phone
				String phone=req.getParameter("phone");
				String phoneReg="^[(0-9)]{1,20}$";
				if (phone == null || phone.trim().length() == 0) {
					errorMsgs.add("會員電話: 請勿空白");
				} else if(!phone.trim().matches(phoneReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員電話: 只能是數字 , 且長度必需為20內");
	            }
				//LocNo
				Integer locno=null;
				String getlocno=req.getParameter("locno");
				String locnoReg="^[(0-9)]{1,5}$";
				if (getlocno == null || getlocno.trim().length() == 0) {
					errorMsgs.add("會員郵遞區號: 請勿空白");
				} else if(!getlocno.trim().matches(locnoReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員郵遞區號: 只能是數字 , 且長度必需為5內");
	            }
				locno=Integer.valueOf(getlocno);
				//地址
				String addr=req.getParameter("addr");
				String addrReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9)]{1,60}$";
				if (addr == null || addr.trim().length() == 0) {
					errorMsgs.add("會員姓名: 請勿空白");
				} else if(!addr.trim().matches(addrReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("會員名稱: 只能是中文(20個字內)、英文字母、數字 , 且長度必需為60內");
	            }
				//過去病史
				String medhistory=req.getParameter("medhistory");
				String medhistoryReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9)]{1,600}$";
				if (medhistory == null || medhistory.trim().length() == 0) {
					errorMsgs.add("過去病史: 請勿空白");
				} else if(!medhistory.trim().matches(medhistoryReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("過去病史: 只能是中文(200個字內)、英文字母、數字 , 且長度必需為600內");
	            }
				//家族病史
				String famhistory=req.getParameter("famhistory");
				String famhistoryReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9)]{1,600}$";
				if (famhistory == null || famhistory.trim().length() == 0) {
					errorMsgs.add("家族病史: 請勿空白");
				} else if(!famhistory.trim().matches(famhistoryReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("家族病史: 只能是中文(200個字內)、英文字母、數字 , 且長度必需為600內");
	            }
				//過敏記錄
				String allergy=req.getParameter("allergy");
				String allergyReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9)]{1,600}$";
				if (allergy == null || allergy.trim().length() == 0) {
					errorMsgs.add("過敏記錄: 請勿空白");
				} else if(!allergy.trim().matches(allergyReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("過敏記錄: 只能是中文(200個字內)、英文字母、數字 , 且長度必需為600內");
	            }
				//抽菸
				String smoking =req.getParameter("smoking");
				//會員狀態
				String memStatus=req.getParameter("memstatus");
				//會員身分
				String ident=req.getParameter("ident");
				//註冊日期
				java.sql.Date regdate = null;
				try {
					regdate = java.sql.Date.valueOf(req.getParameter("regdate").trim());
				} catch (IllegalArgumentException e) {
					regdate=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入註冊日期!");
				}
				//最後登入時間
				java.sql.Timestamp stayTime=null;
				try {
					stayTime=java.sql.Timestamp.valueOf(req.getParameter("staytime").trim());
				} catch (IllegalArgumentException e) {
					stayTime=new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入登入日期!");
				}
				//大頭照
				byte[] data;
				Part memPic=req.getPart("memPic");
				if(memPic.getSubmittedFileName().equals("")||memPic.getSubmittedFileName().trim().length()==0) {
					MemberService memSvc =new MemberService();
					data=memSvc.getOneMember(memNo).getMemPic();
				}else {
					InputStream fileContent = memPic.getInputStream();
					data=TranslateImage.readFully(fileContent);
				}
				
				MemberVO memVO=new MemberVO();
				memVO.setAddr(addr);
				memVO.setAllergy(allergy);
				memVO.setBirth(birth);
				memVO.setBloodType(bloodtype);
				memVO.setEmail(email);
				memVO.setFamHistory(famhistory);
				memVO.setGender(gender);
				memVO.setIdent(ident);
				memVO.setLocNo(locno);
				memVO.setMedHistory(medhistory);
				memVO.setMemId(memid);
				memVO.setMemName(memname);
				memVO.setMemStatus(memStatus);
				memVO.setPhone(phone);
				memVO.setPwd(mempsw);
				memVO.setRegDate(regdate);
				memVO.setSmoking(smoking);
				memVO.setStayTime(stayTime);
				memVO.setMemNo(memNo);
				memVO.setMemPic(data);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memVO",memVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/member/updatemydata.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始修改資料*****************************************/
				MemberService memSvc = new MemberService();
				memVO = memSvc.updateMember(memid, memname, mempsw, email, 
						gender, birth, addr, allergy, 
						bloodtype, phone, famhistory, ident, 
						medhistory, memStatus, smoking, locno, 
						regdate, stayTime, memNo,data);
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("memVO", memVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/front-end/member/showonemember.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			}catch(Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/member/updatemydata.jsp");
				failureView.forward(req, res);
			}
		}//End-point update
		
		
		if ("authorization".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("loginerrorMsgs", errorMsgs);
			
			String account = req.getParameter("account");
			String accountReg = "^[(a-zA-Z0-9)]{1,20}$";
			if (account == null || account.trim().length() == 0) {
				errorMsgs.add("會員密碼: 請勿空白");
			} else if(!account.trim().matches(accountReg)) { //以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("會員密碼: 只能是英文字母、數字 , 且長度必需為20內");
            }
		    String password = req.getParameter("password");
		    String passwordReg = "^[(a-zA-Z0-9)]{1,20}$";
			if (password == null || password.trim().length() == 0) {
				errorMsgs.add("會員密碼: 請勿空白");
			} else if(!password.trim().matches(passwordReg)) { //以下練習正則(規)表示式(regular-expression)
				errorMsgs.add("會員密碼: 只能是英文字母、數字 , 且長度必需為20內");
            }
		    
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/member/index.jsp");
				failureView.forward(req, res);
				return;
			}
			
		    if (!allowUser(account,password)) {          //【帳號 , 密碼無效時】
		    	errorMsgs.add("帳號或密碼錯誤");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/member/index.jsp");
				failureView.forward(req, res);
		      }else {                                       //【帳號 , 密碼有效時, 才做以下工作】
		        HttpSession session = req.getSession();
		        req.getSession().removeAttribute("accessfail");
		        java.sql.Timestamp lastlogin = new Timestamp(System.currentTimeMillis());
		        MemberService memSvc = new MemberService();
			  	MemberVO memVO=memSvc.getOneMemberByAccount(account,lastlogin);
		        session.setAttribute("memVO", memVO);   //*工作1: 才在session內做已經登入過的標識
		        String memno  = memVO.getMemNo();
		        DoctorService ds = new DoctorService();
		        ds.UpdateIsonline("線上", memno);
		         try {                                                        
		           String location = (String) session.getAttribute("location");
		           if (location != null) {
		             session.removeAttribute("location");   //*工作2: 看看有無來源網頁 (-->如有來源網頁:則重導至來源網頁)
		             res.sendRedirect(location);            
		             return;
		           }
		         }catch (Exception ignored) { }

		        res.sendRedirect(req.getContextPath()+"/front-end/index.jsp");  //*工作3: (-->如無來源網頁:則重導至login_success.jsp)
		      }
		}//end auth
	
		if("logout".equals(action)) {
			HttpSession session = req.getSession();
			MemberVO memVO =(MemberVO)session.getAttribute("memVO");
	        String memno  = memVO.getMemNo();
	        DoctorService ds = new DoctorService();
	        ds.UpdateIsonline("離線", memno);
			session.removeAttribute("memno");
			session.removeAttribute("memVO");
			res.sendRedirect(req.getContextPath()+"/front-end/index.jsp");
		}//end logout
		if("verify".equals(action)) {
			String memno = req.getParameter("memno");
			MemberService memSvc = new MemberService();
			MemberVO memVO=memSvc.VerifyMember(memno);
			HttpSession session = req.getSession();
			session.setAttribute("memVO", memVO);
			try {                                                        
		        String location = (String) session.getAttribute("location");
		        if (location != null) {
		             session.removeAttribute("location");   //*工作2: 看看有無來源網頁 (-->如有來源網頁:則重導至來源網頁)
		             res.sendRedirect(location);            
		             return;
		           }
		         }catch (Exception ignored) { }
		        res.sendRedirect(req.getContextPath()+"/front-end/index.jsp");  //*工作3: (-->如無來源網頁:則重導至login_success.jsp)
		}
		
		//start license
		if ("getone_For_lic".equals(action)) {

					List<String> errorMsgs = new LinkedList<String>();
					req.setAttribute("errorMsgs", errorMsgs);

//					try {
						/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 ****************************************/
						String memNo = new String(req.getParameter("memNo"));
						System.out.println(memNo);

						/*************************** 2.開始查詢資料****************************************/
						MemberService memberSvc = new MemberService();
						Set<LicenseVO> set = memberSvc.getOneMemberByLicense(memNo);

						/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
						req.setAttribute("mem_lic", set);    // 資料庫取出的impressionVO物件,存入req

						String url = null;
						if ("getone_For_lic".equals(action))
							url = "/front-end/member/mem_lic.jsp";        // 成功轉交 act_imp.jsp
						
						RequestDispatcher successView = req.getRequestDispatcher(url);
						successView.forward(req, res);

						/*************************** 其他可能的錯誤處理 ***********************************/
//					} catch (Exception e) {
//						throw new ServletException(e);
//					}
		}
		//end license
	}
	  protected boolean allowUser(String account, String password) {
		  	MemberService memSvc = new MemberService();
		  	java.sql.Timestamp lastlogin = new Timestamp(System.currentTimeMillis());
		  	MemberVO memVO=memSvc.getOneMemberByAccount(account,lastlogin);
		  	if(memVO==null) 
		  		return false;
		  	else if (account.equals(memVO.getMemId())&&password.equals(memVO.getPwd()))
		  		return true;
		  	else
		  		return false;
	}
}
