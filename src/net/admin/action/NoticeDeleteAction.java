package net.admin.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.adminDAO;

public class NoticeDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		int noticeId = Integer.parseInt(request.getParameter("noticeId"));
		
		int result = new adminDAO().deleteNotice(noticeId);
		String message = (result==0) ? "공지사항 게시글 삭제에 실패하였습니다" : "공지사항 게시글이 삭제되었습니다";
		String nextPage = (result==0) ? "history.back();" : "location.href='NoticeList.ad';";
		
		PrintWriter out=response.getWriter();
		out.println("<script>");
		out.println("alert("+message+");");
		out.println(nextPage);
		out.println("</script>");
		out.close();
		
		return null;
		
		/*
		ActionForward forward=new ActionForward();
		forward.setRedirect(true);
		forward.setPath("NoticeList.ad");
		
		return forward;
		*/
	}
}
