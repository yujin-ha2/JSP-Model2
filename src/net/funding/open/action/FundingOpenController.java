package net.funding.open.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;

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
		System.out.println("op_contextPath:" + contextPath);
		
		String command=RequestURI.substring(contextPath.length()+6);
		System.out.println("op_command:" + command);
		
		ActionForward forward = null;
		Action action = null;

		//�ݵ� ���� �޴��� ���� ȭ������ �̵�
		if(command.equals("/fundingOpenMain.on")) {
			forward=new ActionForward();
			forward.setRedirect(false);
			forward.setPath("fundingOpen/fundingOpenMain.jsp");
		}
		
		//����Ŀ ���� ��� ȭ������ �̵�
		else if(command.equals("/makerEasyRegForm.on")) {
			action=new makerEasyRegFormAction(); //��ũ��Ʈ�� ��޷� ����(�ΰ�)
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ���� ��� ó�� ��û�� ������ ��
		else if(command.equals("/makerEasyReg.on")){
			action=new makerEasyRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		//���� ���� ������Ʈ ȭ������ �̵�
		else if(command.equals("/myprojectList.on")) {
			action=new myProjectListAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� ���� ȭ������ �̵�
		else if(command.equals("/makerStudioMain.on")) {
			action=new makerStudioMainAciton(); 
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - �⺻ ��� ��� ȭ������ �̵�
		else if(command.equals("/BasicRequireRegForm.on")) {
			action=new BasicRequireFormAction(); //��ũ��Ʈ�� ��޷� ����(�ΰ�)
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - �⺻ ��� ��� ó�� ��û�� ������ �� 
		else if(command.equals("/BasicRequireReg.on")) {
			action=new BasicRequireRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - �⺻ ��� ���� �������� �̵� 
		else if(command.equals("/BasicRequireUpdateForm.on")) {
			action=new BasicRequireUpdateFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - �⺻ ����/���丮 ��� ȭ������ �̵�
		else if(command.equals("/BasicInfoRegForm.on")) {
			action=new BasicInfoRegFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - �⺻ ����/���丮 ��� ó�� ��û�̵����� �� 
		else if(command.equals("/BasicInfoReg.on")) {
			action=new BasicInfoRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - �⺻ ����/���丮 ���� �������� �̵� 
		else if(command.equals("/BasicInfoUpdateForm.on")) {
			action=new BasicInfoUpdateFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - ������ ���� ��� ȭ������ �̵�
		else if(command.equals("/rewardRegForm.on")) {
			forward=new ActionForward();
			forward.setRedirect(false);
			forward.setPath("fundingOpen/projectRewardReg.jsp");
		}
		
		/*//����Ŀ ��Ʃ��� - ������ ���� ��� ó�� ��û�� ������ �� 
		else if(command.equals("/rewardReg.on")) {
			action=new RewardRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}*/
	
		//����Ŀ ��Ʃ��� - ���� ���� ��� ȭ������ �̵�
		else if(command.equals("/rewardDetailRegForm.on")) {
			forward=new ActionForward();
			forward.setRedirect(false);
			forward.setPath("fundingOpen/projectRewardDetailReg.jsp");
		}
		
		/*//����Ŀ ��Ʃ��� - ������ ���� ��� ó�� ��û�� ������ �� 
		else if(command.equals("/rewardDetailReg.on")) {
			action=new RewardDetailRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}*/
		
		//����Ŀ ��Ʃ��� - ����Ŀ ���� ��� ȭ������ �̵�
		else if(command.equals("/makerInfoRegForm.on")) {
			action=new MakerInfoFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - ����Ŀ ���� ��� ó�� ��û�� ������ �� 
		else if(command.equals("/makerInfoReg.on")) {
			action=new MakerInfoRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - ����Ŀ ���� ���� ȭ������ �̵� 
		else if(command.equals("/makerInfoUpdate.on")) {
			action=new MakerInfoUpdateAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		//����Ŀ ��Ʃ��� - �ݵ� ��Ȳ ȭ������ �̵�
		else if(command.equals("/fundingReport.on")) {
			action=new FundingReportAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - ���� ��Ȳ ȭ������ �̵�
		else if(command.equals("/fundingPayment.on")) {
			forward=new ActionForward();
			forward.setRedirect(false);
			forward.setPath("fundingOpen/fundingpayment.jsp");
		}
		
		//����Ŀ ��Ʃ��� - �ݵ� ���� ȭ������ �̵�
		else if(command.equals("/fundingManagement.on")) {
			forward=new ActionForward();
			forward.setRedirect(false);
			forward.setPath("fundingOpen/fundingManagement.jsp");
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
