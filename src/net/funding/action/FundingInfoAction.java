package net.funding.action;

import java.sql.Date;
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
import net.funding.open.db.rewardDetailBean;

public class FundingInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		 /*
		 (기본)
		 달성률, 현재까지의 총 펀딩금액, 서포터 수 (완)
		 메이커 이름, 메이커 이메일/문의전화/홈페이지 (완)
		 메이커와의 팔로우 여부 (완)
		 리워드 종류 및 ajax (완)
		 (new)
		 펀딩 끝나는 날짜 (완)
		 카테고리 이름, 리워드 제공정보 종류, 정보 내용, 정책 (완)
		*/
		
		 request.setCharacterEncoding("UTF-8");
		
		 String userId = (String)request.getSession().getAttribute("id");
		 int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		 
		 FundingDAO dao = new FundingDAO();
 		 FundingInfoBean fundingInfo = dao.getfundingStory(fundingId);
		 MakerBean maker = dao.getMaker(fundingId);
		 List<RewardBean> rewardList = dao.getRewardList(fundingId);
		 List<rewardDetailBean> rewardDetailList = dao.getRewardDetailList(fundingId); 
		 int check = dao.follow(maker.getUserId(), userId); 	   						//메이커와 사용자의 팔로우 여부
		 AllFundingInfoBean report = dao.getFundingReport(fundingId);					//펀딩 매출 정보
		
		 Timestamp currentDate = new Timestamp(System.currentTimeMillis());
		 Timestamp endDate = fundingInfo.getEnddate();
		 long calDate = endDate.getTime() - currentDate.getTime(); 
         long calDayDiff = calDate / ( 24*60*60*1000); 
         
         Date nextDate = new Date(endDate.getTime()+(1000*60*60*24*+1));
        
         request.setAttribute("fundingInfo", fundingInfo);
 		 request.setAttribute("maker", maker);
		 request.setAttribute("rewardList", rewardList);
 		 request.setAttribute("calDayDiff", calDayDiff+1);
 		 request.setAttribute("nextDate", nextDate);
 		 request.setAttribute("rewardDetailList", rewardDetailList);
		 request.setAttribute("check", check);
		 request.setAttribute("report", report);
		 
	     ActionForward forward = new ActionForward();
	     forward.setRedirect(false);
	     forward.setPath("funding/fundingInfo.jsp");
	  
	     return forward;
	}
}
