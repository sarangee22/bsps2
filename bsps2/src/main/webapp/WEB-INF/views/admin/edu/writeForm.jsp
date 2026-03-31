<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="bg-[#F4F7FE] p-10">
    <div class="max-w-4xl mx-auto bg-white p-12 rounded-[40px] shadow-2xl shadow-slate-200">
        <h1 class="text-3xl font-black text-slate-900 mb-8">새 가이드 작성</h1>
        
        <form action="write.do" method="post" class="space-y-6">
            <div class="grid grid-cols-2 gap-6">
                <div>
                    <label class="block text-sm font-bold text-slate-400 mb-2">카테고리</label>
                    <select name="category" class="w-full border-none bg-slate-50 p-4 rounded-2xl focus:ring-2 focus:ring-emerald-500 font-bold">
                        <option>재난 대비</option>
                        <option>안전 점검</option>
                        <option>응급처치</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-bold text-slate-400 mb-2">상태</label>
                    <select name="status" class="w-full border-none bg-slate-50 p-4 rounded-2xl focus:ring-2 focus:ring-emerald-500 font-bold">
                        <option value="발행됨">발행하기</option>
                        <option value="임시저장">임시저장</option>
                    </select>
                </div>
            </div>

            <div>
                <label class="block text-sm font-bold text-slate-400 mb-2">제목</label>
                <input type="text" name="title" required class="w-full border-none bg-slate-50 p-4 rounded-2xl focus:ring-2 focus:ring-emerald-500">
            </div>

            <div>
                <label class="block text-sm font-bold text-slate-400 mb-2">작성자</label>
                <input type="text" name="writer" required class="w-full border-none bg-slate-50 p-4 rounded-2xl focus:ring-2 focus:ring-emerald-500">
            </div>

            <div>
                <label class="block text-sm font-bold text-slate-400 mb-2">요약 내용</label>
                <textarea name="summary" rows="2" class="w-full border-none bg-slate-50 p-4 rounded-2xl focus:ring-2 focus:ring-emerald-500"></textarea>
            </div>

            <div>
                <label class="block text-sm font-bold text-slate-400 mb-2">본문 내용</label>
                <textarea name="content" rows="10" class="w-full border-none bg-slate-50 p-4 rounded-2xl focus:ring-2 focus:ring-emerald-500"></textarea>
            </div>

            <div>
                <label class="block text-sm font-bold text-slate-400 mb-2">태그 (쉼표로 구분)</label>
                <input type="text" name="tags" placeholder="지진,안전,대피" class="w-full border-none bg-slate-50 p-4 rounded-2xl focus:ring-2 focus:ring-emerald-500">
            </div>

            <div class="flex gap-4 pt-6">
                <button type="submit" class="flex-1 bg-emerald-600 text-white py-4 rounded-2xl font-bold hover:bg-emerald-700 shadow-lg shadow-emerald-100 transition-all">가이드 등록</button>
                <a href="list.do" class="flex-1 bg-slate-100 text-slate-500 py-4 rounded-2xl font-bold text-center hover:bg-slate-200 transition-all">취소</a>
            </div>
        </form>
    </div>
</body>
</html>