package net.funding.open.action;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.AllProject;
import net.funding.open.db.FundingOpenDAO;
import net.funding.open.db.FundingReport;
import net.funding.open.db.FundingStatistic;

public class FundingReportAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));

		FundingOpenDAO dao = new FundingOpenDAO();
		AllProject project = dao.getStatus(fundingId, "");
		if(!project.getStatus().equals("start") && !project.getStatus().equals("success") && !project.getStatus().equals("fail")) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('�ݵ��� ���۵Ǿ�� ��밡�� �մϴ�.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
		
		FundingReport report = dao.getFundingReportInfo(fundingId);				//�ݵ� ��Ȳ �⺻ ����
		int todayRevenue = dao.getTodayRevenue(fundingId);						//������ �����
		List<FundingStatistic> byDate = dao.getQuantityByDate(fundingId);		//��¥�� �ݵ���Ȳ
		List<FundingStatistic> byOption = dao.getQuantityByOption(fundingId);	//�ɼǺ� �ݵ���Ȳ
		List<FundingStatistic> today = dao.getTodayQuantity(fundingId);			//���� �ɼǺ� �ݵ���Ȳ
		
		request.setAttribute("report", report);
		request.setAttribute("todayRevenue", todayRevenue);
		request.setAttribute("byDate", byDate);
		request.setAttribute("byOption", byOption);
		request.setAttribute("today", today);
		
		 ActionForward forward = new ActionForward();
		 forward.setRedirect(false);
		 forward.setPath("fundingOpen/fundingReport.jsp");
		 return forward;
	}

}
