package net.funding.open.db;

import java.sql.Timestamp;

public class MakerBean {
	
	private int makerNo;			//����Ŀ ��ȣ
	private String userId;			//����� ID
	private String name;			//����Ŀ��(�����)
	private String type;   			//����Ŀ Ÿ�� (����, ���λ����, ���λ���� ��  �� 1)
	private String profile;			//������ �̹���
	private String ceoName;			//��ǥ�� �̸�
	private String ceoEmail; 		//��ǥ�� �̸���
	private String makerHomepage;	//����Ŀ ���� Ȩ������
	private String makerEmail;		//����Ŀ ���� �̸���
	private String makerTel;		//����Ŀ ���� ��ȭ��ȣ
	private String bankName;		//����
	private String accountNumber; 	//���¹�ȣ
	private String accountHolder; 	//������ ��
	private Timestamp regDate;		//����Ŀ �����
	
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
