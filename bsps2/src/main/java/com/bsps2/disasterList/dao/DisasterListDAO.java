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

	public List<DisasterVO> list(int catID, PageObject pageObject) throws Exception {
        List<DisasterVO> list = null;
        try {
            con = DB.getConnection();
            
            // 1. 기본 쿼리 (매핑 테이블 DISASTER_CAT_ASSIGN 조인)
            // L.catID = ? 대신 A.catID = ? 를 사용하고 L.no = A.no 조건을 추가합니다.
            String sql = "SELECT l.no, l.summary, l.region, l.occur_date "
                       + " FROM disaster_list l, disaster_cat_assign a "
                       + " WHERE (l.no = a.no AND a.catID = ?) ";
            
            // 2. 검색 조건 추가
            String searchSql = search(pageObject);
            sql += searchSql;
            
            sql += " ORDER BY l.no DESC";
            
            // 3. 페이징 처리를 위한 3중 서브쿼리
            sql = "SELECT rownum rnum, no, summary, region, occur_date FROM (" + sql + ")";
            sql = "SELECT rnum, no, summary, region, occur_date FROM (" + sql + ") WHERE rnum BETWEEN ? AND ?";
            
            pstmt = con.prepareStatement(sql);
            int idx = 1;
            
            pstmt.setInt(idx++, catID);
            // 검색 데이터 세팅 (searchSql이 있을 때만 idx 증가)
            idx = searchDataSet(pstmt, idx, pageObject);
            
            pstmt.setLong(idx++, pageObject.getStartRow());
            pstmt.setLong(idx++, pageObject.getEndRow());
            
            rs = pstmt.executeQuery();
            
            if(rs != null) {
                list = new ArrayList<>();
                while(rs.next()) {
                    DisasterVO vo = new DisasterVO();
                    vo.setNo(rs.getInt("no"));
                    vo.setContent(rs.getString("summary"));
                    vo.setLocationName(rs.getString("region"));
                    vo.setCreateDate(rs.getString("occur_date"));
                    list.add(vo);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("재난 목록 조회 중 DB 오류");
        } finally {
            DB.close(con, pstmt, rs);
        }
        return list;
    }// list()의 끝

    private String search(PageObject pageObject) {
        String sql = "";
        String key = pageObject.getKey();
        String word = pageObject.getWord();
        if(word != null && !word.trim().equals("")) {
            sql += " AND ( 1=0 "; 
            if(key.indexOf("t") >= 0) sql += " OR summary LIKE ? ";
            if(key.indexOf("l") >= 0) sql += " OR region LIKE ? ";
            sql += " ) ";
        }
        return sql;
    }

    private int searchDataSet(PreparedStatement pstmt, int idx, PageObject pageObject) throws SQLException {
        String key = pageObject.getKey();
        String word = pageObject.getWord();
        if(word != null && !word.trim().equals("")) {
            if(key.indexOf("t") >= 0) pstmt.setString(idx++, "%" + word + "%");
            if(key.indexOf("l") >= 0) pstmt.setString(idx++, "%" + word + "%");
        }
        return idx;
    }

    public long getTotalRow(int catID, PageObject pageObject) throws Exception {
        long totalRow = 0;
        try {
            con = DB.getConnection();
            // 데이터 개수를 셀 때도 매핑 테이블과 조인해야 정확한 카운트가 나옵니다.
            String sql = "SELECT COUNT(*) FROM disaster_list l, disaster_cat_assign a "
                       + " WHERE (l.no = a.no AND a.catID = ?) ";
            sql += search(pageObject);
            
            pstmt = con.prepareStatement(sql);
            int idx = 1;
            pstmt.setInt(idx++, catID);
            searchDataSet(pstmt, idx, pageObject);
            
            rs = pstmt.executeQuery();
            if(rs != null && rs.next()) totalRow = rs.getLong(1);
        } finally {
            DB.close(con, pstmt, rs);
        }
        return totalRow;
    } // getTotalRow()의 끝

 // DisasterListDAO.java 내의 view 메서드 부분 수정
    public DisasterVO view(long no) throws Exception {
        DisasterVO vo = null;
        try {
            con = DB.getConnection();
            // 💡 ACTION_GUIDE를 빼고 테이블에 실제 존재하는 컬럼들만 적어주세요.
            String sql = "SELECT l.no, l.summary, l.occur_date, l.region, l.risk_grade, "
                       + " d.detail_info, d.situation_desc, d.map_location " // ACTION_GUIDE 제거
                       + " FROM disaster_list l, disaster_detail d "
                       + " WHERE l.no = ? AND l.no = d.no";
            
            pstmt = con.prepareStatement(sql);
            pstmt.setLong(1, no);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                vo = new DisasterVO();
                vo.setNo(rs.getLong("no"));
                vo.setContent(rs.getString("summary"));
                vo.setCreateDate(rs.getString("occur_date"));
                vo.setLocationName(rs.getString("region"));
                vo.setDangerLevel(rs.getInt("risk_grade"));
                // 💡 RS에서 꺼낼 때도 ACTION_GUIDE 대신 상세 정보를 꺼내옵니다.
                vo.setDetailContent(rs.getString("detail_info")); 
                vo.setSituationDesc(rs.getString("situation_desc"));
                vo.setMapLocation(rs.getString("map_location"));
            }
        } finally {
            DB.close(con, pstmt, rs);
        }
        return vo;
    }
}