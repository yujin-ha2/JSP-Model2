package net.funding.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.NoticeBean;
import net.admin.db.adminDAO;

public class NoticeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		int noticeId = Integer.parseInt(request.getParameter("noticeId"));
		
		NoticeBean notice = new adminDAO().getNotice(noticeId, "view");
		request.setAttribute("notice", notice);
		
		ActionForward forward = new ActionForward(); 
		forward.setRedirect(false);
		forward.setPath("funding/notice.jsp");
		
		return forward;	
	}
}
