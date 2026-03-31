<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>새 비상물품 추가</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #F9FAFB; }
        .form-input { width: 100%; padding: 12px; border: 1px solid #E5E7EB; border-radius: 8px; background-color: #F3F4F6; margin-top: 6px; }
        .form-input:focus { outline: none; border-color: #2563EB; background-color: white; }
    </style>
</head>
<body class="p-6 md:p-10">
    <div class="max-w-5xl mx-auto">
        <a href="list.do" class="text-sm text-gray-500 mb-6 inline-block hover:text-gray-800">← 목록으로 돌아가기</a>
        <h1 class="text-3xl font-bold text-gray-900 mb-2">새 비상물품 추가</h1>
        <p class="text-gray-500 mb-10">새로운 비상물품을 등록하세요.</p>

        <form action="write.do" method="post" class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="md:col-span-2 bg-white p-8 rounded-2xl border border-gray-100 shadow-sm space-y-6">
                <div><label class="text-sm font-semibold">물품명 <span class="text-red-500">*</span></label>
                <input type="text" name="name" required placeholder="예: 생수, 손전등" class="form-input"></div>
                 
                <div><label class="text-sm font-semibold">카테고리</label>
                <select name="category" class="form-input">
                    <option value="식수 및 식량">식수 및 식량</option><option value="의료용품">의료용품</option>
                    <option value="조명">조명</option><option value="통신">통신</option>
                </select></div>

                <div class="grid grid-cols-2 gap-4">
                    <div><label class="text-sm font-semibold">수량 <span class="text-red-500">*</span></label>
                    <input type="number" name="quantity" value="1" class="form-input"></div>
                    <div><label class="text-sm font-semibold">단위</label>
                    <input type="text" name="unit" placeholder="병, 개, 세트" class="form-input"></div>
                </div>

                <div><label class="text-sm font-semibold">우선순위</label>
                <select name="priority" class="form-input">
                    <option value="높음">높음</option><option value="중간" selected>중간</option><option value="낮음">낮음</option>
                </select></div>

                <div><label class="text-sm font-semibold">유효기한</label>
                <input type="date" name="expiryDate" class="form-input"></div>

                <div><label class="text-sm font-semibold">메모</label>
                <textarea name="memo" rows="4" class="form-input" placeholder="추가 정보를 입력하세요"></textarea></div>

                <div class="flex gap-3 pt-4">
                    <button type="submit" class="px-6 py-3 bg-blue-600 text-white rounded-xl font-bold hover:bg-blue-700">추가하기</button>
                    <a href="list.do" class="px-6 py-3 bg-gray-100 rounded-xl font-bold">취소</a>
                </div>
            </div>

            <div class="bg-blue-50 p-6 rounded-2xl border border-blue-100 self-start">
                <h3 class="font-bold text-lg mb-4">작성 가이드</h3>
                <ul class="text-sm text-gray-600 space-y-4">
                    <li><p class="font-bold text-gray-900">우선순위</p> 높음: 생존 필수품 | 중간: 중요한 물품</li>
                    <li><p class="font-bold text-gray-900">유효기한</p> 식품, 의약품 등 기한이 있는 것만 입력</li>
                </ul>
            </div>
        </form>
    </div>
</body>
</html>