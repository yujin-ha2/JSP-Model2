package net.admin.action;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.NoticeBean;
import net.admin.db.adminDAO;

public class AdminNoticeListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
ActionForward forward = new ActionForward(); 
		
		Vector<NoticeBean> v = new adminDAO().getNoticelist(); 
		 
		request.setAttribute("v", v);
		 
		forward.setRedirect(false);
		forward.setPath("admin/adminNotice.jsp");
		
		return forward;
	}

}
