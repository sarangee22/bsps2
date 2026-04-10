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

    // 1. 재난 목록 조회 (카테고리명 포함하여 조인)
    public List<DisasterVO> list(int catID, PageObject pageObject) throws Exception {
        List<DisasterVO> list = null;
        try {
            con = DB.getConnection();
            
            // disasterInfo(i), disaster_category(c) 조인하여 카테고리 이름까지 가져옴
            String sql = "SELECT i.no, i.content, i.locationName, i.createDate, i.dangerLevel, c.cat_name " 
                       + " FROM disasterInfo i, disaster_category c "
                       + " WHERE i.catID = c.catID AND i.catID = ? ";
            
            // 검색 조건 추가 (content, locationName 컬럼 기준)
            sql += search(pageObject);
            
            // 정렬 추가 (최신글 우선)
            sql += " ORDER BY i.no DESC";
            
            // 페이징 처리를 위한 3중 서브쿼리
            sql = "SELECT rownum rnum, no, content, locationName, createDate, dangerLevel, cat_name FROM (" + sql + ")";
            sql = "SELECT rnum, no, content, locationName, createDate, dangerLevel, cat_name FROM (" + sql + ") WHERE rnum BETWEEN ? AND ?";
            
            pstmt = con.prepareStatement(sql);
            int idx = 1;
            
            pstmt.setInt(idx++, catID);
            idx = searchDataSet(pstmt, idx, pageObject);
            
            pstmt.setLong(idx++, pageObject.getStartRow());
            pstmt.setLong(idx++, pageObject.getEndRow());
            
            rs = pstmt.executeQuery();
            
            if(rs != null) {
                list = new ArrayList<>();
                while(rs.next()) {
                    DisasterVO vo = new DisasterVO();
                    vo.setNo(rs.getLong("no"));
                    vo.setContent(rs.getString("content"));
                    vo.setLocationName(rs.getString("locationName"));
                    vo.setCreateDate(rs.getString("createDate"));
                    vo.setDangerLevel(rs.getInt("dangerLevel"));
                    vo.setCategoryName(rs.getString("cat_name")); // 조인한 카테고리명 세팅
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
    }

    // 2. 검색 조건 생성 (disasterInfo의 컬럼명 기준)
    private String search(PageObject pageObject) {
        String sql = "";
        String key = pageObject.getKey();
        String word = pageObject.getWord();

        if (word != null && !word.trim().equals("")) {
            // 1. 공백을 기준으로 검색어를 쪼갭니다 (예: "서울 미세먼지" -> ["서울", "미세먼지"])
            String[] words = word.trim().split("\\s+");
            
            sql += " AND ( ";
            
            for (int i = 0; i < words.length; i++) {
                // 2. 단어가 여러 개일 경우 모든 단어가 포함되어야 하므로 AND로 연결
                if (i > 0) sql += " AND ";
                
                sql += " ( 1=0 "; // OR 조건을 시작하기 위한 초기값
                
                // 3. 각 단어에 대해 선택된 키워드(t, l) 검색 조건 추가
                if (key.indexOf("t") >= 0) sql += " OR i.content LIKE '%" + words[i] + "%' ";
                if (key.indexOf("l") >= 0) sql += " OR i.locationName LIKE '%" + words[i] + "%' ";
                
                sql += " ) ";
            }
            sql += " ) ";
        }
        return sql;
    }

    private int searchDataSet(PreparedStatement pstmt, int idx, PageObject pageObject) throws SQLException {
        return idx;
    }

    // 3. 전체 데이터 개수 조회
    public long getTotalRow(int catID, PageObject pageObject) throws Exception {
        long totalRow = 0;
        try {
            con = DB.getConnection();
            String sql = "SELECT COUNT(*) FROM disasterInfo i WHERE catID = ? ";
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
    }

    // 4. 상세보기 (disasterInfo 테이블 하나에서 모든 정보를 가져옴)
    public DisasterVO view(long no) throws Exception {
        DisasterVO vo = null;
        try {
            con = DB.getConnection();
            // disasterInfo(i)와 disaster_category(c) 조인
            String sql = "SELECT i.no, i.content, i.detailContent, i.createDate, i.locationName, "
                       + " i.dangerLevel, i.latitude, i.longitude, i.catID, c.cat_name " 
                       + " FROM disasterInfo i, disaster_category c "
                       + " WHERE i.catID = c.catID AND i.no = ?";
            
            pstmt = con.prepareStatement(sql);
            pstmt.setLong(1, no);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                vo = new DisasterVO();
                vo.setNo(rs.getLong("no"));
                vo.setContent(rs.getString("content"));
                vo.setDetailContent(rs.getString("detailContent"));
                vo.setCreateDate(rs.getString("createDate"));
                vo.setLocationName(rs.getString("locationName"));
                vo.setDangerLevel(rs.getInt("dangerLevel"));
                vo.setLatitude(rs.getDouble("latitude"));
                vo.setLongitude(rs.getDouble("longitude"));
                vo.setCatID(rs.getInt("catID"));
                vo.setCategoryName(rs.getString("cat_name"));
            }
        } finally {
            DB.close(con, pstmt, rs);
        }
        return vo;
    }
}