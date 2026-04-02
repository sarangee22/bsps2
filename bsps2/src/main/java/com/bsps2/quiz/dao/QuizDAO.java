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
	               + " from quiz where levNo = 0 order by no desc";
	
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
	// 2. 상세보기용 해설 가져오기: 부모번호(parentNo)가 현재 글번호인 해설 내용을 가져옴
	public String getReply(Long no) throws Exception {
	    String explain = "";
	    con = DB.getConnection();
	    // 부모글 번호가 내 번호(no)이고, levNo가 1인 데이터의 content를 가져옴
	    String sql = "select content from quiz where parentNo = ? and levNo = 1";
	    pstmt = con.prepareStatement(sql);
	    pstmt.setLong(1, no);
	    rs = pstmt.executeQuery();
	    if(rs.next()) explain = rs.getString("content");
	    DB.close(con, pstmt, rs);
	    return explain;
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
			vo.setNo(rs.getLong("no"));
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
	
	//3.퀴즈 및 해설 등록
	// 3. 퀴즈 및 해설 등록 (한 번에 두 개의 데이터를 넣음)
	public int write(QuizVO vo) throws Exception {
	    int result = 0;
	    con = DB.getConnection();

	    // --- [1단계] 문제 등록 (리스트에 보이는 글) ---
	    // no: 시퀀스 / refNo: 시퀀스 현재값 / levNo: 0 (문제)
	    String sql1 = "insert into quiz(no, title, content, ans, writer, refNo, ordNo, levNo, parentNo) "
	                + " values(quiz_seq.nextval, ?, ?, ?, ?, quiz_seq.currval, 1, 0, null)";
	    
	    pstmt = con.prepareStatement(sql1);
	    pstmt.setString(1, vo.getTitle());   // 제목
	    pstmt.setString(2, vo.getContent()); // 문제 지문
	    pstmt.setString(3, vo.getAns());     // 정답
	    pstmt.setString(4, vo.getWriter());  // 작성자
	    result += pstmt.executeUpdate();    // 첫 번째 실행 (문제 등록)

	    // pstmt를 재사용하기 위해 닫아줌
	    pstmt.close(); 

	    // --- [2단계] 상세 해설 등록 (상세보기에만 쓰이는 글) ---
	    // no: 시퀀스 / refNo: 문제와 동일 / levNo: 1 (해설) / parentNo: 문제번호(currval)
	    String sql2 = "insert into quiz(no, title, content, writer, refNo, ordNo, levNo, parentNo) "
	                + " values(quiz_seq.nextval, ?, ?, ?, quiz_seq.currval, 2, 1, quiz_seq.currval)";
	    
	    pstmt = con.prepareStatement(sql2);
	    pstmt.setString(1, "[해설] " + vo.getTitle()); // 제목 자동 생성
	    pstmt.setString(2, vo.getExplain());          // ✨ 핵심: 사용자가 입력한 해설!
	    pstmt.setString(3, vo.getWriter());
	    result += pstmt.executeUpdate();    // 두 번째 실행 (해설 등록)

	    // 최종 닫기
	    DB.close(con, pstmt);
	    
	    return result; // 총 2건이 등록되면 2가 반환됨
	}
	
	// 4. 퀴즈 및 해설 수정
	public int update(QuizVO vo) throws Exception {
	    int result = 0;
	    con = DB.getConnection();
	    
	    // --- [1단계] 문제 수정 (levNo=0인 본체) ---
	    String sql1 = "update quiz set title = ?, content = ?, ans = ? where no = ?";
	    pstmt = con.prepareStatement(sql1);
	    pstmt.setString(1, vo.getTitle());
	    pstmt.setString(2, vo.getContent());
	    pstmt.setString(3, vo.getAns());
	    pstmt.setLong(4, vo.getNo());
	    result += pstmt.executeUpdate();
	    
	    pstmt.close(); // 재사용을 위해 닫기

	    // --- [2단계] 상세 해설 수정 (levNo=1이고 부모가 현재 글번호인 것) ---
	    // 해설의 제목도 같이 수정해주면 좋습니다.
	    String sql2 = "update quiz set title = ?, content = ? where parentNo = ? and levNo = 1";
	    pstmt = con.prepareStatement(sql2);
	    pstmt.setString(1, "[해설] " + vo.getTitle());
	    pstmt.setString(2, vo.getExplain()); //  수정된 상세 해설 내용
	    pstmt.setLong(3, vo.getNo());        // 부모 번호가 현재 글번호인 해설 찾기
	    result += pstmt.executeUpdate();

	    DB.close(con, pstmt);
	    return result;
	}
	
	//5.퀴즈 삭제
	public int delete(Long no) throws Exception{
		int result = 0;
		
		//1.드라이버 확인 2.연결 객체
		con = DB.getConnection();
		//3.Sql 작성 
		String sql = "delete from quiz where no = ?";				
		//4. 실행 객체 & 데이터 세팅
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, no);
		//5.실행//6.
		rs = pstmt.executeQuery();
		//7.닫기
		DB.close(con, pstmt);
		
		return result;
	}

}
