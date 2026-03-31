<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>가이드 수정 - ${vo.title}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F4F7FE; }
        .input-base { border: none; background-color: #f1f5f9; padding: 1rem; border-radius: 0.75rem; width: 100%; }
        .input-base:focus { ring: 2px; ring-color: #10b981; outline: none; }
    </style>
</head>
<body class="p-6 md:p-12">
    <div class="max-w-4xl mx-auto bg-white p-10 rounded-[40px] shadow-2xl shadow-slate-200">
        <h1 class="text-3xl font-black text-slate-900 mb-2">가이드 수정하기</h1>
        <p class="text-slate-400 font-medium mb-10 text-sm">기존 내용을 수정하고 저장하세요.</p>
        
        <form action="update.do" method="post" class="space-y-6">
            <input type="hidden" name="no" value="${vo.no}">
            <input type="hidden" name="page" value="${param.page}">
            <input type="hidden" name="perPageNum" value="${param.perPageNum}">

            <div class="grid grid-cols-2 gap-6">
                <div>
                    <label class="block text-sm font-bold text-slate-500 mb-2">카테고리</label>
                    <select name="category" class="input-base font-bold">
                        <option ${vo.category == '재난 대비' ? 'selected' : ''}>재난 대비</option>
                        <option ${vo.category == '안전 점검' ? 'selected' : ''}>안전 점검</option>
                        <option ${vo.category == '응급처치' ? 'selected' : ''}>응급처치</option>
                        <option ${vo.category == '온보딩' ? 'selected' : ''}>온보딩</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-bold text-slate-500 mb-2">상태</label>
                    <select name="status" class="input-base font-bold text-emerald-600">
                        <option value="발행됨" ${vo.status == '발행됨' ? 'selected' : ''}>발행하기</option>
                        <option value="임시저장" ${vo.status == '임시저장' ? 'selected' : ''}>임시저장</option>
                    </select>
                </div>
            </div>

            <div>
                <label class="block text-sm font-bold text-slate-500 mb-2">제목</label>
                <input type="text" name="title" value="${vo.title}" required class="input-base font-bold text-lg">
            </div>

            <div>
                <label class="block text-sm font-bold text-slate-500 mb-2">작성자</label>
                <input type="text" name="writer" value="${vo.writer}" required class="input-base">
            </div>

            <div>
                <label class="block text-sm font-bold text-slate-500 mb-2">요약 내용</label>
                <textarea name="summary" rows="2" class="input-base">${vo.summary}</textarea>
            </div>

            <div>
                <label class="block text-sm font-bold text-slate-500 mb-2">본문 내용 (마크다운 지원)</label>
                <textarea name="content" rows="12" class="input-base leading-relaxed">${vo.content}</textarea>
            </div>

            <div>
                <label class="block text-sm font-bold text-slate-500 mb-2">태그 (쉼표 구분)</label>
                <input type="text" name="tags" value="${vo.tags}" class="input-base" placeholder="지진,화재,안전">
            </div>

            <div class="flex gap-4 pt-6">
                <button type="submit" class="flex-1 bg-emerald-600 text-white py-4 rounded-2xl font-bold hover:bg-emerald-700 shadow-lg shadow-emerald-100 transition-all">수정 완료</button>
                <a href="view.do?no=${vo.no}" class="flex-1 bg-slate-100 text-slate-500 py-4 rounded-2xl font-bold text-center hover:bg-slate-200 transition-all">취소</a>
            </div>
        </form>
    </div>
</body>
</html>