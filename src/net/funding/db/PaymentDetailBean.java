package net.funding.db;

public class PaymentDetailBean {
	private int orderDetailId;	
	private String orderId;
	private int rewardId;
	private int quantity;

	public int getOrderDetailId() {
		return orderDetailId;
	}
	public void setOrderDetailId(int orderDetailId) {
		this.orderDetailId = orderDetailId;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public int getRewardId() {
		return rewardId;
	}
	public void setRewardId(int rewardId) {
		this.rewardId = rewardId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}
