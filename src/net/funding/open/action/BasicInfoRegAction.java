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
import net.funding.open.db.fundingOpenDAO;

public class BasicInfoRegAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF-8");
		
		//D:\workspace_jsp1\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\FileUploadDownload\ upload\
		String directory = request.getSession().getServletContext().getRealPath("/fundingUpload/");

		File targetDir = new File(directory);
		if(!targetDir.exists()){
			targetDir.mkdirs();
		}
		
		//업로드 할 수 있는 파일의 최대 사이즈 지정 3MB
		int maxSize = 1024*1024*3;  
		FundingInfoBean bean = new FundingInfoBean();
		
		MultipartRequest multipartRequest;
		String cmd = "";
		try {
			multipartRequest = new MultipartRequest(request, directory, maxSize, "UTF-8", new DefaultFileRenamePolicy());
			
			bean.setFundingId(Integer.parseInt(multipartRequest.getParameter("fundingId")));
			bean.setTitle(multipartRequest.getParameter("title"));
			bean.setSalesTarget(Integer.parseInt(multipartRequest.getParameter("salesTarget")));
			bean.setCategoryId(Integer.parseInt(multipartRequest.getParameter("category")));
			
			bean.setStorySummary(multipartRequest.getParameter("summary"));
			bean.setStoryContent(multipartRequest.getParameter("story"));
			cmd = multipartRequest.getParameter("cmd");
			
			Enumeration fileNames = multipartRequest.getFileNames();
			while( fileNames.hasMoreElements() ) {
//				  String name = (String)fileNames.nextElement();  				  //input name 출력        
//                String filename = multipartRequest.getFilesystemName( name );   //등록한 파일명  
//                String type = multipartRequest.getContentType( name );  		  //파일 타입
                
				String name = (String)fileNames.nextElement();
				if(name == "mainImg") {
					String mainImgName = multipartRequest.getFilesystemName(name); //업로드 된 파일 이름 가져옴, 이거 사용
					bean.setMainImg(mainImgName);
				}else {
					String storyImgName = multipartRequest.getFilesystemName(name); //업로드 된 파일 이름 가져옴, 이거 사용
					bean.setStoryMainImg(storyImgName);
				}
				
			}
			
			if(bean.getMainImg() == null || bean.getMainImg().equals("")) {
				bean.setMainImg(multipartRequest.getParameter("mainImg2"));
			}else if(bean.getStoryMainImg() == null || bean.getStoryMainImg().equals("")){
				bean.setStoryMainImg(multipartRequest.getParameter("storyImg2"));
			}
						
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		if(cmd.equals("register")) {
			
			int result = new fundingOpenDAO().insertBasicInfo(bean);
			
			if(result == 0) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('기본 정보 등록에 실패하였습니다.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
				return null;
			}
			
			request.setAttribute("bean", bean);
			request.setAttribute("mode", "update");
			
		}else if(cmd.equals("update")){
			System.out.println();
			int result = new fundingOpenDAO().updateBasicInfo(bean);
			if(result == 0) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('기본 요건 수정에 실패하였습니다.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
				return null;
			}
			
			request.setAttribute("bean", bean);
			request.setAttribute("mode", "update");
		}

		ActionForward forward = new ActionForward();	
		forward.setRedirect(false);
		forward.setPath("fundingOpen/projectBasicInfoView.jsp"); 		
		
		return forward;
	}

}
