package com.favdr.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class FavDrService {
	
	private FavDr_interface dao;

	public FavDrService() {
		dao = new FavDrDAO();
	}

	public FavDrVO addFavDr(String memNo, String drNo) {
		
		FavDrVO favDrVO = new FavDrVO();
		
		favDrVO.setMemNo(memNo);
		favDrVO.setDrNo(drNo);
		dao.insert(favDrVO);
		
		return favDrVO;
	}
	
	public void deleteFavDr(String memNo, String drNo) {
		
		FavDrVO favDrVO = new FavDrVO();
		
		favDrVO.setMemNo(memNo);
		favDrVO.setDrNo(drNo);
		
		dao.delete(favDrVO);
	}
	
	public List<FavDrVO> getOneFavDr(String memNo){			
		return dao.findByPrimaryKey(memNo);
	}
	
	public List<FavDrVO> getAll(){
		return dao.getAll();
	}

}




	