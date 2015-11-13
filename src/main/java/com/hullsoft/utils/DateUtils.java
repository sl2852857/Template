package com.hullsoft.utils;

import java.text.SimpleDateFormat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 时间处理工具类
 * @author Administrator
 *
 */
public class DateUtils {
	private static final Logger log = LoggerFactory.getLogger(DateUtils.class);
	/**
	 * 根据传入格式 pattern(例：yyyy-MM-dd) 获取当前时间
	 * 格式不正确返回空字符串
	 * @param pattern
	 * @return
	 */
	public static String now(String pattern){
		try {
			SimpleDateFormat format = new SimpleDateFormat(pattern);
			return format.format(System.currentTimeMillis());
		} catch (IllegalArgumentException e) {
			log.info("格式参数 [ "+pattern+" ]为无效参数，返回空字符串");
			return "";
		} catch (Exception e) {
			log.error("异常错误，返回null", e);
			return null;
		}
	}
	
	
}
