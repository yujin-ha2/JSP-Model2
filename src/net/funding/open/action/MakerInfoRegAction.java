package net.funding.open.action;

import java.io.File;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.FundingInfoBean;
import net.funding.open.db.MakerBean;
import net.funding.open.db.fundingOpenDAO;

public class MakerInfoRegAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		String id = (String)request.getSession().getAttribute("id");
		
		//D:\workspace_jsp1\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\FileUploadDownload\ upload\
		String directory = request.getSession().getServletContext().getRealPath("/fundingUpload/");

		File targetDir = new File(directory);
		if(!targetDir.exists()){
			targetDir.mkdirs();
		}
		System.out.println("넘어옴");
		
		//업로드 할 수 있는 파일의 최대 사이즈 지정 3MB
		int maxSize = 1024*1024*3;  
		MakerBean bean = new MakerBean();
		
		MultipartRequest multipartRequest;
		String cmd = "";
		int fundingId = 0;
		try {
			multipartRequest = new MultipartRequest(request, directory, maxSize, "UTF-8", new DefaultFileRenamePolicy());
			
			bean.setName(multipartRequest.getParameter("name"));
			bean.setType(multipartRequest.getParameter("type"));
			bean.setCeoName(multipartRequest.getParameter("ceoName"));
			bean.setCeoEmail(multipartRequest.getParameter("ceoEmail"));
			bean.setMakerEmail(multipartRequest.getParameter("makerEmail"));
			bean.setMakerTel(multipartRequest.getParameter("makerTel"));
			bean.setMakerHomepage(multipartRequest.getParameter("makerHomepage"));
			bean.setBankName(multipartRequest.getParameter("bankName"));
			bean.setAccountNumber(multipartRequest.getParameter("accountNumber"));
			bean.setAccountHolder(multipartRequest.getParameter("accountHolder"));
			fundingId = Integer.parseInt(multipartRequest.getParameter("fundingId"));
			bean.setUserId(id);
			cmd = multipartRequest.getParameter("cmd");
			
			System.out.println(multipartRequest.getParameter("name"));
			System.out.println(multipartRequest.getParameter("type"));
			System.out.println(multipartRequest.getParameter("ceoName"));
			System.out.println(multipartRequest.getParameter("ceoEmail"));
			System.out.println(multipartRequest.getParameter("makerEmail"));
			System.out.println(multipartRequest.getParameter("makerTel"));
			System.out.println(multipartRequest.getParameter("makerHomepage"));
			System.out.println(multipartRequest.getParameter("bankName"));
			System.out.println(multipartRequest.getParameter("accountNumber"));
			System.out.println(multipartRequest.getParameter("accountHolder"));
			System.out.println(multipartRequest.getParameter("fundingId"));
			
			
			Enumeration fileNames = multipartRequest.getFileNames();
			while( fileNames.hasMoreElements() ) {

				String name = (String)fileNames.nextElement();
				String profileName = multipartRequest.getFilesystemName(name); //업로드 된 파일 이름 가져옴, 이거 사용
				bean.setProfile(profileName);
			}
			
			if(bean.getProfile() == null || bean.getProfile().equals("")) {
				bean.setProfile(multipartRequest.getParameter("profile2"));
			}
						
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		if(cmd.equals("register")) {
			
			int result = new fundingOpenDAO().updateMakerInfo(bean, 0);
			
			if(result == 0) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('메이커 정보 등록에 실패하였습니다.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
				return null;
			}
			request.setAttribute("bean", bean);
			request.setAttribute("fundingId", fundingId);
			request.setAttribute("mode", "update");
			
		}else if(cmd.equals("update")){
			System.out.println();
			int result = new fundingOpenDAO().updateMakerInfo(bean, 1);
			if(result == 0) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('메이커 정보 수정에 실패하였습니다.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
				return null;
			}
			
			request.setAttribute("bean", bean);
			request.setAttribute("fundingId", fundingId);
			request.setAttribute("mode", "update");
		}

		ActionForward forward = new ActionForward();	
		forward.setRedirect(false);
		forward.setPath("fundingOpen/projectMakerDetailView.jsp"); 		
		
		return forward;
	}

}
