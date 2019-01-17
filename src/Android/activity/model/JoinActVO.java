package Android.activity.model;

public class JoinActVO implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	private String actNo;
	private String memNo;
	private int joinStatus;
	
	
	public String getActNo() {
		return actNo;
	}
	public void setActNo(String actNo) {
		this.actNo = actNo;
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public int getJoinStatus() {
		return joinStatus;
	}
	public void setJoinStatus(int joinStatus) {
		this.joinStatus = joinStatus;
	}
	
}
