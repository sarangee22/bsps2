package com.bsps2.main.item.dao.ItemDAO;

import java.util.ArrayList;
import java.util.List;
import com.bsps2.main.dao.DAO;
import com.bsps2.main.item.vo.ItemVO.ItemVO;
import com.bsps2.util.db.DB;
import com.bsps2.util.page.PageObject;

public class ItemDAO extends DAO {

	public List<ItemVO> list(PageObject pageObject) throws Exception {
		List<ItemVO> list = new ArrayList<ItemVO>();
		con = DB.getConnection();
		String sql = "select no, name, category, isReady from my_checklist order by no desc";
		sql = "select rownum rnum, no, name, category, isReady from (" + sql + ")";
		sql = "select rnum, no, name, category, isReady from (" + sql + ") where rnum between ? and ?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, pageObject.getStartRow());
		pstmt.setLong(2, pageObject.getEndRow());
		rs = pstmt.executeQuery();
		if(rs != null) {
			while(rs.next()) {
				ItemVO vo = new ItemVO();
				vo.setNo(rs.getLong("no"));
				vo.setName(rs.getString("name"));
				vo.setCategory(rs.getString("category"));
				vo.setIsReady(rs.getString("isReady"));
				list.add(vo);
			}
		}
		DB.close(con, pstmt, rs);
		return list;
	}

	public Long getTotalRow(PageObject pageObject) throws Exception {
		Long totalRow = 0L;
		con = DB.getConnection();
		String sql = "select count(*) from my_checklist";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(rs != null && rs.next()) totalRow = rs.getLong(1);
		DB.close(con, pstmt, rs);
		return totalRow;
	}

	public Integer write(ItemVO vo) throws Exception {
		con = DB.getConnection();
		String sql = "insert into my_checklist(no, id, name, category, memo) values(check_seq.nextval, ?, ?, ?, ?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, vo.getId());
		pstmt.setString(2, vo.getName());
		pstmt.setString(3, vo.getCategory());
		pstmt.setString(4, vo.getMemo());
		int result = pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	}

	public ItemVO view(Long no) throws Exception {
		ItemVO vo = null;
		con = DB.getConnection();
		String sql = "select no, name, category, isReady, memo, to_char(regDate, 'yyyy-mm-dd') regDate from my_checklist where no = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, no);
		rs = pstmt.executeQuery();
		if(rs != null && rs.next()) {
			vo = new ItemVO();
			vo.setNo(rs.getLong("no"));
			vo.setName(rs.getString("name"));
			vo.setCategory(rs.getString("category"));
			vo.setIsReady(rs.getString("isReady"));
			vo.setMemo(rs.getString("memo"));
			vo.setRegDate(rs.getString("regDate"));
		}
		DB.close(con, pstmt, rs);
		return vo;
	}

	public Integer update(ItemVO vo) throws Exception {
		con = DB.getConnection();
		String sql = "update my_checklist set name = ?, category = ?, isReady = ?, memo = ? where no = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, vo.getName());
		pstmt.setString(2, vo.getCategory());
		pstmt.setString(3, vo.getIsReady());
		pstmt.setString(4, vo.getMemo());
		pstmt.setLong(5, vo.getNo());
		int result = pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	}

	public Integer delete(long no) throws Exception {
		con = DB.getConnection();
		String sql = "delete from my_checklist where no = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setLong(1, no);
		int result = pstmt.executeUpdate();
		DB.close(con, pstmt);
		return result;
	}
}