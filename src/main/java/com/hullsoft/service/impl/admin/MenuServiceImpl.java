package com.hullsoft.service.impl.admin;


import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.hullsoft.dao.admin.IMenuDao;
import com.hullsoft.entity.admin.Menu;
import com.hullsoft.entity.common.Condition;
import com.hullsoft.service.admin.IMenuService;
import com.hullsoft.service.impl.BaseServiceImpl;

/**
 * Description:
 * Create DateTime: 2015年11月2日 下午4:35:57
 * @author xanxus
 */

@Service("menuService")
public class MenuServiceImpl extends BaseServiceImpl<Menu> implements IMenuService {
	private static final Logger log = LoggerFactory.getLogger(MenuServiceImpl.class);
	@Resource
	private IMenuDao menuDao;
	
	public List<Menu> selectList(Condition condition) {
		long startTime = System.currentTimeMillis();
		log.info("-------条件查询菜单列表 Start-------");
		log.info("查询条件："+JSON.toJSONString(condition));
		List<Menu> menuList = menuDao.selectList(condition);
		log.info("查询结果size="+menuList.size());
		log.info("耗时："+(System.currentTimeMillis() - startTime)+"ms");
		log.info("-------条件查询菜单列表 End-------");
		return menuList;
	}

	@Override
	public void deleteById(Integer id) {
		long startTime = System.currentTimeMillis();
		log.info("------删除菜单 Start------");
		Menu menu = super.selectById(id);
		if(menu!=null){
			//菜单存在，进行删除操作
			if(menu.getParentID()!=0){
				//非主菜单，直接删除
				log.info("删除子菜单 ["+menu.getName()+"]");
				super.deleteById(id);
			}else{
				//是主菜单，删除主菜单前删除子菜单
				for(Menu m:menu.getMenuList()){
					super.deleteById(m.getId());
				}
				//删除完主菜单后删除子菜单
				super.deleteById(menu.getId());
			}
		}else{
			//菜单未查询到，已删除或者ID不对
			log.info("菜单已删除");
		}
		log.info("耗时："+(System.currentTimeMillis() - startTime)+"ms");
		log.info("------删除菜单 End------");
	}
}
