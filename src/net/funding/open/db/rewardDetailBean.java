package net.funding.open.db;

public class rewardDetailBean {

	private int fundingId;			//펀딩번호
	private int categoryId;			//카테고리 번호
	private String DetailName;		//상세정보 명
	private String DetailContent; 	//상세정보 내용
	
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
	public String getDetailName() {
		return DetailName;
	}
	public void setDetailName(String detailName) {
		DetailName = detailName;
	}
	public String getDetailContent() {
		return DetailContent;
	}
	public void setDetailContent(String detailContent) {
		DetailContent = detailContent;
	}
}
