<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문답변 삭제</title>
<style>
    /* 기본 레이아웃 및 배경 설정 */
    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { width: 900px; margin: 50px auto; border: 1px solid #ccc; background-color: #fff; position: relative; }
    
    :root { --navy-color: #001f3f; }

    header { background-color: var(--navy-color); color: white; padding: 15px 20px; font-weight: bold; }

    /* 메인 영역 (팝업 배경 느낌 재현) */
    main { min-height: 500px; display: flex; justify-content: center; align-items: center; background-color: #f9f9f9; }

    /* 삭제 확인 팝업 (모달) 스타일 */
    .delete-modal {
        width: 400px;
        border: 1px solid #999;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        background-color: #fff;
    }
    .modal-header {
        background-color: #ddd;
        padding: 12px;
        text-align: center;
        font-weight: bold;
        font-size: 16px;
        border-bottom: 1px solid #ccc;
    }
    .modal-body {
        padding: 30px 25px;
    }

    .info-text { font-size: 14px; margin-bottom: 20px; color: #333; }
    .info-text b { color: var(--navy-color); }

    .input-group { margin-bottom: 20px; }
    .input-group label { display: block; font-size: 13px; font-weight: bold; margin-bottom: 8px; }
    .input-group input { 
        width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; 
        font-size: 14px; background-color: #fdfdfd;
    }

    /* 버튼 영역 */
    .modal-footer {
        padding: 0 25px 25px 25px;
        text-align: center;
        display: flex;
        justify-content: center;
        gap: 10px;
    }
    .btn { padding: 10px 30px; border-radius: 4px; font-weight: bold; cursor: pointer; border: 1px solid #ccc; font-size: 14px; width: 100px; }
    .btn-delete { background-color: #ffefef; color: #d32f2f; border-color: #ffcdd2; } /* 삭제 L1 */
    .btn-delete:hover { background-color: #ffe0e0; }
    .btn-cancel { background-color: #eee; color: #333; } /* 취소 L2 */

    footer { background-color: #ddd; text-align: center; padding: 15px; font-size: 12px; color: #777; }
</style>
</head>
<body>

<div class="container">
    <header>재난/안전 정보 사이트</header>

    <main>
        <!-- 삭제 확인 팝업 영역 -->
        <div class="delete-modal">
            <div class="modal-header">삭제 확인</div>
            
            <form action="qnaDelete.do" method="post" id="deleteForm">
                <div class="modal-body">
                    <!-- D1 (no): 글번호 hidden 자동세팅 -->
                    <input type="hidden" name="no" value="3"> 
                    
                    <div class="info-text">
                        글번호: <b>3</b> 번 게시글을 삭제합니다.
                    </div>

                    <!-- D2 (pw): 비밀번호 입력 -->
                    <div class="input-group">
                        <label>비밀번호</label>
                        <input type="password" name="pw" placeholder="4~20자 (대체문자 * 표시)" required>
                    </div>
                </div>

                <div class="modal-footer">
                    <!-- L1: 삭제 실행 -->
                    <button type="submit" class="btn btn-delete">삭제</button>
                    <!-- L2: 취소 (팝업 닫기/이전 화면) -->
                    <button type="button" class="btn btn-cancel" onclick="history.back();">취소</button>
                </div>
            </form>
        </div>
    </main>

    <footer>푸터</footer>
</div>

<script>
    document.getElementById('deleteForm').onsubmit = function(e) {
        const pw = this.pw.value;
        
        // D2 유효성 검사
        if(pw.length < 4 || pw.length > 20) {
            alert("비밀번호는 4~20자 사이여야 합니다.");
            return false;
        }

        if(!confirm("정말로 이 글을 삭제하시겠습니까?\n삭제된 글은 복구할 수 없습니다.")) {
            return false;
        }
        return true;
    };
</script>

</body>
</html>