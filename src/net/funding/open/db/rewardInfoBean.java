package net.funding.open.db;

public class rewardInfoBean {

	private int CategoryId;		//리워드 카테고리 번호
	private int CategoryName;	//리워드카테고리 이름
	private int DetailId;		//카테고리 상세정보 번호
	private String DetailName;	//카테고리 상세정보 이름 
	private String Example;		//카테고리 상세정보 예시
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
