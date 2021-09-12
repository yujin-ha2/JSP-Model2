package net.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class PasswordUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String id = (String)request.getParameter("id");
		String pwd = (String)request.getParameter("pwd");
		System.out.println("id:" + id + ", pwd:" + pwd);
		
		MemberBean mb = new MemberBean();
		mb.setId(id);
		mb.setPwd(pwd);
		
		int result = new MemberDAO().updatePwd(mb);
		
		if(result == 1){
			ActionForward forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("MyInfoEdit.me");
			return forward;
		}else {
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('비밀번호 변경에 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
		
	}

}
