package com.favdr.model;

import java.util.*;

public interface Favdr_interface {
	
	public void insert(FavdrVO favdrVO);
	public void update(FavdrVO favdrVO);
	public void delete(FavdrVO favdrVO);
	public List<FavdrVO> findByPrimaryKey(String memNo);
	public List<FavdrVO> getAll();

}
