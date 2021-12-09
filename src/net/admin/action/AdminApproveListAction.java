package net.admin.action;

import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.ApprovalProjectBean;
import net.admin.db.adminDAO;
import net.funding.db.AllFundingInfoBean;

public class AdminApproveListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF-8");
		
		List<ApprovalProjectBean> approvalList = new adminDAO().getApprovelist(); 
		request.setAttribute("approvalList", approvalList);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("admin/adminApprove.jsp");
		
		return forward;
	}

}
