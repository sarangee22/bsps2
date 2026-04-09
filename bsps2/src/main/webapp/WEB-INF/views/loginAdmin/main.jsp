<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 시스템 - 회원 관리</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<style>
    body { background-color: #f0f2f5; font-family: 'Noto Sans KR', sans-serif; color: #333; }
    
    :root { --main-navy: #1a2a4e; --accent-blue: #3498db; }

    /* [수정] 1100px은 너무 좁아서 1400px로 폭만 넓혔습니다. (디자인은 그대로) */
    .container { max-width: 1400px; margin: 60px auto; }

    .admin-card { 
        background: white; 
        border-radius: 20px; 
        border: none; 
        box-shadow: 0 10px 30px rgba(0,0,0,0.05); 
        padding: 40px; 
    }

    .title-area { 
        margin-bottom: 35px; 
        display: flex; 
        justify-content: space-between; 
        align-items: flex-end;
    }
    
    .title-area h2 { 
        font-size: 28px; 
        font-weight: 700; 
        color: #1e293b; 
        margin: 0;
    }
    
    .title-area p { color: #64748b; margin: 5px 0 0 0; font-size: 14px; }

    .table { margin-bottom: 0; }
    .table thead th { 
        background-color: #f8fafc; 
        color: #475569; 
        font-weight: 600; 
        font-size: 14px; 
        border-top: none; 
        border-bottom: 2px solid #edf2f7; 
        padding: 15px;
        white-space: nowrap; /* [추가] 제목 안 겹치게 */
    }
    
    .table tbody td { 
        padding: 20px 15px; 
        vertical-align: middle; 
        font-size: 15px; 
        color: #1e293b;
        border-bottom: 1px solid #f1f5f9;
        white-space: nowrap; /* [추가] 내용 안 겹치게 */
    }

    /* [추가] 메뉴 잘리는 거 방지용 */
    .table-responsive { overflow: visible !important; }

    .table-hover tbody tr:hover { background-color: #f8fafc; transition: 0.2s; }

    .id-text { font-weight: 700; color: var(--main-navy); }

    .status-badge { 
        padding: 6px 14px; 
        border-radius: 8px; 
        font-size: 12px; 
        font-weight: 600; 
        display: inline-block; 
    }
    .status-정상 { background-color: #ecfdf5; color: #059669; }
    .status-휴면 { background-color: #fffbeb; color: #d97706; }
    .status-강퇴 { background-color: #fef2f2; color: #dc2626; }

    .grade-badge {
        background-color: #eff6ff;
        color: #2563eb;
        padding: 4px 10px;
        border-radius: 6px;
        font-size: 13px;
        font-weight: 500;
    }

    .btn-status-change {
        background-color: #fff;
        border: 1.5px solid #e2e8f0;
        color: #64748b;
        font-weight: 600;
        font-size: 13px;
        padding: 8px 16px;
        border-radius: 10px;
        transition: 0.2s;
    }

    .btn-status-change:hover {
        background-color: #f8fafc;
        border-color: #cbd5e1;
        color: #1e293b;
    }

    /* [수정] 드롭다운 메뉴가 버튼 바로 밑에 오게 살짝 조정 */
    .dropdown-menu {
        border: none;
        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        border-radius: 12px;
        padding: 8px;
        z-index: 1000;
    }

    .dropdown-item {
        padding: 10px 15px;
        font-size: 14px;
        font-weight: 500;
        border-radius: 8px;
        margin-bottom: 2px;
    }

    .btn-home {
        background-color: var(--main-navy);
        color: white;
        padding: 14px 40px;
        border-radius: 12px;
        font-weight: 700;
        font-size: 15px;
        transition: 0.3s;
        border: none;
    }

    .btn-home:hover {
        background-color: #233966;
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(26, 42, 78, 0.2);
    }
</style>
</head>
<body>

<div class="container">
    <div class="admin-card">
        <div class="title-area">
            <div>
                <h2>회원 관리 리스트</h2>
                <p>시스템에 가입된 회원들의 상태와 권한을 관리합니다.</p>
            </div>
            <span class="badge badge-dark px-3 py-2" style="border-radius: 8px; font-size: 12px;">ADMIN ONLY</span>
        </div>

        <div class="table-responsive">
            <table class="table table-hover text-center">
					<thead>
						<tr>
							<th>아이디</th>
							<th>이름</th>
							<th>성별</th>
							<th>생년월일</th>
							<th>연락처</th>
							<th>등급명</th>
							<th>등급번호</th>
							<th>회원 상태</th>
							<th>최근 접속일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="vo">
							<c:if test="${vo.id != 'admin'}">
								<tr class="dataRow" data-id="${vo.id}">
									<td class="id-text">${vo.id}</td>
									<td>${vo.name}</td>
									<td>${vo.gender}</td>
									<td>${vo.birth.substring(0, 10)}</td>
									<td>${vo.tel}</td>
									<td><span class="grade-badge">${vo.gradeName}</span></td>
									<td>${vo.gradeNo}</td>
									<td><span class="status-badge status-${vo.status}">${vo.status}</span></td>
									<td>${vo.conDate}</td>
									<td>
										<div class="dropdown">
											<button class="btn btn-status-change dropdown-toggle"
												type="button" data-toggle="dropdown">상태 변경</button>
											<div class="dropdown-menu dropdown-menu-right">
												<a class="dropdown-item text-success ${vo.status == '정상' ? 'active disabled' : ''}"
													href="/member/changeStatus.do?id=${vo.id}&status=정상">정상 처리</a> 
                                                <a class="dropdown-item text-warning ${vo.status == '휴면' ? 'active disabled' : ''}"
													href="/member/changeStatus.do?id=${vo.id}&status=휴면">휴면 전환</a>
												<div class="dropdown-divider"></div>
												<a class="dropdown-item text-danger ${vo.status == '강퇴' ? 'active disabled' : ''}"
													href="/member/changeStatus.do?id=${vo.id}&status=강퇴">강제 탈퇴</a>
											</div>
										</div>
									</td>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
        </div>

        <div class="mt-5 text-center">
            <a href="/main/main.do" class="btn btn-home">
                <i class="fas fa-home mr-2"></i>메인화면으로 돌아가기
            </a>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>