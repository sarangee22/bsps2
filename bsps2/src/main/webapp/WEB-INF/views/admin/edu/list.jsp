<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>가이드 관리 - 관리자 대시보드</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F4F7FE; }
    </style>
</head>
<body class="p-10">
    <div class="max-w-7xl mx-auto">

        <div class="flex justify-between items-end mb-10">
            <div>
                <h1 class="text-4xl font-black text-slate-900 tracking-tighter">가이드 관리</h1>
                <p class="text-slate-500 mt-2 font-semibold">교육 가이드를 작성하고 관리합니다.</p>
            </div>
            <a href="writeForm.do" class="bg-red-600 text-white px-6 py-3 rounded-xl font-bold shadow-lg shadow-red-100 flex items-center gap-2 hover:bg-red-700 transition-all">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M12 4v16m8-8H4"></path></svg>
                새 가이드 작성
            </a>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
            <div class="bg-white p-8 rounded-3xl border border-slate-100 shadow-sm flex items-center justify-between">
                <div>
                    <p class="text-sm font-bold text-slate-400 mb-1">전체 가이드</p>
                    <p class="text-4xl font-black text-slate-900">${meta.total}</p>
                </div>
                <div class="p-4 bg-slate-100 text-slate-500 rounded-2xl">
                    <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
                </div>
            </div>
            <div class="bg-white p-8 rounded-3xl border border-slate-100 shadow-sm flex items-center justify-between">
                <div>
                    <p class="text-sm font-bold text-slate-400 mb-1">발행됨</p>
                    <p class="text-4xl font-black text-emerald-600">${meta.total - 1}</p> </div>
                <div class="p-4 bg-emerald-50 text-emerald-500 rounded-2xl">
                    <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                </div>
            </div>
            <div class="bg-white p-8 rounded-3xl border border-slate-100 shadow-sm flex items-center justify-between">
                <div>
                    <p class="text-sm font-bold text-slate-400 mb-1">임시저장</p>
                    <p class="text-4xl font-black text-orange-600">1</p> </div>
                <div class="p-4 bg-orange-50 text-orange-500 rounded-2xl">
                    <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                </div>
            </div>
        </div>

        <div class="relative w-full max-w-md mb-8 group">
            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                <svg class="w-5 h-5 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
            </div>
            <input type="text" placeholder="가이드 검색..." class="w-full bg-white border-none py-3.5 pl-12 pr-4 rounded-xl focus:ring-2 focus:ring-slate-200 transition-all font-medium text-slate-600 shadow-sm">
        </div>

        <div class="bg-white rounded-[32px] border border-slate-100 shadow-2xl shadow-slate-200/40 overflow-hidden">
            <table class="w-full text-left">
                <thead class="bg-slate-50/50 border-b border-slate-100">
                    <tr class="text-slate-400 text-sm font-bold">
                        <th class="px-8 py-5">제목</th>
                        <th class="px-8 py-5">카테고리</th>
                        <th class="px-8 py-5">작성자</th>
                        <th class="px-8 py-5">상태</th>
                        <th class="px-8 py-5 text-center">조회수</th>
                        <th class="px-8 py-5">작성일</th>
                        <th class="px-8 py-5 text-right">작업</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-50 text-sm">
                    <c:forEach var="vo" items="${list}">
                        <tr class="hover:bg-slate-50/80 transition-colors">
                            <td class="px-8 py-6 font-bold text-slate-900">${vo.title}</td>
                            <td class="px-8 py-6 text-slate-500 font-medium">${vo.category}</td>
                            <td class="px-8 py-6 text-slate-500 font-medium">${vo.writer}</td>
                            <td class="px-8 py-6">
                                <span class="px-3 py-1.5 ${vo.status == '발행됨' ? 'bg-emerald-50 text-emerald-600' : 'bg-orange-50 text-orange-600'} text-[11px] font-black rounded-lg">
                                    ${vo.status}
                                </span>
                            </td>
                            <td class="px-8 py-6 text-center font-bold text-slate-600">${vo.hit}</td>
                            <td class="px-8 py-6 text-slate-400 font-medium">${vo.regDate}</td>
                            <td class="px-8 py-6 text-right">
                                <div class="flex items-center justify-end gap-3">
                                    <a href="/edu/view.do?no=${vo.no}" class="p-2 text-blue-500 hover:bg-blue-50 rounded-lg transition-colors"><svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg></a>
                                    <a href="updateForm.do?no=${vo.no}" class="p-2 text-slate-400 hover:text-slate-900 hover:bg-slate-100 rounded-lg transition-colors"><svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg></a>
                                    <a href="delete.do?no=${vo.no}" class="p-2 text-red-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors" onclick="return confirm('삭제하시겠습니까?')"><svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg></a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="flex justify-center py-12">
            <pageNav:pageNav listURI="list.do" pageObject="${pageObject}" />
        </div>
    </div>
</body>
</html>