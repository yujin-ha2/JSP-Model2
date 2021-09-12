package net.funding.db;

public class companyFollowBean {

	private String userId;		//팔로우한 사용자 아이디
	private String companyId;	//팔로우당한 회사 아이디
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
}
