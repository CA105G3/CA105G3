package Android.memberChef.modle;

public class MemberChefVO implements java.io.Serializable,Comparable<MemberChefVO>{
	private static final long serialVersionUID = 1L;
		
	private String chefNo;
	private String memNo;
	private byte[] chefPic;
	private String chefDescrip;
	private String chefStatus;
	private String chefPhone;
	private String chefAddr;
	private String chefRep;
	private String chefStoreName;
	private String chefName;
	
	
	
	public String getChefStoreName() {
		return chefStoreName;
	}
	public void setChefStoreName(String chefStoreName) {
		this.chefStoreName = chefStoreName;
	}
	public String getChefName() {
		return chefName;
	}
	public void setChefName(String chefName) {
		this.chefName = chefName;
	}
	public String getChefNo() {
		return chefNo;
	}
	public void setChefNo(String chefNo) {
		this.chefNo = chefNo;
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public byte[] getChefPic() {
		return chefPic;
	}
	public void setChefPic(byte[] chefPic) {
		this.chefPic = chefPic;
	}
	public String getChefDescrip() {
		return chefDescrip;
	}
	public void setChefDescrip(String chefDescrip) {
		this.chefDescrip = chefDescrip;
	}
	public String getChefStatus() {
		return chefStatus;
	}
	public void setChefStatus(String chefStatus) {
		this.chefStatus = chefStatus;
	}
	public String getChefPhone() {
		return chefPhone;
	}
	public void setChefPhone(String chefPhone) {
		this.chefPhone = chefPhone;
	}
	public String getChefAddr() {
		return chefAddr;
	}
	public void setChefAddr(String chefAddr) {
		this.chefAddr = chefAddr;
	}
	public String getChefRep() {
		return chefRep;
	}
	public void setChefRep(String chefRep) {
		this.chefRep = chefRep;
	}
	
	
    @Override
    public int compareTo(MemberChefVO other) {
        String str1 = this.getChefNo();
        String str2 = other.getChefNo();
        return Integer.parseInt(str2.substring(4,7))-Integer.parseInt(str1.substring(4,7));
    }
}