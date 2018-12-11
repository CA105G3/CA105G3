package com.doctoravailable.model;

import java.util.List;

public interface DravailableDAO_interface {
	public void insert(DravailableVO dravailableVO);
	public void update(DravailableVO dravailableVO);
	public void delete(String dravano);
	public DravailableVO findByPK(String dravano);   //�D�n�O��drno����ͩM�L��draym,drava
	public List<DravailableVO> findByDrno(String drno);
	public List<DravailableVO> getAll();
}
