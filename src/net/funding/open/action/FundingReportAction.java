package net.funding.open.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.ReportJoin;
import net.funding.open.db.RewardBean;
import net.funding.open.db.fundingOpenDAO;
import net.funding.open.db.fundingorderBean;

public class FundingReportAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		 ReportJoin dto = new ReportJoin();
		 int fundingId = Integer.parseInt(request.getParameter("fundingId"));

		 ReportJoin result =  new fundingOpenDAO().Report(fundingId);
		 request.setAttribute("report", result);
		
		 List<ReportJoin> abc = new fundingOpenDAO().ListReport(fundingId);
		 List<fundingorderBean> repo = new fundingOpenDAO().reportDate(fundingId);
		 List<fundingorderBean> repo7 = new fundingOpenDAO().report7Date(fundingId);
		 List<RewardBean> reward = new fundingOpenDAO().rewardList(fundingId);
		 List<fundingorderBean> chartDate = new fundingOpenDAO().chartDate(fundingId);
		 
		 request.setAttribute("chartDate", chartDate);
		 request.setAttribute("reward", reward);
		 request.setAttribute("repo", repo);
		 request.setAttribute("repo7", repo7);
		 
		 request.setAttribute("abc", abc);
		 
		 request.setAttribute("fundingId", fundingId);
		
		 ActionForward forward = new ActionForward();
		 forward.setRedirect(false);
		 forward.setPath("fundingOpen/fundingReport.jsp");
		 return forward;
	}

}
