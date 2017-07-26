package com.it61.minecraft.common;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.PropertyFilter;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.it61.minecraft.bean.Moment;

public class Utils {
	/**
	 * 使用FastJson将Moment对象或者List<Moment>序列化为JSON string
	 * @param moment
	 * @return
	 */
	public static String FastJsontoJsonString(Object momentsth){
		//过滤不需要序列化的属性
		PropertyFilter filter = new PropertyFilter(){

			@Override
			public boolean apply(Object obj, String name, Object value) {
				//返回false表示过滤
				if(name.equals("pic")){
					return false;
				}
				return true;
			}
			
		};
		//设置时间格式
		JSON.DEFFAULT_DATE_FORMAT = "yyyy-MM-dd hh:mm:ss"; 
		
		return JSON.toJSONString(momentsth,filter,SerializerFeature.WriteDateUseDateFormat);

	}
	
    /**
     * Filter the specified message string for characters that are sensitive
     * in HTML.  This avoids potential attacks caused by including JavaScript
     * codes in the request URL that is often reported in error messages.
     *
     * @param message The message string to be filtered
     */
    public static String htmlFilter(String message) {

        if (message == null)
            return (null);

        char content[] = new char[message.length()];
        message.getChars(0, message.length(), content, 0);
        StringBuilder result = new StringBuilder(content.length + 50);
        for (int i = 0; i < content.length; i++) {
            switch (content[i]) {
            case '<':
                result.append("&lt;");
                break;
            case '>':
                result.append("&gt;");
                break;
            case '&':
                result.append("&amp;");
                break;
            case '"':
                result.append("&quot;");
                break;
            default:
                result.append(content[i]);
            }
        }
        return (result.toString());

    }
}
