package Android.activity.model;

import java.io.Serializable;
import java.sql.Date;

public class ActivityVOV2 implements Serializable {
    private static final long serialVersionUID = 1L;

    private String actNo;
    private String memNo;
    private String actName;
    private String actLoc;
    private Date actTime;
    private String actStatus;
    private Integer actMax;
    private Integer actLimit;
    private Integer timeCheck;
    private String actDesc;
    private byte[] actPic;
    private float distance;
    private int countJoin;
    private double longitude;
    private double latitude;
    private boolean joined;



	public ActivityVOV2(ActivityVO activityVO,int countJoin){
        this.actNo = activityVO.getActNo();
        this.memNo = activityVO.getMemNo();
        this.actName = activityVO.getActName();
        this.actLoc = activityVO.getActLoc();
        this.actTime = activityVO.getActTime();
        this.actStatus = activityVO.getActStatus();
        this.actMax = activityVO.getActMax();
        this.actLimit = activityVO.getActLimit();
        this.timeCheck = activityVO.getTimeCheck();
        this.actDesc =activityVO.getActDesc();
        this.countJoin = countJoin;
        this.longitude = Float.parseFloat(activityVO.getLongtitude());
        this.latitude = Float.parseFloat(activityVO.getLatitude());
    }





    public boolean isJoined() {
		return joined;
	}
	public void setJoined(boolean joined) {
		this.joined = joined;
	}
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
    public String getActName() {
        return actName;
    }
    public void setActName(String actName) {
        this.actName = actName;
    }
    public String getActLoc() {
        return actLoc;
    }
    public void setActLoc(String actLoc) {
        this.actLoc = actLoc;
    }
    public Date getActTime() {
        return actTime;
    }
    public void setActTime(Date actTime) {
        this.actTime = actTime;
    }
    public String getActStatus() {
        return actStatus;
    }
    public void setActStatus(String actStatus) {
        this.actStatus = actStatus;
    }
    public Integer getActLimit() {
        return actLimit;
    }
    public void setActLimit(Integer actLimit) {
        this.actLimit = actLimit;
    }
    public Integer getTimeCheck() {
        return timeCheck;
    }
    public void setTimeCheck(Integer timeCheck) {
        this.timeCheck = timeCheck;
    }
    public byte[] getActPic() {
        return actPic;
    }
    public void setActPic(byte[] actpic) {
        this.actPic = actpic;
    }
    public Integer getActMax() {
        return actMax;
    }
    public void setActMax(Integer actMax) {
        this.actMax = actMax;
    }
    public String getActDesc() {
        return actDesc;
    }
    public void setActDesc(String actDesc) {
        this.actDesc = actDesc;
    }

    public float getDistance() {
        return distance;
    }

    public void setDistance(float distance) {
        this.distance = distance;
    }

    public int getCountJoin() {
        return countJoin;
    }

    public void setCountJoin(int countJoin) {
        this.countJoin = countJoin;
    }
    
    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }
}
