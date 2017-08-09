package com.it61.minecraft.web.servlet;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.activation.MimeType;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.it61.minecraft.bean.User;
import com.it61.minecraft.common.Constants;
import com.it61.minecraft.service.UserService;
import com.it61.minecraft.service.impl.UserServiceImpl;
import com.mysql.jdbc.Blob;

public class SettingServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//判断form表单的类型是否是 multipart/form-data
		if (ServletFileUpload.isMultipartContent(request)) {
			HttpSession session = request.getSession(false);
			User user = (User) session.getAttribute("user");

			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);

			try {
				List<FileItem> items = upload.parseRequest(request);
				for (FileItem item : items) {
					//普通表单项
					if (item.isFormField()) {
						String name = item.getFieldName();
						String value = item.getString("UTF-8");
						System.out.println("name = " + name + " ; value = "+ value);
						
						if(name.equals("nickname")){
							user.setNickName(value);
						}else if(name.equals("age")){
							user.setAge(Integer.valueOf(value));
						}else if(name.equals("birthday")){
							user.setBirth(value);
						}else if(name.equals("star")){
							user.setStar(value);
						}else if(name.equals("email")){
							user.setEmail(value);
						}else if(name.equals("grade")){
							user.setGrade(Integer.valueOf(value));
						}else if(name.equals("banji")){
							user.setBanji(Integer.valueOf(value));
						}else if(name.equals("phonenumber")){
							user.setPhonenumber(value);
						}else if(name.equals("gender")){
							user.setGender(value);
						}else if(name.equals("newpwd")){
							//TODO 密码合法性判断
							if(!"".equals(value)){
								user.setPassWord(value);
							}
						}
					}else{
						//type 是 file 的表单项
						String name = item.getFieldName();
						String type = item.getContentType();
						System.out.println("name:"+name+",filename = " + item.getName()+","+"size="+item.getSize()+",type:"+type);
						
						//判断类型，保证是图片，且大小不为0
						if((type.equals(Constants.MIME_IMAGE_JPEG) || type.equals(Constants.MIME_IMAGE_PNG))
								&& item.getSize() > 0){
							user.setPhoto(item.getInputStream());
						}
						
//						File file = new File("d://"+new String(item.getName().getBytes("GBK"),"UTF-8"));
//						FileOutputStream fos = new FileOutputStream(file);
//						InputStream is = item.getInputStream();
//						byte[] buff = new byte[1024];
//						int len = -1;
//						while((len=is.read(buff)) != -1){
//							fos.write(buff,0,len);
//						}
//						fos.close();
//						is.close();
					}
				}
				
				//调用UserService方法更新数据
				UserService service = new UserServiceImpl();
				service.updateInfo(user);
				
				//更新成功
				response.getWriter().write("恭喜，修改成功！");
			} catch (Exception e) {
				e.printStackTrace();
				//TODO 更新失败
			}
		}		

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
