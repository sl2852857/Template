<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; UTF-8">
<title>Insert title here</title>
</head>
<body>
	上传
	<br>
	<form action="/Template/admin/upload" method="post" enctype="multipart/form-data">
		<input type="file" name="file1">
		<input type="file" name="file2">
		<input type="file" name="file3">
		<input type="submit" value="上传">
	</form>
</body>
</html>