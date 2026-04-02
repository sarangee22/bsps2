<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<decorator:head>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Bootstrap의 container 여백 무력화 및 커스텀 스타일 */
        .priority-high { background-color: #FEE2E2 !important; color: #991B1B !important; } 
        .priority-mid { background-color: #FEF3C7 !important; color: #92400E !important; }  
        .priority-low { background-color: #E0F2FE !important; color: #075985 !important; }  
        /* 데코레이터 margin-top 때문에 겹쳐 보이면 아래 수치 조절 */
        .main-content-wrapper { margin-top: 20px; }
    </style>
</decorator:head>

<div class="main-content-wrapper w-full overflow-x-hidden">

    <div class="flex flex-col md:flex-row md:items-center justify-between mb-8 gap-4">
        <div class="flex items-center gap-4">
            <div class="p-4 bg-blue-600 rounded-2xl text-white shadow-xl shadow-blue-100">
                <i class="fa fa-check-square-o fa-2x"></i> 
            </div> 
            <div>
                <h1 class="text-3xl font-black text-slate-900 tracking-tighter">비상물품 체크리스트</h1>
                <p class="text-slate-500 font-medium text-sm">재난 대비를 위한 필수 물품을 점검하세요.</p>
            </div>
        </div>
        <a href="writeForm.do?perPageNum=${pageObject.perPageNum}" class="bg-blue-600 text-white px-6 py-3.5 rounded-xl font-bold flex items-center justify-center gap-2 hover:bg-blue-700 transition-all shadow-lg shadow-blue-100">
            <i class="fa fa-plus"></i> 새 물품 추가
        </a>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
        <div class="bg-white p-7 rounded-[24px] border border-slate-100 shadow-sm flex items-center justify-between">
            <div><p class="text-[11px] font-black text-slate-400 uppercase tracking-widest">Total Items</p><p class="text-4xl font-black text-slate-900 mt-1">${meta.total}</p></div>
            <div class="text-blue-500 opacity-20"><i class="fa fa-archive fa-3x"></i></div>
        </div>
        <div class="bg-white p-7 rounded-[24px] border border-slate-100 shadow-sm flex items-center justify-between">
            <div><p class="text-[11px] font-black text-slate-400 uppercase tracking-widest">Ready</p><p class="text-4xl font-black text-green-600 mt-1">${meta.ready}</p></div>
            <div class="text-green-500 opacity-20"><i class="fa fa-check-circle fa-3x"></i></div>
        </div>
        <div class="bg-white p-7 rounded-[24px] border border-slate-100 shadow-sm flex items-center justify-between">
            <div><p class="text-[11px] font-black text-slate-400 uppercase tracking-widest">Pending</p><p class="text-4xl font-black text-orange-600 mt-1">${meta.notReady}</p></div>
            <div class="text-orange-500 opacity-20"><i class="fa fa-clock-o fa-3x"></i></div>
        </div>
    </div>

    <div class="bg-white rounded-[32px] border border-slate-100 shadow-sm overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-left border-collapse">
                <thead class="bg-slate-50/50 border-b border-slate-100">
                    <tr class="text-slate-400 text-[11px] font-black uppercase tracking-widest">
                        <th class="px-8 py-5 text-center">Status</th>
                        <th class="px-8 py-5">Item Name</th>
                        <th class="px-8 py-5">Category</th>
                        <th class="px-8 py-5 text-center">Qty</th>
                        <th class="px-8 py-5 text-center">Priority</th>
                        <th class="px-8 py-5 text-center">Expiry</th>
                        <th class="px-8 py-5 text-center">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-50">
                    <c:forEach var="vo" items="${list}">
                        <tr class="hover:bg-slate-50/50 transition-colors cursor-pointer" onclick="location='view.do?no=${vo.no}'">
                            <td class="px-8 py-6 text-center" onclick="event.stopPropagation();">
                                <input type="checkbox" ${vo.isReady == 'Y' ? 'checked' : ''} class="w-5 h-5 rounded-lg border-slate-300 text-blue-600 focus:ring-blue-500 transition-all">
                            </td>
                            <td class="px-8 py-6 font-bold text-slate-900">${vo.name}</td>
                            <td class="px-8 py-6 text-slate-500 font-medium text-sm">${vo.category}</td>
                            <td class="px-8 py-6 text-center font-black text-slate-700">${vo.quantity}${vo.unit}</td>
                            <td class="px-8 py-6 text-center">
                                <c:set var="pClass" value="${vo.priority == '높음' ? 'priority-high' : (vo.priority == '낮음' ? 'priority-low' : 'priority-mid')}" />
                                <span class="px-3 py-1.5 text-[10px] font-black rounded-lg ${pClass}">${vo.priority}</span>
                            </td>
                            <td class="px-8 py-6 text-center text-slate-400 font-bold text-xs">${vo.expiryDate}</td>
                            <td class="px-8 py-6 text-center" onclick="event.stopPropagation();">
                                <div class="flex items-center justify-center gap-3">
                                    <a href="updateForm.do?no=${vo.no}" class="text-slate-300 hover:text-blue-600 transition-colors"><i class="fa fa-pencil"></i></a>
                                    <a href="delete.do?no=${vo.no}" class="text-slate-300 hover:text-rose-500 transition-colors" onclick="return confirm('삭제할까요?')"><i class="fa fa-trash"></i></a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <div class="py-12 flex justify-center bg-slate-50/30 border-t border-slate-50">
            <pageNav:pageNav listURI="list.do" pageObject="${pageObject}" />
        </div>
    </div>
</div>