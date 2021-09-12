package net.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class MyInfoUpdateAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String id = request.getParameter("id");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		
		MemberBean mb = new MemberBean();
		mb.setId(id);
		mb.setPhone(phone);
		mb.setEmail(email);
		
		int result = new MemberDAO().updateMember(mb);
		
		ActionForward forward = new ActionForward();
		if(result ==1){
			forward.setRedirect(true);
			forward.setPath("MyInfoEdit.me");
		}else{
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('정보 변경에 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		return forward;
	}

}
