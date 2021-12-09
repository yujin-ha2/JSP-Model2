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
		
		String userId = request.getParameter("userId");
		String pwd = request.getParameter("pwd");
		String type = request.getParameter("type");
		
		MemberBean mb = new MemberBean();
		mb.setId(userId);
		mb.setPwd(pwd);
		
		int result = new MemberDAO().updatePwd(mb);
		
		if(result == 0){
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('비밀번호 변경에 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
		
		String path = (type.equals("findPwd")) ? "findIdPwd.me" : "myInfo.me";
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath(path);
		
		return forward;
	}
}
