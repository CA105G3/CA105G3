package com.member.model;

import java.util.List;

import com.administrator.model.AdministratorVO;

public class MemberService {
private MemberDAO_interface dao;
	
	public MemberService() {
		dao=new MemberDAO();
	}
	
	public MemberVO addMember(String memId,String memName,String pwd,String email,
			String gender,java.sql.Date birth,String addr,
			String allergy,String bloodType,String phone,String famHistory,
			String ident,String medHistory,String memStatus,String smoking,
			Integer locNo,java.sql.Date regDate,java.sql.Timestamp stayTime ) {
		MemberVO memberVO = new MemberVO();
		System.out.println(stayTime);
		memberVO.setAddr(addr);
		memberVO.setAllergy(allergy);
		memberVO.setBirth(birth);
		memberVO.setBloodType(bloodType);
		memberVO.setEmail(email);
		memberVO.setFamHistory(famHistory);
		memberVO.setGender(gender);
		memberVO.setIdent(ident);
		memberVO.setLocNo(locNo);
		memberVO.setMedHistory(medHistory);
		memberVO.setMemId(memId);
		memberVO.setMemName(memName);
		memberVO.setMemStatus(memStatus);
		memberVO.setPhone(phone);
		memberVO.setPwd(pwd);
		memberVO.setRegDate(regDate);
		memberVO.setSmoking(smoking);
		memberVO.setStayTime(stayTime);
		dao.insert(memberVO);
		return memberVO;
	}
	
	public MemberVO updateMember(String memId,String memName,String pwd,String email,
			String gender,java.sql.Date birth,String addr,String allergy,
			String bloodType,String phone,String famHistory,String ident,
			String medHistory,String memStatus,String smoking,Integer locNo,
			java.sql.Date regDate,java.sql.Timestamp stayTime,String memNo) {
		MemberVO memberVO = new MemberVO();
		
		memberVO.setAddr(addr);
		memberVO.setAllergy(allergy);
		memberVO.setBirth(birth);
		memberVO.setBloodType(bloodType);
		memberVO.setEmail(email);
		memberVO.setFamHistory(famHistory);
		memberVO.setGender(gender);
		memberVO.setIdent(ident);
		memberVO.setLocNo(locNo);
		memberVO.setMedHistory(medHistory);
		memberVO.setMemId(memId);
		memberVO.setMemName(memName);
		memberVO.setMemStatus(memStatus);
		memberVO.setPhone(phone);
		memberVO.setPwd(pwd);
		memberVO.setRegDate(regDate);
		memberVO.setSmoking(smoking);
		memberVO.setStayTime(stayTime);
		memberVO.setMemNo(memNo);
		dao.update(memberVO);
		return memberVO;
	}
	public void deleteMember(String memno) {
		dao.delete(memno);
	}
	public MemberVO getOneMember(String memno) {
		return dao.findByPrimaryKey(memno);
	}
	public List<MemberVO> getAll(){
		return dao.getAll();
	}
}
