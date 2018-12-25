package com.doctoravailable.model;

import java.sql.Date;
import java.util.List;

public interface DravailableDAO_interface {
	public void insert(DravailableVO dravailableVO);
	public void update(DravailableVO dravailableVO);
	public void delete(String dravano);
	public DravailableVO findByPK(String dravano);   //主要是用drno找醫生和他的draym,drava?
	public List<DravailableVO> findByDrno(String drno);
	public List<DravailableVO> getAll();
}
