package net.funding.open.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.AllProject;
import net.funding.open.db.RequirementsBean;
import net.funding.open.db.FundingOpenDAO;

public class BasicRequireFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String path = "";
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));		
	
		AllProject project = new FundingOpenDAO().getStatus(fundingId, "requirement");
		String status = project.getStatus();
		int isReg = project.getIsReg();
		
		if(isReg == 0) {
			path = "fundingOpen/projectBasicRequireReg.jsp";
		}else if(status.equals("prepare") || status.equals("reject")) {
			path = "fundingOpen/projectBasicRequireView.jsp";
			RequirementsBean bean = new FundingOpenDAO().getRequirement(fundingId);
			request.setAttribute("bean", bean);
			request.setAttribute("mode", "update");
		}else {
			path = "fundingOpen/projectBasicRequireView.jsp";
			RequirementsBean bean = new FundingOpenDAO().getRequirement(fundingId);
			request.setAttribute("bean", bean);
			request.setAttribute("mode", "view");
		}
		
		request.setAttribute("fundingId", fundingId);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath(path); //등록페이지
		
		return forward;
	}

}
