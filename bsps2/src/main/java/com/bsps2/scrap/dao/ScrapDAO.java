package com.bsps2.scrap.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.bsps2.main.dao.DAO;
import com.bsps2.scrap.vo.ScrapVO;
import com.bsps2.util.db.DB;

public class ScrapDAO extends DAO {

    private Connection con = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;

    // 1. 스크랩 처리 (저장)
    public int scrap(ScrapVO vo) throws Exception {
        int result = 0;
        try {
            con = DB.getConnection();
            String sql = "INSERT INTO DISASTER_SCRAP (SCRAP_NO, ID, NO) "
                       + " VALUES (DISASTER_SCRAP_SEQ.NEXTVAL, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, vo.getId());
            pstmt.setLong(2, vo.getNo());
            result = pstmt.executeUpdate();
        } finally {
            DB.close(con, pstmt);
        }
        return result;
    }

    // 2. 스크랩 리스트 (조인 쿼리 사용)
    public List<ScrapVO> list(String id) throws Exception {
        List<ScrapVO> list = null;
        try {
            con = DB.getConnection();
            // DISASTER_SCRAP(s)와 DISASTER_LIST(d)를 조인하여 상세 내용을 가져옵니다.
            String sql = "SELECT s.scrap_no, s.no, d.summary, d.region, s.scrap_date "
                       + " FROM DISASTER_SCRAP s, DISASTER_LIST d "
                       + " WHERE s.id = ? AND s.no = d.no "
                       + " ORDER BY s.scrap_no DESC";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                list = new ArrayList<>();
                do {
                    ScrapVO vo = new ScrapVO();
                    vo.setScrapNo(rs.getLong("scrap_no"));
                    vo.setNo(rs.getLong("no"));
                    vo.setSummary(rs.getString("summary"));
                    vo.setRegion(rs.getString("region"));
                    vo.setScrapDate(rs.getString("scrap_date"));
                    list.add(vo);
                } while (rs.next());
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
            String sql = "DELETE FROM DISASTER_SCRAP WHERE SCRAP_NO = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setLong(1, scrapNo);
            result = pstmt.executeUpdate();
        } finally {
            DB.close(con, pstmt);
        }
        return result;
    }
}