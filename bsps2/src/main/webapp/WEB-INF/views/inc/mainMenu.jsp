<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 문자열 포함 여부를 체크하기 위해 functions 태그라이브러리 추가 --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- 현재 페이지의 URI를 가져옴 --%>
<c:set var="uri" value="${pageContext.request.servletPath}" />

<nav class="navbar navbar-expand-sm navbar-dark bg-dark fixed-top">
  <div class="container-fluid">
    <a class="navbar-brand" href="/">재난 정보 사이트</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="mynavbar">
      
      <%-- 🔥 수정된 조건문: 주소에 'main'이라는 글자가 포함되어 있지 않을 때만 메뉴 출력 --%>
      <c:if test="${ !fn:contains(uri, 'main') }">
          <ul class="navbar-nav me-auto">
            <li class="nav-item"><a class="nav-link" href="/community/list.do">제보게시판</a></li>
            <li class="nav-item"><a class="nav-link" href="/quiz/list.do">퀴즈</a></li>
            <li class="nav-item"><a class="nav-link" href="/edu/list.do">교육</a></li>
            <li class="nav-item"><a class="nav-link" href="/item/list.do">체크리스트</a></li>
            <li class="nav-item"><a class="nav-link" href="/disasterCategory/list.do">재난목록</a></li>
            <li class="nav-item"><a class="nav-link" href="/disasterList/list.do">재난리스트</a></li>
            <li class="nav-item"><a class="nav-link" href="/scrap/list.do">스크랩</a></li>
            <li class="nav-item"><a class="nav-link" href="/agency/list.do">재난기관</a></li>
            <li class="nav-item"><a class="nav-link" href="/disasterMap/list.do">실시간재난현황</a></li>
            <li class="nav-item"><a class="nav-link" href="/qna/list.do">질문답변</a></li>
           
            <c:if test="${!empty login && login.gradeNo == 9 }">
               <li class="nav-item"><a class="nav-link" href="/member/list.do">회원관리</a></li>
            </c:if>
          </ul>
      </c:if>

      <%-- 로그인 관련 메뉴는 주소 상관없이 항상 우측 정렬 --%>
      <ul class="navbar-nav ms-auto d-flex justify-content-end">
         <c:if test="${empty login }">
           <li class="nav-item"><a class="nav-link" href="/member/loginForm.do">로그인</a></li>
           <li class="nav-item"><a class="nav-link" href="/member/writeForm.do">회원가입</a></li>
         </c:if>
         <c:if test="${!empty login }">
           <li class="nav-item"><a class="nav-link" href="/member/view.do">${login.name }(${login.gradeName })</a></li>
           <li class="nav-item"><a class="nav-link" href="/member/logout.do">로그아웃</a></li>
           <li class="nav-item"><a class="nav-link" href="/member/changePwForm.do">비밀번호 변경</a></li>
           <li class="nav-item"><a class="nav-link" href="/member/deleteForm.do">회원 탈퇴</a></li>
         </c:if>
      </ul>
    </div>
  </div>
</nav>