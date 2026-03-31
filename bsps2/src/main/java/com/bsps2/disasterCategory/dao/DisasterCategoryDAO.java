package com.bsps2.disasterCategory.dao;

import java.util.ArrayList;
import java.util.List;

import com.bsps2.disaster.vo.DisasterVO;
import com.bsps2.main.dao.DAO;
import com.bsps2.util.db.DB;

public class DisasterCategoryDAO extends DAO {

	// API 데이터 중복 체크 (Service에서 호출)
	public int checkDuplicate(String apiId) throws Exception{
		int count = 0;
		try {
            con = DB.getConnection();
            String sql = "SELECT COUNT(*) FROM disaster_list WHERE api_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, apiId);
            rs = pstmt.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } finally {
            DB.close(con, pstmt, rs);
        }
        return count;
	}// checkDuplicate()의 끝

	// 전처리된 데이터 삽입 (Service에서 호출)
	public int insert(DisasterVO vo, int catID) throws Exception {
	    int result = 0;
	    try {
	        // 1. DB 연결
	        con = DB.getConnection();
	        
	        // 2. SQL 작성 (risk_grade 컬럼 추가)
	        // [수정] 테이블 설계와 동일하게 컬럼명을 맞춥니다.
	        String sql = "INSERT INTO disaster_list(no, catID, api_id, summary, region, occur_date, risk_grade) "
	                   + "VALUES(disaster_list_seq.nextval, ?, ?, ?, ?, ?, ?)";
	        
	        // 3. 실행 객체 생성 및 데이터 세팅
	        pstmt = con.prepareStatement(sql);
	        
	        // ? 번호 순서가 중요합니다! (총 6개)
	        pstmt.setInt(1, catID);
	        pstmt.setString(2, vo.getApiId());
	        pstmt.setString(3, vo.getContent());      // DB의 summary
	        pstmt.setString(4, vo.getLocationName()); // DB의 region
	        pstmt.setString(5, vo.getCreateDate());   // DB의 occur_date
	        pstmt.setInt(6, vo.getDangerLevel());     // [추가] 서비스에서 계산된 등급
	        
	        // 4. 실행
	        result = pstmt.executeUpdate();
	        System.out.println("DisasterCategoryDAO.insert() - 데이터 저장 성공!");
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new Exception("재난 데이터 저장 중 DB 오류 발생: " + e.getMessage());
	    } finally {
	        // 5. 자원 반환
	        DB.close(con, pstmt);
	    }
	    return result;
	}// insert()의 끝    
 // 카테고리 8개 목록 가져오기
    public List<DisasterVO> list() throws Exception {
        List<DisasterVO> list = new ArrayList<>();
        try {
            con = DB.getConnection();
            String sql = "SELECT catID, cat_name FROM disaster_category ORDER BY catID ASC";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                DisasterVO vo = new DisasterVO();
                vo.setCatID(rs.getInt("catID"));
                vo.setCategoryName(rs.getString("cat_name"));
                list.add(vo);
            }
        } finally {
            DB.close(con, pstmt, rs);
        }
        return list;
    }// list()의 끝
    
}// 클래스의 끝