package net.funding.open.db;

import java.sql.Timestamp;

public class MakerBean {
	
	private int makerNo;			//메이커 번호
	private String userId;			//사용자 ID
	private String name;			//메이커명(기업명)
	private String type;   			//메이커 타입 (개인, 개인사업자, 법인사업자 中  택 1)
	private String profile;			//프로필 이미지
	private String ceoName;			//대표자 이름
	private String ceoEmail; 		//대표자 이메일
	private String makerHomepage;	//메이커 문의 홈페이지
	private String makerEmail;		//메이커 문의 이메일
	private String makerTel;		//메이커 문의 전화번호
	private String bankName;		//은행
	private String accountNumber; 	//계좌번호
	private String accountHolder; 	//예금주 명
	private Timestamp regDate;		//메이커 등록일
	
	public int getMakerNo() {
		return makerNo;
	}
	public void setMakerNo(int makerNo) {
		this.makerNo = makerNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getCeoName() {
		return ceoName;
	}
	public void setCeoName(String ceoName) {
		this.ceoName = ceoName;
	}
	public String getCeoEmail() {
		return ceoEmail;
	}
	public void setCeoEmail(String ceoEmail) {
		this.ceoEmail = ceoEmail;
	}
	public String getMakerHomepage() {
		return makerHomepage;
	}
	public void setMakerHomepage(String makerHomepage) {
		this.makerHomepage = makerHomepage;
	}
	public String getMakerEmail() {
		return makerEmail;
	}
	public void setMakerEmail(String makerEmail) {
		this.makerEmail = makerEmail;
	}
	public String getMakerTel() {
		return makerTel;
	}
	public void setMakerTel(String makerTel) {
		this.makerTel = makerTel;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}
	public String getAccountHolder() {
		return accountHolder;
	}
	public void setAccountHolder(String accountHolder) {
		this.accountHolder = accountHolder;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	
}
