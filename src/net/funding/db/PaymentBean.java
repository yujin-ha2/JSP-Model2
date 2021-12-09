package net.funding.db;

import java.sql.Timestamp;

public class PaymentBean {
	private String orderId;
	private int fundingId;
	private int receiverId;
	private String userId;
	private String profile;
    private int donation;
    private int usedPoint;
    private int deliveryFee;
    private int totalAmount;
    private int finalAmount;
    private Timestamp orderDate;
    private int cancel;
    private Timestamp cancelDate;
    
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public int getFundingId() {
		return fundingId;
	}
	public void setFundingId(int fundingId) {
		this.fundingId = fundingId;
	}
	public int getReceiverId() {
		return receiverId;
	}
	public void setReceiverId(int receiverId) {
		this.receiverId = receiverId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
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
	public int getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}
	public int getFinalAmount() {
		return finalAmount;
	}
	public void setFinalAmount(int finalAmount) {
		this.finalAmount = finalAmount;
	}
	public Timestamp getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}
	public int getCancel() {
		return cancel;
	}
	public void setCancel(int cancel) {
		this.cancel = cancel;
	}
	public Timestamp getCancelDate() {
		return cancelDate;
	}
	public void setCancelDate(Timestamp cancelDate) {
		this.cancelDate = cancelDate;
	}
    
}
   
			
