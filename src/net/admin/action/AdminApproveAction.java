package net.admin.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.adminDAO;

public class AdminApproveAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		String comment = (String)request.getParameter("comment");
		System.out.println("comment: " + comment);
		String projectStatus = request.getParameter("projectStatus");
		
		int result = new adminDAO().ApproveChangeApproveState(fundingId, comment, projectStatus);
		 
		ActionForward forward = new ActionForward(); 
		forward.setRedirect(false);  
		forward.setPath("AdminApproveListAction.ad");
		return forward;
	}

}
