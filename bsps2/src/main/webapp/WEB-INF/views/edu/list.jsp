<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>교육 가이드 - 안전을 배우다</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F8FAFC; }
        .cat-재난 대비 { background-color: #ECFDF5; color: #059669; }
        .cat-안전 점검 { background-color: #EFF6FF; color: #2563EB; }
        .cat-응급처치 { background-color: #FFF1F2; color: #E11D48; }
    </style>
</head>
<body class="p-6 md:p-10">
    <div class="max-w-7xl mx-auto">

        <div class="mb-10 flex items-center gap-5">
            <div class="p-4 bg-emerald-600 rounded-2xl text-white shadow-xl shadow-emerald-100">
                <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path></svg>
            </div>
            <div>
                <h1 class="text-4xl font-extrabold text-slate-950 tracking-tighter">교육 가이드</h1>
                <p class="text-slate-500 mt-1.5 font-semibold text-sm">안전과 재난 대비에 대한 유용한 정보를 제공합니다.</p>
            </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
            <div class="bg-white p-7 rounded-[32px] border border-slate-100 shadow-sm flex items-center justify-between">
                <div>
                    <p class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-1">전체 가이드</p>
                    <p class="text-4xl font-black text-slate-950">${meta.total}</p>
                    <p class="text-[10px] text-slate-400 mt-1 font-bold">Published Guides</p>
                </div>
                <div class="p-4 bg-emerald-50 text-emerald-500 rounded-2xl">
                    <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path></svg>
                </div>
            </div>
            <div class="bg-white p-7 rounded-[32px] border border-slate-100 shadow-sm flex items-center justify-between">
                <div>
                    <p class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-1">총 조회수</p>
                    <p class="text-4xl font-black text-blue-600">${meta.views}</p>
                    <p class="text-[10px] text-slate-400 mt-1 font-bold">Total Views</p>
                </div>
                <div class="p-4 bg-blue-50 text-blue-500 rounded-2xl">
                    <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path></svg>
                </div>
            </div>
            <div class="bg-white p-7 rounded-[32px] border border-slate-100 shadow-sm flex items-center justify-between">
                <div>
                    <p class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-1">카테고리</p>
                    <p class="text-4xl font-black text-purple-600">${meta.cats}</p>
                    <p class="text-[10px] text-slate-400 mt-1 font-bold">Categories</p>
                </div>
                <div class="p-4 bg-purple-50 text-purple-500 rounded-2xl">
                    <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"></path></svg>
                </div>
            </div>
        </div>

        <div class="flex flex-col md:flex-row items-center justify-between gap-6 mb-12">
            <form action="list.do" class="relative w-full md:w-2/3 group">
                <input type="hidden" name="perPageNum" value="${pageObject.perPageNum}">
                <input type="hidden" name="category" value="${pageObject.key}">
                <div class="absolute inset-y-0 left-0 pl-5 flex items-center pointer-events-none">
                    <svg class="w-5 h-5 text-slate-400 group-focus-within:text-emerald-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                </div>
                <input type="text" name="word" value="${pageObject.word}" placeholder="가이드 검색..." 
                       class="w-full bg-slate-100 border-none py-4 pl-14 pr-4 rounded-2xl focus:outline-none focus:ring-4 focus:ring-emerald-50 focus:bg-white transition-all font-medium">
            </form>

            <div class="flex items-center gap-2 overflow-x-auto pb-2 w-full md:w-auto scrollbar-hide">
                <c:forEach var="cat" items="${['전체', '재난 대비', '안전 점검', '응급 처치']}">
                    <a href="list.do?category=${cat}&word=${pageObject.word}&perPageNum=${pageObject.perPageNum}" 
                       class="px-6 py-2.5 rounded-xl font-bold transition-all whitespace-nowrap
                       ${(pageObject.key == cat || (empty pageObject.key && cat == '전체')) ? 'bg-emerald-600 text-white shadow-lg shadow-emerald-100' : 'bg-white text-slate-500 border border-slate-200 hover:bg-slate-50'}">
                        ${cat}
                    </a>
                </c:forEach>
            </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
            <c:forEach var="vo" items="${list}">
                <div class="bg-white rounded-[32px] border border-slate-100 p-8 shadow-sm hover:shadow-2xl hover:-translate-y-2 transition-all duration-300 group cursor-pointer" 
                     onclick="location='view.do?no=${vo.no}&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}'">
                    
                    <div class="flex justify-between items-start mb-6">
                        <span class="inline-block px-3.5 py-1.5 cat-${vo.category} text-[11px] font-black rounded-xl uppercase tracking-wider">${vo.category}</span>
                        <span class="text-slate-300 text-xs flex items-center gap-1.5 font-bold">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg> 
                            ${vo.hit}
                        </span>
                    </div>

                    <h3 class="text-2xl font-bold text-slate-900 group-hover:text-emerald-600 transition-colors mb-4 tracking-tight leading-tight">${vo.title}</h3>
                    <p class="text-slate-500 text-sm leading-relaxed mb-8 line-clamp-2">${vo.summary}</p>

                    <div class="flex flex-wrap gap-2 mb-8">
                        <c:forEach var="tag" items="${vo.tagList}">
                            <span class="text-[10px] font-bold bg-slate-50 text-slate-400 px-2.5 py-1 rounded-md">#${tag}</span>
                        </c:forEach>
                    </div>

                    <div class="flex items-center justify-between pt-6 border-t border-slate-100">
                        <span class="text-[11px] text-slate-300 font-bold flex items-center gap-2">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                            ${vo.regDate}
                        </span>
                        <span class="text-xs text-slate-800 font-black">${vo.writer}</span>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="flex justify-center pb-10">
            <pageNav:pageNav listURI="list.do" pageObject="${pageObject}" />
        </div>
    </div>
</body>
</html>