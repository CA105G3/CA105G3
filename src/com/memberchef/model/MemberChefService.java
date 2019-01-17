package com.memberchef.model;

import java.util.List;

public class MemberChefService {
	
	private MemberChefDAO_interface dao;
	
	public MemberChefService() {
		dao = new MemberChefDAO();
	}

	public MemberChefVO addMemberChef(String chefName, String chefStoreName, byte[] chefPic, String chefDescrip, String chefStatus,
			String chefPhone, String chefAddr, String chefRep) {
		
		MemberChefVO memberChefVO = new MemberChefVO();
		
		memberChefVO.setChefName(chefName);
		memberChefVO.setChefStoreName(chefStoreName);
		memberChefVO.setChefPic(chefPic);
		memberChefVO.setChefDescrip(chefDescrip);
		memberChefVO.setChefStatus(chefStatus);
		memberChefVO.setChefPhone(chefPhone);
		memberChefVO.setChefAddr(chefAddr);
		memberChefVO.setChefRep(chefRep);
		dao.insert(memberChefVO);
		
		return memberChefVO;
	}
	
	public void addMemberChef(MemberChefVO memberChefVO) {
		dao.insert(memberChefVO);
	}

	public MemberChefVO updateMemberChef(String chefNo, String chefName, String chefStoreName, byte[] chefPic, String chefDescrip, String chefStatus,
			String chefPhone, String chefAddr, String chefRep) {
		
		MemberChefVO memberChefVO = new MemberChefVO();

		memberChefVO.setChefNo(chefNo);
		memberChefVO.setChefName(chefName);
		memberChefVO.setChefStoreName(chefStoreName);
		memberChefVO.setChefPic(chefPic);
		memberChefVO.setChefDescrip(chefDescrip);
		memberChefVO.setChefStatus(chefStatus);
		memberChefVO.setChefPhone(chefPhone);
		memberChefVO.setChefAddr(chefAddr);
		memberChefVO.setChefRep(chefRep);
		dao.update(memberChefVO);
		
		return memberChefVO;
	}
	
	public void updateMemberChef(MemberChefVO memberChefVO) {
		dao.update(memberChefVO);
	}
	
	public void deleteMemberChef(String chefNo) {
		dao.delete(chefNo);
	}

	public MemberChefVO getOneChef(String chefNo) {
		return dao.findByPrimaryKey(chefNo);
	}

	public MemberChefVO getOneChefByMemNo(String memNo) {
		return dao.findByMemNo(memNo);
	}
	
	public List<MemberChefVO> getAll() {
		return dao.getAll();
	}
	
}
