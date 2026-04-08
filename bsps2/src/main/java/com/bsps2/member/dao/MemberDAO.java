package com.bsps2.member.dao;

import java.util.ArrayList;
import java.util.List;

import com.bsps2.main.dao.DAO;
import com.bsps2.member.vo.LoginVO;
import com.bsps2.util.db.DB;
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
            String sql = "SELECT m.id, m.name, m.pw, m.gradeNo, g.gradeName "
                       + "FROM member m, grade g "
                       + "WHERE m.id = ? AND m.pw = ? AND m.gradeNo = g.gradeNo";
            
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

    // 1-3. 회원가입..
    public Integer write(MemberVO vo) throws Exception {
        Integer result = 0;
        try {
            con = DB.getConnection();
            String sql = "insert into member(id, pw, name, gender, birth, tel, email) "
                       + " values(?,?,?,? , TO_DATE(?, 'YYYY-MM-DD') ,?,?)";
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
    public List<MemberVO> list() throws Exception {
        List<MemberVO> list = new ArrayList<>();
        try {
            con = DB.getConnection();
            
            // SQL 수정: member(m)와 grade(g) 테이블을 조인하여 gradeName을 가져옵니다..
            String sql = "select m.id, m.name, m.gender, to_char(m.birth, 'yyyy-mm-dd') birth, "
                       + " m.tel, m.email, m.status, m.gradeNo, g.gradeName " // g.gradeName 추가
                       + " from member m, grade g " // 두 테이블 지정
                       + " where m.gradeNo = g.gradeNo " // 조인 조건
                       + " order by m.id";
            
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            if(rs != null) {
                while(rs.next()) {
                    MemberVO vo = new MemberVO();
                    vo.setId(rs.getString("id"));
                    vo.setName(rs.getString("name"));
                    vo.setGender(rs.getString("gender"));
                    vo.setBirth(rs.getString("birth"));
                    vo.setTel(rs.getString("tel"));
                    vo.setEmail(rs.getString("email"));
                    vo.setStatus(rs.getString("status"));
                    vo.setGradeNo(rs.getInt("gradeNo"));
                    // 추가: MemberVO에 gradeName 필드가 있다면 아래 코드를 추가하세요.
                    vo.setGradeName(rs.getString("gradeName")); 
                    
                    list.add(vo);
                }
            }
        } finally {
            DB.close(con, pstmt, rs);
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