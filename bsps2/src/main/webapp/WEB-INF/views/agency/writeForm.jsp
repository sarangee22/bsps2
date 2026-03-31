<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container">
    <h2>기관 등록</h2>
    <form action="write.do" method="post">
        <div class="form-group">
            <label>기관명</label>
            <input name="agencyName" class="form-control" required>
        </div>
        <div class="form-group">
            <label>기관유형</label>
            <select name="agencyType" class="form-control">
                <option>소방서</option>
                <option>경찰서</option>
                <option>응급의료센터</option>
            </select>
        </div>
        <div class="form-group">
            <label>연락처</label>
            <input name="phone" class="form-control" placeholder="02-123-4567" required>
        </div>
        <div class="form-group">
            <label>주소</label>
            <input name="address" class="form-control" required>
        </div>
        <div class="row">
            <div class="col">
                <label>위도</label>
                <input type="number" step="0.000001" name="latitude" class="form-control" required>
            </div>
            <div class="col">
                <label>경도</label>
                <input type="number" step="0.000001" name="longitude" class="form-control" required>
            </div>
        </div>
        <div class="form-group mt-2">
            <label>운영시간</label>
            <input name="operatingHours" class="form-control" value="24시간 연중무휴">
        </div>
        <button type="submit" class="btn btn-success">등록하기</button>
    </form>
</div>