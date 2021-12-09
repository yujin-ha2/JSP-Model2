package net.admin.action;

import java.util.Vector;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.adminDAO;
import net.member.db.MemberBean;

public class AdminMemberGeneralListAction extends HttpServlet implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");

		Vector<MemberBean> generalMembers = new adminDAO().getGeneralMemberList(); 
		Vector<MemberBean> sellerMembers = new adminDAO().getSellerMemberList(); 
		Vector<MemberBean> suspendedMembers = new adminDAO().getSuspendMemberList();
		Vector<MemberBean> adminMembers = new adminDAO().getAdminMemberList();
		  
		request.setAttribute("generalMembers", generalMembers); 
		request.setAttribute("sellerMembers", sellerMembers);
 	    request.setAttribute("suspendedMembers", suspendedMembers);
 	    request.setAttribute("adminMembers", adminMembers);

 	    ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("admin/adminMember.jsp");

		return forward;

	}

}