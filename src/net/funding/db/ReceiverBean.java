package net.funding.db;

public class ReceiverBean {
	private int receiverId;
	private String orderId; 
	private String name;
    private String phone;
    private String postCode;
    private String address;
    private String detailAddress;
    private String Request;
    private String cardNumber;
    private String ExpirationDate;
    private String password;
    private String birth;
    
	public int getReceiverId() {
		return receiverId;
	}
	public void setReceiverId(int receiverId) {
		this.receiverId = receiverId;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public String getRequest() {
		return Request;
	}
	public void setRequest(String request) {
		Request = request;
	}
	public String getCardNumber() {
		return cardNumber;
	}
	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}
	public String getExpirationDate() {
		return ExpirationDate;
	}
	public void setExpirationDate(String expirationDate) {
		ExpirationDate = expirationDate;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
}
