package com.bsps2.disasterList.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.bsps2.disaster.vo.DisasterVO;
import com.bsps2.main.dao.DAO;
import com.bsps2.util.db.DB;
import com.bsps2.util.page.PageObject;

public class DisasterListDAO extends DAO {

	// 1. 재난 상세 목록 조회 (catID와 pageObject 활용)
	public List<DisasterVO> list(int catID, PageObject pageObject) throws Exception {
		// 리턴 타입과 동일한 변수 선언 - 결과 저장
		List<DisasterVO> list = null;
		
		try {
			// 1. 드라이버 확인 & 2. 연결 객체
			con = DB.getConnection();
			
			// 3. 실행할 쿼리 작성
			// 3-1. 원본 데이터 가져오기 (해당 카테고리 조건 포함)
			String sql = "select no, summary, region, occur_date from disaster_list where catID = ? ";
			
			// 검색 처리를 한다. (메서드 활용)
			sql += search(pageObject);
			
			sql += " order by no desc";
			
			// 3-2. 순서 번호(rownum)를 붙인다.
			sql = "select rownum rnum, no, summary, region, occur_date " 
				+ " from(" + sql + ")";
			
			// 3-3. 페이지에 맞는 데이터만 가져온다. (rnum 조건)
			sql = "select rnum, no, summary, region, occur_date "
				+ " from(" + sql + ") where rnum between ? and ?";
			
			// 4. 실행 객체 & 데이터 세팅
			pstmt = con.prepareStatement(sql);
			int idx = 1;
			
			// ? 데이터 세팅 1: 카테고리 번호
			pstmt.setInt(idx++, catID);
			
			// ? 데이터 세팅 2: 검색 데이터 (있을 경우만 idx 증가)
			idx = searchDataSet(pstmt, idx, pageObject);
			
			// ? 데이터 세팅 3: 페이징 시작/끝 번호
			pstmt.setLong(idx++, pageObject.getStartRow());
			pstmt.setLong(idx++, pageObject.getEndRow());
			
			// 5. 실행
			rs = pstmt.executeQuery();
			
			// 6. DB에서 가져온 데이터 채우기
			if(rs != null) {
				list = new ArrayList<>();
				while(rs.next()) {
					DisasterVO vo = new DisasterVO();
					vo.setNo(rs.getInt("no"));
					vo.setContent(rs.getString("summary"));
					vo.setLocationName(rs.getString("region"));
					vo.setCreateDate(rs.getString("occur_date"));
					list.add(vo);
				} //while의 끝
			}// if의 끝
		}// try의 끝 
		catch (Exception e) {
			e.printStackTrace();
			throw new Exception("재난 목록 DB 처리 중 오류 발생");
		} // catch의 끝
		finally {
			// 7. DB 닫기
			DB.close(con, pstmt, rs);
		} // finally의 끝
		
		return list;
	}// list()의 끝

	// 2. 검색 쿼리를 생성하는 메서드
	private String search(PageObject pageObject) {
		String sql = "";
		String key = pageObject.getKey();
		String word = pageObject.getWord();
		
		if(word != null && !word.equals("")) {
			sql += " and ( 1=0 "; // 검색 조건 시작 (OR 연산을 위해 1=0 추가)
			if(key.indexOf("t") >= 0) sql += " or summary like ? ";
			if(key.indexOf("l") >= 0) sql += " or region like ? ";
			sql += " ) ";
		}// if의 끝
		return sql;
	} //search의 끝

	// 3. 검색 데이터 pstmt 세팅 메서드
	private int searchDataSet(PreparedStatement pstmt, int idx, PageObject pageObject) throws SQLException {
		String key = pageObject.getKey();
		String word = pageObject.getWord();
		
		if(word != null && !word.equals("")) {
			if(key.indexOf("t") >= 0) pstmt.setString(idx++, "%" + word + "%");
			if(key.indexOf("l") >= 0) pstmt.setString(idx++, "%" + word + "%");
		} // if의 끝
		return idx;
	}// searchDataSet()의 끝

    // 4. 전체 데이터 개수 구하기 (페이징 처리를 위해 반드시 필요)
    public long getTotalRow(int catID, PageObject pageObject) throws Exception {
        long totalRow = 0;
        try {
            con = DB.getConnection();
            String sql = "select count(*) from disaster_list where catID = ? ";
            sql += search(pageObject);
            
            pstmt = con.prepareStatement(sql);
            int idx = 1;
            pstmt.setInt(idx++, catID);
            searchDataSet(pstmt, idx, pageObject);
            
            rs = pstmt.executeQuery();
            if(rs != null && rs.next()) totalRow = rs.getLong(1);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DB.close(con, pstmt, rs);
        }
        return totalRow;
    } // getTotalRow의 끝
    
    // 5. 재난/안전 정보 글보기
    public DisasterVO view(long no) throws Exception {
        DisasterVO vo = null;
        try {
            con = DB.getConnection();
            String sql = "SELECT no, summary, region, occur_date, risk_grade FROM disaster_list WHERE no = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setLong(1, no);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                vo = new DisasterVO();
                vo.setNo(rs.getInt("no"));
                vo.setContent(rs.getString("summary"));
                vo.setLocationName(rs.getString("region"));
                vo.setCreateDate(rs.getString("occur_date"));
                vo.setDangerLevel(rs.getInt("risk_grade"));
            }
        } finally {
            DB.close(con, pstmt, rs);
        }
        return vo;
    }// view()의 끝
}