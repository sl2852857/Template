package com.hullsoft.entity.admin;

import java.util.List;

/**
 * Description:	菜单
 * Create DateTime: 2015年11月2日 下午1:51:58
 * @author xanxus
 */
public class Menu {
	private Integer id;				//id
	private String name;			//菜单名称
	private String url = "";		//菜单url
	private Integer parentID = 0;	//上级菜单id
	private Integer orderNum;		//菜单排序序号
	private List<Menu> menuList;	//下级菜单列表
	private Integer status= 1;		//状态：0-启用；1-未启用
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Integer getParentID() {
		return parentID;
	}
	public void setParentID(Integer parentID) {
		this.parentID = parentID;
	}
	public Integer getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}
	public List<Menu> getMenuList() {
		return menuList;
	}
	public void setMenuList(List<Menu> menuList) {
		this.menuList = menuList;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
	public Menu() {
		super();
	}
	public Menu(Integer id, String name, String url, Integer parentID) {
		super();
		this.id = id;
		this.name = name;
		this.url = url;
		this.parentID = parentID;
	}
	
}
