<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재난 상세보기</title>
</head>
<body>

<h2>재난 상세보기</h2>

재난명 : ${vo.disasterName} <br>
유형 : ${vo.disasterType} <br>
지역 : ${vo.region} <br>
주소 : ${vo.address} <br>

위도 : ${vo.latitude} <br>
경도 : ${vo.longitude} <br>

내용 : ${vo.content} <br>

<a href="list.do">목록</a>

</body>
</html>