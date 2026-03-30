<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비상물품 정보 수정</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F9FAFB; }
        .input-base { width: 100%; padding: 12px 16px; border: 1px solid #E5E7EB; border-radius: 8px; background-color: #F3F4F6; margin-top: 8px; font-size: 0.95rem; }
        .input-base:focus { outline: none; border-color: #2563EB; background-color: #fff; ring: 2px ring-blue-100; }
        .label-base { font-size: 0.9rem; font-weight: 600; color: #374151; }
        .req { color: #DC2626; margin-left: 2px; }
    </style>
</head>
<body class="p-6 md:p-10">

    <div class="max-w-5xl mx-auto">
        <div class="mb-10">
            <a href="view.do?no=${vo.no}&page=${param.page}&perPageNum=${param.perPageNum}" class="text-sm text-gray-500 hover:text-gray-900 flex items-center gap-1.5 mb-4">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
                상세보기로 돌아가기
            </a>
            <h1 class="text-3xl font-bold text-gray-950">비상물품 수정</h1>
            <p class="text-gray-500 mt-1.5 text-sm">물품의 최신 정보를 업데이트하세요.</p>
        </div>

        <form action="update.do" method="post" class="grid grid-cols-1 md:grid-cols-3 gap-8">
            
            <input type="hidden" name="no" value="${vo.no}">
            <input type="hidden" name="page" value="${param.page}">
            <input type="hidden" name="perPageNum" value="${param.perPageNum}">

            <div class="md:col-span-2 bg-white p-8 rounded-2xl border border-gray-100 shadow-sm space-y-6">
                <h2 class="text-xl font-semibold text-gray-950 pb-4 border-b border-gray-100">물품 정보 수정</h2>

                <div>
                    <label class="label-base">물품명<span class="req">*</span></label>
                    <input type="text" name="name" value="${vo.name}" required class="input-base">
                </div>

                <div>
                    <label class="label-base">카테고리</label>
                    <select name="category" class="input-base appearance-none">
                        <option value="식수 및 식량" ${vo.category == '식수 및 식량' ? 'selected' : ''}>식수 및 식량</option>
                        <option value="조명" ${vo.category == '조명' ? 'selected' : ''}>조명</option>
                        <option value="의료용품" ${vo.category == '의료용품' ? 'selected' : ''}>의료용품</option>
                        <option value="통신" ${vo.category == '통신' ? 'selected' : ''}>통신</option>
                        <option value="기타" ${vo.category == '기타' ? 'selected' : ''}>기타</option>
                    </select>
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="label-base">수량<span class="req">*</span></label>
                        <input type="number" name="quantity" value="${vo.quantity}" required min="1" class="input-base">
                    </div>
                    <div>
                        <label class="label-base">단위</label>
                        <input type="text" name="unit" value="${vo.unit}" placeholder="예: 병, 개" class="input-base">
                    </div>
                </div>

                <div>
                    <label class="label-base">우선순위</label>
                    <select name="priority" class="input-base">
                        <option value="높음" ${vo.priority == '높음' ? 'selected' : ''}>높음</option>
                        <option value="중간" ${vo.priority == '중간' ? 'selected' : ''}>중간</option>
                        <option value="낮음" ${vo.priority == '낮음' ? 'selected' : ''}>낮음</option>
                    </select>
                </div>

                <div>
                    <label class="label-base">유효기한</label>
                    <input type="date" name="expiryDate" value="${vo.expiryDate}" class="input-base">
                </div>

                <div>
                    <label class="label-base mb-3 block">구비 상태</label>
                    <div class="flex gap-4">
                        <label class="flex-1 cursor-pointer">
                            <input type="radio" name="isReady" value="N" ${vo.isReady == 'N' ? 'checked' : ''} class="hidden peer">
                            <div class="p-3 text-center border rounded-xl peer-checked:bg-orange-50 peer-checked:border-orange-500 peer-checked:text-orange-700 bg-white text-gray-500">미확인</div>
                        </label>
                        <label class="flex-1 cursor-pointer">
                            <input type="radio" name="isReady" value="Y" ${vo.isReady == 'Y' ? 'checked' : ''} class="hidden peer">
                            <div class="p-3 text-center border rounded-xl peer-checked:bg-green-50 peer-checked:border-green-500 peer-checked:text-green-700 bg-white text-gray-500">확인 완료</div>
                        </label>
                    </div>
                </div>

                <div>
                    <label class="label-base">메모</label>
                    <textarea name="memo" rows="4" class="input-base">${vo.memo}</textarea>
                </div>

                <div class="pt-8 border-t border-gray-100 flex gap-3">
                    <button type="submit" class="px-8 py-3 bg-blue-600 text-white rounded-xl font-bold hover:bg-blue-700">수정 완료</button>
                    <a href="javascript:history.back()" class="px-8 py-3 bg-gray-100 text-gray-700 rounded-xl font-bold hover:bg-gray-200 text-center">취소</a>
                </div>
            </div>

            <div class="space-y-6">
                <div class="bg-white p-6 rounded-2xl border border-gray-100 shadow-sm">
                    <h3 class="font-bold text-gray-900 mb-4 flex items-center gap-2">
                        <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                        수정 안내
                    </h3>
                    <ul class="text-sm text-gray-500 space-y-3 list-disc list-inside">
                        <li>수정 시 <span class="text-gray-900 font-medium">최종 수정일</span>이 자동으로 갱신됩니다.</li>
                        <li>유효기한이 지난 물품은 <span class="text-red-600 font-medium font-bold">빨간색</span>으로 강조될 수 있습니다.</li>
                        <li>모든 변경 사항은 즉시 반영됩니다.</li>
                    </ul>
                </div>
            </div>
        </form>
    </div>

</body>
</html>