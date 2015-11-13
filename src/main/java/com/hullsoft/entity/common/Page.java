package com.hullsoft.entity.common;

import java.util.List;

/**
 * Description: 分页
 * Create DateTime: 2015年11月2日 下午1:57:02
 * @author xanxus
 */
public class Page<T> {
	private int pageCount;	//总页数
	private int pageSize = 10;	//页容量
	private int pageIndex = 1;	//页码
	private int startIndex;	//查询起始下标(pageSize*(pageIndex-1))
	private int dataCount;	//总记录数
	private boolean isLimit = true;//是否分页查询
	private Condition condition = new Condition();	//条件集合
	private List<T> result;	//查询结果
	
	public List<T> getResult() {
		return result;
	}

	public void setResult(List<T> result) {
		this.result = result;
	}

	public int getPageCount() {
		this.pageCount = ((this.dataCount-1)/this.pageSize)+1;
		return pageCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getStartIndex() {
		this.startIndex = this.pageSize * (this.pageIndex - 1);
		return startIndex;
	}

	public int getDataCount() {
		return dataCount;
	}

	public void setDataCount(int dataCount) {
		this.dataCount = dataCount;
	}

	public boolean isLimit() {
		return isLimit;
	}

	public void setLimit(boolean isLimit) {
		this.isLimit = isLimit;
	}

	public Condition getCondition() {
		return condition;
	}

	public void setCondition(Condition condition) {
		this.condition = condition;
	}
	
	/**
	 * 设置条件condition.put("searchValue", "关键字");
	 * @param searchValue
	 */
	public void setSearchValue(String searchValue) {
		searchValue = searchValue==null?"":searchValue;
		this.condition.put(Condition.SEARCH_VALUE, searchValue);
	}
}
