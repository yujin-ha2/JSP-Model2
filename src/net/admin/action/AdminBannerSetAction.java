package net.admin.action;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.BannerBean;
import net.admin.db.adminDAO;
import net.funding.open.db.FundingInfoBean;

public class AdminBannerSetAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		 ActionForward forward = new ActionForward(); 
		
		 adminDAO dao = new adminDAO();
		 Vector<BannerBean> v = dao.getBannerList(); 
		 
		 request.setAttribute("v", v);
		 
		 forward.setRedirect(false);
		 forward.setPath("admin/adminBanner.jsp");
		
		return forward;
	}

}
