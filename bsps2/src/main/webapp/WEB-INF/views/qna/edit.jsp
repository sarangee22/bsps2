<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 질문 수정</title>
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

    /* 읽기 전용 스타일 (D1: 글번호) */
    .input-group input[readonly] { background-color: #eee; cursor: not-allowed; color: #777; }

    /* 내용 입력창 (D3) */
    .input-group textarea { height: 200px; resize: none; }

    /* 작성자/비밀번호 가로 배치 */
    .flex-row { display: flex; gap: 15px; margin-bottom: 20px; }
    .flex-row .input-group { flex: 1; margin-bottom: 0; }

    /* 버튼 영역 */
    .btn-area { text-align: center; margin-top: 40px; border-top: 1px solid #eee; padding-top: 30px; }
    .btn { padding: 12px 40px; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 14px; margin: 0 5px; border: 1px solid #ccc; text-decoration: none; display: inline-block; }
    
    .btn-submit { background-color: var(--navy-color); color: white; border: none; } /* 수정 L1 */
    .btn-cancel { background-color: #888; color: white; border: none; } /* 취소 L2 */

    footer { background-color: #eee; text-align: center; padding: 15px; font-size: 12px; color: #888; }
</style>
</head>
<body>

<div class="container">
    <header>재난/안전 정보 사이트</header>

    <main>
        <div class="form-title">질문답변 수정</div>

        <form action="qnaEdit.do" method="post" id="editForm">
            
            <div class="input-group">
                <label>글번호</label>
                <input type="text" name="no" value="3" readonly>
            </div>

            <div class="input-group">
                <label>제목</label>
                <input type="text" name="title" value="지진 발생 시 행동요령이 궁금합니다" required>
            </div>

            <div class="input-group">
                <label>내용</label>
                <textarea name="content" required>지진 발생 시 구체적인 대피 장소와 준비물에 대해 알고 싶습니다.</textarea>
            </div>

            <div class="flex-row">
                <div class="input-group">
                    <label>작성자</label>
                    <input type="text" name="name" value="hong123" required>
                </div>
                
                <div class="input-group">
                    <label>비밀번호 (본인확인)</label>
                    <input type="password" name="pw" placeholder="비밀번호 입력" required>
                </div>
            </div>

            <div class="btn-area">
                <button type="submit" class="btn btn-submit">수정</button>
                <button type="button" class="btn btn-cancel" onclick="location.href='qnaView.do?no=3'">취소</button>
            </div>
        </form>
    </main>

    <footer>푸터</footer>
</div>

<script>
    document.getElementById('editForm').onsubmit = function(e) {
        const title = this.title.value.trim();
        const content = this.content.value;

        if(title.length < 4 || title.length > 100) {
            alert("제목은 4자에서 100자 사이로 입력해주세요.");
            return false;
        }

        if(content.length < 4 || content.length > 1500) {
            alert("내용은 4자에서 1500자 사이로 입력해주세요.");
            return false;
        }

        if(!confirm("글을 수정하시겠습니까?")) {
            return false;
        }
        return true;
    };
</script>

</body>
</html>