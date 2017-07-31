package com.it61.minecraft.web.servlet;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ValidateCodeServlet extends HttpServlet {
	private int width = 90;// 定义图片的width
	private int height = 40;// 定义图片的height
	private int codeCount = 4;// 定义图片上显示验证码的个数
	private int xx = 18;//绘制验证码时的x轴偏移量
	private int fontHeight = 35;
	private int codeY = 30;
	char[] codeSequence = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
			'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
			'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 禁止图像缓存。
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);

		//设置响应头
		response.setContentType("image/jpeg");

		// 将四位数字的验证码保存到Session中,便于之后验证
		String randomCode = generateRandomCode();
		HttpSession session = request.getSession();
		session.setAttribute("validate_code", randomCode);
		
		System.out.println("ValidateCodeServlet 随机码 "+randomCode);

		// 将图像输出到Servlet输出流中。
		BufferedImage image = generateImage(randomCode);
		ServletOutputStream sos = response.getOutputStream();
		ImageIO.write(image, "jpeg", sos);
		sos.flush();
		sos.close();

	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
	/**
	 * 生成随机码
	 * @return
	 */
	private String generateRandomCode(){
		// 创建一个随机数生成器类
		Random random = new Random();		
		// randomCode用于保存随机产生的验证码，以便用户登录后进行验证。
		StringBuffer randomCode = new StringBuffer();
		for (int i = 0; i < codeCount; i++) {
			// 得到随机产生的验证码数字。
			String code = String.valueOf(codeSequence[random.nextInt(36)]);
			// 将产生的四个随机数组合在一起。
			randomCode.append(code);
		}
		return randomCode.toString();
	}
	
	/**
	 * 生成随机码图像
	 * @param randomCode
	 * @return
	 */
	private BufferedImage generateImage(String randomCode){
		// 定义图像buffer
		BufferedImage buffImg = new BufferedImage(width, height,
				BufferedImage.TYPE_INT_RGB);
		Graphics gd = buffImg.getGraphics();
		
		// 创建一个随机数生成器类
		Random random = new Random();
		// 将图像填充为白色
		gd.setColor(Color.WHITE);
		gd.fillRect(0, 0, width, height);

		// 创建字体，字体的大小应该根据图片的高度来定。
		Font font = new Font("Fixedsys", Font.BOLD, fontHeight);
		// 设置字体。
		gd.setFont(font);

		// 画边框。
//		gd.setColor(Color.BLACK);
//		gd.drawRect(0, 0, width - 1, height - 1);

		// 随机产生40条干扰线，使图象中的认证码不易被其它程序探测到。
		gd.setColor(Color.BLACK);
		for (int i = 0; i < 20; i++) {
			int x = random.nextInt(width);
			int y = random.nextInt(height);
			int xl = random.nextInt(12);
			int yl = random.nextInt(12);
			gd.drawLine(x, y, x + xl, y + yl);
		}
		
		
		char[] codes = randomCode.toCharArray();
		int red = 0, green = 0, blue = 0;
		// 将验证码画在图片上
		for (int i = 0; i < codes.length; i++) {
			// 产生随机的颜色分量来构造颜色值，这样输出的每位数字的颜色值都将不同。
			red = random.nextInt(255);
			green = random.nextInt(255);
			blue = random.nextInt(255);

			// 用随机产生的颜色将验证码绘制到图像中。
			gd.setColor(new Color(red, green, blue));
			gd.drawString(codes[i]+"", (i + 1) * xx, codeY);
		}		
		
		return buffImg;
	}

}
