package com.bsps2.member.dao;

import java.util.ArrayList;
import java.util.List;

import com.bsps2.main.dao.DAO;
import com.bsps2.member.vo.LoginVO;
import com.bsps2.util.db.DB;
import com.bsps2.member.vo.MemberVO;

public class MemberDAO extends DAO{
	
	// 1-1. 로그인 처리 - 데이터 가져오기(R) - 1개 데이터 가져오기.(view)
	public LoginVO login(LoginVO userVO) throws Exception {
		LoginVO vo = null;
		
		// 1. 드라이브 확인 
		con = DB.getConnection();
		// 3. SQL 작성
		String sql = "select m.id, m.name, m.gradeNo, g.gradeName from member m, grade g "
				+ " where (id = ? and pw = ?) and (m.gradeNo = g.gradeNo)";
		// 4. 실행 객체 & 데이터 세팅
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, userVO.getId());
		pstmt.setString(2, userVO.getPw());	
		// 5. 실행
		rs = pstmt.executeQuery();	
		// 6. 저장
		if(rs != null && rs.next()) {
			vo = new LoginVO();
			vo.setId(rs.getString("id"));
			vo.setName(rs.getString("name"));
			vo.setGradeNo(rs.getInt("gradeNo"));
			vo.setGradeName(rs.getString("gradeName"));
		}
		// 7. 닫기
		DB.close(con, pstmt, rs);
		
		return vo;
	} // login()의 끝
	
	// 1-2. 로그아웃 처리 - DB 사용하지 않음.
	
	// 1-3. 회원가입
		public Integer write(MemberVO vo) throws Exception {
			Integer result = 0;
			
			// 1. 드라이버 확인 & 2. 연결 객체
			con = DB.getConnection();
			// 3. SQL 작성
			String sql = "insert into member(id, pw, name, gender, birth, tel, email) "
					+ " values(?,?,?,?,?,?,?)";
			// 4. 실행객체 & 데이터 세팅
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPw());
			pstmt.setString(3, vo.getName());
			pstmt.setString(4, vo.getGender());
			pstmt.setString(5, vo.getBirth());
			pstmt.setString(6, vo.getTel());
			pstmt.setString(7, vo.getEmail());
			// 5. 실행 //6. 데이터 저장
			// select - executeQuery() : rs, insert, update, delete - executeUpdate() : Integer
			result = pstmt.executeUpdate();
			// 7. 닫기
			DB.close(con, pstmt);
			
			return result;
		} // write()의 끝

		
		// 1-4. (7.) 내(회원) 정보보기 - 데이터 가져오기(R) - 1개 데이터 가져오기.(view)
		public MemberVO view(String id) throws Exception {
			MemberVO vo = null;
			
			// 1. 드라이버 확인 & 2. 연결 객체
			con = DB.getConnection();
			// 3. SQL 작성
			String sql = "select id, name, gender, "
					+ "to_char(m.birth, 'yyyy-mm-dd') birth, "
					+ " tel, email, "
					+ "TO_CHAR(regDate,'yyyy-mm-dd') regDate, "
			        + "status, gradeNo "
			        + "FROM member WHERE id=?";
			// 4. 실행 객체 & 데이터 세팅
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 5. 실행
			rs = pstmt.executeQuery();
			// 6. 저장
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
			// 7. 닫기
			DB.close(con, pstmt, rs);
			
			
			return vo;
		} // view()의 끝
		
		
		// 1-5. 비밀번호 변경
		public Integer changePw(MemberVO vo) throws Exception {
			Integer result = 0;
			
			// 1. 드라이버 확인 & 2. 연결 객체
			con = DB.getConnection();
			// 3. SQL 작성
			String sql = "update member set pw = ? where id = ? and pw = ?";
			// 4. 실행객체 & 데이터 세팅
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getNewPw());
			pstmt.setString(2, vo.getId());
			pstmt.setString(3, vo.getPw());
			// 5. 실행 //6. 데이터 저장
			// select - executeQuery() : rs, insert, update, delete - executeUpdate() : Integer
			result = pstmt.executeUpdate();
			// 7. 닫기
			DB.close(con, pstmt);
			
			return result;
		} // changePw()의 끝
		
		
		// ---------------- 관리자 메뉴 ----------------
		// 1-6. 회원 리스트
		public List<MemberVO> list() throws Exception {
			List<MemberVO> list = null;
			
			list = new ArrayList<>();
			
			// 1. 드라이버 확인 & 2. 연결 객체
			con = DB.getConnection();
			
			// 3. 실행할 쿼리 작성
			String sql = "select id, name, gender,"
					+ "to_char(m.birth, 'yyyy-mm-dd') birth, "
					+ " tel, email, status, gradeNo, "
					+ " from member order by id";
			
			// 4. 실행 객체 & 데이터 세팅
			pstmt = con.prepareStatement(sql);
			
			// 5. 실행 : select :executeQuery() -> rs, insert / update / delete :executeUpdate() -> Integer
			rs = pstmt.executeQuery();
			
			// 6. DB에서 가져온 데이터 채우기
			if(rs != null) {
				while(rs.next()) { // 데이터가 있는 만큼 반복 실행
					// 저장할 객체를 생성한다.
					MemberVO vo = new MemberVO();
					vo.setId(rs.getString("id"));
					vo.setName(rs.getString("name"));
					vo.setGender(rs.getString("gender"));
					vo.setBirth(rs.getString("birth"));
					vo.setTel(rs.getString("tel"));
					vo.setEmail(rs.getString("email"));
					vo.setStatus(rs.getString("status"));
					vo.setGradeNo(rs.getInt("gradeNo"));
					
					
					list.add(vo);
				}// while의 끝
			}// if의 끝

			// 7. DB 닫기
			DB.close(con, pstmt, rs);
			
			return list;
		} // list()의 끝

		
		// 1-7. 회원 상태 변경
		// id와 상태를 받는다..
		public Integer changeStatus(MemberVO vo) throws Exception {
			Integer result = 0;
			
			// 1. 드라이버 확인 & 2. 연결 객체
			con = DB.getConnection();
			// 3. SQL 작성
			String sql = "update member set status = ? where id = ? ";
			// 4. 실행객체 & 데이터 세팅
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getStatus());
			pstmt.setString(2, vo.getId());
			// 5. 실행 //6. 데이터 저장
			// select - executeQuery() : rs, insert, update, delete - executeUpdate() : Integer
			result = pstmt.executeUpdate();
			// 7. 닫기
			DB.close(con, pstmt);
			
			return result;
		} // changeStatus()의 끝

		// 1-8. 아이디 중복 체크
		public String checkId(String inId) throws Exception {
			String id = null;
			
			// 1.2.
			con = DB.getConnection();
			// 3
			String sql = "select id from member where id = ?";
			//4. 
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, inId);
			// 5. 
			rs = pstmt.executeQuery();
			// 6.
			if(rs != null && rs.next())
				id = rs.getString("id");
			// 7.
			DB.close(con, pstmt, rs);
			
			return id;
		}

		public Object edit(MemberVO obj) {
			// TODO Auto-generated method stub
			return null;
		}

		public Object delete(MemberVO obj) {
			// TODO Auto-generated method stub
			return null;
		}
		
	} // 클래스의 끝
		