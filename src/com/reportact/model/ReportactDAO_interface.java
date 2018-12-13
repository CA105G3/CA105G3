package com.reportact.model;

import java.util.List;

public interface ReportactDAO_interface {
	public void insert(ReportactVO reportactVO);
    public void update(ReportactVO reportactVO);
    public void delete(String repano);
    public ReportactVO findByPrimaryKey(String repano);
    public List<ReportactVO> getAll();
}
