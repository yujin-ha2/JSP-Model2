package net.member.action;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.BannerBean;
import net.admin.db.NoticeBean;
import net.admin.db.adminDAO;
import net.funding.db.AllFundingInfoBean;
import net.funding.db.fundingDAO;
import net.funding.open.db.FundingInfoBean;
import net.member.db.MemberDAO;

public class MainLoadAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Vector<BannerBean> v = new adminDAO().getBannerList(); //배너 
		
		int category = 0;
		int statusVal = 0;
		int sortVal = 0;
		Vector<AllFundingInfoBean> v1 = new fundingDAO().getAllFundinglist(category, statusVal, sortVal); //최신순
		Vector<FundingInfoBean> v2 = new fundingDAO().getAllFundingRank(); //인기순(많은 펀딩 받은 글 순서)
		 
		Vector<NoticeBean> v3 = new adminDAO().getNoticelist(); 
		
		System.out.println("v1 size:" + v1.size());
		System.out.println("v2 size:" + v2.size());
		System.out.println("v3 size:" + v3.size());
		
		request.setAttribute("v", v);
		request.setAttribute("v1", v1);
		request.setAttribute("v2", v2);
		request.setAttribute("v3", v3);
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("index.jsp");
	
		return forward;
	}

}
