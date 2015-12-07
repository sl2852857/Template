package com.hullsoft.utils;


/**
 * 数字工具类
 * @author Administrator
 *
 */
public class MathUtils {
	
	/**
	 * 
	 * @param length
	 * 		要获取的随机数的长度，最长9位;
	 * @return
	 * 		length长度的随机数
	 */
	public static String getRandomByLength(int length){
		return String.valueOf((int)(Math.random()*(9*Math.pow(10, length-1)) + Math.pow(10, length-1)));
	}
	
	
	
}
