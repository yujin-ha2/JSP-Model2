package net.funding.open.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.AllProject;
import net.funding.open.db.FundingInfoBean;
import net.funding.open.db.fundingOpenDAO;

public class BasicInfoRegFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		System.out.println("기본정보/스토리 : " + fundingId);
		
		String path = "";
		
		AllProject project = new fundingOpenDAO().getStatus(fundingId, "fundinginfo");
		String status = project.getStatus();
		int isReg = project.getIsReg();
		
		if(status.equals("prepare") && isReg == 0) {
			path = "fundingOpen/projectBasicInfoReg.jsp";
			
		}else if((status.equals("prepare") && isReg == 1) || status.equals("reject") || status.equals("approve") || status.equals("apply")) {
			path = "fundingOpen/projectBasicInfoView.jsp";
			FundingInfoBean bean = new fundingOpenDAO().getFundingInfo(fundingId);
			request.setAttribute("bean", bean);
			request.setAttribute("mode", "update");
			
		}else {
			path = "fundingOpen/projectBasicInfoView.jsp";
			FundingInfoBean bean = new fundingOpenDAO().getFundingInfo(fundingId);
			request.setAttribute("bean", bean);
			request.setAttribute("mode", "view");
		}
		
		request.setAttribute("fundingId", fundingId);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath(path);
		return forward;
	}

}
