package net.admin.action;

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
import net.admin.db.adminDAO;
import net.funding.open.db.FundingOpenDAO;

public class AdminController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
		String RequestURI=request.getRequestURI();
		System.out.println(RequestURI);
		
		String contextPath=request.getContextPath();
		System.out.println("ad_contextPath:" + contextPath);
		
		String command=RequestURI.substring(contextPath.length()+6);
		System.out.println("ad_command:" + command);
		
		ActionForward forward = null;
		Action action = null;
		
		//���ΰ��� �޴�
		if(command.equals("/AdminApproveListAction.ad")) {
			action = new AdminApproveListAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//���ΰ��� - ����/�ݷ� ó��
		else if(command.equals("/AdminApproveAction.ad")) {
			action = new AdminApproveAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//ȸ������ �޴�
		else if(command.equals("/MemberManagement.ad")) {
			action = new AdminMemberGeneralListAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//ȸ�� ���� ���¸� ���� (����, ���)
		else if(command.equals("/ChangeAccountStatus.ad")) {
			action = new ChangeAccountStatusAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//ȸ�� ���� ���¸� ���� (������, �Ϲ�����)
		else if(command.equals("/ChangeAccountAuthority.ad")) {
			action = new ChangeAccountAuthorityAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//��ʰ��� �޴�
		else if(command.equals("/AdminBannerSetAction.ad")) {
			action = new AdminBannerSetAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//��� ����
		else if(command.equals("/AdminBannerUpdateAction.ad")) {
			action = new AdminBannerUpdateAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
			
		//�������� ����Ʈ�� �̵�
		else if(command.equals("/NoticeList.ad")) {
			action = new AdminNoticeListAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//�������� �Խ��� - �������� ��� ȭ������ �̵�
		if(command.equals("/NoticeRegisterForm.ad")) {
			forward=new ActionForward();
			forward.setRedirect(false);
			forward.setPath("admin/adminNoticeRegister.jsp");
		}
		
		//�������� �Խ��� - �������� ��� ó�� ��û�� ������ ��
		else if(command.equals("/NoticeRegister.ad")) {
			action = new NoticeRegisterAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//�������� �Խ��� - �������� �Խñ� (��/����)ȭ������ �̵�
		else if(command.equals("/NoticeView.ad")) {
			action = new NoticeViewAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//�������� �Խ��� - �������� ���� ó�� ��û�� ������ ��
		if(command.equals("/NoticeUpdate.ad")) {
			action = new NoticeUpdateAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		//�������� �Խ��� - �������� �Խñ� ���� ó�� ��û�� ������ ��
		if(command.equals("/NoticeDelete.ad")) {
			action = new NoticeDeleteAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
				
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
			
			
	
	
