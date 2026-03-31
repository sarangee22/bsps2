<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 답변하기</title>
<style>
    /* 전체 레이아웃 */
    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { width: 800px; margin: 50px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    
    :root { --navy-color: #001f3f; }

    header { background-color: var(--navy-color); color: white; padding: 15px 20px; text-align: center; font-weight: bold; }

    main { padding: 40px; }
    .form-title { text-align: center; margin-bottom: 25px; font-size: 22px; font-weight: bold; }

    /* 원본 질문 영역 (D1: 읽기 전용 자동 세팅) */
    .origin-box { background-color: #eee; border: 1px solid #ddd; padding: 15px; border-radius: 4px; margin-bottom: 30px; }
    .origin-label { font-size: 13px; font-weight: bold; color: #666; margin-bottom: 8px; }
    .origin-title { font-size: 15px; font-weight: bold; margin-bottom: 5px; }
    .origin-info { font-size: 12px; color: #888; }

    /* 폼 요소 스타일 */
    .input-group { margin-bottom: 20px; }
    .input-group label { display: block; font-size: 14px; font-weight: bold; margin-bottom: 8px; color: #333; }
    
    .input-group input[type="text"], 
    .input-group input[type="password"],
    .input-group textarea { 
        width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; background-color: #fdfdfd; font-size: 14px;
    }

    /* 답변 내용 입력 (D3) */
    .input-group textarea { height: 180px; resize: none; }

    /* 작성자/비밀번호 하단 배치 영역 */
    .flex-row { display: flex; gap: 15px; margin-bottom: 20px; }
    .flex-row .input-group { flex: 1; margin-bottom: 0; }

    /* 버튼 영역 */
    .btn-area { text-align: center; margin-top: 35px; border-top: 1px solid #eee; padding-top: 25px; }
    .btn { padding: 10px 35px; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 14px; margin: 0 5px; border: 1px solid #ccc; text-decoration: none; display: inline-block; }
    
    .btn-submit { background-color: var(--navy-color); color: white; border: none; } /* 등록 L1 */
    .btn-cancel { background-color: #888; color: white; border: none; } /* 취소 L2 */

    footer { background-color: #eee; text-align: center; padding: 15px; font-size: 12px; color: #888; border-top: 1px solid #ccc; }
</style>
</head>
<body>

<div class="container">
    <header>재난/안전 정보 사이트</header>

    <main>
        <div class="form-title">답변하기</div>

        <!-- [원문 질문] (D1) -->
        <div class="origin-box">
            <div class="origin-label">[원본 질문]</div>
            <div class="origin-title">지진 발생 시 행동요령이 궁금합니다</div>
            <div class="origin-info">hong123 | 2025-03-10</div>
        </div>

        <form action="qnaReply.do" method="post" id="replyForm">
            <!-- 답변 제목 (D2) -->
            <div class="input-group">
                <label>제목</label>
                <input type="text" name="title" placeholder="답변 제목 입력 (4~100자)" required>
            </div>

            <!-- 답변 내용 (D3) -->
            <div class="input-group">
                <label>내용</label>
                <textarea name="content" placeholder="답변 내용 입력 (4~1500자, 줄바꿈 가능)" required></textarea>
            </div>

            <div class="flex-row">
                <!-- 작성자 (D4) -->
                <div class="input-group">
                    <label>작성자</label>
                    <input type="text" name="name" placeholder="한글 2~10자" required>
                </div>
                <!-- 비밀번호 (D5) -->
                <div class="input-group">
                    <label>비밀번호</label>
                    <input type="password" name="pw" placeholder="4~20자" required>
                </div>
                <!-- 비번 확인 (D6) -->
                <div class="input-group">
                    <label>비번 확인</label>
                    <input type="password" name="pwConfirm" placeholder="동일입력" required>
                </div>
            </div>

            <div class="btn-area">
                <button type="submit" class="btn btn-submit">등록</button>
                <button type="button" class="btn btn-cancel" onclick="history.back();">취소</button>
            </div>
        </form>
    </main>

    <footer>푸터</footer>
</div>

<script>
    document.getElementById('replyForm').onsubmit = function(e) {
        const title = this.title.value;
        const content = this.content.value;
        const name = this.name.value;
        const pw = this.pw.value;
        const pwConfirm = this.pwConfirm.value;

        // 유효성 검사 (설계안 기준)
        if(title.length < 4 || title.length > 100) {
            alert("제목은 4~100자 이내여야 합니다.");
            return false;
        }
        if(content.length < 4 || content.length > 1500) {
            alert("내용은 4~1500자 이내여야 합니다.");
            return false;
        }
        const nameReg = /^[가-힣]{2,10}$/;
        if(!nameReg.test(name)) {
            alert("작성자는 한글 2~10자 이내여야 합니다.");
            return false;
        }
        if(pw !== pwConfirm) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }

        if(confirm("답변을 등록하시겠습니까?")) {
            return true;
        }
        return false;
    };
</script>

</body>
</html>