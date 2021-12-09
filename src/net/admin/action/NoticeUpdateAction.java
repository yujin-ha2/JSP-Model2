package net.admin.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.adminDAO;

public class NoticeUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		int noticeId = Integer.parseInt(request.getParameter("noticeId"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		System.out.println("title: " + title + ", content: " + content + ", noticeId: " + noticeId);
		
		int result = new adminDAO().updateNotice(noticeId, title, content);
		if(result == 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('공지사항 게시글 수정에 실패하였습니다');");
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
