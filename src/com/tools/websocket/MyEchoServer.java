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

@ServerEndpoint("/MyEchoServer/{myName}/{myRoom}")
public class MyEchoServer {
	
private static final Set<Session> allSessions = Collections.synchronizedSet(new HashSet<Session>());
	
	JSONObject getInfo;
	PPTToolService pptSvc=new PPTToolService();
	List<PPTToolVO> list =(ArrayList)pptSvc.getAll();
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
	public void onMessage(Session userSession, String message) throws JSONException {

		System.out.println("Message received: " + message);
		
		getInfo=new JSONObject(message);
		String username=getInfo.getString("userName");
		String message2=getInfo.getString("message");
		ArrayList<PPTToolVO> pptlist = new ArrayList<PPTToolVO>();
		for(int i=0;i<list.size();i++) {
			PPTToolVO pptvo=list.get(i);
			if(pptvo.getDrno().equals(username)) {
				pptlist.add(pptvo);
			}
		}
		int t=pptlist.size();
		if(message2.equals("next")) {
			System.out.println("next");
			a++;
			if(a>=t)
				a=0;
			
			PPTToolVO pptvo=pptlist.get(a);
			for (Session session : allSessions) {
				if (session.isOpen())
					session.getAsyncRemote().sendText(pptvo.getPptno());
				}
		}
		if(message2.equals("back")) {
			System.out.println("back");
			a--;
			if(a<0)
				a=pptlist.size()-1;
			PPTToolVO pptvo=pptlist.get(a);
			for (Session session : allSessions) {
				if (session.isOpen())
					session.getAsyncRemote().sendText(pptvo.getPptno());
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
