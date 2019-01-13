package com.member.model;

import java.util.*;

import com.license.model.LicenseVO;
import com.member.model.MemberVO;

public interface MemberDAO_interface {
	public void insert(MemberVO memberVO);
    public void update(MemberVO memberVO);
    public void delete(String memberNo);
    public MemberVO findByPrimaryKey(String memberNo);
    public List<MemberVO> getAll();
    public MemberVO findByID(String memid);
    public MemberVO UpdateForBasicRecord(MemberVO memberVO);
    public void UpdateVerify(String memno);
    public void UpdateLogin(String memno,java.sql.Timestamp lastlogin);
    //license驗證需要
    public Set<LicenseVO> findByMemNo(String memNo);
    //license更改member的ident狀態
    public void changeident(String memNo,String ident);
}
