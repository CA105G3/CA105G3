package com.reportdr.model;

import java.util.*;

public interface ReportDr_interface {
 
	public void insert(ReportDrVO reportdrVO);
	public void update(ReportDrVO reportdrVO);
	public void delete(ReportDrVO reportdrVO);
	public ReportDrVO findByPrimaryKey(String rdrNo);
	public List<ReportDrVO> getAll();
	
	
	
}
