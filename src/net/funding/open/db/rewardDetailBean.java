package net.funding.open.db;

public class rewardDetailBean {

	private int fundingId;			//�ݵ���ȣ
	private int categoryId;			//ī�װ� ��ȣ
	private String DetailName;		//������ ��
	private String DetailContent; 	//������ ����
	
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
