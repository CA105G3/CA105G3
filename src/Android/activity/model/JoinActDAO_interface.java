package Android.activity.model;

import java.util.List;
import java.util.Set;


public interface JoinActDAO_interface {
	public boolean insert(JoinActVO joinactVO);
    public boolean update(JoinActVO joinactVO);
    public void delete(String actNo, String memNo);
    public JoinActVO findByPrimaryKey(String actNo);
    public List<JoinActVO> getAllBymemNo(String memNo);
    public List<JoinActVO> getAllByActNo(String actNo);
    public List<JoinActVO> getAll();
	
//    public Set<PersonActVO> getAll(String memNo);
}
