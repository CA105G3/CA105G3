package Android.memberChef.modle;

import java.util.List;

public interface MemberChefDAO_interface {
	public void insert(MemberChefVO memberChefVO); 
	public void update(MemberChefVO memberChefVO); 
	public void delete(String chefNo); 
	public MemberChefVO findByPrimaryKey(String chefNo);
	public List<MemberChefVO> getAll();
	byte[] getImage(String isbn);
}
