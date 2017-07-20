package com.it61.minecraft.test;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class AjaxServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//判断form表单的类型是否是 multipart/form-data
		if (ServletFileUpload.isMultipartContent(request)) {

			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);

			try {
				List<FileItem> items = upload.parseRequest(request);
				for (FileItem item : items) {
					//普通表单项
					if (item.isFormField()) {
						String name = item.getFieldName();
						String value = item.getString("UTF-8");
						System.out.println("name = " + name + " ; value = "+ value+","+item.getName());
						
						//只输出name的值
						if(name.equals("name_")){
							response.setCharacterEncoding("UTF-8");
							response.getWriter().write("hello," + value+ ",from multipart form post");
						}
					}else{
						//类型是 file 的表单项
						//将文件保存在本地
						File file = new File("d://"+new String(item.getName().getBytes("GBK"),"UTF-8"));
						FileOutputStream fos = new FileOutputStream(file);
						InputStream is = item.getInputStream();
						byte[] buff = new byte[1024];
						int len = -1;
						while((len=is.read(buff)) != -1){
							fos.write(buff,0,len);
						}
						fos.close();
						is.close();
					}

				}
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
			return;
		}

		response.getWriter().write("hello," + request.getParameter("name") +"\n"+ request.getParameter("city")+ ",from get or www-form post");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
