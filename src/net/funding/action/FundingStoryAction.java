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
import net.funding.open.db.FundingOpenDAO;

public class FundingStoryAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF-8");
		
		String userId = (String)request.getSession().getAttribute("id");
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));

		/*
		카테고리이름, 펀딩이름, 펀딩 사진, 요약설명, 스토리설명, 목표금액, 펀딩기간 (완)
		달성률, 현재까지의 총 펀딩금액, 서포터 수 (완)
		메이커 이름, 메이커 이메일/문의전화/홈페이지 (완)
		메이커와의 팔로우 여부 (완)
		리워드 종류 (완)
		*/
		
		FundingDAO dao = new FundingDAO();
		FundingInfoBean fundingInfo = dao.getfundingStory(fundingId);	//펀딩 스토리 정보
		MakerBean maker = dao.getMaker(fundingId);						//메이커 정보
		List<RewardBean> rewardList = dao.getRewardList(fundingId);		//리워드 옵션
		int check = dao.follow(maker.getUserId(), userId); 	   			//메이커와 사용자의 팔로우 여부
		AllFundingInfoBean report = dao.getFundingReport(fundingId);	//펀딩 매출 정보
		
		Timestamp currentDate = new Timestamp(System.currentTimeMillis());
		Timestamp endDate = fundingInfo.getEnddate();
		long calDate = endDate.getTime() - currentDate.getTime(); 
        long calDayDiff = calDate / ( 24*60*60*1000); 
        
        request.setAttribute("fundingInfo", fundingInfo);
		request.setAttribute("maker", maker);
		request.setAttribute("rewardList", rewardList);
		request.setAttribute("calDayDiff", calDayDiff+1);
		request.setAttribute("check", check);
		request.setAttribute("report", report);
				 
	    ActionForward forward = new ActionForward();
	    forward.setRedirect(false);
	    forward.setPath("funding/fundingStory.jsp");
	  
	    return forward;
	    
	}

}
