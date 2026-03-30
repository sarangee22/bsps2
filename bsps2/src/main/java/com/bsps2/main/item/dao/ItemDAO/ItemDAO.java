package com.bsps2.main.item.dao.ItemDAO; // 기존 패키지 경로 유지

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bsps2.main.dao.DAO;
import com.bsps2.main.item.vo.ItemVO.ItemVO;
import com.bsps2.util.db.DB;
import com.bsps2.util.page.PageObject;

public class ItemDAO extends DAO {

	// [추가] 대시보드 통계용 메서드
	public Map<String, Long> getMetaData() throws Exception {
		Map<String, Long> map = new HashMap<String, Long>();
		try {
			con = DB.getConnection();
			String sql = "SELECT COUNT(*) total, "
					   + "COUNT(DECODE(isReady, 'Y', 1)) ready, "
					   + "COUNT(DECODE(isReady, 'N', 1)) notReady FROM my_checklist";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs != null && rs.next()) {
				map.put("total", rs.getLong("total"));
				map.put("ready", rs.getLong("ready"));
				map.put("notReady", rs.getLong("notReady"));
			}
		} finally { DB.close(con, pstmt, rs); }
		return map;
	}

	// 1. 목록 조회 (모든 확장 컬럼 포함)
	public List<ItemVO> list(PageObject pageObject) throws Exception {
		List<ItemVO> list = new ArrayList<ItemVO>();
		try {
			con = DB.getConnection();
			// SQL 수정: quantity, unit, priority, expiryDate 추가
			String sql = "select no, name, category, quantity, unit, priority, to_char(expiryDate, 'yyyy. mm. dd.') expiryDate, isReady "
					   + " from my_checklist order by no desc";
			sql = "select rownum rnum, no, name, category, quantity, unit, priority, expiryDate, isReady from (" + sql + ")";
			sql = "select * from (" + sql + ") where rnum between ? and ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, pageObject.getStartRow());
			pstmt.setLong(2, pageObject.getEndRow());
			rs = pstmt.executeQuery();
			
			if(rs != null) {
				while(rs.next()) {
					ItemVO vo = new ItemVO();
					vo.setNo(rs.getLong("no"));
					vo.setName(rs.getString("name"));
					vo.setCategory(rs.getString("category"));
					// 데이터 매핑 추가
					vo.setQuantity(rs.getInt("quantity"));
					vo.setUnit(rs.getString("unit"));
					vo.setPriority(rs.getString("priority"));
					vo.setExpiryDate(rs.getString("expiryDate"));
					vo.setIsReady(rs.getString("isReady"));
					list.add(vo);
				}
			}
		} finally { DB.close(con, pstmt, rs); }
		return list;
	}

	// 2. 전체 데이터 개수
	public Long getTotalRow(PageObject pageObject) throws Exception {
		Long totalRow = 0L;
		try {
			con = DB.getConnection();
			String sql = "select count(*) from my_checklist";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs != null && rs.next()) totalRow = rs.getLong(1);
		} finally { DB.close(con, pstmt, rs); }
		return totalRow;
	}

	// 3. 등록 (확장 컬럼 반영)
	public Integer write(ItemVO vo) throws Exception {
		int result = 0;
		try {
			con = DB.getConnection();
			// SQL 수정: quantity, unit, priority, expiryDate, isReady(기본값)
			String sql = "insert into my_checklist(no, id, name, category, quantity, unit, priority, expiryDate, memo, isReady) "
					   + " values(check_seq.nextval, ?, ?, ?, ?, ?, ?, to_date(?, 'yyyy-mm-dd'), ?, 'N')";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getName());
			pstmt.setString(3, vo.getCategory());
			pstmt.setInt(4, vo.getQuantity());
			pstmt.setString(5, vo.getUnit());
			pstmt.setString(6, vo.getPriority());
			pstmt.setString(7, vo.getExpiryDate());
			pstmt.setString(8, vo.getMemo());
			result = pstmt.executeUpdate();
		} finally { DB.close(con, pstmt); }
		return result;
	}

	// 4. 상세보기 (확장 컬럼 반영)
	public ItemVO view(Long no) throws Exception {
		ItemVO vo = null;
		try {
			con = DB.getConnection();
			String sql = "select no, name, category, quantity, unit, priority, to_char(expiryDate, 'yyyy-mm-dd') expiryDate, isReady, memo, to_char(regDate, 'yyyy-mm-dd') regDate from my_checklist where no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, no);
			rs = pstmt.executeQuery();
			if(rs != null && rs.next()) {
				vo = new ItemVO();
				vo.setNo(rs.getLong("no"));
				vo.setName(rs.getString("name"));
				vo.setCategory(rs.getString("category"));
				vo.setQuantity(rs.getInt("quantity"));
				vo.setUnit(rs.getString("unit"));
				vo.setPriority(rs.getString("priority"));
				vo.setExpiryDate(rs.getString("expiryDate"));
				vo.setIsReady(rs.getString("isReady"));
				vo.setMemo(rs.getString("memo"));
				vo.setRegDate(rs.getString("regDate"));
			}
		} finally { DB.close(con, pstmt, rs); }
		return vo;
	}

	// 5. 수정 (확장 컬럼 반영)
	public Integer update(ItemVO vo) throws Exception {
		int result = 0;
		try {
			con = DB.getConnection();
			// SQL 수정: 모든 정보 업데이트
			String sql = "update my_checklist set name = ?, category = ?, quantity = ?, unit = ?, priority = ?, "
					   + " expiryDate = to_date(?, 'yyyy-mm-dd'), isReady = ?, memo = ? where no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getCategory());
			pstmt.setInt(3, vo.getQuantity());
			pstmt.setString(4, vo.getUnit());
			pstmt.setString(5, vo.getPriority());
			pstmt.setString(6, vo.getExpiryDate());
			pstmt.setString(7, vo.getIsReady());
			pstmt.setString(8, vo.getMemo());
			pstmt.setLong(9, vo.getNo());
			result = pstmt.executeUpdate();
		} finally { DB.close(con, pstmt); }
		return result;
	}

	// 6. 삭제
	public Integer delete(long no) throws Exception {
		int result = 0;
		try {
			con = DB.getConnection();
			String sql = "delete from my_checklist where no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, no);
			result = pstmt.executeUpdate();
		} finally { DB.close(con, pstmt); }
		return result;
	}
	
	// 7. isready
	public Integer changeReady(Long no, String isReady) throws Exception {
	    int result = 0;
	    try {
	        con = DB.getConnection();
	        // 현재 상태의 반대나 특정 상태로 변경 (보통 'Y'로 변경)
	        String sql = "update my_checklist set isReady = ? where no = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, isReady);
	        pstmt.setLong(2, no);
	        result = pstmt.executeUpdate();
	    } finally {
	        DB.close(con, pstmt);
	    }
	    return result;
	}
}