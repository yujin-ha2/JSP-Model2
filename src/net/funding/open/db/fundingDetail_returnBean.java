package net.funding.open.db;

public class fundingDetail_returnBean {
	
	private int fundingId;
	private int categoryId;
	private int DetailId;
	private String DetailContent;
	private String regDate;
	private String updateDate;
	private String DetailName;
	private String endDate;
	
	
	public String getDetailName() {
		return DetailName;
	}
	public void setDetailName(String detailName) {
		DetailName = detailName;
	}
	public int getFundingId() {
		return fundingId;
	}
	public void setFundingId(int fundingId) {
		this.fundingId = fundingId;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public int getDetailId() {
		return DetailId;
	}
	public void setDetailId(int detailId) {
		DetailId = detailId;
	}
	public String getDetailContent() {
		return DetailContent;
	}
	public void setDetailContent(String detailContent) {
		DetailContent = detailContent;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
	
	
}
