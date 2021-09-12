package net.admin.action;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.adminDAO;
import net.member.db.MemberBean;

public class AdminMemberSuspenderAction extends HttpServlet implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward(); 
		
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		
		adminDAO dao = new adminDAO();
		MemberBean bean = dao.changeStateToSuspend(id);
		
		request.setAttribute("bean", bean);
		
		forward.setRedirect(true);
		forward.setPath("AdminMemberGeneralListAction.ad");
		
		return forward;
	}

}