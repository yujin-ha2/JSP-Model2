package net.funding.action;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.db.AllFundingInfoBean;
import net.funding.db.FundingDAO;
import net.funding.open.db.FundingInfoBean;
import net.funding.open.db.MakerBean;
import net.funding.open.db.RewardBean;
import net.member.db.MemberBean;

public class FundingCommunityAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		 
		 /*
		(기본)
		달성률, 현재까지의 총 펀딩금액, 서포터 수 (완)
		메이커 이름, 메이커 이메일/문의전화/홈페이지 (완)
		메이커와의 팔로우 여부 (완)
		리워드 종류 및 ajax (완)
		(new)
		(부모)댓글 전체 개수
		댓글별 작성자ID, 내용, 작성날짜 
		ajax로 부모댓글 답변 버튼 선택시 자식댓글 리스트 
		*/
		 request.setCharacterEncoding("UTF-8");
		 
		 FundingDAO dao = new FundingDAO();
		 int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		 
		 FundingInfoBean fundingInfo = dao.getfundingStory(fundingId);
		 MakerBean maker = dao.getMaker(fundingId);
		 List<RewardBean> rewardList = dao.getRewardList(fundingId);
		 AllFundingInfoBean report = dao.getFundingReport(fundingId);	//펀딩 매출 정보
		
		 Timestamp currentDate = new Timestamp(System.currentTimeMillis());
		 Timestamp endDate = fundingInfo.getEnddate();
		 long calDate = endDate.getTime() - currentDate.getTime(); 
         long calDayDiff = calDate / ( 24*60*60*1000); 
         
         if(request.getSession().getAttribute("id") != null) {
        	 String userId = (String)request.getSession().getAttribute("id");
			 int check = dao.follow(maker.getUserId(), userId); 	   		//메이커와 사용자의 팔로우 여부
			 MemberBean member = dao.getMemberTypeInfo(userId);				//현재 로그인한 사용자 정보 가져오
			 request.setAttribute("check", check);
			 request.setAttribute("member", member);
		 }
         
         List<CommunityBean> commentList = dao.getComment(fundingId);	//댓글리스트 가져오기
       
         request.setAttribute("fundingInfo", fundingInfo);
		 request.setAttribute("maker", maker);
		 request.setAttribute("rewardList", rewardList);
		 request.setAttribute("calDayDiff", calDayDiff+1);
		 request.setAttribute("report", report);
		 request.setAttribute("commentList", commentList);
		 
	     ActionForward forward = new ActionForward();
	     forward.setRedirect(false);
	     forward.setPath("funding/fundingCommunity.jsp");
	  
	     return forward;
	}

}
