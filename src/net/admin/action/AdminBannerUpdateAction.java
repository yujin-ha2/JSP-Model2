package net.admin.action;

import java.io.File;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.action.Action;
import net.action.ActionForward;
import net.admin.db.BannerBean;
import net.admin.db.adminDAO;

public class AdminBannerUpdateAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/bannerUpload/");
		
		File targetDir = new File(uploadPath);
		if(!targetDir.exists()){
			targetDir.mkdirs();
		}
		
		int maxSize = 1024 * 1024 * 10; // 10M크기
		MultipartRequest multi = null;
		
		multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
		
		//String originalName = multi.getOriginalFileName("bannerImgFile");
		//String file = multi.getFilesystemName("bannerImgFile");
		/*
		String[] linkArr = multi.getParameterValues("link");
		for(int i=0; i<linkArr.length; i++) {
			 System.out.println("링크"+i+"번: "+linkArr[i]); 
		}
		
		//이걸로 저장하고 히든인풋으로 저장하자
		Enumeration<String> fileNames = multi.getFileNames();
		while( fileNames.hasMoreElements() ) {
			String name = (String)fileNames.nextElement();
			String filename = multi.getFilesystemName(name);
			System.out.println("name: " + name + ", filename: " + filename);
		}	
		*/
		
		/*
		Vector<BannerBean> banners = new Vector<BannerBean>();
		BannerBean bean = null;
		String[] linkArr = multi.getParameterValues("link");
		for(int i=1; i<linkArr.length; i++) {
			System.out.println("링크"+i+"번: "+linkArr[i]); 
			String filename = multi.getFilesystemName("bannerImgFile"+(i));
			System.out.println("파일"+i+"번: "+filename);
			
			bean = new BannerBean();
			bean.setImg(filename);
			bean.setLink(linkArr[i]);
			banners.add(bean);
		}
		
		
		Enumeration<String> fileNames = multi.getFileNames();
		while( fileNames.hasMoreElements() ) {
			String name = (String)fileNames.nextElement();
			String SavedName = multi.getFilesystemName(name);
			String originalName = multi.getOriginalFileName(name);
			System.out.println("name: " + name + ", SavedName: " + SavedName + ", originalName: " + originalName);
		}	
		*/
		
		Vector<BannerBean> banners = new Vector<BannerBean>();
		BannerBean bean = null;
		int bannerCount = Integer.parseInt(multi.getParameter("bannerCount"));
		for(int i=1; i<=bannerCount; i++) {
			String originalName = "";
			String savedName = "";
			if(multi.getOriginalFileName("bannerImgFile"+i) != null) {
				originalName = multi.getOriginalFileName("bannerImgFile"+i);
				savedName = multi.getFilesystemName("bannerImgFile"+i);
			}else {
				originalName = multi.getParameter("fileName"+i);
				savedName = multi.getParameter("savedFileName"+i);
			}
			
			String link = multi.getParameter("link"+i);
			
			bean = new BannerBean();
			bean.setSavedFileName(savedName);
			bean.setOriginalFileName(originalName);
			bean.setLink(link);
			banners.add(bean);
		}
		
		int result = new adminDAO().bannerImgUpdate(banners);
		
		if(result == 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('배너 등록에 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
		

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("AdminBannerSetAction.ad");

		return forward;
	}


}
