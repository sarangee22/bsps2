<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>물품 상세 정보</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="p-6 md:p-10 bg-gray-50">
    <div class="max-w-5xl mx-auto">
        <a href="list.do?page=${param.page}&perPageNum=${param.perPageNum}" class="text-sm text-gray-500 mb-6 inline-block hover:text-gray-900">← 목록으로 돌아가기</a>
        
        <div class="flex items-center justify-between mb-10">
            <div class="flex items-center gap-4">
                <div class="p-3 bg-blue-50 text-blue-600 rounded-xl">
                    <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 11m8 4L4 11m16 4v10l-8 4m0-10v10"></path></svg>
                </div>
                <div>
                    <h1 class="text-4xl font-bold text-gray-900">${vo.name}</h1>
                    <p class="text-gray-500 font-medium">${vo.category}</p>
                </div>
            </div>
            <div class="flex gap-2">
                <a href="updateForm.do?no=${vo.no}&page=${param.page}&perPageNum=${param.perPageNum}" class="px-4 py-2 bg-white border border-gray-200 text-gray-700 rounded-lg font-bold hover:bg-gray-50">수정</a>
                <a href="delete.do?no=${vo.no}&perPageNum=${param.perPageNum}" class="px-4 py-2 bg-red-50 text-red-600 rounded-lg font-bold hover:bg-red-100" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
            </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="md:col-span-2 space-y-6">
                <div class="bg-white p-6 rounded-2xl border border-gray-100 flex items-center justify-between shadow-sm">
                    <div>
                        <p class="text-xs text-gray-400 font-bold uppercase">확인 상태</p>
                        <p class="text-2xl font-black mt-1 ${vo.isReady == 'Y' ? 'text-green-600' : 'text-orange-600'}">
                            ${vo.isReady == 'Y' ? '확인 완료' : '미확인'}
                        </p>
                    </div>
                    
                    <c:if test="${vo.isReady == 'N'}">
                        <a href="changeReady.do?no=${vo.no}&isReady=Y&page=${param.page}&perPageNum=${param.perPageNum}" 
                           class="px-6 py-3 bg-green-600 text-white rounded-xl font-bold hover:bg-green-700 transition-colors">
                           확인 완료로 변경
                        </a>
                    </c:if>
                    <c:if test="${vo.isReady == 'Y'}">
                        <a href="changeReady.do?no=${vo.no}&isReady=N&page=${param.page}&perPageNum=${param.perPageNum}" 
                           class="px-6 py-3 bg-orange-500 text-white rounded-xl font-bold hover:bg-orange-600 transition-colors">
                           미확인으로 변경
                        </a>
                    </c:if>
                </div>

                <div class="bg-white p-8 rounded-2xl border border-gray-100 shadow-sm space-y-8">
                    <div class="grid grid-cols-2 gap-4">
                        <div class="bg-gray-50 p-4 rounded-xl">
                            <p class="text-xs text-gray-400 font-bold uppercase">수량</p>
                            <p class="text-2xl font-bold mt-1 text-gray-900">${vo.quantity} ${vo.unit}</p>
                        </div>
                        <div class="bg-red-50 p-4 rounded-xl">
                            <p class="text-xs text-red-400 font-bold uppercase">우선순위</p>
                            <p class="text-2xl font-bold text-red-600 mt-1">${vo.priority}</p>
                        </div>
                    </div>
                    <div>
                        <p class="text-xs text-gray-400 font-bold uppercase mb-2">유효기한</p>
                        <p class="text-lg font-bold text-gray-900">${empty vo.expiryDate ? '기한 없음' : vo.expiryDate}</p>
                    </div>
                    <div>
                        <p class="text-xs text-gray-400 font-bold uppercase mb-2">메모</p>
                        <div class="bg-gray-50 p-5 rounded-xl text-gray-700 leading-relaxed">
                            ${empty vo.memo ? '입력된 메모가 없습니다.' : vo.memo}
                        </div>
                    </div>
                </div>
            </div>

            <div class="space-y-6">
                <div class="bg-white p-6 rounded-2xl border border-gray-100 shadow-sm space-y-4">
                    <h3 class="font-bold text-gray-400 uppercase text-xs tracking-wider">기록 정보</h3>
                    <div>
                        <p class="text-xs text-gray-400">최초 생성일</p>
                        <p class="text-sm font-bold text-gray-800">${vo.regDate}</p>
                    </div>
                    <div>
                        <p class="text-xs text-gray-400">최종 수정일</p>
                        <p class="text-sm font-bold text-gray-800">${empty vo.updateDate ? '-' : vo.updateDate}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>