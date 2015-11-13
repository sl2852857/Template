package com.hullsoft.utils;


/**
 * 数字工具类
 * @author Administrator
 *
 */
public class MathUtils {
	public static String getRandomByLength(int length){
		return String.valueOf((int)(Math.random()*(9*Math.pow(10, length-1)) + Math.pow(10, length-1)));
	}
	
	
	public static void main(String[] args) {
	}
}
