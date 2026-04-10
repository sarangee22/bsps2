package com.bsps2.qna.dao;

import java.util.ArrayList;
import java.util.List;

import com.bsps2.main.dao.DAO;
import com.bsps2.qna.vo.QnaVO;
import com.bsps2.util.db.DB;

public class QnaDAO extends DAO{
	
	// 1. 질문답변 리스트 (검색어 word 추가)....
	// 1. 질문답변 리스트 (누구나 다 보이도록 조인 방식 변경)
		public List<QnaVO> list(String word) throws Exception{
			
			List<QnaVO> list = new ArrayList<>();
			
			try {
				con = DB.getConnection();
				
				// 3. 실행할 쿼리 작성 (member 테이블 조인을 빼고 qna 테이블 위주로 가져옵니다)
				String sql = "select no, title, id, writeDate, hit, levNo from qna where 1=1 ";
				
				// 검색어가 숫자인지 판단하는 변수
				boolean isNumber = false;
				long searchNo = 0;

				// 검색어가 들어왔을 때만 처리
				if(word != null && !word.equals("")) {
				    try {
				        searchNo = Long.parseLong(word);
				        isNumber = true;
				    } catch (Exception e) {
				        isNumber = false;
				    }

				    if(isNumber) {
				        // 숫자면 no만 정확히 검색
				        sql += " and no = ? ";
				    } else {
				        // 문자면 제목/내용/아이디 검색
				        sql += " and (title like ? or content like ? or id like ?) ";
				    }
				}

				// 정렬
				sql += " order by refNo desc, ordNo asc";

				pstmt = con.prepareStatement(sql);

				// 검색어가 있을 때 데이터 세팅
				if(word != null && !word.equals("")) {
				    if(isNumber) {
				        pstmt.setLong(1, searchNo);
				    } else {
				        pstmt.setString(1, "%" + word + "%");
				        pstmt.setString(2, "%" + word + "%");
				        pstmt.setString(3, "%" + word + "%");
				    }
				}
				rs = pstmt.executeQuery();
						
				if(rs != null) {
					while(rs.next()) {
						QnaVO vo = new QnaVO();
						vo.setNo(rs.getLong("no"));
						vo.setTitle(rs.getString("title"));
						vo.setId(rs.getString("id"));
						// 작성자 이름(name)이 필요하면 일단 id를 넣어두거나 나중에 조인하세요.
						vo.setName(rs.getString("id")); 
						vo.setWriteDate(rs.getString("writeDate"));
						vo.setHit(rs.getLong("hit"));
						vo.setLevNo(rs.getLong("levNo"));
						list.add(vo);
					}
				}
			} finally {
				DB.close(con, pstmt, rs);
			}
			
			return list;
		}


	// 2-0. 조회수 1 증가
	public Integer increase(Long no) throws Exception{
		Integer result = 0;
		con = DB.getConnection();
		String sql = "update qna set hit = hit + 1 where no = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, no);
		result = pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	} 

	// 2. 질문답변 글보기
	public QnaVO view(Long no) throws Exception {
		QnaVO vo = null;
		con = DB.getConnection();
		String sql = "select q.no, q.title, q.content, q.id, m.name, "
				+ " to_char(q.writeDate, 'yyyy-mm-dd') writeDate, "
				+ "      q.hit, q.refNo, q.ordNo, q.levNo "
				+ " from qna q, member m "
				+ " where (q.no = ?) and (q.id = m.id)";
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, no);
		rs = pstmt.executeQuery();
		if(rs != null && rs.next()) {
			vo = new QnaVO();
			vo.setNo(rs.getLong("no"));
			vo.setTitle(rs.getString("title"));
			vo.setContent(rs.getString("content"));
			vo.setId(rs.getString("id"));
			vo.setName(rs.getString("name"));
			vo.setWriteDate(rs.getString("writeDate"));
			vo.setHit(rs.getLong("hit"));
			vo.setRefNo(rs.getLong("refNo")); 
			vo.setOrdNo(rs.getLong("ordNo")); 
			vo.setLevNo(rs.getLong("levNo")); 
		} 
		DB.close(con, pstmt, rs);
		return vo;
	}

	// 3-1. 질문 등록
	public Integer question(QnaVO vo) throws Exception {
		Integer result = 0;
		con = DB.getConnection();
		String sql = "insert into qna(no, title, content, id, refNo, ordNo, levNo, parentNo) "
				+ " values(qna_seq.nextval, ?, ?, ?, qna_seq.nextval, 1, 0, null)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, vo.getTitle());
		pstmt.setString(2, vo.getContent());
		pstmt.setString(3, vo.getId());
		result = pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	}

	// 3-2. 답변 등록
	public Integer answer(QnaVO vo) throws Exception {
		Integer result = 0;
		con = DB.getConnection();
		String sql = "insert into qna(no, title, content, id, refNo, ordNo, levNo, parentNo) "
				+ " values(qna_seq.nextval,?,?,?,?,?,?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, vo.getTitle());
		pstmt.setString(2, vo.getContent());
		pstmt.setString(3, vo.getId());
		pstmt.setLong(4, vo.getRefNo());
		pstmt.setLong(5, vo.getOrdNo());
		pstmt.setLong(6, vo.getLevNo());
		pstmt.setLong(7, vo.getParentNo());
		result = pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	}

	// 3-3. 순서 번호 증가
	public Integer increaseOrd(QnaVO vo) throws Exception {
		Integer result = 0;
		con = DB.getConnection();
		String sql = "update qna set ordNo = ordNo + 1 where refNo = ? and ordNo >= ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, vo.getRefNo());
		pstmt.setLong(2, vo.getOrdNo());
		result = pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	}

	// 4. 글수정
	public Integer update(QnaVO vo) throws Exception {
		Integer result = 0;
		con = DB.getConnection();
		String sql = "update qna set title = ?, content = ? where no = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, vo.getTitle());
		pstmt.setString(2, vo.getContent());
		pstmt.setLong(3, vo.getNo());
		result = pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	}

	// 5. 글삭제
	public Integer delete(long no) throws Exception{
		Integer result = 0;
		con = DB.getConnection();
		String sql = "delete from qna where no = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, no);
		result = pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	}

}