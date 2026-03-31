package com.bsps2.main.edu.dao.EduDAO;

import java.util.*;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.edu.vo.EduVO.EduVO;
import com.bsps2.util.db.DB;
import com.bsps2.util.page.PageObject;

public class EduDAO extends DAO {

    // [1] 대시보드 통계 데이터 (전체/발행됨/임시저장/조회수합계)
    // 관리자 화면 상단 카드에 들어갈 데이터를 한 번에 가져옵니다.
    public Map<String, Long> getMetaData() throws Exception {
        Map<String, Long> map = new HashMap<>();
        try {
            con = DB.getConnection();
            // 시안에 맞춰 발행됨(pub)과 임시저장(draft) 개수를 각각 카운트합니다.
            String sql = "SELECT COUNT(*) total, "
                       + "COUNT(CASE WHEN status='발행됨' THEN 1 END) pub, "
                       + "COUNT(CASE WHEN status='임시저장' THEN 1 END) draft, "
                       + "SUM(hit) views FROM edu_guide";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                map.put("total", rs.getLong("total"));
                map.put("pub", rs.getLong("pub"));
                map.put("draft", rs.getLong("draft"));
                map.put("views", rs.getLong("views"));
            }
        } finally { DB.close(con, pstmt, rs); }
        return map;
    }

    // [2] 가이드 목록 조회 (검색 + 카테고리 필터 + 페이징)
    public List<EduVO> list(PageObject pageObject) throws Exception {
        List<EduVO> list = new ArrayList<>();
        try {
            con = DB.getConnection();
            String sql = "SELECT no, title, category, writer, summary, tags, hit, status, TO_CHAR(regDate, 'yyyy. mm. dd.') regDate "
                       + "FROM edu_guide WHERE 1=1 ";
            
            String word = pageObject.getWord();
            if (word != null && !word.equals("")) {
                sql += " AND (title LIKE ? OR summary LIKE ? OR tags LIKE ?) ";
            }
            
            String category = pageObject.getKey();
            if (category != null && !category.equals("") && !category.equals("전체")) {
                sql += " AND category = ? ";
            }
            
            sql += " ORDER BY no DESC";
            
            // 페이징 처리 래퍼 쿼리
            sql = "SELECT rownum rnum, no, title, category, writer, summary, tags, hit, status, regDate FROM (" + sql + ")";
            sql = "SELECT * FROM (" + sql + ") WHERE rnum BETWEEN ? AND ?";
            
            pstmt = con.prepareStatement(sql);
            
            int idx = 1;
            if (word != null && !word.equals("")) {
                pstmt.setString(idx++, "%" + word + "%");
                pstmt.setString(idx++, "%" + word + "%");
                pstmt.setString(idx++, "%" + word + "%");
            }
            if (category != null && !category.equals("") && !category.equals("전체")) {
                pstmt.setString(idx++, category);
            }
            pstmt.setLong(idx++, pageObject.getStartRow());
            pstmt.setLong(idx++, pageObject.getEndRow());
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                EduVO vo = new EduVO();
                vo.setNo(rs.getLong("no"));
                vo.setTitle(rs.getString("title"));
                vo.setCategory(rs.getString("category"));
                vo.setWriter(rs.getString("writer"));
                vo.setSummary(rs.getString("summary"));
                vo.setTags(rs.getString("tags"));
                vo.setHit(rs.getLong("hit"));
                vo.setStatus(rs.getString("status"));
                vo.setRegDate(rs.getString("regDate"));
                list.add(vo);
            }
        } finally { DB.close(con, pstmt, rs); }
        return list;
    }

    // [3] 상세보기 (조회수 증가 포함)
    public EduVO view(long no) throws Exception {
        EduVO vo = null;
        try {
            con = DB.getConnection();
            String sqlHit = "UPDATE edu_guide SET hit = hit + 1 WHERE no = ?";
            pstmt = con.prepareStatement(sqlHit);
            pstmt.setLong(1, no);
            pstmt.executeUpdate();
            pstmt.close();

            String sql = "SELECT no, title, category, writer, summary, content, tags, hit, status, "
                       + "TO_CHAR(regDate, 'yyyy. mm. dd.') regDate FROM edu_guide WHERE no = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setLong(1, no);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                vo = new EduVO();
                vo.setNo(rs.getLong("no"));
                vo.setTitle(rs.getString("title"));
                vo.setCategory(rs.getString("category"));
                vo.setWriter(rs.getString("writer"));
                vo.setSummary(rs.getString("summary"));
                vo.setContent(rs.getString("content"));
                vo.setTags(rs.getString("tags"));
                vo.setHit(rs.getLong("hit"));
                vo.setStatus(rs.getString("status"));
                vo.setRegDate(rs.getString("regDate"));
            }
        } finally { DB.close(con, pstmt, rs); }
        return vo;
    }

    // [4] 전체 데이터 개수 (페이징용)
    public long getTotalRow(PageObject pageObject) throws Exception {
        long totalRow = 0;
        try {
            con = DB.getConnection();
            String sql = "SELECT COUNT(*) FROM edu_guide WHERE 1=1 ";
            
            String word = pageObject.getWord();
            if (word != null && !word.equals("")) {
                sql += " AND (title LIKE ? OR summary LIKE ? OR tags LIKE ?) ";
            }
            String category = pageObject.getKey();
            if (category != null && !category.equals("") && !category.equals("전체")) {
                sql += " AND category = ? ";
            }
            
            pstmt = con.prepareStatement(sql);
            int idx = 1;
            if (word != null && !word.equals("")) {
                pstmt.setString(idx++, "%" + word + "%");
                pstmt.setString(idx++, "%" + word + "%");
                pstmt.setString(idx++, "%" + word + "%");
            }
            if (category != null && !category.equals("") && !category.equals("전체")) {
                pstmt.setString(idx++, category);
            }
            
            rs = pstmt.executeQuery();
            if (rs.next()) totalRow = rs.getLong(1);
        } finally { DB.close(con, pstmt, rs); }
        return totalRow;
    }

    // [5] 등록
    public Integer write(EduVO vo) throws Exception {
        try {
            con = DB.getConnection();
            String sql = "INSERT INTO edu_guide(no, title, category, writer, summary, content, tags, status) "
                       + "VALUES(edu_seq.nextval, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, vo.getTitle());
            pstmt.setString(2, vo.getCategory());
            pstmt.setString(3, vo.getWriter());
            pstmt.setString(4, vo.getSummary());
            pstmt.setString(5, vo.getContent());
            pstmt.setString(6, vo.getTags());
            pstmt.setString(7, vo.getStatus());
            return pstmt.executeUpdate();
        } finally { DB.close(con, pstmt); }
    }

    // [6] 수정 (추가됨)
    public Integer update(EduVO vo) throws Exception {
        try {
            con = DB.getConnection();
            String sql = "UPDATE edu_guide SET title=?, category=?, writer=?, summary=?, content=?, tags=?, status=? WHERE no=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, vo.getTitle());
            pstmt.setString(2, vo.getCategory());
            pstmt.setString(3, vo.getWriter());
            pstmt.setString(4, vo.getSummary());
            pstmt.setString(5, vo.getContent());
            pstmt.setString(6, vo.getTags());
            pstmt.setString(7, vo.getStatus());
            pstmt.setLong(8, vo.getNo());
            return pstmt.executeUpdate();
        } finally { DB.close(con, pstmt); }
    }

    // [7] 삭제
    public Integer delete(long no) throws Exception {
        try {
            con = DB.getConnection();
            String sql = "DELETE FROM edu_guide WHERE no = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setLong(1, no);
            return pstmt.executeUpdate();
        } finally { DB.close(con, pstmt); }
    }
}