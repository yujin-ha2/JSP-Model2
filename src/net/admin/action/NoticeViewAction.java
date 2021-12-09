package net.admin.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.NoticeBean;
import net.admin.db.adminDAO;
import net.funding.open.db.AllProject;
import net.funding.open.db.RequirementsBean;
import net.funding.open.db.FundingOpenDAO;

public class NoticeViewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("update", "admin/adminNoticeUpdate.jsp");
		map.put("view", "admin/adminNoticeView.jsp");
			
		int noticeId = Integer.parseInt(request.getParameter("noticeId"));	
		String path = request.getParameter("cmd");
			
		NoticeBean bean = new adminDAO().getNotice(noticeId, path);
		request.setAttribute("bean", bean);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath(map.get(path)); //등록페이지
		
		return forward;
	}

}
