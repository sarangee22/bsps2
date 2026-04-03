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
    public void insertAll(Connection con, DisasterVO vo, List<Integer> catIDs) throws Exception {
    		PreparedStatement pstmtList = null;
        PreparedStatement pstmtDetail = null;
        PreparedStatement pstmtAssign = null;
        ResultSet rsKeys = null;
        
        try {
        	con.setAutoCommit(false); // 트랜잭션 시작

            // 1. DISASTER_LIST 삽입 (CATID 컬럼은 삭제했으므로 뺍니다)
            String sqlList = "INSERT INTO DISASTER_LIST (NO, SUMMARY, OCCUR_DATE, REGION, RISK_GRADE, API_ID) " 
                           + " VALUES (DISASTER_LIST_SEQ.NEXTVAL, ?, TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS'), ?, ?, ?) ";
            
            pstmtList = con.prepareStatement(sqlList, new String[]{"NO"}); 
            pstmtList.setString(1, vo.getContent());
            pstmtList.setString(2, vo.getCreateDate());
            pstmtList.setString(3, vo.getLocationName());
            pstmtList.setInt(4, vo.getDangerLevel());
            pstmtList.setString(5, vo.getApiId());
            pstmtList.executeUpdate();

            // 생성된 시퀀스 번호(NO) 가져오기
            rsKeys = pstmtList.getGeneratedKeys();
            long newNo = 0;
            if(rsKeys.next()) newNo = rsKeys.getLong(1);

            // 2. DISASTER_DETAIL 삽입 (기존과 동일)
            String sqlDetail = "INSERT INTO DISASTER_DETAIL(DETAILID, NO, DETAIL_INFO, SITUATION_DESC, MAP_LOCATION) "
                             + " VALUES(DISASTER_DETAIL_SEQ.NEXTVAL, ?, ?, ?, ?)";
            pstmtDetail = con.prepareStatement(sqlDetail);
            pstmtDetail.setLong(1, newNo);
            pstmtDetail.setString(2, vo.getContent());
            pstmtDetail.setString(3, "현재 상황 확인 중");
            pstmtDetail.setString(4, vo.getLocationName());
            pstmtDetail.executeUpdate();

            // 3. 💡 [핵심] DISASTER_CAT_ASSIGN 매핑 테이블 삽입
            // 넘겨받은 카테고리 리스트(catIDs)만큼 반복해서 저장합니다.
            String sqlAssign = "INSERT INTO DISASTER_CAT_ASSIGN (NO, CATID) VALUES (?, ?)";
            pstmtAssign = con.prepareStatement(sqlAssign);
            
            for (int catID : catIDs) {
                pstmtAssign.setLong(1, newNo);
                pstmtAssign.setInt(2, catID);
                pstmtAssign.executeUpdate();
                // 팁: Batch 처리를 쓰면 더 빠르지만, 일단 이해하기 쉽게 기본 루프로 짭니다.
            }

            con.commit(); // 모든 삽입 성공 시 커밋
            System.out.println(">>> [전처리 저장] NO: " + newNo + " / 카테고리 개수: " + catIDs.size());
            
        } catch (Exception e) {
            if (con != null) con.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            // 리소스 해제 (생성 역순)
            if (rsKeys != null) rsKeys.close();
            if (pstmtAssign != null) pstmtAssign.close();
            if (pstmtDetail != null) pstmtDetail.close();
            if (pstmtList != null) pstmtList.close();
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
                   + " FROM DISASTER ORDER BY DISASTER_ID DESC";
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