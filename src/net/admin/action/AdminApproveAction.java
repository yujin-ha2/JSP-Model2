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
		ActionForward forward = new ActionForward(); 
		
		String num = request.getParameter("num");
		String comment = (String)request.getParameter("comment");
		int btnValue = Integer.parseInt(request.getParameter("btnValue"));
		
		adminDAO dao = new adminDAO();
		dao.ApproveChangeApproveState(num, comment, btnValue);
		 
		 forward.setRedirect(false);
		 forward.setPath("AdminApproveListAction.ad");
		
		return forward;
	}

}
