<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<decorator:head>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* 카테고리별 동적 색상 클래스 */
        .cat-재난-대비 { background-color: #ECFDF5 !important; color: #059669 !important; }
        .cat-안전-점검 { background-color: #EFF6FF !important; color: #2563EB !important; }
        .cat-응급처치 { background-color: #FFF1F2 !important; color: #E11D48 !important; }
        
        /* 데코레이터의 container-fluid 여백 때문에 좌우가 좁아 보일 때 조절 */
        .edu-list-wrapper { padding-top: 2rem; padding-bottom: 5rem; }
    </style>
</decorator:head>

<div class="edu-list-wrapper max-w-7xl mx-auto">

    <div class="mb-12 flex flex-col md:flex-row items-center gap-6">
        <div class="p-5 bg-emerald-600 rounded-[24px] text-white shadow-2xl shadow-emerald-100 flex-shrink-0">
            <i class="fa fa-book fa-3x"></i> </div>
        <div>
            <h1 class="text-4xl font-black text-slate-900 tracking-tighter">교육 가이드</h1>
            <p class="text-slate-500 mt-2 font-bold text-sm leading-relaxed">
                안전과 재난 대비에 대한 유용한 정보를 제공합니다. <br class="hidden md:block">
                실제 상황에서 바로 활용 가능한 단계별 가이드를 확인하세요.
            </p>
        </div>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
        <div class="bg-white p-8 rounded-[40px] border border-slate-100 shadow-sm flex items-center justify-between transition-all hover:shadow-xl">
            <div>
                <p class="text-[11px] font-black text-slate-400 uppercase tracking-[0.2em] mb-2">Total Guides</p>
                <p class="text-5xl font-black text-slate-900 leading-none">${meta.total}</p>
            </div>
            <div class="text-emerald-500 opacity-20"><i class="fa fa-files-o fa-3x"></i></div>
        </div>
        <div class="bg-white p-8 rounded-[40px] border border-slate-100 shadow-sm flex items-center justify-between transition-all hover:shadow-xl">
            <div>
                <p class="text-[11px] font-black text-slate-400 uppercase tracking-[0.2em] mb-2">Total Views</p>
                <p class="text-5xl font-black text-blue-600 leading-none">${meta.views}</p>
            </div>
            <div class="text-blue-500 opacity-20"><i class="fa fa-line-chart fa-3x"></i></div>
        </div>
        <div class="bg-white p-8 rounded-[40px] border border-slate-100 shadow-sm flex items-center justify-between transition-all hover:shadow-xl">
            <div>
                <p class="text-[11px] font-black text-slate-400 uppercase tracking-[0.2em] mb-2">Categories</p>
                <p class="text-5xl font-black text-purple-600 leading-none">${meta.cats}</p>
            </div>
            <div class="text-purple-500 opacity-20"><i class="fa fa-tags fa-3x"></i></div>
        </div>
    </div>

    <div class="flex flex-col xl:flex-row items-center justify-between gap-8 mb-16">
        <form action="list.do" class="relative w-full xl:w-1/2 group">
            <input type="hidden" name="perPageNum" value="${pageObject.perPageNum}">
            <input type="hidden" name="category" value="${pageObject.key}">
            <div class="absolute inset-y-0 left-0 pl-6 flex items-center pointer-events-none">
                <i class="fa fa-search text-slate-400 group-focus-within:text-emerald-500 transition-colors"></i>
            </div>
            <input type="text" name="word" value="${pageObject.word}" placeholder="가이드 제목, 내용, 태그로 검색..." 
                   class="w-full bg-slate-100/80 border-none py-5 pl-14 pr-6 rounded-[24px] focus:outline-none focus:ring-4 focus:ring-emerald-50 focus:bg-white transition-all font-bold text-slate-700">
        </form>

        <div class="flex items-center gap-3 overflow-x-auto pb-4 w-full xl:w-auto scrollbar-hide">
            <c:forEach var="cat" items="${['전체', '재난 대비', '안전 점검', '응급 처치']}">
                <a href="list.do?category=${cat}&word=${pageObject.word}&perPageNum=${pageObject.perPageNum}" 
                   class="px-8 py-3.5 rounded-2xl font-black transition-all whitespace-nowrap text-sm
                   ${(pageObject.key == cat || (empty pageObject.key && cat == '전체')) ? 'bg-slate-900 text-white shadow-2xl shadow-slate-200' : 'bg-white text-slate-400 border border-slate-100 hover:bg-slate-50'}">
                    ${cat}
                </a>
            </c:forEach>
        </div>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-10 mb-20">
        <c:forEach var="vo" items="${list}">
            <div class="bg-white rounded-[48px] border border-slate-50 p-10 shadow-sm hover:shadow-[0_30px_60px_-15px_rgba(0,0,0,0.1)] hover:-translate-y-3 transition-all duration-500 group cursor-pointer relative overflow-hidden" 
                 onclick="location='view.do?no=${vo.no}&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}'">
                
                <div class="flex justify-between items-center mb-8">
                    <c:set var="catClass" value="${vo.category.replace(' ', '-')}" />
                    <span class="inline-block px-4 py-1.5 cat-${catClass} text-[10px] font-black rounded-xl uppercase tracking-widest transition-all group-hover:scale-110">
                        ${vo.category}
                    </span>
                    <span class="text-slate-300 text-xs flex items-center gap-2 font-black">
                        <i class="fa fa-eye"></i> ${vo.hit}
                    </span>
                </div>

                <h3 class="text-2xl font-black text-slate-900 group-hover:text-emerald-600 transition-colors mb-5 tracking-tight leading-tight">
                    ${vo.title}
                </h3>
                <p class="text-slate-400 text-sm leading-relaxed mb-10 line-clamp-2 font-medium">${vo.summary}</p>

                <div class="flex flex-wrap gap-2 mb-10">
                    <c:forEach var="tag" items="${vo.tagList}">
                        <span class="text-[10px] font-black bg-slate-50 text-slate-400 px-3 py-1.5 rounded-lg border border-slate-50">#${tag}</span>
                    </c:forEach>
                </div>

                <div class="flex items-center justify-between pt-8 border-t border-slate-50">
                    <div class="flex items-center gap-3">
                        <div class="w-8 h-8 rounded-full bg-slate-100 flex items-center justify-center text-slate-400">
                            <i class="fa fa-user"></i>
                        </div>
                        <span class="text-xs text-slate-900 font-black">${vo.writer}</span>
                    </div>
                    <span class="text-[10px] text-slate-300 font-bold uppercase tracking-tighter">
                        <i class="fa fa-calendar-o mr-1"></i> ${vo.regDate}
                    </span>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="flex justify-center pb-20">
        <div class="bg-white px-8 py-4 rounded-[32px] shadow-sm border border-slate-50">
            <pageNav:pageNav listURI="list.do" pageObject="${pageObject}" />
        </div>
    </div>
</div>