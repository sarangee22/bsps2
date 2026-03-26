package com.bsps2.community.dao;

import java.util.List;

import com.bsps2.community.vo.CommunityVO;
import com.bsps2.main.dao.DAO;
import com.bsps2.util.db.DB;
import com.bsps2.util.page.PageObject;

public class CommunityDAO extends DAO {
	
	//1.리스트
	public List<CommunityVO> list(PageObject pageObject) throws Exception{
		List<CommunityVO> list = null;
		
		
		//1.드라이버 확인 2.연결
		con = DB.getConnection();
		//3.SQL작성
		//3-1
		String sql = "select no , title, writer, to_char(writeDate, 'yyyy-mm-dd') writeDate, hit, fileName "
				+ " from community order by no desc";
		//3-2 순서번호
		sql = " select rownum rnum, no , title, writer, writeDate, hit, fileName"
				+ " from (" + sql + ") ";
		//3-3 페이지 데이터 추출
		sql = " select rnum, no , title writer, writeDate, hit , fileName "
				+ " from (" + sql + ") where rnum between ? and ? ";
				
		//4.실행 객체 및 데이터 세팅
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, pageObject.getStartRow());
		pstmt.setLong(2, pageObject.getEndRow());
		//5.실행
		rs = pstmt.executeQuery();
		//6.결과 담기
		if(rs != null) 
			while (rs.next()) {
				CommunityVO vo = new CommunityVO();
				vo.setNo(rs.getLong("no"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer	"));
				vo.setWriteDate(rs.getString("writeDate"));
				vo.setHit(rs.getLong("hit"));
				vo.setFileName(rs.getString("fileName"));
				list.add(vo);
			}
		//7.닫기
		DB.close(con, pstmt, rs);
		return list;
		
	}//list()의 끝
	
	//1-2 getTotalRow() 
	public long getTotalRow(PageObject pageObject) throws Exception {
		Long totalRow = 0L;
		//1.드라이버 확인 2.연결
		con = DB.getConnection();
		//3.SQL작성
		String sql = "select count(*) from community ";
		//4.실행 객체 및 데이터 세팅
		pstmt = con.prepareStatement(sql);
		//5.실행
		rs = pstmt.executeQuery();
		//6.결과 담기
		if(rs != null && rs.next()) {
			totalRow = rs.getLong(1);
		}
		//7.닫기
		DB.close(con, pstmt, rs);
		return totalRow;
		
	}//getTotalRow()의 끝 
	
	
	
}
