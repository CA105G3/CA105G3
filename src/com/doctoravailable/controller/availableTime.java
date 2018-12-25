package com.doctoravailable.controller;


public class availableTime {
	public static String randomAvaTime() {
		String avaTime = "";
		for (int i = 0; i < 93; i++) {
			int random = (int)(Math.random()*2);
//			System.out.println(random);
			String randomstr = Integer.toString(random);
			avaTime = avaTime + randomstr;
		}
		System.out.println(avaTime);
		return avaTime;
	}
	
	public static String set93Zero() {
		String avaTime = "";
		for(int i = 0; i < 93; i++) {
			avaTime += Integer.toString(0);
		}
//		System.out.println(avaTime);
		return avaTime;
		
	}
	
	public static void main(String[] args) {
		randomAvaTime();
		set93Zero();
	}
	
}
