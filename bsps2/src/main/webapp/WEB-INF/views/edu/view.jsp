<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${vo.title} - 가이드 상세</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #FFFFFF; }
        .content-area { line-height: 1.8; color: #1F2937; font-size: 1.1rem; }
    </style>
</head>
<body class="p-6 md:p-12">
    <div class="max-w-6xl mx-auto">

        <div class="flex justify-between items-center mb-10">
            <a href="list.do?page=${pageObject.page}&perPageNum=${pageObject.perPageNum}" class="flex items-center gap-2 text-slate-500 hover:text-slate-950 font-medium transition-colors">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
                목록으로
            </a>

            <div class="flex items-center gap-3">
                <a href="writeForm.do" class="flex items-center gap-2 bg-emerald-600 text-white px-5 py-2.5 rounded-lg font-bold hover:bg-emerald-700 transition-all shadow-sm">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M12 4v16m8-8H4"></path></svg>
                    글 작성하기
                </a>
                <a href="updateForm.do?no=${vo.no}" class="flex items-center gap-2 bg-white text-emerald-600 border border-emerald-600 px-5 py-2.5 rounded-lg font-bold hover:bg-emerald-50 transition-all">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                    수정하기
                </a>
                <a href="delete.do?no=${vo.no}" onclick="return confirm('정말 삭제하시겠습니까?')" class="flex items-center gap-2 bg-white text-rose-600 border border-rose-600 px-5 py-2.5 rounded-lg font-bold hover:bg-rose-50 transition-all">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                    삭제
                </a>
            </div>
        </div>

        <div class="mb-10">
            <span class="inline-block px-4 py-1.5 bg-emerald-50 text-emerald-600 text-sm font-bold rounded-full mb-6">
                ${vo.category}
            </span>
            <h1 class="text-5xl font-black text-slate-900 leading-tight mb-8 tracking-tighter">
                ${vo.title}
            </h1>

            <div class="flex flex-wrap items-center gap-6 text-slate-400 font-bold text-sm">
                <div class="flex items-center gap-2">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                    ${vo.writer}
                </div>
                <div class="flex items-center gap-2 text-slate-500">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                    작성: ${vo.regDate}
                </div>
                <div class="flex items-center gap-2">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                    수정: ${vo.regDate}
                </div>
                <div class="flex items-center gap-2">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg>
                    조회 ${vo.hit}
                </div>
            </div>
        </div>

        <hr class="border-slate-100 mb-12">

        <div class="content-area whitespace-pre-wrap break-words min-h-[400px]">
            ${vo.content}
        </div>

    </div>
</body>
</html>