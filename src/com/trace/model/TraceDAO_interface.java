package com.trace.model;

import java.util.List;

public interface TraceDAO_interface {
	public void insert(TraceVO traceVO);
    public void update(TraceVO traceVO);
    public void delete(String actno);
    public TraceVO findByPrimaryKey(String actno);
    public List<TraceVO> getAll();
}
