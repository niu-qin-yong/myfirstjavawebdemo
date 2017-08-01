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
		
		String name = request.getParameter("name");
		System.out.println("MusicServlet:name  "+name);
		
		String path = getServletContext().getRealPath(name);
		File file = new File(path);
		byte[] data = getBytesFromFile(file);
		
		response.setContentType("audio/mp3");
		response.setContentLength(data.length);
		
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
		int offset = is.read(bytes);
		
		if (offset < bytes.length) {
			throw new IOException("Could not completely read file " + file.getName());
		}
		
		is.close();
		
		return bytes;
	}


}
