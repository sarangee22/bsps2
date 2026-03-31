<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 질문하기</title>
<style>
    /* 공통 레이아웃 */
    body { font-family: 'Malgun Gothic', sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { width: 800px; margin: 50px auto; border: 1px solid #ccc; background-color: #fff; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    
    :root { --navy-color: #001f3f; }

    header { background-color: var(--navy-color); color: white; padding: 15px 20px; text-align: center; font-weight: bold; }

    main { padding: 40px; }
    .form-title { text-align: center; margin-bottom: 30px; font-size: 22px; font-weight: bold; border-bottom: 2px solid var(--navy-color); padding-bottom: 10px; }

    /* 폼 요소 스타일 */
    .input-group { margin-bottom: 20px; }
    .input-group label { display: block; font-size: 14px; font-weight: bold; margin-bottom: 8px; color: #333; }
    
    .input-group input[type="text"], 
    .input-group input[type="password"],
    .input-group textarea { 
        width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; background-color: #fdfdfd; font-size: 14px;
    }

    /* 내용 입력창 (D2) */
    .input-group textarea { height: 200px; resize: none; }

    /* 작성자/비밀번호 가로 배치 영역 */
    .flex-row { display: flex; gap: 15px; margin-bottom: 20px; }
    .flex-row .input-group { flex: 1; margin-bottom: 0; }

    /* 버튼 영역 */
    .btn-area { text-align: center; margin-top: 40px; border-top: 1px solid #eee; padding-top: 30px; }
    .btn { padding: 12px 35px; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 14px; margin: 0 5px; border: 1px solid #ccc; text-decoration: none; display: inline-block; }
    
    .btn-submit { background-color: var(--navy-color); color: white; border: none; } /* 등록 L1 */
    .btn-cancel { background-color: #888; color: white; border: none; } /* 취소 L2 */
    .btn-reset { background-color: #eee; color: #333; } /* 다시 입력 */

    footer { background-color: #eee; text-align: center; padding: 15px; font-size: 12px; color: #888; }
</style>
</head>
<body>

<div class="container">
    <header>재난/안전 정보 사이트</header>

    <main>
        <div class="form-title">질문하기</div>

        <form action="qnaWrite.do" method="post" id="qnaForm">
            <!-- 제목 (D1) -->
            <div class="input-group">
                <label>제목</label>
                <input type="text" name="title" placeholder="제목 입력 (4~100자, 앞뒤 공백 불가)" required>
            </div>

            <!-- 내용 (D2) -->
            <div class="input-group">
                <label>내용</label>
                <textarea name="content" placeholder="내용 입력 (4~1500자, 줄바꿈 가능)" required></textarea>
            </div>

            <div class="flex-row">
                <!-- 작성자 (D3) -->
                <div class="input-group">
                    <label>작성자</label>
                    <input type="text" name="name" placeholder="한글 2~10자" required>
                </div>
                <!-- 비밀번호 (D4) -->
                <div class="input-group">
                    <label>비밀번호</label>
                    <input type="password" name="pw" placeholder="4~20자" required>
                </div>
                <!-- 비밀번호 확인 (D5) -->
                <div class="input-group">
                    <label>비밀번호 확인</label>
                    <input type="password" name="pwConfirm" placeholder="동일입력" required>
                </div>
            </div>

            <div class="btn-area">
                <button type="submit" class="btn btn-submit">등록</button>
                <button type="button" class="btn btn-cancel" onclick="location.href='qnaList.do'">취소</button>
                <button type="reset" class="btn btn-reset">다시 입력</button>
            </div>
        </form>
    </main>

    <footer>푸터</footer>
</div>

<script>
    document.getElementById('qnaForm').onsubmit = function(e) {
        const title = this.title.value.trim();
        const content = this.content.value;
        const name = this.name.value;
        const pw = this.pw.value;
        const pwConfirm = this.pwConfirm.value;

        // D1: 제목 유효성 (4~100자)
        if(title.length < 4 || title.length > 100) {
            alert("제목은 4자에서 100자 사이로 입력해주세요.");
            return false;
        }

        // D2: 내용 유효성 (4~1500자)
        if(content.length < 4 || content.length > 1500) {
            alert("내용은 4자에서 1500자 사이로 입력해주세요.");
            return false;
        }

        // D3: 작성자 유효성 (한글 2~10자)
        const nameReg = /^[가-힣]{2,10}$/;
        if(!nameReg.test(name)) {
            alert("작성자는 한글 2~10자 이내로 입력해주세요.");
            return false;
        }

        // D4, D5: 비밀번호 확인
        if(pw !== pwConfirm) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }

        if(confirm("새로운 글을 등록하시겠습니까?")) {
            return true;
        } else {
            return false;
        }
    };
</script>

</body>
</html>