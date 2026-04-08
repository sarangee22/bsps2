<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재난 정보 사이트 - 통합 메인</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

<style>
    body { background-color: #f8f9fa; font-family: 'Noto Sans KR', sans-serif; }
    .main-container { margin-top: 80px; padding-bottom: 70px; }
    .welcome-header { text-align: center; margin-bottom: 60px; }
    .welcome-header h1 { font-weight: 700; color: #333; margin-bottom: 10px; font-size: 32px; }

    .group-title { text-align: left; font-weight: 700; margin-bottom: 25px; padding-bottom: 15px; border-bottom: 2px solid #e9ecef; font-size: 24px; color: #2c3e50; }
    .group-title i { margin-right: 10px; }

    .menu-box { background: #fff; border-radius: 15px; padding: 35px 10px; margin-bottom: 25px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); transition: transform 0.3s, box-shadow 0.3s; text-decoration: none !important; display: block; height: 100%; border-top: 5px solid transparent; text-align: center; }
    .menu-box:hover { transform: translateY(-10px); box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1); background-color: #ffffff; }
    .menu-box i { font-size: 40px; margin-bottom: 18px; display: block; }
    .menu-box span { display: block; font-size: 16px; font-weight: 600; color: #444; }

    .col-5-custom { flex: 0 0 20%; max-width: 20%; position: relative; width: 100%; padding-right: 15px; padding-left: 15px; }

    .color-map { color: #d63031; border-top-color: #d63031; }
    .color-community { color: #e84393; border-top-color: #e84393; }
    .color-agency { color: #e17055; border-top-color: #e17055; }
    .color-check { color: #0984e3; border-top-color: #0984e3; }
    .color-cat { color: #6c5ce7; border-top-color: #6c5ce7; }
    .color-edu { color: #00b894; border-top-color: #00b894; }
    .color-quiz { color: #fdcb6e; border-top-color: #fdcb6e; }
    .color-qna { color: #2d3436; border-top-color: #2d3436; }
    .color-scrap { color: #b2bec3; border-top-color: #b2bec3; }
    .color-notice { color: #1a2a4e; border-top-color: #1a2a4e; }
</style>
</head>
<body>

    <div class="container main-container">
        <div class="welcome-header">
            <h1>🛡️ 재난 안전 통합 서비스</h1>
        </div>

        <h3 class="group-title">
            <i class="fas fa-exclamation-triangle text-danger"></i> 실시간 대응
        </h3>
        <div class="row mb-5">
            <div class="col-md-6">
                <a href="/disasterMap/list.do" class="menu-box color-map">
                    <i class="fas fa-map-marked-alt"></i> <span>실시간재난현황</span>
                </a>
            </div>
            <div class="col-md-6">
                <a href="/community/list.do" class="menu-box color-community">
                    <i class="fas fa-edit"></i> <span>제보게시판</span>
                </a>
            </div>
        </div>

        <h3 class="group-title">
            <i class="fas fa-shield-alt text-primary"></i> 안전 준비
        </h3>
        <div class="row mb-5">
            <div class="col-md-4">
                <a href="/agency/list.do" class="menu-box color-agency">
                    <i class="fas fa-hospital-symbol"></i> <span>재난기관</span>
                </a>
            </div>
            <div class="col-md-4">
                <a href="/item/list.do" class="menu-box color-check">
                    <i class="fas fa-clipboard-check"></i> <span>체크리스트</span>
                </a>
            </div>
            <div class="col-md-4">
                <a href="/disasterCategory/list.do" class="menu-box color-cat">
                    <i class="fas fa-th-list"></i> <span>재난목록</span>
                </a>
            </div>
        </div>

        <h3 class="group-title">
            <i class="fas fa-book-open text-success"></i> 참여 및 학습
        </h3>
        <div class="row">
            <div class="col-5-custom">
                <a href="/edu/list.do" class="menu-box color-edu">
                    <i class="fas fa-user-graduate"></i> <span>교육</span>
                </a>
            </div>
            <div class="col-5-custom">
                <a href="/quiz/list.do" class="menu-box color-quiz">
                    <i class="fas fa-puzzle-piece"></i> <span>퀴즈</span>
                </a>
            </div>
            <div class="col-5-custom">
                <a href="/qna/list.do" class="menu-box color-qna">
                    <i class="fas fa-comments"></i> <span>질문답변</span>
                </a>
            </div>
            <div class="col-5-custom">
                <a href="/scrap/list.do" class="menu-box color-scrap">
                    <i class="fas fa-bookmark"></i> <span>스크랩</span>
                </a>
            </div>
            <div class="col-5-custom">
                <a href="/notice/list.do" class="menu-box color-notice">
                    <i class="fas fa-bullhorn"></i> <span>공지사항</span>
                </a>
            </div>
        </div>
    </div>

</body>
</html>