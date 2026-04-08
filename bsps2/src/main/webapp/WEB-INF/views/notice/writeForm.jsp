<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리</title>

<style type="text/css">
    body { background-color: #f4f7f6; font-family: 'Pretendard', sans-serif; }
    
    /* 입력 폼 카드 스타일 */
    .form-card {
        background: white;
        border-radius: 25px;
        padding: 40px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.05);
        margin-top: 50px;
        border: 1px solid rgba(0,0,0,0.03);
    }

    .form-header {
        border-bottom: 2px solid #f1f3f5;
        padding-bottom: 20px;
        margin-bottom: 30px;
    }
    .form-header h2 { font-weight: 800; color: #1a237e; letter-spacing: -1px; }

    /* 라벨 및 입력창 스타일 */
    .form-label { font-weight: 700; color: #495057; margin-bottom: 10px; }
    .form-control {
        border-radius: 12px;
        padding: 12px 15px;
        border: 1px solid #dee2e6;
        transition: all 0.3s;
    }
    .form-control:focus {
        border-color: #5c67f2;
        box-shadow: 0 0 0 0.25rem rgba(92, 103, 242, 0.1);
    }

    /* 날짜 입력창 아이콘 배경 */
    .datepicker {
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%23666' class='bi bi-calendar' viewBox='0 0 16 16'%3E%3Cpath d='M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 15px center;
        cursor: pointer !important;
        background-color: #fff !important;
    }

    /* 버튼 스타일 */
    .btn-custom { border-radius: 10px; padding: 12px 30px; font-weight: 600; }
</style>

<script type="text/javascript">
$(function(){
    $(".cancelBtn").click(function(){ history.back(); });
    
    // datepicker 설정 (기존 로직 유지)
    $(".datepicker").datepicker({
         changeMonth: true,
         changeYear: true,
         dateFormat: "yy-mm-dd",
         dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
         monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
    });

    $("#startDate").datepicker("option", {
        "minDate" : new Date(),
        onClose : function(selectedDate) {
            if($(this).val() != "") $("#endDate").datepicker("option", "minDate", selectedDate);
        }
    });
    
    $("#endDate").datepicker("option", {
        "minDate" : new Date(),
        onClose : function(selectedDate) {
            if($(this).val() != "") $("#startDate").datepicker("option", "maxDate", selectedDate);
        }
    });
});
</script>
</head>
<body>

<div class="container">
    <div class="form-card">
        <div class="form-header">
            <h2><i class="bi bi-pencil-square me-2 text-primary"></i> 공지사항 ${empty vo ? '등록' : '수정'}</h2>
            <p class="text-muted small">공지 시작일과 종료일을 설정하여 사용자에게 알림을 전달하세요.</p>
        </div>

        <form action="${empty vo ? 'write.do' : 'update.do'}" method="post">
            <input type="hidden" name="no" value="${vo.no}">
            <input type="hidden" name="page" value="${param.page}">
            <input type="hidden" name="perPageNum" value="${param.perPageNum}">
            <input type="hidden" name="key" value="${param.key}">
            <input type="hidden" name="word" value="${param.word}">
            <input type="hidden" name="period" value="${param.period}">

            <div class="mb-4">
                <label for="title" class="form-label">공지 제목</label>
                <input type="text" class="form-control" id="title" name="title" 
                       placeholder="제목을 입력하세요." required value="${vo.title}">
            </div>
            
            <div class="mb-4">
                <label for="content" class="form-label">공지 내용</label>
                <textarea class="form-control" rows="8" id="content" name="content" 
                          required placeholder="공지 상세 내용을 입력하세요.">${vo.content}</textarea>
            </div>
            
            <div class="row">
                <div class="col-md-6 mb-4">
                    <label for="startDate" class="form-label">공지 시작일</label>
                    <input type="text" class="form-control datepicker" id="startDate" 
                           name="startDate" placeholder="날짜 선택" autocomplete="off" readonly value="${vo.startDate}">
                </div>
                <div class="col-md-6 mb-4">
                    <label for="endDate" class="form-label">공지 종료일</label>
                    <input type="text" class="form-control datepicker" id="endDate" 
                           name="endDate" placeholder="날짜 선택" autocomplete="off" readonly value="${vo.endDate}">
                </div>
            </div>

            <div class="mt-4 text-center">
                <button type="submit" class="btn btn-primary btn-custom shadow-sm me-2">
                    <i class="bi bi-check-lg"></i> ${empty vo ? '등록하기' : '수정완료'}
                </button>
                <button type="reset" class="btn btn-warning btn-custom shadow-sm me-2 text-white">
                    <i class="bi bi-arrow-counterclockwise"></i> 다시입력
                </button>
                <button type="button" class="cancelBtn btn btn-outline-secondary btn-custom">
                    <i class="bi bi-x-lg"></i> 취소 
                </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>