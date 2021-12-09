package net.member.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.MemberDAO;

public class MemberFrontController extends HttpServlet{
	
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
		String contextPath=request.getContextPath();
		String command=RequestURI.substring(contextPath.length()+6);
		
		ActionForward forward = null;
		Action action = null;

		//회원가입 화면으로 이동
		if(command.equals("/join.me")){
			forward=new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/aroma/member/join.jsp");
		}
		
		//회원가입 처리 요청이 들어 왔을떄
		else if(command.equals("/joinAction.me")){
			action=new MemberJoinAction();
			
			try {
				forward=action.execute(request, response);
						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//회원가입 유효성 체크
		else if(command.equals("/IdCheck.me")){
			 response.setContentType("text/html;charset=utf-8");
	         JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
	         String id = data.get("id").getAsString();
	         System.out.println("id="+id);
	         
	         MemberDAO dao = new MemberDAO();
	         int idx = dao.idCheck(id);
	         
	         if(idx == 1){
	            new Gson().toJson("이미 존재하는 아이디 입니다.", response.getWriter());
	         }else{
	            new Gson().toJson("사용가능한 아이디 입니다.", response.getWriter());
	         }
		}
		
		//로그인 화면으로 이동
		else if(command.equals("/login.me")){ 	
			forward=new ActionForward();
			forward.setRedirect(false); 
			forward.setPath("/aroma/member/login.jsp"); 
		}

		//로그인 처리 요청이 들어왔을 때
		else if(command.equals("/loginAction.me")){
			action=new MemberLoginAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		//로그아웃 처리 요청이 들어왔을 때
		else if(command.equals("/logout.me")){
			action=new MemberLogoutAction(); 

			try {
				forward=action.execute(request, response); 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//마이페이지 화면으로 이동
		else if(command.equals("/Mypage.me")) {
			action = new MypageAction();
			
			try {
				forward=action.execute(request, response); 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//프로필 변경 처리
		else if(command.equals("/memberProfileChange.me")) {
			action=new MemberProfileChangeAction();

			try {
				forward=action.execute(request, response); 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//마이페이지(서포터), 나의 메이커 팔로잉 리스트 화면으로 이동
		else if(command.equals("/myFollowList.me")){
	       action= new MyFollowListAction();
	       
	       try {
	    	   forward = action.execute(request, response);
	       } catch (Exception e) {
	       e.printStackTrace();
	       }
	    }
		
		//회원 정보 수정 화면으로 이동
		else if(command.equals("/myInfo.me")){
			action = new MyInfoFormAction();
			try{
				forward = action.execute(request, response);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//회원 정보 수정 처리 요청이 들어왔을 때
		else if(command.equals("/myInfoUpdate.me")){
			action = new MyInfoUpdateAction();
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	

		//회원 정보 수정 - 비밀번호 변경에서 회원 정보 수정 화면으로 이동
		else if(command.equals("/myInfoFindPwd.me")){
			action = new MyInfoFindPwdFormAction();
			try{
				forward = action.execute(request, response);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//회원 탈퇴 요청이 들어왔을 때
		else if(command.equals("/memberDelete.me")){
			action= new MemberDeleteAction();
			try {
			forward = action.execute(request, response);
			} catch (Exception e) {
			e.printStackTrace();
			}
		}
		
		//아이디/비밀번호 찾기 화면으로 이동
		else if(command.equals("/findIdPwd.me")) {
			forward=new ActionForward();
			forward.setRedirect(false); 
			forward.setPath("member/find_id_pwd_form1.jsp");
		}
		
		//아이디 찾기 처리 요청이 들어왔을 때
		else if(command.equals("/showId.me")){
			action = new ShowIdAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//비밀번호 찾기에서 사용자 인증 요청이 들어왔을 때
		else if(command.equals("/userCheck.me")){
			action = new UserCheckAction();
			try{
				forward = action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		//비밀번호 변경 요청이 들어왔을 때
		else if(command.equals("/passwordUpdate.me")){
			action= new PasswordUpdateAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//(마이페이지, 서포터) 나의 펀딩 내역으로 이동  
		else if(command.equals("/MyFundingHistory.me")){
			action= new MyFundingHistoryAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//(마이페이지, 서포터) 나의 펀딩  내역 정보 페이지로 이동
		else if(command.equals("/MyFundingHistoryInfo.me")){
			action= new MyFundingHistoryInfoAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
			e.printStackTrace();
			}
		}
		
		//(마이페이지, 서포터) 나의 펀딩 취소하기 
		else if(command.equals("/MyFundingCancel.me")){
			action= new MyFundingCancelAction();
			try {
				forward = action.execute(request, response);
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
