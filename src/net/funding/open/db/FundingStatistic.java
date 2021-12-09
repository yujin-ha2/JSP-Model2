package net.funding.open.db;

public class FundingStatistic {
	
	private String date;			//날짜(yy-MM)
	private int actual;				//매출액
	private String rewardOption;	//리워드 옵션 이름
	private int quantity;			//총 판매개수
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getActual() {
		return actual;
	}
	public void setActual(int actual) {
		this.actual = actual;
	}
	public String getRewardOption() {
		return rewardOption;
	}
	public void setRewardOption(String rewardOption) {
		this.rewardOption = rewardOption;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
}
