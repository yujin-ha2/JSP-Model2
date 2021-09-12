package net.funding.open.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.AllProject;
import net.funding.open.db.fundingOpenDAO;

public class makerStudioMainAciton implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		String id = (String)request.getSession().getAttribute("id");
		int fundingId = Integer.parseInt(request.getParameter("no"));
		
		fundingOpenDAO openDao = new fundingOpenDAO();

		String status = "";
		List<String> statusBtnList = new ArrayList<String>();
		List<String> writeList = new ArrayList<String>();
		
		if(fundingId == 0) {
			//프로젝트 생성
			fundingId = openDao.insertNewProject(id);
			
			status = "prepare";
			statusBtnList = Arrays.asList("작성하기", "작성하기", "작성하기", "작성하기", "작성하기");
			writeList = Arrays.asList("작성전", "작성전", "작성전", "작성전", "작성전"); 
			
		}else {
			List<String> statusList = openDao.getProjectStatus(fundingId);
		
			if(statusList == null) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('메이커 스튜디오로 넘어가는데 오류가 발생했습니다.');");
				out.println("location.href='fundingOpenMain.on';");
				out.println("</script>");
				out.close();
				return null;
			}else {
				
	//			public static List<String> ConfirmBtnList = Arrays.asList("확인하기", "확인하기", "확인하기", "확인하기", "확인하기"); 
	//			public static List<String> ReviseBtnList = Arrays.asList("수정하기", "수정하기", "수정하기", "수정하기", "수정하기"); 
	//			public static List<String> ApproveBtnList = Arrays.asList("확인하기", "수정하기", "확인하기", "확인하기", "확인하기"); 
	//			public static List<String> writeLis1t = Arrays.asList("작성완료", "작성완료", "작성완료", "작성완료", "작성완료");
				status = statusList.get(5);
				if(status.equals("prepare")) {
					
					for(int i=0; i<5; i++) {
						statusBtnList.add(statusList.get(i).equals("0") ? "작성하기": "수정하기");
						writeList.add(statusList.get(i).equals("0") ? "작성전": "작성완료");
					}
				}else if(status.equals("reject")) {
					statusBtnList = Arrays.asList("수정하기", "수정하기", "수정하기", "수정하기", "수정하기");
					writeList = Arrays.asList("작성완료", "작성완료", "작성완료", "작성완료", "작성완료");
				}else if(status.equals("approve") || status.equals("apply")) {
					statusBtnList = Arrays.asList("확인하기", "수정하기", "확인하기", "확인하기", "확인하기");
					writeList = Arrays.asList("작성완료", "작성완료", "작성완료", "작성완료", "작성완료"); 
				}else {
					statusBtnList = Arrays.asList("확인하기", "확인하기", "확인하기", "확인하기", "확인하기");
					writeList = Arrays.asList("작성완료", "작성완료", "작성완료", "작성완료", "작성완료"); 
				}
				
			}
		}
		
		request.setAttribute("statusBtnList", statusBtnList);
		request.setAttribute("writeList", writeList);
		request.setAttribute("status", status);
		request.setAttribute("fundingId", fundingId);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("fundingOpen/makerStudioMain.jsp");
		
		return forward;
	}

}
