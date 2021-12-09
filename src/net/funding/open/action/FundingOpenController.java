package net.funding.open.action;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.FundingOpenDAO;
import net.funding.open.db.rewardInfoBean;

public class FundingOpenController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String RequestURI=request.getRequestURI();
		System.out.println(RequestURI);
		
		String contextPath=request.getContextPath();
		//System.out.println("op_contextPath:" + contextPath);
		
		String command=RequestURI.substring(contextPath.length()+6);
		System.out.println("op_command:" + command);
		
		ActionForward forward = null;
		Action action = null;

		//펀딩 오픈 메뉴의 메인 화면으로 이동
		if(command.equals("/fundingOpenMain.on")) {
			forward=new ActionForward();
			forward.setRedirect(false);
			forward.setPath("fundingOpen/fundingOpenMain.jsp");
		}
		
		//메이커 간편 등록 화면으로 이동
		else if(command.equals("/makerEasyRegForm.on")) {
			action=new makerEasyRegFormAction(); //스크립트를 모달로 변경(두경)
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 간편 등록 처리 요청이 들어왔을 때
		else if(command.equals("/makerEasyReg.on")){
			action=new makerEasyRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		//내가 만든 프로젝트 화면으로 이동
		else if(command.equals("/myprojectList.on")) {
			action=new myProjectListAction();
				
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 메인 화면으로 이동
		else if(command.equals("/makerStudioMain.on")) {
			action=new makerStudioMainAciton(); 
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		//메이커 스튜디오 - 펀딩 제출 요청 (ajax)
		else if(command.equals("/RequestFundingApproval.on")) {
			try {
				JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
				response.setHeader("Content-Type", "application/json"); 
				response.setContentType("text/html;charset=UTF-8"); 
				response.setCharacterEncoding("utf-8");
			     
			    int fundingId = data.get("fundingId").getAsInt(); 
			    
			    String message = "";
			    int result = new FundingOpenDAO().RequestForApproval(fundingId);
				if(result == 1) 
					message = "프로젝트 준비 작성이 제출되었습니다.";
				else 
					message = "프로젝트 제출에 실패하였습니다.";
			
				new Gson().toJson(message, response.getWriter());	
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 - 기본 요건 등록 화면으로 이동
		else if(command.equals("/BasicRequireRegForm.on")) {
			action=new BasicRequireFormAction(); 
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 - 기본 요건 등록 처리 요청이 들어왔을 때 
		else if(command.equals("/BasicRequireReg.on")) {
			action=new BasicRequireRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 - 기본 요건 수정 페이지로 이동 
		else if(command.equals("/BasicRequireUpdateForm.on")) {
			action=new BasicRequireUpdateFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 - 기본 정보/스토리 등록 화면으로 이동
		else if(command.equals("/BasicInfoRegForm.on")) {
			action=new BasicInfoRegFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 - 기본 정보/스토리 등록 처리 요청이들어왔을 때 
		else if(command.equals("/BasicInfoReg.on")) {
			action=new BasicInfoRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 - 기본 정보/스토리 수정 페이지로 이동 
		else if(command.equals("/BasicInfoUpdateForm.on")) {
			action=new BasicInfoUpdateFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 - 리워드 설계 등록 화면으로 이동
		else if(command.equals("/rewardRegForm.on")) {
			
			action=new RewardRegFormAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 - 리워드 설계 등록 처리 요청이 들어왔을 때 
		else if(command.equals("/rewardReg.on")) {
			action=new RewardRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 - 리워드 설계 수정 화면으로 이동 
		else if(command.equals("/rewardUpdateForm.on")) {
			action=new RewardUpdateFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	
		//메이커 스튜디오 - 제공 정보 등록 화면으로 이동
		else if(command.equals("/rewardDetailRegForm.on")) {
			action=new RewardDetailRegFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 - 카테고리 상세 정보 리스트 반환(ajax)
		else if(command.equals("/conveyCategorydetail.on")) {
			try {
				
				JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
				response.setHeader("Content-Type", "application/json"); 
				response.setContentType("text/html;charset=UTF-8"); 
				response.setCharacterEncoding("utf-8");
			     
			    int categoryId = data.get("categoryId").getAsInt(); //카테고리 숫자값 0-5
			    System.out.println("카테고리id: " + categoryId);
			    
			    FundingOpenDAO dao = new FundingOpenDAO();
				Vector<rewardInfoBean> v = dao.getCategoryDetails(categoryId);
				
			/*	for(rewardInfoBean bean : v) { //for문을 통한 전체출력
				    System.out.println(bean.getDetailId() + " : " + bean.getDetailName() + ", ex: " + bean.getExample());
				}
			*/
				new Gson().toJson(v, response.getWriter());			
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//메이커 스튜디오 - 상세정보 등록 처리 요청이 들어왔을 때 
		else if(command.equals("/rewardDetailReg.on")) {
			action=new RewardDetailRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 - 상세정보 수정 화면으로 이동
		else if(command.equals("/rewardDetailUpdateForm.on")) {
			action=new RewardDetailUpdateFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 - 메이커 정보 등록 화면으로 이동
		else if(command.equals("/makerInfoRegForm.on")) {
			action=new MakerInfoFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 - 메이커 정보 등록 처리 요청이 들어왔을 때 
		else if(command.equals("/makerInfoReg.on")) {
			action=new MakerInfoRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 - 메이커 정보 수정 화면으로 이동 
		else if(command.equals("/makerInfoUpdate.on")) {
			action=new MakerInfoUpdateAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		//메이커 스튜디오 - 펀딩 현황 화면으로 이동
		else if(command.equals("/fundingReport.on")) {
			action=new FundingReportAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 스튜디오 - 결제 현황 화면으로 이동
		else if(command.equals("/fundingResult.on")) {
			action=new FundingResultAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//주소 이동
		if(forward!=null){ 
			if(forward.isRedirect()){
				response.sendRedirect(forward.getPath());
			}else{
				RequestDispatcher dispatcher=request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
	}
	
}
