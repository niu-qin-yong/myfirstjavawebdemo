package com.it61.minecraft.web.servlet;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.it61.minecraft.bean.Album;
import com.it61.minecraft.bean.Music;
import com.it61.minecraft.bean.Picture;
import com.it61.minecraft.common.Constants;
import com.it61.minecraft.common.ImageResize;
import com.it61.minecraft.service.AlbumService;
import com.it61.minecraft.service.MusicService;
import com.it61.minecraft.service.PictureService;
import com.it61.minecraft.service.impl.AlbumServiceImpl;
import com.it61.minecraft.service.impl.MusicServiceImpl;
import com.it61.minecraft.service.impl.PictureServiceImpl;

public class MusicUploadServet extends HttpServlet {

	private int userId;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 判断form表单的类型是否是 multipart/form-data
		if (ServletFileUpload.isMultipartContent(request)) {
			request.setCharacterEncoding("UTF-8");
			
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);

			try {
				List<FileItem> items = upload.parseRequest(request);
				
				Music music = new Music();
				music.setServerSide(0);
				
				for (FileItem item : items) {
					// 普通表单项
					if (item.isFormField()) {
						String name = item.getFieldName();
						String value = item.getString("UTF-8");
						System.out.println("name = " + name + " ; value = "
								+ value);
						
						if(name.equals("userId")){
							userId = Integer.valueOf(value);
							music.setUserId(userId);
						}else if(name.equals("singer")){
							music.setSinger(value);
						}
						
					} else {
						// type 是 file 的表单项
						String type = item.getContentType();
						
						String path = null;

						// 判断类型，保证是图片，且大小不为0
						if (type.equals(Constants.MIME_AUDIO_MPEG)
								&& item.getSize() > 0) {
							
							music.setMusic("audio/"+userId+"/"+item.getName());
							String title = item.getName().substring(0,item.getName().indexOf("."));
							music.setTitle(title);
							
							//保存音乐在文件中，放在目录 audio/userId/ 下
							path = getServletContext().getRealPath("/audio/"+userId);
							
							
						}else if(type.equals(Constants.MIME_IMAGE_JPEG) || type.equals(Constants.MIME_IMAGE_PNG)
								&& item.getSize() > 0){
							
							music.setPoster("poster/"+userId+"/"+item.getName());
							
							//保存封面在文件中，放在目录 poster/userId/ 下
							path = getServletContext().getRealPath("/poster/"+userId);
							
						}
						System.out.println(item.getName()+" type:"+type+" path:"+path);
						File pathFile = new File(path);
						if(!pathFile.exists()){
							//如果目錄不存在則创建
							pathFile.mkdirs();
						}
						
						//将二进制数据写到文件中
						File file = new File(path+"/"+item.getName());
						BufferedInputStream bis = new BufferedInputStream(item.getInputStream());
						BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(file));
						byte[] buf = new byte[1024*4];
						int len = -1;
						while((len = bis.read(buf)) != -1){
							bos.write(buf, 0, len);
						}
						
						bos.close();
						bis.close();

					}
					
				}
				
				//保存音乐数据到数据库
				MusicService service = new MusicServiceImpl();
				service.addMusics(music);
				
				//TODO 将我的音乐作为响应返回给客户端
				Music latestMusic = service.getLatestMusic(userId);
				String json = JSON.toJSONString(latestMusic);
				
				System.out.println("latestMusic  "+json);
				
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(json);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
