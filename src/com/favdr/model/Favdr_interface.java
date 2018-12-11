package com.favdr.model;

import java.util.*;

public interface Favdr_interface {
	
	public void insert(FavdrVO favdrVO);
	public void update(FavdrVO favdrVO);
	public void delete(FavdrVO favdrVO);
	public FavdrVO findByPrimaryKey(String memno);
	public List<FavdrVO> getAll();

}
