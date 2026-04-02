<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문답변 삭제</title>
<style>
    /* 기존 로그인/회원가입 화면과 통일감을 주는 네이비 테마 */
    :root { --navy-color: #001f3f; }
    body { font-family: 'Malgun Gothic', sans-serif; background-color: rgba(0,0,0,0.5); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    
    .delete-container { width: 400px; background: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.3); }
    .header { background: var(--navy-color); color: #fff; padding: 15px; text-align: center; font-weight: bold; }
    .content { padding: 30px; }
    
    .info-text { font-size: 14px; margin-bottom: 20px; color: #333; }
    .input-group { margin-bottom: 20px; }
    .input-group label { display: block; font-size: 13px; font-weight: bold; margin-bottom: 8px; }
    .input-group input { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
    
    .btn-group { display: flex; gap: 10px; justify-content: center; }
    .btn { padding: 10px 30px; border-radius: 4px; font-weight: bold; cursor: pointer; border: none; }
    .btn-del { background: #d32f2f; color: #fff; } /* 삭제 버튼 강조 */
    .btn-cancel { background: #eee; color: #333; }
</style>
</head>
<body>

<div class="delete-container">
    <div class="header">삭제 확인</div>
    <div class="content">
        <form action="qnaDelete.do" method="post" id="deleteForm">
            <input type="hidden" name="no" value="${param.no}">
            
            <div class="info-text">
                글번호: <strong>${param.no}</strong>번 게시글을 삭제하시겠습니까?
            </div>

            <div class="input-group">
                <label>비밀번호</label>
                <input type="password" name="pw" placeholder="비밀번호 4~20자 입력" required maxlength="20">
            </div>

            <div class="btn-group">
                <button type="submit" class="btn btn-del">삭제</button>
                <button type="button" class="btn btn-cancel" onclick="window.close();">취소</button>
            </div>
        </form>
    </div>
</div>

<script>
    // 유효성 검사 및 삭제 확인 팝업
    document.getElementById('deleteForm').onsubmit = function() {
        const pw = this.pw.value;
        if(pw.length < 4 || pw.length > 20) {
            alert("비밀번호는 4~20자 이내여야 합니다.");
            return false;
        }
        return confirm("삭제 후 복구할 수 없습니다. 정말 삭제하시겠습니까?");
    };
</script>

</body>
</html>