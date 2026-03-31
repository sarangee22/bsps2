<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${vo.title} - 교육 가이드</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F8FAFC; }
        
        /* 본문 가독성을 위한 스타일 */
        .content-area { 
            line-height: 2.2; /* 줄 간격 최적화 */
            color: #334155; 
            font-size: 1.15rem; 
            letter-spacing: -0.025em;
        }
        
        /* 본문 내 강조 텍스트 스타일 */
        .content-area strong, .content-area b {
            color: #0F172A;
            font-weight: 800;
            display: inline-block;
            margin-top: 1.5rem;
        }
    </style>
</head>
<body class="p-6 md:p-10">
    <div class="max-w-6xl mx-auto">
        
        <div class="mb-10">
            <a href="list.do?page=${pageObject.page}&perPageNum=${pageObject.perPageNum}" class="group text-sm font-bold text-slate-400 hover:text-slate-900 flex items-center gap-2 transition-all">
                <div class="p-2 bg-white rounded-xl shadow-sm group-hover:shadow-md transition-all">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
                </div>
                목록으로 돌아가기
            </a>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-12">
            
            <div class="lg:col-span-2">
                <div class="bg-white rounded-[48px] border border-slate-100 p-12 shadow-sm min-h-[600px] flex flex-col">
                    
                    <div class="mb-8">
                        <span class="inline-block px-4 py-1.5 bg-emerald-50 text-emerald-700 text-[11px] font-black rounded-xl uppercase tracking-widest">
                            ${vo.category}
                        </span>
                    </div>
                    
                    <h1 class="text-4xl md:text-5xl font-black text-slate-950 leading-tight mb-8 tracking-tighter">
                        ${vo.title}
                    </h1>
                    
                    <p class="text-xl text-slate-400 font-bold leading-relaxed mb-12 border-l-4 border-slate-100 pl-8 italic">
                        "${vo.summary}"
                    </p>

                    <div class="flex flex-wrap items-center gap-8 py-8 border-y border-slate-50 text-[13px] text-slate-400 font-bold mb-12">
                        <div class="flex items-center gap-2">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                            ${vo.writer}
                        </div>
                        <div class="flex items-center gap-2">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                            ${vo.regDate}
                        </div>
                        <div class="flex items-center gap-2">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg>
                            ${vo.hit} views
                        </div>
                    </div>

                    <div class="content-area whitespace-pre-wrap break-words flex-grow">
                        ${vo.content}
                    </div>
                    
                </div>
            </div>

            <div class="space-y-8">
                <div class="bg-white p-8 rounded-[40px] border border-slate-100 shadow-sm">
                    <h3 class="flex items-center gap-2.5 text-slate-900 font-black text-lg mb-8">
                        <div class="w-2 h-6 bg-emerald-500 rounded-full"></div>
                        태그
                    </h3>
                    <div class="flex flex-wrap gap-2.5">
                        <c:forEach var="tag" items="${vo.tagList}">
                            <span class="px-4 py-2 bg-slate-50 text-slate-400 text-xs font-black rounded-xl hover:bg-slate-100 transition-colors">
                                #${tag}
                            </span>
                        </c:forEach>
                    </div>
                </div>

                <div class="bg-white p-8 rounded-[40px] border border-slate-100 shadow-sm">
                    <h3 class="text-slate-900 font-black text-lg mb-8">관련 가이드</h3>
                    <div class="group cursor-pointer p-6 rounded-[32px] border border-slate-50 bg-slate-50/30 hover:bg-emerald-50/50 hover:border-emerald-100 transition-all">
                        <p class="font-bold text-slate-800 group-hover:text-emerald-700 mb-2 leading-snug">비상 대피 가방 준비 가이드</p>
                        <span class="text-[11px] text-slate-400 font-black flex items-center gap-1.5">
                            <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg> 
                            156
                        </span>
                    </div>
                </div>

                <div class="bg-emerald-600 p-10 rounded-[48px] shadow-xl shadow-emerald-100 text-white">
                    <h3 class="font-black text-xl mb-4">도움이 되셨나요?</h3>
                    <p class="text-emerald-100 text-sm font-medium leading-relaxed mb-8 opacity-80">이 가이드가 유용하셨다면 다른 분들과 공유해주세요.</p>
                    <div class="flex items-center gap-2 text-[11px] font-black uppercase tracking-widest text-emerald-200">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                        최종 수정: ${vo.regDate}
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</body>
</html>