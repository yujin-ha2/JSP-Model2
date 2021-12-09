package net.funding.open.db;

public class FundingResult {

	private int donation;
	private int usedPoint;
	private int deliveryFee;
	private int finalAmount;
	private int commission;
	
	public int getDonation() {
		return donation;
	}
	public void setDonation(int donation) {
		this.donation = donation;
	}
	public int getUsedPoint() {
		return usedPoint;
	}
	public void setUsedPoint(int usedPoint) {
		this.usedPoint = usedPoint;
	}
	public int getDeliveryFee() {
		return deliveryFee;
	}
	public void setDeliveryFee(int deliveryFee) {
		this.deliveryFee = deliveryFee;
	}
	public int getFinalAmount() {
		return finalAmount;
	}
	public void setFinalAmount(int finalAmount) {
		this.finalAmount = finalAmount;
	}
	public int getCommission() {
		return commission;
	}
	public void setCommission(int commission) {
		this.commission = commission;
	}
}
