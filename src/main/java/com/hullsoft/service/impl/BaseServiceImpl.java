package com.hullsoft.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.hullsoft.dao.IBaseDao;
import com.hullsoft.entity.common.Condition;
import com.hullsoft.entity.common.Page;
import com.hullsoft.service.IBaseService;

@Service
public abstract class BaseServiceImpl<T> implements IBaseService<T> {
	private static final Logger log = LoggerFactory.getLogger(BaseServiceImpl.class);
	
	@Autowired
	private IBaseDao<T> baseDao;
	
	@Transactional
	public void insert(T t) throws Exception {
		long startTime = System.currentTimeMillis();
		log.info("------持久化对象 Start------");
		try {
			log.info("持久化对象："+JSON.toJSONString(t));
			baseDao.insert(t);
		} catch (Exception e) {
			throw e;
		} finally {
			log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
			log.info("------持久化对象 End------");
		}
	}

	@Transactional
	public Integer insertAndBackID(T t) throws Exception{
		log.info("------持久化对象(返回对象ID) Start------");
		long startTime = System.currentTimeMillis();
		try {
		log.info("持久化对象(返回对象ID)："+JSON.toJSONString(t));
		this.baseDao.insert(t);
		Integer id = this.baseDao.selectLastInsertId();
		log.info("返回ID："+id);
		return id;
		} catch (RuntimeException e) {
			throw e;
		} finally {
			log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
			log.info("------持久化对象(返回对象ID) End------");
		}
	}

	public void deleteById(Integer id) {
		log.info("------删除对象 Start------");
		long startTime = System.currentTimeMillis();
		log.info("删除对象：ID="+id);
		this.baseDao.deleteByPrimaryKey(id);
		log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
		log.info("------删除对象 End------");
	}

	@Transactional
	public void updateById(T t) throws Exception{
		log.info("------修改对象 Start------");
		long startTime = System.currentTimeMillis();
		try {
			log.info("修改对象："+JSON.toJSONString(t));
			this.baseDao.updateByPrimaryKey(t);
		} catch (Exception e) {
			throw e;
		} finally {
			log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
			log.info("------修改对象 End------");
		}
	}

	public T selectById(Integer id) {
		log.info("------查询对象 Start------");
		long startTime = System.currentTimeMillis();
		log.info("查询对象：ID="+id);
		T t = this.baseDao.selectByPrimaryKey(id);
		log.info("查询结果："+JSON.toJSONString(t));
		log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
		log.info("------查询对象 End------");
		return t;
	}

	public T selectByCondition(Condition condition) {
		log.info("------根据条件查询对象 Start------");
		long startTime = System.currentTimeMillis();
		log.info("查询条件："+JSON.toJSONString(condition));
		T t = this.baseDao.selectByCondition(condition);
		log.info("查询结果："+JSON.toJSONString(t));
		log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
		log.info("------根据条件查询对象 End------");
		return t;
	}

	/**
	 * 根据 page 查询对象集合
	 * page 中可包含 condition 条件
	 * 设置 page.isLimit() 是否分页查询
	 */
	public Page<T> selectList(Page<T> page) {
		log.info("------根据page查询对象列表 Start------");
		long startTime = System.currentTimeMillis();
		log.info("查询对象：page="+JSON.toJSONString(page));
		List<T> result = this.baseDao.selectList(page);
		Integer dataCount = result.size();
		page.setDataCount(dataCount);
		page.setResult(result);
		log.info("查询结果集合size："+(result.size()));
		log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
		log.info("------根据page查询对象列表 End------");
		return page;
	}

	/**
	 * 根据 condition 条件修改对象
	 * 条件以Key-Value形式传入
	 * 抽象方法，需要时继承该类并重写方法实现
	 */
	public void updateByCondition(Condition condition) {
		log.info("------根据条件修改对象 Start------");
		long startTime = System.currentTimeMillis();
		log.info("修改条件："+JSON.toJSONString(condition));
		this.baseDao.updateByCondition(condition);
		log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
		log.info("------根据条件修改对象 End------");
	}

	@Transactional
	public void insertSelective(T t) throws Exception{
		log.info("------持久化对象(选择性) Start------");
		long startTime = System.currentTimeMillis();
		try {
			log.info("持久化对象(选择性)："+JSON.toJSONString(t));
			this.baseDao.insertSelective(t);
		} catch (Exception e) {
			log.error("持久化对象失败，可能ID冲突", e);
			log.info("------持久化对象 End------");
			throw new RuntimeException();
		}
		log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
		log.info("------持久化对象(选择性) End------");
	}


	/*
	 * 事务回滚示例代码，事务回滚多用于批量操作
	 * @Transactional
	public void updateById(T t) throws Exception {
		try {
			this.baseDao.updateByPrimaryKey(t);
		} catch(Exception e) {
			log.error("修改数据异常，进行事务回滚", e);
			throw new RuntimeException();
		}
	}
	 */
}
