package com.bsps2.disasterSafe.dao;

import java.util.ArrayList;
import java.util.List;

import com.bsps2.disasterSafe.vo.AgencyVO;
import com.bsps2.main.dao.DAO;
import com.bsps2.util.db.DB;
import com.bsps2.util.page.PageObject;

public class AgencyDAO extends DAO {

	// 1. 리스트 조회
	public List<AgencyVO> list(PageObject pageObject) throws Exception {
		List<AgencyVO> list = new ArrayList<>();
		try {
			con = DB.getConnection();
			String key = pageObject.getKey();
			String word = pageObject.getWord();
			StringBuilder search = new StringBuilder(); 

			if (key != null && !key.equals("")) {
				search.append(" WHERE agency_type LIKE ? ");
			}

			if (word != null && !word.equals("")) {
				if (search.length() > 0) search.append(" AND ");
				else search.append(" WHERE ");
				search.append(" (agency_name LIKE ? OR address LIKE ?) ");
			}

			String sql = "SELECT agency_id, agency_name, agency_type, phone, address, latitude, longitude "
					   + "FROM agency " + search.toString() + " ORDER BY agency_id DESC";
			
			sql = "SELECT rownum rnum, agency_id, agency_name, agency_type, phone, address, latitude, longitude "
				+ "FROM (" + sql + ")";
			sql = "SELECT rnum, agency_id, agency_name, agency_type, phone, address, latitude, longitude "
				+ "FROM (" + sql + ") WHERE rnum BETWEEN ? AND ?";
			
			pstmt = con.prepareStatement(sql);
			int idx = 0;
			if (key != null && !key.equals("")) {
				// 병원을 눌러도 보건소까지 나오게 보정한 로직 유지
				if(key.equals("병원") || key.equals("보건")) pstmt.setString(++idx, "%보건%");
				else pstmt.setString(++idx, "%" + key + "%");
			}
			if (word != null && !word.equals("")) {
				pstmt.setString(++idx, "%" + word + "%");
				pstmt.setString(++idx, "%" + word + "%");
			}
			pstmt.setLong(++idx, pageObject.getStartRow());
			pstmt.setLong(++idx, pageObject.getEndRow());
			
			rs = pstmt.executeQuery();
			if (rs != null) {
				while (rs.next()) {
					AgencyVO vo = new AgencyVO();
					vo.setRnum(rs.getInt("rnum")); 
					vo.setAgencyId(rs.getInt("agency_id"));
					vo.setAgencyName(rs.getString("agency_name"));
					vo.setAgencyType(rs.getString("agency_type"));
					vo.setPhone(rs.getString("phone"));
					vo.setAddress(rs.getString("address"));
					vo.setLatitude(rs.getDouble("latitude"));
					vo.setLongitude(rs.getDouble("longitude"));
					list.add(vo);
				}
			}
		} finally { DB.close(con, pstmt, rs); }
		return list;
	}

	// 2. 전체 개수 조회
	public Long getTotalRow(PageObject pageObject) throws Exception {
		Long totalRow = 0L;
		try {
			con = DB.getConnection();
			String key = pageObject.getKey();
			String word = pageObject.getWord();
			StringBuilder search = new StringBuilder();

			if (key != null && !key.equals("")) search.append(" WHERE agency_type LIKE ? ");
			if (word != null && !word.equals("")) {
				if (search.length() > 0) search.append(" AND ");
				else search.append(" WHERE ");
				search.append(" (agency_name LIKE ? OR address LIKE ?) ");
			}

			String sql = "SELECT COUNT(*) FROM agency " + search.toString();
			pstmt = con.prepareStatement(sql);
			int idx = 0;
			if (key != null && !key.equals("")) {
				if(key.equals("병원") || key.equals("보건")) pstmt.setString(++idx, "%보건%");
				else pstmt.setString(++idx, "%" + key + "%");
			}
			if (word != null && !word.equals("")) {
				pstmt.setString(++idx, "%" + word + "%");
				pstmt.setString(++idx, "%" + word + "%");
			}
			rs = pstmt.executeQuery();
			if (rs != null && rs.next()) totalRow = rs.getLong(1);
		} finally { DB.close(con, pstmt, rs); }
		return totalRow;
	}

	// ⭐ [여기가 범인!] 3. 상세 보기 (이 메서드가 없어서 에러가 났던 거예요)
	public AgencyVO view(int agencyId) throws Exception {
		AgencyVO vo = null;
		try {
			con = DB.getConnection();
			String sql = "SELECT agency_id, agency_name, agency_type, phone, address, latitude, longitude, operating_hours "
					   + "FROM agency WHERE agency_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, agencyId);
			rs = pstmt.executeQuery();
			if (rs != null && rs.next()) {
				vo = new AgencyVO();
				vo.setAgencyId(rs.getInt("agency_id"));
				vo.setAgencyName(rs.getString("agency_name"));
				vo.setAgencyType(rs.getString("agency_type"));
				vo.setPhone(rs.getString("phone"));
				vo.setAddress(rs.getString("address"));
				vo.setLatitude(rs.getDouble("latitude"));
				vo.setLongitude(rs.getDouble("longitude"));
				vo.setOperatingHours(rs.getString("operating_hours"));
			}
		} finally { DB.close(con, pstmt, rs); }
		return vo;
	}

	// 4. 등록
	public Integer write(AgencyVO vo) throws Exception {
		try {
			con = DB.getConnection();
			String sql = "INSERT INTO agency(agency_id, agency_name, agency_type, phone, address, latitude, longitude, operating_hours) "
					   + "VALUES(agency_id_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getAgencyName());
			pstmt.setString(2, vo.getAgencyType());
			pstmt.setString(3, vo.getPhone());
			pstmt.setString(4, vo.getAddress());
			pstmt.setDouble(5, vo.getLatitude());
			pstmt.setDouble(6, vo.getLongitude());
			pstmt.setString(7, vo.getOperatingHours());
			return pstmt.executeUpdate();
		} finally { DB.close(con, pstmt); }
	}

	// 5. 수정
	public Integer update(AgencyVO vo) throws Exception {
		try {
			con = DB.getConnection();
			String sql = "UPDATE agency SET agency_name = ?, agency_type = ?, phone = ?, address = ?, latitude = ?, longitude = ?, operating_hours = ? "
					   + "WHERE agency_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getAgencyName());
			pstmt.setString(2, vo.getAgencyType());
			pstmt.setString(3, vo.getPhone());
			pstmt.setString(4, vo.getAddress());
			pstmt.setDouble(5, vo.getLatitude());
			pstmt.setDouble(6, vo.getLongitude());
			pstmt.setString(7, vo.getOperatingHours());
			pstmt.setInt(8, vo.getAgencyId());
			return pstmt.executeUpdate();
		} finally { DB.close(con, pstmt); }
	}

	// 6. 삭제
	public Integer delete(int agencyId) throws Exception {
		try {
			con = DB.getConnection();
			String sql = "DELETE FROM agency WHERE agency_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, agencyId);
			return pstmt.executeUpdate();
		} finally { DB.close(con, pstmt); }
	}
}