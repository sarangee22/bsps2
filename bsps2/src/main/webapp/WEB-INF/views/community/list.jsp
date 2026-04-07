<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>제보 게시판.</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<style>
body {
        background-color: #f4f7f9;
        font-family: 'Noto Sans KR', sans-serif;
    }

.wrapper {
    max-width: 1200px; 
    margin: 80px auto;
    padding: 0 20px;
}

.header { margin-bottom: 30px; }
.title { font-size: 30px; font-weight: 800; color: #1A237E; }

/* 입체감을 더 살리기 위해 카드 전체 테두리 농도 살짝 조절 */
.table-card {
    background: white !important;
    border-radius: 25px !important;
    box-shadow: 0 15px 45px rgba(0, 0, 0, 0.15) !important;
    overflow: hidden;
    margin-bottom: 25px;
    border: 1px solid rgba(0, 0, 0, 0.05) !important;
}

.custom-table { width: 100%; border-collapse: collapse; }

/* 추가 보정: thead 영역 전체를 한 번 더 누릅니다. */
.custom-table thead {
    background-color: #e2e6ea !important;
    display: table-header-group; /* 렌더링 방식 강제 */
}

/*  */
.custom-table td {
    padding: 20px;
    text-align: center;
    color: #444;
    
    /* [수정] 선의 색상을 더 진하게(#dee2e6) 하고 두께를 1px로 확실하게 줍니다. */
    border-bottom: 1.5px solid #dee2e6 !important; 
}

/* 제목 행(th) 아래 선도 밸런스를 맞추기 위해 조금 더 진하게 고정 */
.custom-table th {
    padding: 20px 16px;
    font-size: 14px;
    color: #333 !important;
    text-align: center;
    font-weight: 800;
    background: linear-gradient(#e2e6ea, #e2e6ea) !important;
    background-color: #e2e6ea !important;

    
    filter: brightness(0.95);
}


.custom-table tbody tr:last-child td {
    border-bottom: none !important;
}

.text-left {
    text-align: left !important;
    padding-left: 25px !important;
    font-weight: 700;
}

.custom-table tr:hover { background: #fcfdff; cursor: pointer; }

.list-img {
    width: 50px; height: 50px; /* 크기 살짝 키움 */
    border-radius: 10px;
    object-fit: cover;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.button-area { margin-top: 15px; text-align: left; }
    .btn {
        display: inline-block;
        padding: 12px 22px !important; /* 커뮤니티와 동일한 패딩 */
        border-radius: 12px !important; /* 커뮤니티와 동일한 둥글기 */
        font-weight: 700 !important;    /* 커뮤니티와 동일한 글자 두께 */
        font-size: 1rem !important;     /* 글자 크기 일치 */
        text-decoration: none;
        border: none !important;
        transition: 0.2s;
        cursor: pointer;
    }
.btn-primary { background-color: #1A237E !important; color: white !important; }
.btn-primary:hover { background-color: #0d145c !important; }

.pagination-container { margin-top: 40px; display: flex; justify-content: center; }
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function(){
    $(".dataRow").click(function(){
        let no = $(this).find(".no").text();
        location = "view.do?no=" + no + "&inc=1&" + "${pageObject.pageQuery}";
    });
});
</script>

</head> 

<body>

<div class="wrapper">

    <div class="header">
        <div class="title">📢 제보 게시판</div>
    </div>

    <div class="table-card">
        <table class="custom-table">
            <thead>
                <tr>
                    <th style="width: 80px;">번호</th>
                    <th style="width: 100px;">이미지</th>
                    <th class="text-left">제목</th> 
                    <th >작성자</th>
                    <th style="width: 150px;">작성일</th>
                    <th style="width: 100px;">조회수</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty list}">
                    <tr><td colspan="6" style="padding: 50px;">등록된 데이터가 없습니다.</td></tr>
                </c:if>
                <c:forEach items="${list}" var="vo">
                    <tr class="dataRow">
                        <td class="no">${vo.no}</td>
                        <td>
                            <c:if test="${!empty vo.fileName}">
                                <img src="${vo.fileName}" class="list-img">
                            </c:if>
                        </td>
                        <td class="text-left">${vo.title}</td> <td>${vo.writer}</td>
                        <td>${vo.writeDate}</td>
                        <td>${vo.hit}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="button-area">
        <a href="writeForm.do?perPageNum=${pageObject.perPageNum}" class="btn btn-primary">
            제보하기
        </a>
    </div>

    <div class="pagination-container">
        <pageNav:pageNav listURI="list.do" pageObject="${pageObject}"/>
    </div>

</div>

</body>
</html>