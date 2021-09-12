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
		ActionForward forward = new ActionForward();

		Vector<MemberBean> g = new adminDAO().getGeneralMemberList(); 
		Vector<MemberBean> se = new adminDAO().getSellerMemberList(); 
		Vector<MemberBean> su = new adminDAO().getSuspendMemberList();
		  
		request.setAttribute("g", g); 
		request.setAttribute("se", se);
 	    request.setAttribute("su", su);

		forward.setRedirect(false);
		forward.setPath("admin/adminMember.jsp");

		return forward;

	}

}