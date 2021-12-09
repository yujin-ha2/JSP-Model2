package net.funding.open.action;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.FundingInfoBean;

public class BasicInfoUpdateFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		request.setCharacterEncoding("UTF-8");
		
		FundingInfoBean bean = new FundingInfoBean();
		
		bean.setFundingId(Integer.parseInt(request.getParameter("fundingId")));
		bean.setTitle(request.getParameter("title"));
		String salesTarget = request.getParameter("salesTarget").replace(",", "");
		bean.setSalesTarget(Integer.parseInt(salesTarget)); 
		bean.setCategoryId(Integer.parseInt(request.getParameter("category")));
		bean.setMainImg(request.getParameter("mainImg"));
		bean.setStoryMainImg(request.getParameter("storyImg"));
		System.out.println("mainImg: " + request.getParameter("storyImg"));
		bean.setStorySummary(request.getParameter("summary"));
		bean.setStoryContent(request.getParameter("story"));
		String start = request.getParameter("startdate") + " 00:00:00.0";
		System.out.println("start: " + start);
		Timestamp startdate = Timestamp.valueOf(start);
		bean.setStartdate(startdate);
		Timestamp enddate = Timestamp.valueOf(request.getParameter("enddate") + " 23:59:59.0");
		bean.setEnddate(enddate);
		
		request.setAttribute("bean", bean);
		request.setAttribute("cmd", "update");
			
		ActionForward forward = new ActionForward();	
		forward.setRedirect(false);
		forward.setPath("fundingOpen/projectBasicInfoUpdate.jsp"); 
		return forward;
	}

}
