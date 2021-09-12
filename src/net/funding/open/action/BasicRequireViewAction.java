package net.funding.open.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.db.fundingDAO;
import net.funding.open.db.RequirementsBean;
import net.funding.open.db.fundingOpenDAO;

public class BasicRequireViewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		String mode = request.getParameter("mode");
		
		RequirementsBean bean = new fundingOpenDAO().getRequirement(fundingId);
		request.setAttribute("bean", bean);
		
		if(mode.equals("update"))
			request.setAttribute("mode", "update");
		else
			request.setAttribute("mode", "view");
		
		ActionForward forward = new ActionForward();	
		forward.setRedirect(false);
		forward.setPath("fundingOpen/projectBasicRequireView.jsp"); 
		return forward;
	}

}
