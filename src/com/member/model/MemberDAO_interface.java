package com.member.model;

import java.util.*;

import com.member.model.MemberVO;

public interface MemberDAO_interface {
	public void insert(MemberVO memberVO);
    public void update(MemberVO memberVO);
    public void delete(String memberNo);
    public MemberVO findByPrimaryKey(String memberNo);
    public List<MemberVO> getAll();
}
