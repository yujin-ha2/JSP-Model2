package net.funding.open.db;

import java.sql.Timestamp;

public class FundingReport {
	
	private int fundingId;
	private String fundingTitle;
	private String makerName;
	private int salesTarget;
	private int totalRevenue;		//지금까지 매출액
	private int achievement;		//달성률
	private Timestamp startDate;
	private Timestamp endDate;
	private int dayDiff;			//펀딩마감까지 남은 기간
	private String bankName;		//은행 이름
	private String accountNumber;	//계좌번호
	private String accountHolder;	//계좌예금주
	
	public int getFundingId() {
		return fundingId;
	}
	public void setFundingId(int fundingId) {
		this.fundingId = fundingId;
	}
	public String getFundingTitle() {
		return fundingTitle;
	}
	public void setFundingTitle(String fundingTitle) {
		this.fundingTitle = fundingTitle;
	}
	public String getMakerName() {
		return makerName;
	}
	public void setMakerName(String makerName) {
		this.makerName = makerName;
	}
	public int getSalesTarget() {
		return salesTarget;
	}
	public void setSalesTarget(int salesTarget) {
		this.salesTarget = salesTarget;
	}
	public int getTotalRevenue() {
		return totalRevenue;
	}
	public void setTotalRevenue(int totalRevenue) {
		this.totalRevenue = totalRevenue;
	}
	public int getAchievement() {
		return achievement;
	}
	public void setAchievement(int achievement) {
		this.achievement = achievement;
	}
	public Timestamp getStartDate() {
		return startDate;
	}
	public void setStartDate(Timestamp startDate) {
		this.startDate = startDate;
	}
	public Timestamp getEndDate() {
		return endDate;
	}
	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
	}
	public int getDayDiff() {
		return dayDiff;
	}
	public void setDayDiff(int dayDiff) {
		this.dayDiff = dayDiff;
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
}
