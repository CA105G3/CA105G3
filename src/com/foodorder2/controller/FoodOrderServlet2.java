package com.foodorder2.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.GregorianCalendar; 
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodorder2.model.*;

public class FoodOrderServlet2 extends HttpServlet {
	
		private static final long serialVersionUID = 1L;

		protected void doGet(HttpServletRequest req, HttpServletResponse res) 
				throws ServletException, IOException {
	
			doPost(req, res);
		}
		
		 
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		protected void doPost(HttpServletRequest req, HttpServletResponse res) 
				throws ServletException, IOException {
			HttpSession  session = req.getSession();
			
			
			req.setCharacterEncoding("UTF-8");
			String action = req.getParameter("action");
			
			
			
			//根據廚師，找出所有明日以後(包括明日)有供餐的菜單
			if("getMenusByChefno".equals(action)) {
				String chefno = req.getParameter("chefno");
				MenuService menuService = new MenuService();
				MenuListService menuListService = new MenuListService();
				List<MenuVO> list  = menuService.getOneChefMenu(chefno);
				
//				List<MenuVO> list  = menuService.getOneChefMenu("CHEF0001");
				Iterator<MenuVO> it = list.iterator();
				MenuVO menuVO = new MenuVO();
				MenuListVO menuListVO = new MenuListVO();
				while(it.hasNext()) {
					menuVO = it.next();
					List<MenuListVO> menuListVOList = menuListService.getOneKindMenuList( menuVO.getMenuNo());
					Iterator<MenuListVO> itMenuListVOList = menuListVOList.iterator();
					java.util.Date date = new java.util.Date();
					while(itMenuListVOList.hasNext()) {
						menuListVO = itMenuListVOList.next();
						if(menuListVO.getMenuDate().getTime()<=((date.getTime()/86400)*86400)) {
							itMenuListVOList.remove();
						}
					}
					if(menuListVOList.size()==0) {
						it.remove();
					}
				}
				session.setAttribute("listMenu_ByChefno", list);	
				String url = "/front-end/foodOrder2/selectMenu.jsp";
				RequestDispatcher dispatcher = req.getRequestDispatcher(url);
				dispatcher.forward(req, res);
			}
			
			
			
			//根據菜單，找出所有明日以後(包括明日)的供餐時間	
			/*				  早		 午	     晚
			 * 1/29    offer   offer    offer
			 * 1/30    offer   offer    
			 * 1/31    offer               offer
			 * 2/01               offer    offer
			 * 
			 * 上圖就是下行程式碼
			 * Map<String,LinkedHashMap<String,String>> list2 = new LinkedHashMap<>();
			 */
			if("getMenuListsByMenuno".equals(action)) {
				
//				MenuService menuService = new MenuService();
				MenuListService menuListService = new MenuListService();
				MenuListVO menuListVO = new MenuListVO();
				List<MenuListVO> list = menuListService.getOneKindMenuList(req.getParameter("menuno"));
				//篩選明日以後有供餐的明細
				java.util.Date date = new java.util.Date();
				Iterator<MenuListVO> it = list.iterator();
				while(it.hasNext()) {
					menuListVO = it.next();
					if(menuListVO.getMenuDate().getTime()<=((date.getTime()/86400)*86400)) {
						it.remove();
					}
				}
				
				
				Map<String,LinkedHashMap<String,String>> viewlist = new LinkedHashMap<>();
				Iterator<MenuListVO> itMenuListVO = list.iterator();
				MenuListVO menuListVO2;
				LinkedHashMap<String,String> lhm;
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				while(itMenuListVO.hasNext()) {
					menuListVO2 = itMenuListVO.next();
					
					
					if(viewlist.get(sdf.format(menuListVO2.getMenuDate()))==null) {
						
						lhm = new LinkedHashMap<>();
						lhm.put("breakfast","");
						lhm.put("lunch","");
						lhm.put("dinner","");
						if("早".equals(menuListVO2.getMenuTimeSlot())) {
							lhm.put("breakfast","offerB");
						}
						if("午".equals(menuListVO2.getMenuTimeSlot())) {
							lhm.put("lunch","offerL");
						}
						if("晚".equals(menuListVO2.getMenuTimeSlot())) {
							lhm.put("dinner","offerD");
						}
						viewlist.put(sdf.format(menuListVO2.getMenuDate()),lhm);
						
					}else {
						
						lhm = viewlist.get(sdf.format(menuListVO2.getMenuDate()));
						if("早".equals(menuListVO2.getMenuTimeSlot())) {
							lhm.put("breakfast","offerB");
						}
						if("午".equals(menuListVO2.getMenuTimeSlot())) {
							lhm.put("lunch","offerL");
						}
						if("晚".equals(menuListVO2.getMenuTimeSlot())) {
							lhm.put("dinner","offerD");
						}
					}
				}
				req.setAttribute("listMenuList_ByMenuno", viewlist);
				String url = "/front-end/foodOrder2/selectMenu.jsp";
				RequestDispatcher dispatcher = req.getRequestDispatcher(url);
				dispatcher.forward(req, res);
			}
		
			
			
			
			//餐車新增項目
			if("addMenuIntoCart".equals(action)) {
				List<MenuVO> menuVOList = (List<MenuVO>)session.getAttribute("shoppingCart");
				if(menuVOList==null) 
					menuVOList = new Vector<MenuVO>();
				
				String menuno = req.getParameter("menuno");
				boolean check = false;
				
				Iterator<MenuVO> it = menuVOList.iterator();
				MenuVO menuVOForIt; 
				while(it.hasNext()) {
					menuVOForIt=it.next();
					if(menuno.equals(menuVOForIt.getMenuNo())){
						check = true;
					}
				}
				if(!check) {
					MenuService menuService = new MenuService();
					MenuVO menuVO = menuService.getOneMenu(menuno);
					menuVOList.add(menuVO);
				}
				
				session.setAttribute("shoppingCart",menuVOList);
				String url = "/front-end/foodOrder2/selectMenu.jsp";
				RequestDispatcher dispatcher = req.getRequestDispatcher(url);
				dispatcher.forward(req, res);
			}
			
			
			
			
			//餐車刪除項目
			if("deleteMenuFromCart".equals(action)) {
				List<MenuVO> menuVOList = (List<MenuVO>)session.getAttribute("shoppingCart");
				String menuNo = req.getParameter("menuno");
				Iterator<MenuVO> it = menuVOList.iterator();
				MenuVO menuVO;
				while(it.hasNext()) {
					menuVO = it.next();
					if(menuVO.getMenuNo().equals(menuNo))
							it.remove();
				}
				session.setAttribute("shoppingCart",menuVOList);
				String url = "/front-end/foodOrder2/selectMenu.jsp";
				RequestDispatcher dispatcher = req.getRequestDispatcher(url);
				dispatcher.forward(req, res);
			}
			
			//進入點餐頁面，需選出起始到終止時間內所有時間物件，需取出所有在Session的菜單，
			//取得時間內所有menuListVO，對應時間、時段後包裝資料送往jsp
			if("beginOrder".equals(action)) {
				String startDate = req.getParameter("startDate");
				String endDate = req.getParameter("endDate");
				String[] startDateStr = startDate.split("-");
				String[] endDateStr = endDate.split("-");
				int beginYear =Integer.parseInt(startDateStr[0]);
				int beginMonth =Integer.parseInt(startDateStr[1]);
				int beginDay =Integer.parseInt(startDateStr[2]);
				int endYear =Integer.parseInt(endDateStr[0]);
				int endMonth =Integer.parseInt(endDateStr[1]);
				int endDay =Integer.parseInt(endDateStr[2]);
				List<java.sql.Date> list = getDateBetweenBeginAndEnd(beginYear,beginMonth,beginDay,endYear,endMonth,endDay);
				
				
				Map<Long,LinkedHashMap<String,LinkedHashSet<MenuListVO>>> map = new LinkedHashMap<>();
				//Map<Long,LinkedHashMap>:							long描述Y軸時間，LinkedHashMap包裝X軸與Z軸資訊
				//LinkedHashMap<String,LinkedHashSet>:			String描述X軸時段"早"、"中"、"晚"，LinkedHashSet包裝Z軸資訊
				//LinkedHashSet<MenuListVO>: 							MenuListVO描述Z軸MenuListVO資訊
				
				
				MenuListService menuListService = new MenuListService();
				Iterator<java.sql.Date> itDateIntoMap  = list.iterator();
				LinkedHashMap<String,LinkedHashSet<MenuListVO>> lhm;
				while(itDateIntoMap.hasNext()) {
					lhm = new LinkedHashMap<String,LinkedHashSet<MenuListVO>>();
					lhm.put("早",new LinkedHashSet<MenuListVO>());
					lhm.put("午",new LinkedHashSet<MenuListVO>());
					lhm.put("晚",new LinkedHashSet<MenuListVO>());
					map.put(itDateIntoMap.next().getTime(),lhm);
				}
				List<MenuVO> menuVOList = (List<MenuVO>)session.getAttribute("shoppingCart");
				List<MenuListVO> allMenuListVO = new ArrayList<>();
				
				Iterator<MenuVO> itGetMenunoFromSession = menuVOList.iterator();
				while(itGetMenunoFromSession.hasNext()) {
					allMenuListVO.addAll(menuListService.getOneKindMenuList(itGetMenunoFromSession.next().getMenuNo()));
				}
				Iterator<MenuListVO> itPutIntoMap = allMenuListVO.iterator();
				MenuListVO menuListVO;
				Long time;
				String timeSlot;
				while(itPutIntoMap.hasNext()) {
					menuListVO = itPutIntoMap.next();
					time = menuListVO.getMenuDate().getTime();
					timeSlot = menuListVO.getMenuTimeSlot();
					if(map.get(time)!=null) {
						map.get(time).get(timeSlot).add(menuListVO);
					}
				}
				req.setAttribute("showDatesToOrderFood", map);
				
				Iterator<Map.Entry<Long, LinkedHashMap<String,LinkedHashSet<MenuListVO>>>> its = map.entrySet().iterator();
				Map.Entry<Long, LinkedHashMap<String,LinkedHashSet<MenuListVO>>> mapsentrys;
				int max = 0;
				int pivot;
				while(its.hasNext()) {
					mapsentrys = its.next();
					pivot = mapsentrys.getValue().get("早").size();
					if(pivot>max) {
						max=pivot;
					}
					pivot = mapsentrys.getValue().get("午").size();
					if(pivot>max) {
						max=pivot;
					}
					pivot = mapsentrys.getValue().get("晚").size();
					if(pivot>max) {
						max=pivot;
					}
				}
				
				Calendar cal = Calendar.getInstance();
				cal.setTime(list.get(0));
				int weekDay = cal.get(Calendar.DAY_OF_WEEK)-1;
				
				req.setAttribute("weekDay", weekDay);
				req.setAttribute("beginMonth", beginMonth);
				req.setAttribute("beginDay", beginDay);
				req.setAttribute("firstDayLong",list.get(0).getTime());
				req.setAttribute("maxColunmSize", max);
				
				System.out.println("weekDay"+weekDay);
				System.out.println("beginMonth"+beginMonth);
				System.out.println("beginDay"+beginDay);
				
				String url = "/front-end/foodOrder2/selectMenuList.jsp";
				RequestDispatcher dispatcher = req.getRequestDispatcher(url);
				dispatcher.forward(req, res);
			}
			
			
			
			//進行下訂動作
			if("SendOrderDetail".equals(action)) {
				Map<String,String> map = new HashMap<>();
				Enumeration<String> en = req.getParameterNames();
				while(en.hasMoreElements()) {
					String name = en.nextElement();
					String values[] = req.getParameterValues(name);
					if(!"action".equals(name)) {
						if(values!=null) {
								map.put(name, values[0]);
						}
					}
				}
				Set<Map.Entry<String,String>> set = map.entrySet();
				Iterator<Map.Entry<String,String>> it = set.iterator();
				Map.Entry mapentry;
				while(it.hasNext()) {
					mapentry = it.next();
					if("".equals(mapentry.getValue())) {
						it.remove();
					}
				}
				FoodOrderService foodOrderService = new FoodOrderService();
				FoodOrderVO foodOrderVO = new FoodOrderVO();
				
				Map<String,Object[]> collectByChefnoMap = new HashMap<>();
				List<MenuVO> menuVOList = (List<MenuVO>)session.getAttribute("shoppingCart");
				Iterator<MenuVO> itGetChefno = menuVOList.iterator();
				MenuVO menuVOForIt;
				Object[] hm;
				while(itGetChefno.hasNext()) {
					menuVOForIt = itGetChefno.next();
					String chefno = menuVOForIt.getChefNo();
					if(!collectByChefnoMap.containsKey(chefno)) {
						hm = new Object[2];
						
						FoodOrderVO foodOrder= new FoodOrderVO();
						foodOrder.setChefno(chefno);
						foodOrder.setDeliverAddr(null);
//						foodOrder.setMemno((String)session.getAttribute("memberno"));
						foodOrder.setMemno("M0001");
						foodOrder.setOrderStatus("接受");
						java.sql.Date ordTIme = new java.sql.Date((new java.util.Date()).getTime());
						foodOrder.setOrdTime(ordTIme);
						
						hm[0] = foodOrder;
						hm[1] = new ArrayList<OrderDetailVO>();
						collectByChefnoMap.put( chefno,hm);
					}
				}
				
				
				MenuListService menuListService =new MenuListService();
				MenuService menuService = new MenuService();
				
				int totalPrice = 0;
				
				List<OrderDetailVO> list = new ArrayList<>();
				Iterator<Map.Entry<String,String>> itPutInfo = map.entrySet().iterator();
				OrderDetailVO orderDetailVO ;
				Map.Entry<String,String> mapEntry;
				MenuVO menuVO;
				Object[] objects;
				while(itPutInfo.hasNext()) {
					mapEntry = itPutInfo.next();
					orderDetailVO = new OrderDetailVO();
					orderDetailVO.setAmount(Integer.parseInt(mapEntry.getValue()));
					orderDetailVO.setMenuListno(mapEntry.getKey());
					orderDetailVO.setOdStatus(null);
					menuVO = menuService.getOneMenu(menuListService.getOneMenuList(mapEntry.getKey()).getMenuNo());
					totalPrice += menuVO.getUnitPrice()*Integer.parseInt(mapEntry.getValue());
					orderDetailVO.setUnitPrice(menuVO.getUnitPrice());
					objects = collectByChefnoMap.get(menuVO.getChefNo());
					((List<OrderDetailVO>)objects[1]).add(orderDetailVO);
				}
				
System.out.println(totalPrice);
				
				
				Iterator<Map.Entry<String, Object[]>> itRemoveNullList = collectByChefnoMap.entrySet().iterator();
				Map.Entry<String, Object[]> mapEntries;
				while(itRemoveNullList.hasNext()) {
					mapEntries = itRemoveNullList.next();
					objects = mapEntries.getValue();
					if(((List<OrderDetailVO>)objects[1]).size()==0) {
						itRemoveNullList.remove();
					}
				}
				
				boolean check = foodOrderService.insertNewMutiOrder(collectByChefnoMap);
				
				req.setAttribute("showOrderResult", check);
				String url = "/front-end/foodOrder2/showOrderResult.jsp";
				RequestDispatcher dispatcher = req.getRequestDispatcher(url);
				dispatcher.forward(req, res);
			}
		}
		
		
		
		
		public List<java.sql.Date> getDateBetweenBeginAndEnd(int beginYear, int beginMonth, int beginDay,int endYear, int endMonth, int  endDay){

	        StringBuilder beginDateStr = new StringBuilder();
	        beginDateStr.append(beginYear).append("-").append(beginMonth).append("-").append(beginDay);
	        SimpleDateFormat starsdf = new SimpleDateFormat("yyyy-MM-dd");
	        java.util.Date beginDate = null;

	        try {
	            beginDate = starsdf.parse(beginDateStr.toString());
	        } catch (ParseException e) {
	            e.printStackTrace();
	        }

	        StringBuilder endDateStr = new StringBuilder();
	        endDateStr.append(endYear).append("-").append(endMonth).append("-").append(endDay);
	        SimpleDateFormat endsdf = new SimpleDateFormat("yyyy-MM-dd");
	        java.util.Date endDate = null;

	        List<java.sql.Date> dateList = new ArrayList<>();


	        try {
	            endDate = endsdf.parse(endDateStr.toString());
	        } catch (ParseException e) {
	            e.printStackTrace();
	        }

	        if(beginDate.getTime() > endDate.getTime()){
	            return null;
	        }
	        if(beginDate.getTime() == endDate.getTime()){
	            dateList.add(new java.sql.Date(beginDate.getTime()));
	            return dateList;
	        }


	        dateList.add(new java.sql.Date(beginDate.getTime()));

	        Calendar calendar = Calendar.getInstance();
	        calendar.setTime(beginDate);
	        while(true){
	            calendar.add(Calendar.DAY_OF_MONTH,1);
	            if(endDate.after(calendar.getTime())){
	                dateList.add(new java.sql.Date(calendar.getTime().getTime()));
	            }else{
	                break;
	            }
	        }
	        dateList.add(new java.sql.Date(endDate.getTime()));
	        return dateList;
	    }
		
		 @SuppressWarnings("unused")
		private static String parseNum(int day) {
		        if (day >= 10)
		            return String.valueOf(day);
		        else
		            return "0" + String.valueOf(day);
		    }

}
