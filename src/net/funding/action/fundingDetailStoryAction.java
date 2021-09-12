package net.funding.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.FundingInfoBean;
import net.funding.open.db.JoinFunding;
import net.funding.open.db.MakerBean;
import net.funding.open.db.ReportJoin;
import net.funding.open.db.RewardBean;
import net.funding.open.db.fundingOpenDAO;

public class fundingDetailStoryAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		String id = (String)request.getSession().getAttribute("id");
		
		FundingInfoBean dto = new fundingOpenDAO().fundingStory(fundingId);
		ReportJoin result = new fundingOpenDAO().Report(fundingId);
		JoinFunding endDate = new fundingOpenDAO().EndDate(fundingId);
		List<ReportJoin> abc  = new fundingOpenDAO().ListReport(fundingId);
		List<RewardBean> reward = new fundingOpenDAO().rewardList(fundingId);
		MakerBean maker = new fundingOpenDAO().getMaker(id);
		 
		request.setAttribute("story", dto);
		request.setAttribute("reward", reward);
		request.setAttribute("report", result);
		request.setAttribute("abc", abc);
		request.setAttribute("endDate", endDate);
		request.setAttribute("maker", maker);
				 
	    ActionForward forward = new ActionForward();
	    forward.setRedirect(false);
	    forward.setPath("funding/fundingDetail1_story.jsp");
	  
	    return forward;
	    
	}

}
