package com.reportact.model;

import java.util.List;

public interface ReportactDAO_interface {
	public void insert(ReportactVO reportactVO);
    public void update(ReportactVO reportactVO);
    public void delete(String repaNo);
    public ReportactVO findByPrimaryKey(String repaNo);
    public List<ReportactVO> getAll();
}
