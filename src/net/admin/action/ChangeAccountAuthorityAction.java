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
		String Message = (currentStatus.equals("user")) ? "관리자 " : "사용자 ";
		
		if(result == 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('"+id+"님이 "+Message+" 권한을 가지는데 실패하였습니다.');");
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
