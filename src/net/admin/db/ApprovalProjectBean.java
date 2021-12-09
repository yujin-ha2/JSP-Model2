package net.admin.db;

import java.sql.Timestamp;

public class ApprovalProjectBean {
	
	private int fundingId;
	private String makerName;
	private String projectTitle;
	private Timestamp submitDate;
	private Timestamp rejectDate;
	//private String projectStatus;
	
	public int getFundingId() {
		return fundingId;
	}
	public void setFundingId(int fundingId) {
		this.fundingId = fundingId;
	}
	public String getMakerName() {
		return makerName;
	}
	public void setMakerName(String makerName) {
		this.makerName = makerName;
	}
	public String getProjectTitle() {
		return projectTitle;
	}
	public void setProjectTitle(String projectTitle) {
		this.projectTitle = projectTitle;
	}
	public Timestamp getSubmitDate() {
		return submitDate;
	}
	public void setSubmitDate(Timestamp submitDate) {
		this.submitDate = submitDate;
	}
	public Timestamp getRejectDate() {
		return rejectDate;
	}
	public void setRejectDate(Timestamp rejectDate) {
		this.rejectDate = rejectDate;
	}
}
