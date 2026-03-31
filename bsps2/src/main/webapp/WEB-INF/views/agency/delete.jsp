<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="mt-3 text-center">
		<a href="list.do" class="btn btn-secondary">목록</a> <a
			href="updateForm.do?id=${vo.id}" class="btn btn-warning">수정</a> <a
			href="delete.do?id=${vo.id}" class="btn btn-danger"
			onclick="return confirm('정말로 이 기관 정보를 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.')">
			삭제 </a>
	</div>

</body>
</html>