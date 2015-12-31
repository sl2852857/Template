package com.hullsoft.service;

import com.hullsoft.entity.common.Condition;
import com.hullsoft.entity.common.Page;

public interface IBaseService<T> {
	/**
	 * 持久化对象
	 * @param t
	 */
	void insert(T t) throws Exception;
	
	/**
	 * 持久化对象(选择性 - 字段key有value就插入数据)
	 * 可能因为ID为主键不可重复而抛出错误，持久化失败
	 * @param t
	 * @throws Exception 
	 */
	void insertSelective(T t) throws Exception;
	
	/**
	 * 持久化对象并返回自动生成的ID
	 * @param t
	 * @return
	 */
	Integer insertAndBackID(T t) throws Exception;
	
	/**
	 * 根据 ID 删除对象
	 * @param id
	 */
	void deleteById(Integer id);
	
	/**
	 * 根据 ID 修改对象
	 * @param t
	 * @throws Exception 
	 */
	void updateById(T t) throws Exception;
	
	/**
	 * 根据 ID 修改对象(选择性的)
	 * @param t
	 * @throws Exception 
	 */
	void updateByIdSelective(T t) throws Exception;
	
	/**
	 * 根据 condition 条件修改对象
	 * 条件以Key-Value形式传入
	 * @param map
	 */
	void updateByCondition(Condition condition);
	
	/**
	 * 根据 ID 查询对象
	 * @param id
	 * @return
	 */
	T selectById(Integer id);
	
	/**
	 * 根据 condition 条件查询对象
	 * 条件以Key-Value形式传入
	 * @param condition
	 * @return
	 */
	public T selectByCondition(Condition condition);
	
	/**
	 * 根据  Page 分页查询
	 * @param page
	 * @return
	 */
	public Page<T> selectList(Page<T> page);
}
