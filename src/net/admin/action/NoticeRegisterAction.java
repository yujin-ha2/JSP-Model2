package net.admin.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.adminDAO;

public class NoticeRegisterAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String id = (String)request.getSession().getAttribute("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		int noticeId = new adminDAO().insertNotice(id, title, content);
		if(noticeId == 0) {
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('�������� �Խñ� ��Ͽ� �����Ͽ����ϴ�');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(true);
		forward.setPath("NoticeView.ad?cmd=view&noticeId="+noticeId);
		
		return forward;
	}

}
