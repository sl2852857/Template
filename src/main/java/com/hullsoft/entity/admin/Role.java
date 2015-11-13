package com.hullsoft.entity.admin;

import java.util.List;

/**
 * Description: 角色
 * Create DateTime: 2015年11月2日 下午1:57:02
 * @author xanxus
 */
public class Role {
	private Integer id;
	private String name;			//角色名
	private List<Menu> menuList;	//角色拥有的菜单
	private String createTime;		//创建时间
	private String lastUpdateTime;	//最后修改时间
	private Integer status;			//状态：0-启用，1-停用
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public List<Menu> getMenuList() {
		return menuList;
	}
	public void setMenuList(List<Menu> menuList) {
		this.menuList = menuList;
	}
	public String getLastUpdateTime() {
		return lastUpdateTime;
	}
	public void setLastUpdateTime(String lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}
}
