<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>새 가이드 작성 - 교육 관리</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F4F7FE; }
        .input-base { border-none bg-slate-100/50 p-4 rounded-xl focus:ring-2 focus:ring-blue-500 w-full transition-all; }
        label { display: block; font-weight: 700; color: #1e293b; margin-bottom: 0.5rem; font-size: 0.95rem; }
        label span { color: #ef4444; margin-left: 2px; }
    </style>
</head>
<body class="p-6 md:p-12">
    <div class="max-w-7xl mx-auto">
        
        <header class="mb-10">
            <h1 class="text-3xl font-black text-slate-900 tracking-tighter">새 가이드 작성</h1>
            <p class="text-slate-500 font-medium mt-1">새로운 교육 가이드를 작성하세요.</p>
        </header>

        <form action="write.do" method="post" id="writeForm">
            <input type="hidden" name="status" id="status" value="발행됨">

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-10">
                
                <div class="lg:col-span-2 bg-white p-10 rounded-[32px] shadow-sm space-y-8">
                    <h2 class="text-lg font-bold text-slate-800 mb-6">가이드 정보</h2>
                    
                    <div>
                        <label>제목 <span>*</span></label>
                        <input type="text" name="title" required placeholder="예: 재난 발생 시 행동 요령" class="input-base text-lg font-semibold">
                    </div>

                    <div>
                        <label>카테고리</label>
                        <select name="category" class="input-base font-bold text-slate-600">
                            <option>재난 대비</option>
                            <option>안전 점검</option>
                            <option>응급처치</option>
                            <option>온보딩</option>
                        </select>
                    </div>

                    <div>
                        <label>작성자 <span>*</span></label>
                        <input type="text" name="writer" required placeholder="예: 재난안전본부" class="input-base">
                    </div>

                    <div>
                        <label>요약 <span>*</span></label>
                        <textarea name="summary" rows="2" placeholder="가이드의 핵심 내용을 간단히 요약하세요" class="input-base"></textarea>
                    </div>

                    <div>
                        <label>본문 <span>*</span></label>
                        <textarea name="content" rows="10" placeholder="마크다운 형식으로 작성하세요&#10;# 제목&#10;## 소제목&#10;- 목록&#10;**강조**" class="input-base leading-relaxed"></textarea>
                        <p class="text-[11px] text-slate-400 mt-2 font-medium">마크다운 문법을 사용할 수 있습니다: # 제목, ## 소제목, - 목록, **강조**</p>
                    </div>

                    <hr class="border-slate-100 my-10">

                    <div>
                        <label>태그</label>
                        <div class="flex gap-2">
                            <input type="text" name="tags" placeholder="태그를 입력하고 Enter를 누르세요" class="input-base flex-1">
                            <button type="button" class="px-5 bg-white border border-slate-200 rounded-xl hover:bg-slate-50 text-slate-400 text-xl font-bold">+</button>
                        </div>
                    </div>

                    <div class="flex justify-between items-center pt-10">
                        <div class="flex gap-3">
                            <button type="button" onclick="submitForm('발행됨')" class="bg-[#00c457] text-white px-8 py-3.5 rounded-xl font-bold flex items-center gap-2 hover:bg-emerald-600 transition-all shadow-lg shadow-emerald-100">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg>
                                발행하기
                            </button>
                            <button type="button" onclick="submitForm('임시저장')" class="bg-white border border-slate-200 text-slate-700 px-8 py-3.5 rounded-xl font-bold flex items-center gap-2 hover:bg-slate-50 transition-all">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4"></path></svg>
                                임시저장
                            </button>
                            <a href="list.do" class="bg-white border border-slate-200 text-slate-700 px-8 py-3.5 rounded-xl font-bold flex items-center gap-2 hover:bg-slate-50 transition-all">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M6 18L18 6M6 6l12 12"></path></svg>
                                취소
                            </a>
                        </div>
                        
                        <div class="hidden md:flex bg-slate-800 text-white p-2 rounded-2xl items-center gap-4 shadow-xl">
                            <span class="text-xs font-medium pl-3 opacity-80 flex items-center gap-2">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                버전 4 미리보는 중
                            </span>
                            <div class="flex gap-1">
                                <button type="button" class="px-3 py-1.5 text-[11px] font-bold bg-slate-700 hover:bg-slate-600 rounded-lg">미리보기 중지</button>
                                <button type="button" class="px-3 py-1.5 text-[11px] font-bold bg-blue-600 hover:bg-blue-500 rounded-lg">이 버전 복원</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="space-y-6">
                    <div class="bg-blue-50 border border-blue-100 p-8 rounded-[32px] sticky top-10">
                        <h3 class="text-slate-800 font-black text-lg mb-6">작성 가이드</h3>
                        
                        <div class="mb-8">
                            <p class="text-xs font-black text-blue-600 uppercase tracking-widest mb-4">마크다운 문법</p>
                            <ul class="text-sm text-slate-600 space-y-3 font-medium">
                                <li class="flex items-center gap-2"><span class="w-1.5 h-1.5 bg-blue-400 rounded-full"></span> # 큰 제목</li>
                                <li class="flex items-center gap-2"><span class="w-1.5 h-1.5 bg-blue-400 rounded-full"></span> ## 작은 제목</li>
                                <li class="flex items-center gap-2"><span class="w-1.5 h-1.5 bg-blue-400 rounded-full"></span> - 목록 항목</li>
                                <li class="flex items-center gap-2"><span class="w-1.5 h-1.5 bg-blue-400 rounded-full"></span> **굵은 글씨**</li>
                                <li class="flex items-center gap-2"><span class="w-1.5 h-1.5 bg-blue-400 rounded-full"></span> - [ ] 체크박스</li>
                            </ul>
                        </div>

                        <div>
                            <p class="text-xs font-black text-blue-600 uppercase tracking-widest mb-4">작성 팁</p>
                            <ul class="text-sm text-slate-600 space-y-3 font-medium">
                                <li class="flex items-center gap-2"><span class="w-1.5 h-1.5 bg-blue-400 rounded-full"></span> 명확하고 간결하게</li>
                                <li class="flex items-center gap-2"><span class="w-1.5 h-1.5 bg-blue-400 rounded-full"></span> 핵심 정보를 먼저</li>
                                <li class="flex items-center gap-2"><span class="w-1.5 h-1.5 bg-blue-400 rounded-full"></span> 단계별로 설명</li>
                                <li class="flex items-center gap-2"><span class="w-1.5 h-1.5 bg-blue-400 rounded-full"></span> 적절한 태그 사용</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <script>
        function submitForm(statusValue) {
            document.getElementById('status').value = statusValue;
            document.getElementById('writeForm').submit();
        }
    </script>
</body>
</html>