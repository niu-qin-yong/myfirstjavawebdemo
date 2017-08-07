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
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.it61.minecraft.bean.Album;
import com.it61.minecraft.bean.Picture;
import com.it61.minecraft.common.Constants;
import com.it61.minecraft.common.ImageResize;
import com.it61.minecraft.common.Utils;
import com.it61.minecraft.service.AlbumService;
import com.it61.minecraft.service.PictureService;
import com.it61.minecraft.service.impl.AlbumServiceImpl;
import com.it61.minecraft.service.impl.PictureServiceImpl;

public class AlbumUploadServet extends HttpServlet {

	private String userId;
	private String albumId;
	private String albumName;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 判断form表单的类型是否是 multipart/form-data
		if (ServletFileUpload.isMultipartContent(request)) {
			request.setCharacterEncoding("UTF-8");
			
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);

			try {
				List<FileItem> items = upload.parseRequest(request);
				//依次存放userid，albumid，picname
				List<Object> datas = new ArrayList<Object>();

				for (FileItem item : items) {
					// 普通表单项
					if (item.isFormField()) {
						String name = item.getFieldName();
						String value = item.getString("UTF-8");
						System.out.println("name = " + name + " ; value = "
								+ value);
						
						if(name.equals("userId")){
							userId = value;
						}else if(name.equals("albumId")){
							albumId = value;
						}else if(name.equals("albumName")){
							albumName = value;
						}
						
					} else {
						// type 是 file 的表单项
						String name = item.getFieldName();
						String type = item.getContentType();
						
						System.out.println("name:" + name + ",filename = "
								+ item.getName() + "," + "size="
								+ item.getSize() + ",type:" + type);

						// 判断类型，保证是图片，且大小不为0
						if ((type.equals(Constants.MIME_IMAGE_JPEG) || type
								.equals(Constants.MIME_IMAGE_PNG))
								&& item.getSize() > 0) {
							
							Picture pic = new Picture();
							pic.setUserId(Integer.valueOf(userId));
							pic.setAlbumId(Integer.valueOf(albumId));
							
							//保存图片在文件中
							//一个相册的图片放在一个目录下，用户名id，相册id分别作为目录名
							String realPath = getServletContext().getRealPath("/pictures");
							
							String filePath = realPath+"/"+pic.getUserId()+"/"+pic.getAlbumId();
							File pathFile = new File(filePath);
							if(!pathFile.exists()){
								//如果目錄不存在則创建
								pathFile.mkdirs();
							}
							
							File picFile = new File(filePath+"/"+item.getName());
							BufferedInputStream bis = new BufferedInputStream(item.getInputStream());
							BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(picFile));
							
							byte[] buf = new byte[1024*4];
							int len = -1;
							while((len = bis.read(buf)) != -1){
								bos.write(buf, 0, len);
							}
							
							bos.close();
							bis.close();
							
							//检测缩略图目录是否存在
							String thumbFilePath = filePath+"/thumb";
							File thumbPathFile = new File(thumbFilePath);
							if(!thumbPathFile.exists()){
								thumbPathFile.mkdirs();
							}
							//生成缩略图并保存在文件
							ImageResize.setWidthHeight(160, 160);
							BufferedImage img = ImageResize.resize(picFile.getAbsolutePath());
							String fileName = item.getName();
							ImageIO.write(img, fileName.substring(fileName.indexOf(".")+1), new File(thumbFilePath+"/"+fileName));
							
							//图片数据,存储数据库时用到
							datas.add(pic.getUserId());
							datas.add(pic.getAlbumId());
							datas.add(item.getName());
						}

					}
				}
				
				//保存图片数据到数据库
				AlbumService service = new AlbumServiceImpl();
				service.addPictures(datas.toArray());
				
				//将相册数据作为响应返回给客户端
				Album album = new Album(Integer.valueOf(userId),Integer.valueOf(albumId),albumName);
				
				PictureService picService = new PictureServiceImpl();
				List<Picture> pictures = picService.getPictures(album);
				album.setPics(pictures);
				
				JSON.DEFFAULT_DATE_FORMAT = "yyyy-MM-dd hh:mm:ss"; 
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(JSON.toJSONString(album,SerializerFeature.WriteDateUseDateFormat));
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
