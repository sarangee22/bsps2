package com.bsps2.quiz.dao;

import java.util.ArrayList;
import java.util.List;

import com.bsps2.main.dao.DAO;
import com.bsps2.quiz.vo.QuizVO;
import com.bsps2.util.db.DB;

public class QuizDAO extends DAO{
	
	//1.퀴즈 리스트
	public List<QuizVO> list() throws Exception{
		List<QuizVO> list = new ArrayList<>();
		
		//1.드라이버 확인 2.연결 객체..
		con = DB.getConnection();
		//3-1 .Sql 작성 
		String sql = "select no, title, writer, to_char(writeDate, 'yyyy-mm-dd') writeDate, hit "
                + " from quiz order by no desc";
	
		//4. 실행 객체 & 데이터 세팅
		pstmt = con.prepareStatement(sql);

		//5.실행
		rs = pstmt.executeQuery();
		
		//6.
		if(rs != null) {
			while (rs.next()) {
				QuizVO vo = new QuizVO();
				vo.setNo(rs.getLong("no"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setWriteDate(rs.getString("writeDate"));
				vo.setHit(rs.getLong("hit"));
				list.add(vo);
		
			}
		}
		//7.닫기
		DB.close(con, pstmt, rs);
		
		return list;
		
	}
	//2-1.퀴즈보기
	public QuizVO view(Long no )throws Exception{
		QuizVO vo = null;
		//1.드라이버 확인 2.연결 객체
		con = DB.getConnection();
		//3.Sql 작성 
		String sql = "select no, title,content,ans,writer,"
				+ " to_char(writeDate, 'yyyy-mm-dd') writeDate, hit "
				+ " from quiz where no = ?";
				
		//4. 실행 객체 & 데이터 세팅
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, no);
		//5.실행
		rs = pstmt.executeQuery();
		//6.
		if(rs != null && rs.next()) {
			vo = new QuizVO();
			vo.setNo(rs.getLong("title"));
			vo.setTitle(rs.getString("title"));
			vo.setContent(rs.getString("content"));
			vo.setAns(rs.getString("ans"));
			vo.setWriter(rs.getString("writer"));
			vo.setWriteDate(rs.getString("writeDate"));
			vo.setHit(rs.getLong("hit"));
		}
		//7.닫기
		DB.close(con, pstmt, rs);
		
		return vo;
	}

	//2-2 조회수 1증가
	public int increase(Long no) throws Exception{
		Integer result = 0;
		
		//1.드라이버 확인 2.연결 객체
		con = DB.getConnection();
		//3.Sq1 작성
		String sql = "update quiz set hit = hit + 1 where no =? ";
		//4. 실행 객체 & 데이터 세팅
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, no);
		//5. 실행.6
		result = pstmt. executeUpdate();
		//7.닫기
		DB.close(con, pstmt);
		
		return result;
	}

}
