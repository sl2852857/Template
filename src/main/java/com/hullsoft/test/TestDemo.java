package com.hullsoft.test;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * Description:
 * Create DateTime: 2015年12月22日 上午10:15:05
 * @author xanxus
 */
public class TestDemo {
	public static void main(String[] args) {
		List<String> list = new CopyOnWriteArrayList<String>();
		
		list.add("1");
		if(list.iterator().hasNext()) {
			String str =list.iterator().next();
			System.out.println(str);
		}
	}
}
