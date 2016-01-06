<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layouts/taglibs.jsp"%>
<!DOCTYPE html>
<html>
  <script type="text/javascript">
  </script>
  <div class="table-products section">
	<div class="row-fluid head">
	  <div class="span12">
		<h4>系统用户管理<small>>> 用户列表</small></h4>
	  </div>
	</div>
	<div class="row-fluid filter-block">
	  <div class="left">
		<input type="text" class="search" id="searchValue" onkeypress="EnterPress(event)" value="${searchValue }"/>
		<a class="btn-flat new-product" href="javascript:loadUrl('admin/toAddOrEdit.do?method=add')">+ 添加角色</a>
	  </div>
	</div>
	<!-- 数据加载区域 -->
	<div class="row-fluid" id="dataContent"></div>
	<!-- 分页 -->
	<div class="pagination"></div>
  </div>
  <script type="text/javascript">
  	//记录翻页页码
  	var pageIndex = '0';
  	$(function(){
  		$(".pagination").pagination('${page.dataCount}', {
            callback: pageSelectCallback,//pageSelectCallback() 为翻页调用次函数。
            prev_text: "上一页",
            next_text: "下一页 ",
            items_per_page: '${page.pageSize}', //每页的数据个数
            num_display_entries: 3, //两侧首尾分页条目数
            current_page: 0,   //当前页码
            num_edge_entries: 2 //连续分页主体部分分页条目数
        });
  	})
  	
  	function pageSelectCallback(page_id, jq) {
		loadData(page_id);
	}	
  	
  	//搜索文本框触发事件
  	function EnterPress(e) { //传入 event
		var e = e || window.event;
		if(e.keyCode == 13){
  			var searchValue = $.trim($("#searchValue").val());
			loadUrl('admin/list.do?searchValue='+encodeURI(encodeURI(searchValue)));
		}
	} 
  	
  	//加载数据  page_id页码，第一页为0
  	function loadData(page_id) {
  		if(page_id != ''){
	  		pageIndex = page_id;
  		}else {
  			page_id = pageIndex;
  		}
  		var searchValue = $.trim($("#searchValue").val());
  		$.get("${base}/admin/data.do?searchValue="+encodeURI(encodeURI(searchValue))+"&pageIndex="+(page_id+1), function(html) {
  			$("#dataContent").html(html);
  		})
  	}
  </script>
</html>