package com.bsps2.disasterMap.dao;

import java.util.ArrayList;
import java.util.List;

import com.bsps2.disasterMap.ov.DisasterMapVO;
import com.bsps2.main.dao.DAO;
import com.bsps2.util.db.DB;
import com.bsps2.util.page.PageObject;

public class DisasterMapDAO extends DAO {

	public List<DisasterMapVO> list(PageObject pageObject) throws Exception {

		List<DisasterMapVO> list = new ArrayList<>();

		con = DB.getConnection();

		String sql = "select disasterId, disasterName, disasterType, region, address, latitude, longitude, createdAt from disaster_map order by disasterId desc";
		sql = "select rownum rnum, disasterId, disasterName, disasterType, region, address, latitude, longitude, createdAt from (" + sql + ")";
		sql = "select rnum, disasterId, disasterName, disasterType, region, address, latitude, longitude, createdAt from (" + sql + ") where rnum between ? and ?";

		pstmt = con.prepareStatement(sql);

		pstmt.setLong(1, pageObject.getStartRow());
		pstmt.setLong(2, pageObject.getEndRow());

		rs = pstmt.executeQuery();

		if(rs != null) {
			while(rs.next()) {

				DisasterMapVO vo = new DisasterMapVO();

				vo.setDisasterId(rs.getInt("disasterId"));
				vo.setDisasterName(rs.getString("disasterName"));
				vo.setDisasterType(rs.getString("disasterType"));
				vo.setRegion(rs.getString("region"));
				vo.setAddress(rs.getString("address"));
				vo.setLatitude(rs.getDouble("latitude"));
				vo.setLongitude(rs.getDouble("longitude"));
				vo.setCreatedAt(rs.getString("createdAt"));

				list.add(vo);
			}
		}

		DB.close(con, pstmt, rs);

		return list;
	}

	// 전체 데이터 개수
	public Long getTotalRow(PageObject pageObject) throws Exception {

		Long totalRow = 0L;

		con = DB.getConnection();

		String sql = "select count(*) from disaster_map";

		pstmt = con.prepareStatement(sql);

		rs = pstmt.executeQuery();

		if(rs != null && rs.next())
			totalRow = rs.getLong(1);

		DB.close(con, pstmt, rs);

		return totalRow;
	}

	// 상세보기
	public DisasterMapVO view(Long disasterId) throws Exception {

		DisasterMapVO vo = null;

		con = DB.getConnection();

		String sql = "select disasterId, disasterName, disasterType, region, address, latitude, longitude, content, createdAt "
				+ "from disaster_map where disasterId = ?";

		pstmt = con.prepareStatement(sql);

		pstmt.setLong(1, disasterId);

		rs = pstmt.executeQuery();

		if(rs != null && rs.next()) {

			vo = new DisasterMapVO();

			vo.setDisasterId(rs.getInt("disasterId"));
			vo.setDisasterName(rs.getString("disasterName"));
			vo.setDisasterType(rs.getString("disasterType"));
			vo.setRegion(rs.getString("region"));
			vo.setAddress(rs.getString("address"));
			vo.setLatitude(rs.getDouble("latitude"));
			vo.setLongitude(rs.getDouble("longitude"));
			vo.setContent(rs.getString("content"));
			vo.setCreatedAt(rs.getString("createdAt"));
		}

		DB.close(con, pstmt, rs);

		return vo;
	}

	// 등록
	public Integer write(DisasterMapVO vo) throws Exception {

		con = DB.getConnection();

		String sql = "insert into disaster_map(disasterId, disasterName, disasterType, region, address, latitude, longitude, content, createdAt)"
				+ " values(disaster_seq.nextval, ?, ?, ?, ?, ?, ?, ?, sysdate)";

		pstmt = con.prepareStatement(sql);

		pstmt.setString(1, vo.getDisasterName());
		pstmt.setString(2, vo.getDisasterType());
		pstmt.setString(3, vo.getRegion());
		pstmt.setString(4, vo.getAddress());
		pstmt.setDouble(5, vo.getLatitude());
		pstmt.setDouble(6, vo.getLongitude());
		pstmt.setString(7, vo.getContent());

		int result = pstmt.executeUpdate();

		DB.close(con, pstmt);

		return result;
	}

	// 수정
	public Integer update(DisasterMapVO vo) throws Exception {

		con = DB.getConnection();

		String sql = "update disaster_map set disasterName=?, disasterType=?, region=?, address=?, latitude=?, longitude=?, content=? where disasterId=?";

		pstmt = con.prepareStatement(sql);

		pstmt.setString(1, vo.getDisasterName());
		pstmt.setString(2, vo.getDisasterType());
		pstmt.setString(3, vo.getRegion());
		pstmt.setString(4, vo.getAddress());
		pstmt.setDouble(5, vo.getLatitude());
		pstmt.setDouble(6, vo.getLongitude());
		pstmt.setString(7, vo.getContent());
		pstmt.setInt(8, vo.getDisasterId());

		int result = pstmt.executeUpdate();

		DB.close(con, pstmt);

		return result;
	}

	// 삭제
	public Integer delete(long disasterId) throws Exception {

		con = DB.getConnection();

		String sql = "delete from disaster_map where disasterId = ?";

		pstmt = con.prepareStatement(sql);

		pstmt.setLong(1, disasterId);

		int result = pstmt.executeUpdate();

		DB.close(con, pstmt);

		return result;
	}
}