package com.tools.websocket;

import java.io.*;
import java.util.*;

import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONException;
import org.json.JSONObject;

import com.ppttool.model.*;

import javax.websocket.Session;
import javax.websocket.OnOpen;
import javax.websocket.OnMessage;
import javax.websocket.OnError;
import javax.websocket.OnClose;
import javax.websocket.CloseReason;
import javax.websocket.EncodeException;

@ServerEndpoint("/MyEchoServer/{myName}/{myRoom}")
public class MyEchoServer {
	
private static final Set<Session> allSessions = Collections.synchronizedSet(new HashSet<Session>());
	
	JSONObject getInfo;
	PPTToolService pptSvc=new PPTToolService();
	List<PPTToolVO> list =pptSvc.getAll();
	int a=0;
	@OnOpen
	public void onOpen(@PathParam("myName") String myName, @PathParam("myRoom") String myRoom, Session userSession) throws IOException {
		allSessions.add(userSession);
		System.out.println(userSession.getId() + ": 已連線");
		System.out.println(myName + ": 已連線");
		System.out.println(myRoom + ": 房號");
//		userSession.getBasicRemote().sendText("WebSocket 連線成功");
	}

	
	@OnMessage
	public void onMessage(Session userSession, String message) throws JSONException, IOException, EncodeException {

		System.out.println("Message received: " + message);
		getInfo=new JSONObject(message);
		String username=getInfo.getString("userName");
		String message2=getInfo.getString("message");
		String roomno=getInfo.getString("roomno");
		
		ArrayList<PPTToolVO> pptlist = new ArrayList<PPTToolVO>();
		list.stream().filter(ppt->ppt.getDrno().equals(username)).forEach(ppt->pptlist.add(ppt));
		
		
		
		int t=pptlist.size();
		
		if(message2.equals("next")) {
			JSONObject sendInfo = new JSONObject();
			System.out.println("next");
			a++;
			if(a>=t)
				a=0;
			PPTToolVO pptvo=pptlist.get(a);
			System.out.println(roomno);
			System.out.println(pptvo.getPptno());
			sendInfo.accumulate("roomno", roomno);
			sendInfo.accumulate("pptno", pptvo.getPptno());
			System.out.println("test: "+sendInfo.toString());
			for (Session session : allSessions) {
					if (session.isOpen())
						session.getAsyncRemote().sendText(sendInfo.toString());
				}	
		}
		if(message2.equals("back")) {
			JSONObject sendInfo = new JSONObject();
			System.out.println("back");
			a--;
			if(a<0)
				a=pptlist.size()-1;
			PPTToolVO pptvo=pptlist.get(a);
			sendInfo.accumulate("roomno", roomno);
			sendInfo.accumulate("pptno", pptvo.getPptno());
			for (Session session : allSessions) {
				if (session.isOpen())
					session.getAsyncRemote().sendText(sendInfo.toString());
			}
		}
		if(message2.equals("stop")) {
			JSONObject sendInfo = new JSONObject();
			System.out.println("leave");
			String leaveMessage="患者已離開診間";
			sendInfo.accumulate("roomno", roomno);
			sendInfo.accumulate("pptno", null);
			sendInfo.accumulate("leavemessage", leaveMessage);
			for (Session session : allSessions) {
				if (session.isOpen())
					session.getAsyncRemote().sendText(sendInfo.toString());
				}
		}
	}
	
	@OnError
	public void onError(Session userSession, Throwable e){
//		e.printStackTrace();
	}
	
	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		allSessions.remove(userSession);
		System.out.println(userSession.getId() + ": Disconnected: " + Integer.toString(reason.getCloseCode().getCode()));
	}

 
}
