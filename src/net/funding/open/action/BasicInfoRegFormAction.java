package net.funding.open.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.AllProject;
import net.funding.open.db.FundingInfoBean;
import net.funding.open.db.FundingOpenDAO;

public class BasicInfoRegFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String path = "";
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		
		AllProject project = new FundingOpenDAO().getStatus(fundingId, "fundinginfo");
		String status = project.getStatus();
		int isReg = project.getIsReg();
		
		FundingInfoBean bean = null;
		
		if(isReg == 0) {
			path = "fundingOpen/projectBasicInfoReg.jsp";
			
		}else if(status.equals("prepare") || status.equals("reject") || status.equals("approve")) {
			path = "fundingOpen/projectBasicInfoView.jsp";
			bean = new FundingOpenDAO().getFundingInfo(fundingId);
			request.setAttribute("mode", "update");
			
		}else {
			path = "fundingOpen/projectBasicInfoView.jsp";
			bean = new FundingOpenDAO().getFundingInfo(fundingId);
			request.setAttribute("mode", "view");	
		}
		
		request.setAttribute("fundingId", fundingId);
		request.setAttribute("bean", bean);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath(path);
		return forward;
	}

}
