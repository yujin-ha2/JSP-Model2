package net.admin.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.adminDAO;

public class ChangeAccountAuthorityAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward(); 
		
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String currentStatus = request.getParameter("current");
		int result = (currentStatus.equals("user")) ? new adminDAO().ChangeToAdminAuthority(id) : new adminDAO().changeToUserAuthority(id);
		String Message = (currentStatus.equals("user")) ? "������ " : "����� ";
		
		if(result == 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('"+id+"���� "+Message+" ������ �����µ� �����Ͽ����ϴ�.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
		
		forward.setRedirect(true);
		forward.setPath("AdminMemberGeneralListAction.ad");
		
		return forward;
	}

}
