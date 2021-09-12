package net.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class MemberDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		
		MemberBean mb = new MemberBean();
		mb.setId(id);
		mb.setPwd(pwd);
		
		int result = new MemberDAO().deleteMember(mb);
		
		if(result == 1) {
			//���ǰ� �ʱ�ȭ
			request.getSession().invalidate();
			
			ActionForward forward = new ActionForward();
			forward.setPath("MyInfoEdit.me");
			forward.setRedirect(false);
			
			return forward;
		}else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('ȸ�� Ż�� �����Ͽ����ϴ� ��й�ȣ�� �ٽ� �Է����ּ���.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
	}

}
