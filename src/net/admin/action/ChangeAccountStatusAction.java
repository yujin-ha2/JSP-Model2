package net.admin.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.adminDAO;
import net.member.db.MemberBean;

public class ChangeAccountStatusAction extends HttpServlet implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward(); 
		
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String currentStatus = request.getParameter("current");
		int result = (currentStatus.equals("using")) ? new adminDAO().changeStateToSuspend(id) : new adminDAO().changeStateReturn(id);
		String Message = (currentStatus.equals("using")) ? "정지" : "사용 가능한 상태로 복구";
		
		if(result == 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('"+id+"님의 계정을 "+Message+"하는데 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
		
		forward.setRedirect(true);
		forward.setPath("MemberManagement.ad");
		
		return forward;
	}

}