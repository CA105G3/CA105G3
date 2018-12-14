package com.reportdr.model;

import java.util.*;

public interface ReportDr_interface {
 
	public void insert(ReportDrVO reportDrVO);
	public void update_rdrReason_rdrState(ReportDrVO reportDrVO);
	public void update_rdrReason(ReportDrVO reportDrVO);
	public void update_rdrState(ReportDrVO reportDrVO);
	public void delete(String rdrNo);
	public ReportDrVO findByPrimaryKey(String rdrNo);
	public List<ReportDrVO> getAll();
	
	
	
}
