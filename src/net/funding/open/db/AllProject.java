package net.funding.open.db;

import java.sql.Timestamp;

public class AllProject {
	
	private int fundingId;
	private String userId;
	private int makerNo;
	private int requirement;
	private int fundinginfo;
	private int reward;
	private int rewarddetail;
	private int maker;
	private int isReg;
	private Timestamp startDate;
	private Timestamp endDate;
	private String status;
	private String comment;
	private Timestamp regDate;
	
	public int getFundingId() {
		return fundingId;
	}
	public void setFundingId(int fundingId) {
		this.fundingId = fundingId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getMakerNo() {
		return makerNo;
	}
	public void setMakerNo(int makerNo) {
		this.makerNo = makerNo;
	}
	public int getRequirement() {
		return requirement;
	}
	public void setRequirement(int requirement) {
		this.requirement = requirement;
	}
	public int getFundinginfo() {
		return fundinginfo;
	}
	public void setFundinginfo(int fundinginfo) {
		this.fundinginfo = fundinginfo;
	}
	public int getReward() {
		return reward;
	}
	public void setReward(int reward) {
		this.reward = reward;
	}
	public int getRewarddetail() {
		return rewarddetail;
	}
	public void setRewarddetail(int rewarddetail) {
		this.rewarddetail = rewarddetail;
	}
	public int getMaker() {
		return maker;
	}
	public void setMaker(int maker) {
		this.maker = maker;
	}
	public int getIsReg() {
		return isReg;
	}
	public void setIsReg(int isReg) {
		this.isReg = isReg;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

}

