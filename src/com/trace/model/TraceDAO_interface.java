package com.trace.model;

import java.util.List;

public interface TraceDAO_interface {
	public void insert(TraceVO traceVO);
    public void update(TraceVO traceVO);
    public void delete(String actNo);
    public TraceVO findByPrimaryKey(String actNo);
    public List<TraceVO> getAll();
}
