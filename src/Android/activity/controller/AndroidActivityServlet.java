package Android.activity.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.lang.reflect.Type;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import Android.activity.model.ActivityDAO;
import Android.activity.model.ActivityDAO_interface;
import Android.activity.model.ActivityVO;
import Android.activity.model.ActivityVOV2;
import Android.activity.model.JoinActDAO;
import Android.activity.model.JoinActDAO_interface;
import Android.activity.model.JoinActVO;
import Android.utilities.ImageUtil;

public class AndroidActivityServlet extends HttpServlet {

	private final static String CONTENT_TYPE = "text/html;charset=UTF-8";
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		
		//---------------------------------------------
		BufferedReader br = req.getReader();
		StringBuilder jsonIn = new StringBuilder();
		String line = null;
		while((line = br.readLine()) != null) {
			jsonIn.append(line);
		}
		System.out.println("input: "+ jsonIn);
		//----------------------------------------------
		
		
		
		//-----------------------------------------------------------------------
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
			String action = null;
		//-------------------------------------------------------------------------

			JsonObject jsonObject = null;
			jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);
			action = jsonObject.get("action").getAsString();
		
		
		
		//------------------------------------------------------------------------
			ActivityDAO_interface activityDAO = new ActivityDAO();
			JoinActDAO_interface joinactDAO = new JoinActDAO();
			String jsonOut;
			
			
		if("allActivityInfo".equals(action)) {
			List<ActivityVO> activityVOList = new ArrayList<>();
			activityVOList = activityDAO.getAll();
			
			
			Iterator<ActivityVO> itRemoveDoneAct = activityVOList.iterator();
			ActivityVO activityVOforCheck;
			java.util.Date date = new java.util.Date();
			while(itRemoveDoneAct.hasNext()) {
				activityVOforCheck= itRemoveDoneAct.next();
				if(activityVOforCheck.getActTime().getTime()<date.getTime()||
						"已取消".equals(activityVOforCheck.getActStatus())||
						"已結束".equals(activityVOforCheck.getActStatus())) {
					itRemoveDoneAct.remove();
				}
			}
			
			List<ActivityVOV2> activityVOV2List = new ArrayList<>();
			ActivityVO activityVOforIt;
			Iterator<ActivityVO> it = activityVOList.iterator();
			while(it.hasNext()){
				activityVOforIt = it.next();
				
				List<JoinActVO> filter = joinactDAO.getAllByActNo(activityVOforIt.getActNo());
				Iterator<JoinActVO> itf = filter.iterator();
				JoinActVO joinActVo;
				while(itf.hasNext()) {
					joinActVo =  itf.next();
					if(joinActVo.getJoinStatus()==0) {
						itf.remove();
					}
				}
				activityVOV2List.add(new ActivityVOV2(activityVOforIt,filter.size()));
			}
			
			
			jsonOut = gson.toJson(activityVOV2List);
			writeText(res,jsonOut);
		}
		
		
		else if("joinAct".equals(action)) {
			String memNo = jsonObject.get("memNo").getAsString();
			String actNo = jsonObject.get("actNo").getAsString();
			List<JoinActVO> joinActVOList = joinactDAO.getAllByActNo(actNo);
			Iterator<JoinActVO> it = joinActVOList.iterator();
			boolean checkIfAlreayInTable = false;
			JoinActVO joinacts;
			while(it.hasNext()) {
				joinacts = it.next();
				if(joinacts.getMemNo().equals(memNo)) {
					checkIfAlreayInTable=true;
					break;
				}
			}
			
			
			if(checkIfAlreayInTable) {
				JoinActVO joinactVO = new JoinActVO();
				joinactVO.setActNo(actNo);
				joinactVO.setMemNo(memNo);
				joinactVO.setJoinStatus(1);
				boolean check = joinactDAO.update(joinactVO);
				writeText(res,String.valueOf(check));
				
			}else {
				JoinActVO joinactVO = new JoinActVO();
				joinactVO.setActNo(actNo);
				joinactVO.setMemNo(memNo);
				joinactVO.setJoinStatus(1);
				boolean check = joinactDAO.insert(joinactVO);
				writeText(res,String.valueOf(check));
			}
		}
		
		else if("departJoinedAct".equals(action)) {
			String memNo = jsonObject.get("memNo").getAsString();
			String actNo = jsonObject.get("actNo").getAsString();
			
			JoinActVO joinactVO = new JoinActVO();
			joinactVO.setActNo(actNo);
			joinactVO.setMemNo(memNo);
			joinactVO.setJoinStatus(0);
			boolean check = joinactDAO.update(joinactVO);
			writeText(res,String.valueOf(check));
		}
		
		
		
		else if("allJoinedActivityInfo".equals(action)) {
			String memNo = jsonObject.get("memNo").getAsString();
			List<JoinActVO> joinActVOList = joinactDAO.getAllBymemNo(memNo);
			Iterator<JoinActVO>  it = joinActVOList.iterator();
			Map<String,ActivityVOV2> map = new LinkedHashMap<>();
			JoinActVO joinActVO;
			while(it.hasNext()) {
				joinActVO = it.next();
				if(joinActVO.getJoinStatus()==0) {
					it.remove();
				}else {
					List<JoinActVO> filter = joinactDAO.getAllByActNo(joinActVO.getActNo());
					Iterator<JoinActVO> itf = filter.iterator();
					JoinActVO joinActVo2;
					while(itf.hasNext()) {
						joinActVo2 =  itf.next();
						if(joinActVo2.getJoinStatus()==0) {
							itf.remove();
						}
					}
					map.put(joinActVO.getActNo(), new ActivityVOV2(activityDAO.findByPrimaryKey(joinActVO.getActNo()),filter.size()));
				}
			}
			
			String jasonOut = gson.toJson(map);
			writeText(res,jasonOut);
		}
		
		
		
		
		else if ("getImage".equals(action)) {
			OutputStream os = res.getOutputStream();
			String isbn = jsonObject.get("isbn").getAsString();
			int imageSize = jsonObject.get("imageSize").getAsInt();
			byte[] image = activityDAO.getImage(isbn);
			if (image != null) {
				// 縮圖 in server side
				image = ImageUtil.shrink(image, imageSize);
				res.setContentType("image/jpeg");
				res.setContentLength(image.length);
			}
			os.write(image);
		}
		
		else {
			writeText(res, "");
		}
		//------------------------------------------------------------------------
	}
	
	
	
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
		
	}

	
	private void writeText(HttpServletResponse res, String outText) throws IOException {
		res.setContentType(CONTENT_TYPE);
		PrintWriter out = res.getWriter();
		out.print(outText);
		out.close();
		System.out.println("outText: " + outText);

	}


}
