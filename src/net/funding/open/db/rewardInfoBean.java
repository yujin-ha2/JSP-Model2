package net.funding.open.db;

public class rewardInfoBean {

	private int CategoryId;		//������ ī�װ� ��ȣ
	private int CategoryName;	//������ī�װ� �̸�
	private int DetailId;		//������ ī�װ��� ������ ��ȣ
	private int DetailName;		//������ ī�װ���  ������ �̸�
	
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
	public int getDetailName() {
		return DetailName;
	}
	public void setDetailName(int detailName) {
		DetailName = detailName;
	}
}
