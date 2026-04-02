package com.bsps2.disasterMap.dao;

import java.util.ArrayList;
import java.util.List;

import com.bsps2.disasterMap.ov.DisasterMapVO;
import com.bsps2.main.dao.DAO;
import com.bsps2.util.db.DB;
import com.bsps2.util.page.PageObject;

public class DisasterMapDAO extends DAO {

    // 1. 리스트 (페이징 처리)
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

    // 2. 전체 데이터 개수
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

    // 3. 상세보기
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

    // 🌟 추가 항목: 조회수 증가 (상세보기 시 호출)
    public Integer increaseHit(Long disasterId) throws Exception {
        con = DB.getConnection();
        // DB 테이블에 hit 컬럼이 있다고 가정합니다.
        String sql = "update disaster_map set hit = hit + 1 where disasterId = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setLong(1, disasterId);
        int result = pstmt.executeUpdate();
        DB.close(con, pstmt);
        return result;
    }

    // 4. 등록
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

    // 5. 수정 (updatedAt 또는 sysdate 활용 권장)
    public Integer update(DisasterMapVO vo) throws Exception {
        con = DB.getConnection();
        // 정보를 수정할 때 작성일(createdAt)을 현재 시간으로 갱신하도록 sysdate를 추가했습니다.
        String sql = "update disaster_map set disasterName=?, disasterType=?, region=?, address=?, latitude=?, longitude=?, content=?, createdAt=sysdate where disasterId=?";
        
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, vo.getDisasterName());
        pstmt.setString(2, vo.getDisasterType());
        pstmt.setString(3, vo.getRegion());
        pstmt.setString(4, vo.getAddress());
        pstmt.setDouble(5, vo.getLatitude());
        pstmt.setDouble(6, vo.getLongitude());
        pstmt.setString(7, vo.getContent());
        // 타입을 setLong으로 맞추는 것이 더 안정적입니다.
        pstmt.setLong(8, (long)vo.getDisasterId());

        int result = pstmt.executeUpdate();
        DB.close(con, pstmt);
        return result;
    }

    // 6. 삭제
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