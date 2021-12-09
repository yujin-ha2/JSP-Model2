package net.funding.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.BannerBean;
import net.funding.db.AllFundingInfoBean;
import net.funding.db.FundingDAO;

public class MainAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		List<BannerBean> banners = new ArrayList<BannerBean>();
		List<AllFundingInfoBean> lankingList = new ArrayList<AllFundingInfoBean>();
		List<AllFundingInfoBean> recentList = new ArrayList<AllFundingInfoBean>();
		
		FundingDAO dao = new FundingDAO();
		banners = dao.getBanners();
		lankingList = dao.getLankingList();
		recentList = dao.getRecentFundingList();
		
		request.setAttribute("banners", banners);
		request.setAttribute("lankingList", lankingList);
		request.setAttribute("recentList", recentList);
		
		ActionForward forward = new ActionForward(); 
		forward.setRedirect(false);
		forward.setPath("/aroma/funding/main.jsp"); 
		
		return forward;	
	}
}
