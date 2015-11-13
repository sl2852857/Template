package com.hullsoft.common;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hullsoft.utils.DateUtils;

public class UtilsTest {
	Logger log = LoggerFactory.getLogger(UtilsTest.class);
	
	@Test
	public void test(){
		System.out.println(DateUtils.now("yyyy-MM-dd"));
	}

}
