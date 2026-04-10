package com.bsps2.scrap.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.bsps2.main.dao.DAO;
import com.bsps2.scrap.vo.ScrapVO;
import com.bsps2.util.db.DB;
import com.bsps2.util.page.PageObject;

public class ScrapDAO extends DAO {

    // DAO 상속 시 부모의 필드를 사용하므로 중복 선언 제거 가능 (프로젝트 구조에 따라 유지)
    private Connection con = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;

    // 1. 스크랩 처리 (저장)
    public int scrap(ScrapVO vo) throws Exception {
        int result = 0;
        try {
            con = DB.getConnection();
            // 테이블명: disaster_scrap
            String sql = "INSERT INTO disaster_scrap (scrap_no, id, no) "
                       + " VALUES (disaster_scrap_seq.NEXTVAL, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, vo.getId());
            pstmt.setLong(2, vo.getNo());
            result = pstmt.executeUpdate();
        } finally {
            DB.close(con, pstmt);
        }
        return result;
    }

    // 2. 스크랩 리스트 (disasterInfo와 조인)
    public List<ScrapVO> list(String id, PageObject pageObject) throws Exception {
        List<ScrapVO> list = null;
        try {
            con = DB.getConnection();

            // 1. 전체 데이터 개수 구하기 (페이징 필수 과정)
            String countSql = "SELECT COUNT(*) FROM disaster_scrap s, disasterInfo d WHERE s.id = ? AND s.no = d.no ";
            countSql += getSearchSql(pageObject); // 검색 조건 추가
            pstmt = con.prepareStatement(countSql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) pageObject.setTotalRow(rs.getLong(1));
            
            DB.close(null, pstmt, rs); // 개수 구한 후 객체 닫기

            // 2. 실제 리스트 쿼리 (페이징 서브쿼리 적용)
            String sql = "SELECT * FROM ( "
                       + "  SELECT ROWNUM rnum, a.* FROM ( "
                       + "    SELECT s.scrap_no, s.no, s.scrap_date, d.content, d.locationName, d.createDate, d.dangerLevel "
                       + "    FROM disaster_scrap s, disasterInfo d "
                       + "    WHERE s.id = ? AND s.no = d.no ";
            
            sql += getSearchSql(pageObject); // 검색 조건 추가
            sql += "    ORDER BY s.scrap_no DESC "
                 + "  ) a "
                 + " ) WHERE rnum BETWEEN ? AND ? ";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setLong(2, pageObject.getStartRow());
            pstmt.setLong(3, pageObject.getEndRow());
            rs = pstmt.executeQuery();

            if (rs != null) {
                list = new ArrayList<>();
                while (rs.next()) {
                    ScrapVO vo = new ScrapVO();
                    vo.setScrapNo(rs.getLong("scrap_no"));
                    vo.setNo(rs.getLong("no"));
                    vo.setScrapDate(rs.getString("scrap_date"));
                    vo.setContent(rs.getString("content"));
                    vo.setLocationName(rs.getString("locationName"));
                    vo.setCreateDate(rs.getString("createDate"));
                    vo.setDangerLevel(rs.getInt("dangerLevel"));
                    list.add(vo);
                }
            }
        } finally {
            DB.close(con, pstmt, rs);
        }
        return list;
    }


    // 3. 스크랩 취소 (삭제)
    public int delete(long scrapNo) throws Exception {
        int result = 0;
        try {
            con = DB.getConnection();
            String sql = "DELETE FROM disaster_scrap WHERE scrap_no = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setLong(1, scrapNo);
            result = pstmt.executeUpdate();
        } finally {
            DB.close(con, pstmt);
        }
        return result;
    }
    
    // 4. 검색 조건을 생성하는 내부 메서드
    private String getSearchSql(PageObject pageObject) {
        String sql = "";
        String word = pageObject.getWord();
        String key = pageObject.getKey();
        
        if (word != null && !word.equals("")) {
            // [수정 포인트] 공백을 기준으로 단어를 쪼개서 배열로 만듦
            String[] words = word.split("\\s+");
            sql += " AND ( ";
            
            for (int i = 0; i < words.length; i++) {
                // 두 번째 단어부터는 앞의 조건과 AND로 연결 (모든 단어 포함 조건)
                if (i > 0) sql += " AND "; 
                
                if (key.equals("tl")) {
                    // 각 단어가 지역명 혹은 내용 중 한 곳에라도 있으면 OK
                    sql += " (d.locationName LIKE '%" + words[i] + "%' OR d.content LIKE '%" + words[i] + "%') ";
                }
            }
            sql += " ) ";
        }
        return sql;
    }// getSearchSql()의 끝
}