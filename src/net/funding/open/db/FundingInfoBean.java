package net.funding.open.db;

public class FundingInfoBean {

	private int fundingId;			//�ݵ���ȣ
	private String title;			//������Ʈ ����	
	private int salesTarget;		//��ǥ �ݾ�
	private String mainImg;			//��ǥ �̹���
	private int categoryId;			//������ ī�װ��� ��ȣ(��Ƽ,���̺�, ��..)
	private String storyMainImg;	//������Ʈ �Ұ�����
	private String storySummary;	//������Ʈ ���
	private String storyContent;	//������Ʈ ���丮
	
	public int getFundingId() {
		return fundingId;
	}
	public void setFundingId(int fundingId) {
		this.fundingId = fundingId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getSalesTarget() {
		return salesTarget;
	}
	public void setSalesTarget(int salesTarget) {
		this.salesTarget = salesTarget;
	}
	public String getMainImg() {
		return mainImg;
	}
	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public String getStoryMainImg() {
		return storyMainImg;
	}
	public void setStoryMainImg(String storyMainImg) {
		this.storyMainImg = storyMainImg;
	}
	public String getStorySummary() {
		return storySummary;
	}
	public void setStorySummary(String storySummary) {
		this.storySummary = storySummary;
	}
	public String getStoryContent() {
		return storyContent;
	}
	public void setStoryContent(String storyContent) {
		this.storyContent = storyContent;
	}
	
}