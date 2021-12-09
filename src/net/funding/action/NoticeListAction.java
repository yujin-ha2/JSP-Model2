package net.funding.action;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.NoticeBean;
import net.admin.db.adminDAO;

public class NoticeListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String keyfield = "title";
		String keyword = "";
		int currentPage = 1;
		
		if(request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
			keyfield = request.getParameter("keyfield");
		}	
		
		if(request.getParameter("selectPage") != null) {
			//일단은 next, prev 제외하고 해보자
			currentPage = Integer.parseInt(request.getParameter("selectPage"));
		}
		
		adminDAO dao = new adminDAO();
		
		Vector<NoticeBean> noticeVector = dao.getNoticeList(keyfield, keyword, currentPage);
		
		int totalCount = dao.getNoticeTotalCount(keyfield, keyword);
		int totalPage = (int)Math.ceil(totalCount/5.0); // =전체 게시물 개수/한 페이지 당 출력되는 페이지 개수
		int startPage = currentPage-(currentPage-1)%5; //1, 6, 11, 16
		int lastPage = startPage + 4; //
		
		if(lastPage >= totalPage)
			lastPage = totalPage;
		
		System.out.println("totalCount: " + totalCount + ", totalPage: " + totalPage + ", currentPage: " + currentPage);
		System.out.println("startPage: " + startPage + ", lastPage: " + lastPage);
		
		request.setAttribute("vector", noticeVector);
		request.setAttribute("startPage", startPage);
		request.setAttribute("lastPage", lastPage);
		request.setAttribute("currentPage", currentPage);
		
		ActionForward forward = new ActionForward(); 
		forward.setRedirect(false);
		forward.setPath("funding/noticeList.jsp");
		
		return forward;	
	}

}
