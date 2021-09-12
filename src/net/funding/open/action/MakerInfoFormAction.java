package net.funding.open.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.AllProject;
import net.funding.open.db.MakerBean;
import net.funding.open.db.fundingOpenDAO;

public class MakerInfoFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		String id = (String)request.getSession().getAttribute("id");
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		System.out.println("fundingId: " + fundingId);
		
		String path = null;
	
		AllProject project = new fundingOpenDAO().getStatus(fundingId, "maker");
		String status = project.getStatus();
		int isReg = project.getIsReg();
		
		if(status.equals("prepare") && isReg == 0) {
			//기존에 등록된 메이커인지 체크해야 함 ( 마지막에 추가)
			path = "fundingOpen/projectMakerDetailReg.jsp";
			MakerBean bean = new fundingOpenDAO().getMakerInfo(id);
			request.setAttribute("bean", bean);
			
		}else if((status.equals("prepare") && isReg == 1) || status.equals("reject")) {
			path = "fundingOpen/projectMakerDetailView.jsp";
			MakerBean bean = new fundingOpenDAO().getMakerDetail(id);
			request.setAttribute("bean", bean);
			request.setAttribute("mode", "update");
		}else {
			path = "fundingOpen/projectMakerDetailView.jsp";
			MakerBean bean = new fundingOpenDAO().getMakerDetail(id);
			request.setAttribute("bean", bean);
			request.setAttribute("mode", "view");
		}
		
		request.setAttribute("fundingId", fundingId);
		
		System.out.println("path: " + path);
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath(path);
		return forward;
	}

}
