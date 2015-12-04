package com.hullsoft.entity.common;

import java.util.HashMap;

import com.alibaba.fastjson.JSON;

/**
 * Description:接口返回结果，设置state
 * Create DateTime: 2015年11月4日 上午11:24:44
 * @author xanxus
 */
public class Result extends HashMap<String, Object> {
	//成功状态
	public static final String SUCCESS = "success";
		
	//失败状态
	public static final String FAILURE = "failure";
		
	//系统异常状态
	public static final String ERROR = "error";
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public void setState(String state) {
		this.put("state", state);
	}
	
	public void setMsg(String msg) {
		this.put("msg", msg);
	}
	
	public String toJSONString(){
		return JSON.toJSONString(this);
	}

	/**
	 * 设置state='error',msg='错误类型'
	 * @param e
	 */
	public void setError(Exception e){
		this.put("state", ERROR);
		this.put("msg", e.getClass().getName());
	}
}
