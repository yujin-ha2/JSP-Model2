package net.admin.db;

public class BannerBean {
	private int bannerId;
	//private String img;
	private String savedFileName;
	private String originalFileName;
	private String link;
	
	public int getBannerId() {
		return bannerId;
	}
	public void setBannerId(int bannerId) {
		this.bannerId = bannerId;
	}
	public String getSavedFileName() {
		return savedFileName;
	}
	public void setSavedFileName(String savedFileName) {
		this.savedFileName = savedFileName;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
}
