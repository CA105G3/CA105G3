package com.reportdr.model;

import java.util.*;

public interface Reportdr_interface {
 
	public void insert(ReportdrVO reportdrVO);
	public void update(ReportdrVO reportdrVO);
	public void delete(ReportdrVO reportdrVO);
	public ReportdrVO findByPrimaryKey(String rdrno);
	public List<ReportdrVO> getAll();
	
	
}
