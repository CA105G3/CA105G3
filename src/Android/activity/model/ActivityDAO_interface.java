package Android.activity.model;

import java.util.List;
import java.util.Set;

//import com.impression.model.ImpressionVO;


public interface ActivityDAO_interface {
	public void insert(ActivityVO activityVO);
    public void update(ActivityVO activityVO);
    public void delete(String actNo);
    public ActivityVO findByPrimaryKey(String actNo);
    byte[] getImage(String isbn);
    
    public List<ActivityVO> getAll();
//    public Set<ImpressionVO> getmembyactno(String actNo);
}
