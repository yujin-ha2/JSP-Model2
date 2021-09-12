package net.funding.open.db;

public class rewardInfoBean {

	private int CategoryId;		//리워드 카테고리 번호
	private int CategoryName;	//리워드카테고리 이름
	private int DetailId;		//리워드 카테고리별 상세정보 번호
	private int DetailName;		//리워드 카테고리별  상세정보 이름
	
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
