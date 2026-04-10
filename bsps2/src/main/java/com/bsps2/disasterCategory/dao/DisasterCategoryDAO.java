package com.bsps2.disasterCategory.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.bsps2.disaster.vo.DisasterVO;
import com.bsps2.main.dao.DAO;
import com.bsps2.util.db.DB;

public class DisasterCategoryDAO extends DAO {

    // [1] 중복 체크 (Connection 인자 추가)
    public int checkDuplicate(Connection con, String apiId) throws Exception {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM DISASTERINFO WHERE APIID = ?";
        try {
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, apiId);
            rs = pstmt.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
        }
        return count;
    }

 public void insertDisaster(Connection con, DisasterVO vo, List<Integer> catIDs) throws Exception {
        
        // 통합 테이블 disasterInfo에 맞춘 SQL
        String sql = "INSERT INTO disasterInfo (no, apiId, catID, title, locationName, dangerLevel, createDate, content) "
                   + " VALUES (disasterInfo_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";
        
        try {
            // 트랜잭션 설정 (Service에서 이미 설정했을 수 있으나 안전을 위해 유지)
            con.setAutoCommit(false); 

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, vo.getApiId());
            
            // 💡 리스트 중 첫 번째 카테고리를 대표 카테고리로 저장 (전처리 결과 반영)
            int catID = (catIDs != null && !catIDs.isEmpty()) ? catIDs.get(0) : 9;
            pstmt.setInt(2, catID);
            
            pstmt.setString(3, vo.getTitle());        // 제목
            pstmt.setString(4, vo.getLocationName());  // 지역
            pstmt.setInt(5, vo.getDangerLevel());     // 위험 등급
            pstmt.setString(6, vo.getCreateDate());    // 발생 일시
            pstmt.setString(7, vo.getContent());       // 요약 내용
            
            pstmt.executeUpdate();
            con.commit(); // 성공 시 커밋
            
            System.out.println(">>> [저장 완료] APIID: " + vo.getApiId() + " / 분류: " + catID);
            
        } catch (Exception e) {
            if (con != null) con.rollback(); // 에러 시 롤백
            e.printStackTrace();
            throw e;
        } finally {
            if (pstmt != null) pstmt.close();
        }
    }

    // [3] 카테고리 목록 조회 (기본 구조 유지)
    public List<DisasterVO> list() throws Exception {
        List<DisasterVO> list = new ArrayList<>();
        try {
            con = DB.getConnection();
            // 컬럼명 CAT_ID로 수정 확인 필요 (테이블 설계에 따라)
            String sql = "SELECT CATID, CAT_NAME FROM DISASTER_CATEGORY ORDER BY CATID ASC";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                DisasterVO vo = new DisasterVO();
                vo.setCatID(rs.getInt("CATID"));
                vo.setCategoryName(rs.getString("CAT_NAME"));
                list.add(vo);
            }
        } finally {
            DB.close(con, pstmt, rs);
        }
        return list;
    }

}