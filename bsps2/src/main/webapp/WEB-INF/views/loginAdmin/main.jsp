<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 시스템 - 회원 관리..</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
    body { background-color: #f8f9fa; font-family: 'Malgun Gothic', sans-serif; }
    .admin-card { background: white; border-radius: 15px; border: none; box-shadow: 0 4px 20px rgba(0,0,0,0.08); margin-top: 50px; padding: 40px; }
    .table thead { background-color: #001f3f; color: white; border-radius: 10px; }
    .table-hover tbody tr:hover { background-color: #f1f3f5; transition: 0.3s; }
    
    /* 상태별 뱃지 스타일 */
    .status-badge { padding: 6px 12px; border-radius: 50px; font-size: 12px; font-weight: bold; display: inline-block; }
    .status-정상 { background-color: #d4edda; color: #155724; }
    .status-휴면 { background-color: #fff3cd; color: #856404; }
    .status-강퇴 { background-color: #f8d7da; color: #721c24; }
    
    .btn-group-sm .btn { font-size: 12px; font-weight: bold; margin-right: 2px; }
    .title-area { border-bottom: 2px solid #001f3f; padding-bottom: 15px; margin-bottom: 30px; }
</style>
</head>
<body>

<div class="container">
    <div class="admin-card">
        <div class="title-area d-flex justify-content-between align-items-center">
            <h2 class="text-dark"><i class="fas fa-user-shield mr-2"></i>회원 관리 리스트</h2>
            <span class="badge badge-dark p-2">관리자 전용</span>
        </div>

        <table class="table table-hover text-center">
            <thead>
                <tr>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>연락처</th>
                    <th>등급</th>
                    <th>회원 상태</th>
                    <th>상태 변경 관리</th>
                </tr>
            </thead>
				<tbody>
					<c:forEach items="${list}" var="vo">
						<%-- 1. admin이 아닐 때만 한 줄(tr)을 만듭니다 --%>
						<c:if test="${vo.id != 'admin'}">
							<tr>
								<td class="font-weight-bold">${vo.id}</td>
								<td>${vo.name}</td>
								<td>${vo.tel}</td>
								<td><span class="badge badge-info">${vo.gradeName}</span></td>
								<td><span class="status-badge status-${vo.status}">${vo.status}</span></td>
								<td>
									<div class="dropdown">
										<button
											class="btn btn-sm btn-outline-secondary dropdown-toggle"
											type="button" id="statusDrop${vo.id}" data-toggle="dropdown"
											aria-haspopup="true" aria-expanded="false">상태 변경</button>
										<div class="dropdown-menu shadow">
											<a
												class="dropdown-item text-success ${vo.status == '정상' ? 'active disabled' : ''}"
												href="/member/changeStatus.do?id=${vo.id}&status=정상">정상
												처리</a> <a
												class="dropdown-item text-warning ${vo.status == '휴면' ? 'active disabled' : ''}"
												href="/member/changeStatus.do?id=${vo.id}&status=휴면">휴면
												전환</a>
											<div class="dropdown-divider"></div>
											<a
												class="dropdown-item text-danger ${vo.status == '강퇴' ? 'active disabled' : ''}"
												href="/member/changeStatus.do?id=${vo.id}&status=강퇴">강제
												탈퇴</a>
										</div>
									</div>
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>

        <div class="mt-4 text-center">
            <a href="/main/main.do" class="btn btn-secondary px-5"><i class="fas fa-home mr-1"></i> 메인화면</a>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>