package com.bsps2.disasterCategory.dao;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import com.bsps2.disaster.vo.DisasterVO;
import com.bsps2.main.dao.DAO;
import com.bsps2.util.db.DB;

public class DisasterCategoryDAO extends DAO {

    // [1] 중복 체크 (Connection 인자 추가)
    public int checkDuplicate(Connection con, String apiId) throws Exception {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM DISASTER_LIST WHERE API_ID = ?";
        try {
            // 외부 con 사용하므로 DB.getConnection() 지움
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, apiId);
            rs = pstmt.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } finally {
            // con은 닫지 않고 pstmt와 rs만 닫음
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
        }
        return count;
    }

    // [2] 동시 삽입 (Connection 인자 추가)
    public void insertAll(Connection con, DisasterVO vo, int catID) throws Exception {
        try {
            con.setAutoCommit(false); 

            String sqlList = "INSERT INTO DISASTER_LIST (NO, CATID, SUMMARY, OCCUR_DATE, REGION, RISK_GRADE, API_ID) " 
                    + " VALUES (DISASTER_LIST_SEQ.NEXTVAL, ?, ?, TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS'), ?, ?, ?) ";
            
            pstmt = con.prepareStatement(sqlList, new String[]{"NO"}); 
            pstmt.setInt(1, catID);
            pstmt.setString(2, vo.getContent());
            pstmt.setString(3, vo.getCreateDate());
            pstmt.setString(4, vo.getLocationName());
            pstmt.setInt(5, vo.getDangerLevel());
            pstmt.setString(6, vo.getApiId());
            pstmt.executeUpdate();

            rs = pstmt.getGeneratedKeys();
            long newNo = 0;
            if(rs.next()) newNo = rs.getLong(1);

            String sqlDetail = "INSERT INTO DISASTER_DETAIL(DETAILID, NO, DETAIL_INFO, SITUATION_DESC, MAP_LOCATION) "
                             + " VALUES(DISASTER_DETAIL_SEQ.NEXTVAL, ?, ?, ?, ?)";
            
            // 기존 pstmt 닫고 새로 생성
            if (pstmt != null) pstmt.close();
            pstmt = con.prepareStatement(sqlDetail);
            pstmt.setLong(1, newNo);
            pstmt.setString(2, vo.getContent());
            pstmt.setString(3, "현재 상황 확인 중");
            pstmt.setString(4, vo.getLocationName());
            pstmt.executeUpdate();

            con.commit(); 
            System.out.println(">>> [저장 완료] NO: " + newNo + " / API_ID: " + vo.getApiId());
            
        }  catch (Exception e) {
            if (con != null) con.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
        }
    }

    // [3] 카테고리 목록 조회 (기본 구조 유지)
    public List<DisasterVO> list() throws Exception {
        List<DisasterVO> list = new ArrayList<>();
        try {
            con = DB.getConnection();
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
    
    // [4] 원본 데이터 가져오기 (Connection 인자 추가)
    public List<DisasterVO> getRawDisasterData(Connection con) throws Exception {
        List<DisasterVO> list = new ArrayList<>();
        // 💡 팁: BSPS.DISASTER 처럼 스키마명을 붙여주면 더 안전합니다.
        String sql = "SELECT DISASTER_ID, DESCRIPTION, DISASTER_NAME, DISASTER_DATE "
                   + " FROM DISASTER WHERE ROWNUM <= 50";
        try {
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                DisasterVO vo = new DisasterVO();
                vo.setApiId(String.valueOf(rs.getLong("DISASTER_ID"))); 
                vo.setContent(rs.getString("DESCRIPTION"));            
                vo.setLocationName(rs.getString("DISASTER_NAME"));     
                vo.setCreateDate(rs.getString("DISASTER_DATE")); 
                list.add(vo);
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
        }
        return list;
    }
}