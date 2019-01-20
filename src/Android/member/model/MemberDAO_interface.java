package Android.member.model;

import java.util.*;

public interface MemberDAO_interface {
	public boolean insert(MemberVO memberVO);
    public boolean update(MemberVO memberVO);
    public boolean delete(String memberNo);
    public boolean isMember(String memId,String pwd);
    public boolean isUserIdExist(String memId);
    public MemberVO findById(String memId);
    public MemberVO findByPrimaryKey(String memNo);
    public List<MemberVO> getAll();
    byte[] getImage(String isbn);
}
