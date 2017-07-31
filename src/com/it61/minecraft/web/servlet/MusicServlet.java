package com.it61.minecraft.web.servlet;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MusicServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String path = getServletContext().getRealPath("/audio/Faded.mp3");
//		byte[] data = getBytesFromFile(new File("C:/media/final.mp4"));
		byte[] data = getBytesFromFile(new File(path));
		String diskfilename = "Faded.mp3";
		response.setContentType("vaudio/mp3");
		// response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + diskfilename + "\"");
		System.out.println("data.length " + data.length);
		response.setContentLength(data.length);
//		response.setHeader("Content-Range", range + Integer.valueOf(data.length - 1));
		response.setHeader("Accept-Ranges", "bytes");
//		response.setHeader("Etag", "W/\"9767057-1323779115364\"");
		byte[] content = new byte[1024];
		BufferedInputStream is = new BufferedInputStream(new ByteArrayInputStream(data));
		OutputStream os = response.getOutputStream();
		while (is.read(content) != -1) {
			os.write(content);
		}
		is.close();
		os.close();		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
	
	private static byte[] getBytesFromFile(File file) throws IOException {
		InputStream is = new FileInputStream(file);
		long length = file.length();
		if (length > Integer.MAX_VALUE) {
			return null;
		}
		byte[] bytes = new byte[(int) length];
		int offset = 0;
		int numRead = 0;
		while ((offset < bytes.length) && ((numRead = is.read(bytes, offset, bytes.length - offset)) >= 0)) {
			System.out.println("getBytesFromFile "+offset);
			offset += numRead;
		}
		if (offset < bytes.length) {
			throw new IOException("Could not completely read file " + file.getName());
		}
		is.close();
		return bytes;
	}


}
