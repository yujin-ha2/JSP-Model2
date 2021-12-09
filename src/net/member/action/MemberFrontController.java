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

		//ȸ������ ȭ������ �̵�
		if(command.equals("/join.me")){
			forward=new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/aroma/member/join.jsp");
		}
		
		//ȸ������ ó�� ��û�� ��� ������
		else if(command.equals("/joinAction.me")){
			action=new MemberJoinAction();
			
			try {
				forward=action.execute(request, response);
						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//ȸ������ ��ȿ�� üũ
		else if(command.equals("/IdCheck.me")){
			 response.setContentType("text/html;charset=utf-8");
	         JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
	         String id = data.get("id").getAsString();
	         System.out.println("id="+id);
	         
	         MemberDAO dao = new MemberDAO();
	         int idx = dao.idCheck(id);
	         
	         if(idx == 1){
	            new Gson().toJson("�̹� �����ϴ� ���̵� �Դϴ�.", response.getWriter());
	         }else{
	            new Gson().toJson("��밡���� ���̵� �Դϴ�.", response.getWriter());
	         }
		}
		
		//�α��� ȭ������ �̵�
		else if(command.equals("/login.me")){ 	
			forward=new ActionForward();
			forward.setRedirect(false); 
			forward.setPath("/aroma/member/login.jsp"); 
		}

		//�α��� ó�� ��û�� ������ ��
		else if(command.equals("/loginAction.me")){
			action=new MemberLoginAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		//�α׾ƿ� ó�� ��û�� ������ ��
		else if(command.equals("/logout.me")){
			action=new MemberLogoutAction(); 

			try {
				forward=action.execute(request, response); 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//���������� ȭ������ �̵�
		else if(command.equals("/Mypage.me")) {
			action = new MypageAction();
			
			try {
				forward=action.execute(request, response); 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//������ ���� ó��
		else if(command.equals("/memberProfileChange.me")) {
			action=new MemberProfileChangeAction();

			try {
				forward=action.execute(request, response); 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����������(������), ���� ����Ŀ �ȷ��� ����Ʈ ȭ������ �̵�
		else if(command.equals("/myFollowList.me")){
	       action= new MyFollowListAction();
	       
	       try {
	    	   forward = action.execute(request, response);
	       } catch (Exception e) {
	       e.printStackTrace();
	       }
	    }
		
		//ȸ�� ���� ���� ȭ������ �̵�
		else if(command.equals("/myInfo.me")){
			action = new MyInfoFormAction();
			try{
				forward = action.execute(request, response);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//ȸ�� ���� ���� ó�� ��û�� ������ ��
		else if(command.equals("/myInfoUpdate.me")){
			action = new MyInfoUpdateAction();
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	

		//ȸ�� ���� ���� - ��й�ȣ ���濡�� ȸ�� ���� ���� ȭ������ �̵�
		else if(command.equals("/myInfoFindPwd.me")){
			action = new MyInfoFindPwdFormAction();
			try{
				forward = action.execute(request, response);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//ȸ�� Ż�� ��û�� ������ ��
		else if(command.equals("/memberDelete.me")){
			action= new MemberDeleteAction();
			try {
			forward = action.execute(request, response);
			} catch (Exception e) {
			e.printStackTrace();
			}
		}
		
		//���̵�/��й�ȣ ã�� ȭ������ �̵�
		else if(command.equals("/findIdPwd.me")) {
			forward=new ActionForward();
			forward.setRedirect(false); 
			forward.setPath("member/find_id_pwd_form1.jsp");
		}
		
		//���̵� ã�� ó�� ��û�� ������ ��
		else if(command.equals("/showId.me")){
			action = new ShowIdAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//��й�ȣ ã�⿡�� ����� ���� ��û�� ������ ��
		else if(command.equals("/userCheck.me")){
			action = new UserCheckAction();
			try{
				forward = action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		//��й�ȣ ���� ��û�� ������ ��
		else if(command.equals("/passwordUpdate.me")){
			action= new PasswordUpdateAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//(����������, ������) ���� �ݵ� �������� �̵�  
		else if(command.equals("/MyFundingHistory.me")){
			action= new MyFundingHistoryAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//(����������, ������) ���� �ݵ�  ���� ���� �������� �̵�
		else if(command.equals("/MyFundingHistoryInfo.me")){
			action= new MyFundingHistoryInfoAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
			e.printStackTrace();
			}
		}
		
		//(����������, ������) ���� �ݵ� ����ϱ� 
		else if(command.equals("/MyFundingCancel.me")){
			action= new MyFundingCancelAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
			e.printStackTrace();
			}
		}
		
		//�ּ� �̵�
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
