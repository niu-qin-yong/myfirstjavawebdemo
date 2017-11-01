package com.it61.minecraft.common;

public class StringUtils {
	public static boolean isNotEmpty(String str){
		return (str != null)&&(!str.equals("")&&(!str.equals("null")));
	}
	
	/**
	 * 对 HTML 中特殊字符进行编码，比如 >、<、'、\n、\r等
	 * @param oldJson
	 * @return
	 */
	 public static String getJsonForJS(String oldJson) {  
        String newJson = oldJson;  
        newJson = newJson.replaceAll("\\'", "&#39;");
        return newJson;  
	 }  
	 
	 public static void main(String[] args) {
		String hi = "I'm back";
		String json = StringUtils.getJsonForJS(hi);
		System.out.println(json);
	}
}
