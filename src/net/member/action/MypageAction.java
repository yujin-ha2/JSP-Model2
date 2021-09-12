package net.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.action.StatusName;
import net.funding.open.db.RewardBean;
import net.funding.open.db.fundingOpenDAO;
import net.funding.open.db.myProjectBean;
import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class MypageAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//세션에 저장된 사용자 id 받아오기
		String id = (String)request.getSession().getAttribute("id"); 

		MemberDAO dao = new MemberDAO();
		MemberBean mb = new MemberBean();
		
		mb = new MemberDAO().InfoMember(id);
		int type = dao.UserTypeCheck(id);

		String path;
		if(type == 1) { 
			path = "member/mypage_maker.jsp";
			//확인하기
			List<myProjectBean> list = new fundingOpenDAO().getProjectList(id);
			
			for(int i=0; i<list.size(); i++) {
				String name = list.get(i).getStatus();
				list.get(i).setStatus(StatusName.get(name));
			}
			request.setAttribute("projectList", list);
			
		}else { 		 
			path = "member/mypage_support.jsp";
			int fundingCount = new MemberDAO().myFundingCount(id);
			
			request.setAttribute("fundingCount", fundingCount);
		}
		
		request.setAttribute("mb", mb);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath(path);
		
		return forward;
	}

}
