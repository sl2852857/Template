package com.hullsoft.dao;

import java.util.List;

import com.hullsoft.entity.common.Condition;
import com.hullsoft.entity.common.Page;


/**
 * Dao - 操作数据库(spring-mybatis.xml扫描dao并生成代理交由spring管理，无impl)
 * @author Administrator
 *
 * @param <T>
 */
public interface IBaseDao<T> {
	/**
	 * 持久化数据(ID自动生成)
	 * @param t
	 */
	public int insert(T t);
	
	/**
	 * 持久化数据(选择性，若字段有数据则插入对应字段数据)
	 * @param t
	 * @return
	 */
	public int insertSelective(T t);
	
	/**
	 * 持久化数据(返回新增数据自动生成的主键ID)
	 * @return
	 */
	public Integer selectLastInsertId();
	
	/**
	 * 根据 ID 删除数据
	 * @param id
	 * @return
	 */
	public int deleteByPrimaryKey(Integer id);
	
	/**
	 * 根据 ID 修改数据(非选择性)
	 * @param t
	 */
	public int updateByPrimaryKey(T t);
	
	/**
	 * 根据 ID 修改数据(选择性)
	 * @param t
	 */
	public void updateByPrimaryKeySelective(T t);

	/**
	 * 根据 condition 条件查询数据
	 * @param condition
	 * @return
	 */
	public T selectByCondition(Condition condition);
	
	/**
	 * 根据 ID 查询数据
	 * @param id 
	 * @return
	 */
	public T selectByPrimaryKey(Integer id);

	/**
	 * 根据 page 查询数据
	 * @return
	 */
	public List<T> selectList(Page<T> page);

	/**
	 * 根据 condition 条件修改对象
	 * @param condition
	 */
	public void updateByCondition(Condition condition);
}
