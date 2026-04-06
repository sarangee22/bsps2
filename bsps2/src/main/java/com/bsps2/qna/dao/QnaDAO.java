package com.bsps2.qna.dao;

import java.util.ArrayList;
import java.util.List;

import com.bsps2.main.dao.DAO;
import com.bsps2.qna.vo.QnaVO;
import com.bsps2.util.db.DB;

public class QnaDAO extends DAO{
	
	// 1. 질문답변 리스트 (검색어 word 추가)
	public List<QnaVO> list(String word) throws Exception{
		
		List<QnaVO> list = new ArrayList<>();
		
		con = DB.getConnection();
		
		// 3. 실행할 쿼리 작성
		String sql = "select q.no, q.title, q.id, m.name, q.writeDate, q.hit, q.levNo "
				+ " from qna q, member m "
				+ " where q.id = m.id ";
		
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

			// 쿼리에 조건 추가 (숫자면 no 조건 추가)
			sql += " and (q.title like ? or q.content like ? or q.id like ? ";
			if(isNumber) sql += " or q.no = ? ";
			sql += ") ";
		}
		
		sql += " order by q.refNo desc, q.ordNo";
				
		pstmt = con.prepareStatement(sql);
		
		// 검색어가 있을 때 데이터 세팅
		if(word != null && !word.equals("")) {
			pstmt.setString(1, "%" + word + "%");
			pstmt.setString(2, "%" + word + "%");
			pstmt.setString(3, "%" + word + "%");
			if(isNumber) {
				pstmt.setLong(4, searchNo); // 4번째 물음표에 번호 세팅
			}
		}
				
		rs = pstmt.executeQuery();
				
		if(rs != null) {
			while(rs.next()) {
				QnaVO vo = new QnaVO();
				vo.setNo(rs.getLong("no"));
				vo.setTitle(rs.getString("title"));
				vo.setId(rs.getString("id"));
				vo.setName(rs.getString("name"));
				vo.setWriteDate(rs.getString("writeDate"));
				vo.setHit(rs.getLong("hit"));
				vo.setLevNo(rs.getLong("levNo"));
				list.add(vo);
			}
		}
				
		DB.close(con, pstmt, rs);
		
		return list;
	}
	
	// [이하 increase, view, question, answer, update, delete 코드는 동일함]
	// (지원이님의 원본 코드와 동일하므로 지면 관계상 생략하지만, 
	// 실제 파일에는 지원이님 원본 그대로 두시면 됩니다!)

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