package net.funding.open.db;

public class rewardInfoBean {

	private int CategoryId;		//������ ī�װ� ��ȣ
	private int CategoryName;	//������ī�װ� �̸�
	private int DetailId;		//ī�װ� ������ ��ȣ
	private String DetailName;	//ī�װ� ������ �̸� 
	private String Example;		//ī�װ� ������ ����
	private String DetailContent;
	
	public int getCategoryId() {
		return CategoryId;
	}
	public void setCategoryId(int categoryId) {
		CategoryId = categoryId;
	}
	public int getCategoryName() {
		return CategoryName;
	}
	public void setCategoryName(int categoryName) {
		CategoryName = categoryName;
	}
	public int getDetailId() {
		return DetailId;
	}
	public void setDetailId(int detailId) {
		DetailId = detailId;
	}
	public String getDetailName() {
		return DetailName;
	}
	public void setDetailName(String detailName) {
		DetailName = detailName;
	}
	public String getExample() {
		return Example;
	}
	public void setExample(String example) {
		Example = example;
	}
	public String getDetailContent() {
		return DetailContent;
	}
	public void setDetailContent(String detailContent) {
		DetailContent = detailContent;
	}

}
