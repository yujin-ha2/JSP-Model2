package net.funding.open.action;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.FundingInfoBean;
import net.funding.open.db.FundingOpenDAO;

public class BasicInfoRegAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF-8");
		
		//D:\workspace_jsp1\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\FileUploadDownload\
		String directory = request.getSession().getServletContext().getRealPath("/fundingUpload/");

		File targetDir = new File(directory);
		if(!targetDir.exists()){
			targetDir.mkdirs();
		}
		
		//업로드 할 수 있는 파일의 최대 사이즈 지정 3MB
		String cmd = "";
		int maxSize = 1024*1024*3;  
		Map<String, String> map = new HashMap<String, String>();
		FundingInfoBean bean = new FundingInfoBean();		
		MultipartRequest multipartRequest;
		int fundingId = 0;

		try {
			multipartRequest = new MultipartRequest(request, directory, maxSize, "UTF-8", new DefaultFileRenamePolicy());
			
			fundingId = Integer.parseInt(multipartRequest.getParameter("fundingId"));
			bean.setFundingId(fundingId);
			bean.setTitle(multipartRequest.getParameter("title"));
			String salesTarget = multipartRequest.getParameter("salesTarget").replace(",", "");
			bean.setSalesTarget(Integer.parseInt(salesTarget));
			bean.setCategoryId(Integer.parseInt(multipartRequest.getParameter("category")));
					
			String startdate_ = multipartRequest.getParameter("startdate").concat(" 00:00:00.0");
			String enddate_ = multipartRequest.getParameter("enddate").concat(" 23:59:59.0");
			Timestamp startdate = Timestamp.valueOf(startdate_);
			Timestamp enddate = Timestamp.valueOf(enddate_);
			bean.setStartdate(startdate);
			bean.setEnddate(enddate); 

			bean.setStorySummary(multipartRequest.getParameter("summary"));
			bean.setStoryContent(multipartRequest.getParameter("story"));
			System.out.println("story: " + bean.getStoryContent());
			cmd = multipartRequest.getParameter("cmd");
			
			Enumeration<String> fileNames = multipartRequest.getFileNames();
			
			while( fileNames.hasMoreElements() ) {
//				  String name = (String)fileNames.nextElement();  				  //input name 출력        
//                String filename = multipartRequest.getFilesystemName( name );   //등록한 파일명  
//                String type = multipartRequest.getContentType( name );  		  //파일 타입
              
				String name = (String)fileNames.nextElement();
				String filename = multipartRequest.getFilesystemName(name);
				map.put(name, filename);
			}

			if(map.get("mainImg") == null || map.containsKey("mainImg") == false){
				map.put("mainImg", multipartRequest.getParameter("mainImg2"));
			}
			if(map.get("storyImg") == null || map.containsKey("storyImg") == false){
				map.put("storyImg", multipartRequest.getParameter("storyImg2"));
			}
			
			//System.out.println("map: " + map.get("mainImg") + ", " + map.get("storyImg"));
			
			bean.setMainImg(map.get("mainImg"));
			bean.setStoryMainImg(map.get("storyImg"));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int result = 0;
		String Message = "";
		if(cmd.equals("register")) {
			result = new FundingOpenDAO().insertBasicInfo(bean);
			Message = "등록";
		}else if(cmd.equals("update")){
			result = new FundingOpenDAO().updateBasicInfo(bean);
			Message = "수정";
		}
		
		if(result == 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('기본 요건 "+Message+"에 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}

		request.setAttribute("bean", bean);
		request.setAttribute("fundingId", fundingId);
		request.setAttribute("mode", "update");
		
		ActionForward forward = new ActionForward();	
		forward.setRedirect(false);
		forward.setPath("fundingOpen/projectBasicInfoView.jsp"); 		
		
		return forward;
	}

}
