<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재난 등록</title>
</head>

<body>

<h2>재난 등록</h2>

<form action="write.do" method="post">

재난 이름  
<input type="text" name="disasterName"><br>

재난 유형  
<input type="text" name="disasterType"><br>

지역  
<input type="text" name="region"><br>

주소  
<input type="text" name="address"><br>

위도  
<input type="text" name="latitude"><br>

경도  
<input type="text" name="longitude"><br>

내용  
<textarea name="content"></textarea><br>

<button type="submit">등록</button>

</form>

</body>
</html>