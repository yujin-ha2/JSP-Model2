package net.funding.open.db;

public class FundingStatistic {
	
	private String date;			//��¥(yy-MM)
	private int actual;				//�����
	private String rewardOption;	//������ �ɼ� �̸�
	private int quantity;			//�� �ǸŰ���
	
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
