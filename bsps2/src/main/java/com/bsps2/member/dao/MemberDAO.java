package com.bsps2.member.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bsps2.main.dao.DAO;
import com.bsps2.member.vo.LoginVO;
import com.bsps2.util.db.DB;
import com.bsps2.util.page.PageObject;
import com.bsps2.member.vo.MemberVO;

public class MemberDAO extends DAO {
    
    // 1-1. 로그인 처리
    public LoginVO login(LoginVO userVO) throws Exception {
        LoginVO vo = null;
        
        try {
            con = DB.getConnection();
            // SQL 수정: m.id, m.pw로 테이블 별칭을 명확히 지정하여 모호성 제거
         // MemberDAO.java 파일 안의 로그인 쿼리 부분
         // 21~22 라인 수정
            String sql = "SELECT m.id, m.name, m.pw, m.gradeNo, "
                    + " (SELECT gradeName FROM grade g WHERE g.gradeNo = m.gradeNo) gradeName "
                    + "FROM member m "
                    + "WHERE m.id = ? AND m.pw = ?";
            
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userVO.getId());
            pstmt.setString(2, userVO.getPw());    
            
            rs = pstmt.executeQuery();    
            
            if(rs != null && rs.next()) {
                vo = new LoginVO();
                vo.setId(rs.getString("id"));
                vo.setName(rs.getString("name"));
                vo.setGradeNo(rs.getInt("gradeNo"));
                vo.setGradeName(rs.getString("gradeName"));
            }
        } finally {
            DB.close(con, pstmt, rs);
        }
        return vo;
    }

    // --- 로그인 메서드 바로 아래(약 43행쯤)에 추가하세요 ---

    // 1-2. 최근 접속일 업데이트 (로그인 성공 시 호출)
    // MemberDAO.java 안에 추가할 메서드..
    public void updateConDate(String id) throws Exception {
        try {
            con = DB.getConnection();
            // sysdate로 최근 접속일을 현재 시간으로 업데이트
            String sql = "update member set conDate = sysdate where id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.executeUpdate();
        } finally {
            DB.close(con, pstmt);
        }
    }
    
    
    // 1-3. 회원가입..
    public Integer write(MemberVO vo) throws Exception {
        Integer result = 0;
        try {
            con = DB.getConnection();
            String sql = "insert into member(id, pw, name, gender, birth, tel, email, conDate) "
                    + " values(?,?,?,?, TO_DATE(?, 'YYYY-MM-DD') ,?,?, sysdate)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, vo.getId());
            pstmt.setString(2, vo.getPw());
            pstmt.setString(3, vo.getName());
            pstmt.setString(4, vo.getGender());
            pstmt.setString(5, vo.getBirth());
            pstmt.setString(6, vo.getTel());
            pstmt.setString(7, vo.getEmail());
            
            result = pstmt.executeUpdate();
        } finally {
            DB.close(con, pstmt);
        }
        return result;
    }

    // 1-4. 내 정보보기
    public MemberVO view(String id) throws Exception {
        MemberVO vo = null;
        try {
            con = DB.getConnection();
            // TO_CHAR 함수 사용 시 콤마 위치 및 공백 정리
            String sql = "select id, name, gender, "
                       + " to_char(birth, 'yyyy-mm-dd') birth, "
                       + " tel, email, to_char(regDate, 'yyyy-mm-dd') regDate, "
                       + " status, gradeNo "
                       + " from member where id = ?";
            
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            
            if(rs != null && rs.next()) {
                vo = new MemberVO();
                vo.setId(rs.getString("id"));
                vo.setName(rs.getString("name"));
                vo.setGender(rs.getString("gender"));
                vo.setBirth(rs.getString("birth"));
                vo.setTel(rs.getString("tel"));
                vo.setEmail(rs.getString("email"));
                vo.setRegDate(rs.getString("regDate"));
                vo.setStatus(rs.getString("status"));
                vo.setGradeNo(rs.getInt("gradeNo"));
            }
        } finally {
            DB.close(con, pstmt, rs);
        }
        return vo;
    }

    // 1-5. 비밀번호 변경
    public Integer changePw(MemberVO vo) throws Exception {
        Integer result = 0;
        try {
            con = DB.getConnection();
            String sql = "update member set pw = ? where id = ? and pw = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, vo.getNewPw());
            pstmt.setString(2, vo.getId());
            pstmt.setString(3, vo.getPw());
            
            result = pstmt.executeUpdate();
        } finally {
            DB.close(con, pstmt);
        }
        return result;
    }

 // 1-6. 회원 리스트 (관리자용)
 // MemberDAO.java 안의 list 메서드 부분
    public List<MemberVO> list(PageObject pageObject) throws SQLException {
        List<MemberVO> list = null;
        
        try {
            // 1. DB 연결 (con = DB.getConnection(); 등 기존 코드 유지)
            con = DB.getConnection();

            // 2. SQL 작성
            String sql = "SELECT * FROM ("
                       + " SELECT rownum rnum, id, name, gender, birth, tel, status, gradeNo, gradeName, conDate FROM ("
                       + " SELECT m.id, m.name, m.gender, m.birth, m.tel, m.status, m.gradeNo, g.gradeName, m.conDate "
                       + " FROM member m, grade g WHERE (m.gradeNo = g.gradeNo) ";
            
            // 검색 처리 (오류 나면 이 줄을 주석처리 하세요)
            // sql += searchSQL(pageObject); 
            
            sql += " AND m.id != ? ";
            sql += " ORDER BY m.id ASC )) WHERE rnum BETWEEN 1 AND 100";
            
            pstmt = con.prepareStatement(sql);
            
            // 3. ? 세팅 (물음표 순서대로 채우기)
            int idx = 0;
            pstmt.setString(++idx, pageObject.getAccepter()); // 첫 번째 ? (관리자 제외)
      
            // 4. 실행 및 결과 담기
            rs = pstmt.executeQuery();
            
            if (rs != null) {
                while (rs.next()) {
                    if (list == null) list = new ArrayList<>();
                    MemberVO vo = new MemberVO();
                    
                    // 기존 데이터 담기
                    vo.setId(rs.getString("id"));
                    vo.setName(rs.getString("name"));
                    vo.setTel(rs.getString("tel"));
                    vo.setStatus(rs.getString("status"));
                    vo.setGradeName(rs.getString("gradeName"));
                    
                    // [추가 항목들] 여기에 추가하세요!
                    vo.setGender(rs.getString("gender"));
                    vo.setBirth(rs.getString("birth"));
                    vo.setGradeNo(rs.getInt("gradeNo"));
                    vo.setConDate(rs.getString("conDate"));
                    
                    list.add(vo);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 5. 닫기 (DB.close(con, pstmt, rs); 등 기존 코드 유지)
        	// 178행을 아래처럼 수정해 보세요.
        	if (rs != null) rs.close();
        	if (pstmt != null) pstmt.close();
        	if (con != null) con.close();
        }
        
        return list;
    }
    // 1-7. 회원 상태 변경
    public Integer changeStatus(MemberVO vo) throws Exception {
        Integer result = 0;
        try {
            con = DB.getConnection();
            String sql = "update member set status = ? where id = ? ";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, vo.getStatus());
            pstmt.setString(2, vo.getId());
            
            result = pstmt.executeUpdate();
        } finally {
            DB.close(con, pstmt);
        }
        return result;
    }

    // 1-8. 아이디 중복 체크
    public String checkId(String inId) throws Exception {
        String id = null;
        try {
            con = DB.getConnection();
            String sql = "select id from member where id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, inId);
            rs = pstmt.executeQuery();
            
            if(rs != null && rs.next())
                id = rs.getString("id");
        } finally {
            DB.close(con, pstmt, rs);
        }
        return id;
    }

    // 1-9. 회원 정보 수정
    public Integer edit(MemberVO vo) throws Exception {
        Integer result = 0;
        try {
            con = DB.getConnection();
            String sql = "update member set name=?, gender=?, birth=TO_DATE(?, 'YYYY-MM-DD'), tel=?, email=? where id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, vo.getName());
            pstmt.setString(2, vo.getGender());
            pstmt.setString(3, vo.getBirth());
            pstmt.setString(4, vo.getTel());
            pstmt.setString(5, vo.getEmail());
            pstmt.setString(6, vo.getId());
            result = pstmt.executeUpdate();
        } finally {
            DB.close(con, pstmt);
        }
        return result;
    }

    // 1-10. 회원 탈퇴 (또는 삭제)
    public Integer delete(MemberVO vo) throws Exception {
        Integer result = 0;
        try {
            con = DB.getConnection();
            String sql = "delete from member where id=? and pw=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, vo.getId());
            pstmt.setString(2, vo.getPw());
            result = pstmt.executeUpdate();
        } finally {
            DB.close(con, pstmt);
        }
        return result;
    }
}