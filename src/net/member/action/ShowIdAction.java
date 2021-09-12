package net.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class ShowIdAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		String email = request.getParameter("email");	
		
		String id = new MemberDAO().findId(email);

		ActionForward forward = new ActionForward();
		
		if(id != null) {
			request.setAttribute("id", id);
			
			forward.setRedirect(false);
		    forward.setPath("member/showId.jsp");
		    return forward;
		}else {
			
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("history.back();");
			out.println("alert('�������� �ʴ� �̸��� �����Դϴ� �̸����� �ٽ� �Է����ּ���');");
			out.println("</script>");
			out.close();
			return null;
		}
		
	    
	}

}
