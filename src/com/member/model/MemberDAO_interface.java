package com.member.model;

import java.util.List;

public interface MemberDAO_interface {
	public void insert(MemberVO memberVO);
    public void update(MemberVO memberVO);
    public void delete(MemberVO memberVO);
    public MemberVO findByPrimaryKey(String memNo);
    public List<MemberVO> getAll();
}
