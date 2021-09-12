package net.funding.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.JoinFunding;
import net.funding.open.db.MakerBean;
import net.funding.open.db.ReportJoin;
import net.funding.open.db.RewardBean;
import net.funding.open.db.fundingDetail_returnBean;
import net.funding.open.db.fundingOpenDAO;

public class fundingDetailInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		 int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		 String id = (String)request.getSession().getAttribute("id");
		 
		 ReportJoin result = new fundingOpenDAO().Report(fundingId);  //펀딩현황 메소드 재사용
		 JoinFunding endDate = new fundingOpenDAO().EndDate(fundingId);
		 List<fundingDetail_returnBean> detail = new fundingOpenDAO().Detail_return(fundingId);
		 List<ReportJoin> abc  = new fundingOpenDAO().ListReport(fundingId); //펀딩현황 메소드 재사용
		 MakerBean maker = new fundingOpenDAO().getMaker(id);
		 List<RewardBean> reward = new fundingOpenDAO().rewardList(fundingId); //펀딩현황 메소드 재사용
		 
		 request.setAttribute("reward", reward);
		 request.setAttribute("maker", maker);
		 request.setAttribute("report", result);
		 request.setAttribute("abc", abc);
		 request.setAttribute("re", detail);
		 request.setAttribute("endDate", endDate);
		 request.setAttribute("fundingId", fundingId);
		
	     ActionForward forward = new ActionForward();
	     forward.setRedirect(false);
	     forward.setPath("funding/fundingDetail2_info.jsp");
	  
	     return forward;
	}

}
