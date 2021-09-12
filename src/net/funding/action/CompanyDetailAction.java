package net.funding.action;

import java.util.Vector;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.action.Action;
import net.action.ActionForward;
import net.funding.db.AllFundingInfoBean;
import net.funding.db.fundingDAO;

public class CompanyDetailAction extends HttpServlet implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		ActionForward forward = new ActionForward(); 
		
		HttpSession session=request.getSession();
		String id = (String)session.getAttribute("id");
		String companyId = request.getParameter("companyId");
		String companyName = request.getParameter("companyName");
		
		Vector<AllFundingInfoBean> v = new fundingDAO().getInformation(companyId); //메이커가 진행한 모든 펀딩 정보
		int check = new fundingDAO().follow(companyId, id); 		   //메이커와 사용자의 팔로우 여부
		int followCount = new fundingDAO().countFollow(companyId);	   //메이커의 팔로워 수
		//int fundingCount = fdao.countFunding(companyId);			   //메이커의 펀딩 개수
		
		request.setAttribute("v", v);
//		request.setAttribute("fundingCount", v.size());
		request.setAttribute("check", check);
		request.setAttribute("followCount", followCount);
		
		forward.setRedirect(false);
		forward.setPath("funding/companyDetail.jsp?companyId="+companyId+"&companyName="+companyName);	
		return forward;
	
	}

}
