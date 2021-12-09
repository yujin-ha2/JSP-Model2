package net.funding.open.db;

public class RewardBean {

	private int rewardId;				//리워드 번호
	private int fundingId;				//펀딩 번호
	private int price;					//금액	
	private String name;				//리워드명
	private String rewardDetail;		//상세조건
	private String rewardOption;		//옵션조건
	private int deliveryFee;			//배송비
	private int salesQuantity;			//제한 수량
	private int remainingQuantity;		//판매되고 남은 수량
	private String deliveryDate;		//배송 시작일
	
	public int getRewardId() {
		return rewardId;
	}
	public void setRewardId(int rewardId) {
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
	public int getSalesQuantity() {
		return salesQuantity;
	}
	public void setSalesQuantity(int salesQuantity) {
		this.salesQuantity = salesQuantity;
	}
	public int getRemainingQuantity() {
		return remainingQuantity;
	}
	public void setRemainingQuantity(int remainingQuantity) {
		this.remainingQuantity = remainingQuantity;
	}
	public String getDeliveryDate() {
		return deliveryDate;
	}
	public void setDeliveryDate(String deliveryDate) {
		this.deliveryDate = deliveryDate;
	}
}
