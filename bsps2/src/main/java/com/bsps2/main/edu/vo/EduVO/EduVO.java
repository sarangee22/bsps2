package com.bsps2.main.edu.vo.EduVO;

public class EduVO {
    // 1. DB 컬럼과 1:1 매칭되는 변수
    private long no;
    private String title;
    private String category;
    private String writer;
    private String summary;
    private String content;
    private String tags;
    private long hit;
    private String status;
    private String regDate;
    private String updateDate;

    // 2. 표준 Getter / Setter
    public long getNo() { return no; }
    public void setNo(long no) { this.no = no; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getWriter() { return writer; }
    public void setWriter(String writer) { this.writer = writer; }
    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getTags() { return tags; }
    public void setTags(String tags) { this.tags = tags; }
    public long getHit() { return hit; }
    public void setHit(long hit) { this.hit = hit; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getRegDate() { return regDate; }
    public void setRegDate(String regDate) { this.regDate = regDate; }
    public String getUpdateDate() { return updateDate; }
    public void setUpdateDate(String updateDate) { this.updateDate = updateDate; }

    // 3. JSP에서 태그를 배열로 사용하기 위한 편의 메서드
    public String[] getTagList() {
        if (tags == null || tags.isEmpty()) return new String[0];
        return tags.split(",");
    }

    @Override
    public String toString() {
        return "EduVO [no=" + no + ", title=" + title + ", hit=" + hit + ", status=" + status + "]";
    }
}