package net.funding.db;

import java.sql.Timestamp;

public class AllFundingInfoBean {
	private int id;
	private int fundingId;			//펀딩번호
	private String title;			//프로젝트 제목	
	private int salesTarget;		//목표 금액
	private String mainImg;			//대표 이미지
	private int categoryId;			//리워드 카테고리 번호(뷰티,베이비, 등..)
	private String storyMainImg;	//프로젝트 소개사진
	private String storySummary;	//프로젝트 요약
	private String storyContent;	//프로젝트 스토리
	private Timestamp startDate;	//프로젝트 시작일
	private Timestamp endDate;		//프로젝트 종료일
	private int status;				//프로젝트 상태
	private String comment;			//반려 이유
	private String makerId;			//사용자 ID
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getFundingId() {
		return fundingId;
	}
	public void setFundingId(int fundingId) {
		this.fundingId = fundingId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getSalesTarget() {
		return salesTarget;
	}
	public void setSalesTarget(int salesTarget) {
		this.salesTarget = salesTarget;
	}
	public String getMainImg() {
		return mainImg;
	}
	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public String getStoryMainImg() {
		return storyMainImg;
	}
	public void setStoryMainImg(String storyMainImg) {
		this.storyMainImg = storyMainImg;
	}
	public String getStorySummary() {
		return storySummary;
	}
	public void setStorySummary(String storySummary) {
		this.storySummary = storySummary;
	}
	public String getStoryContent() {
		return storyContent;
	}
	public void setStoryContent(String storyContent) {
		this.storyContent = storyContent;
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getMakerId() {
		return makerId;
	}
	public void setMakerId(String makerId) {
		this.makerId = makerId;
	}
}
