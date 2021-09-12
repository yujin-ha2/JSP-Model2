package net.funding.open.db;

import java.sql.Timestamp;

public class RewardBean {

	private String rewardId;			//?
	private int fundingId;				//�ݵ� ��ȣ
	private int price;					//�ݾ�	
	private String name;				//�������
	private String rewardDetail;		//������
	private String rewardOption;		//�ɼ�����
	private int deliveryFee;			//��ۺ�
	private int salesQuantity;			//���� ����
	private int Quantity;				//?
	private Timestamp deliveryDate;		//��� ������
	
	public String getRewardId() {
		return rewardId;
	}
	public void setRewardId(String rewardId) {
		this.rewardId = rewardId;
	}
	public int getFundingId() {
		return fundingId;
	}
	public void setFundingId(int fundingId) {
		this.fundingId = fundingId;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRewardDetail() {
		return rewardDetail;
	}
	public void setRewardDetail(String rewardDetail) {
		this.rewardDetail = rewardDetail;
	}
	public String getRewardOption() {
		return rewardOption;
	}
	public void setRewardOption(String rewardOption) {
		this.rewardOption = rewardOption;
	}
	public int getDeliveryFee() {
		return deliveryFee;
	}
	public void setDeliveryFee(int deliveryFee) {
		this.deliveryFee = deliveryFee;
	}
	public int getQuantity() {
		return Quantity;
	}
	public void setQuantity(int quantity) {
		Quantity = quantity;
	}
	public int getSalesQuantity() {
		return salesQuantity;
	}
	public void setSalesQuantity(int salesQuantity) {
		this.salesQuantity = salesQuantity;
	}
	public Timestamp getDeliveryDate() {
		return deliveryDate;
	}
	public void setDeliveryDate(Timestamp deliveryDate) {
		this.deliveryDate = deliveryDate;
	}
}
