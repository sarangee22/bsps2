package com.bsps2.quiz.vo;

public class QuizVO {
	
	private long no;
	private String title;
	private String content;
	private String ans;
	private String writer;
	private String writeDate;
	private long hit;
	
	private long refNo;
	private long ordNo;
	private long levNo;
	private long parentNo;
	public long getNo() {
		return no;
	}
	public void setNo(long no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAns() {
		return ans;
	}
	public void setAns(String ans) {
		this.ans = ans;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public long getHit() {
		return hit;
	}
	public void setHit(long hit) {
		this.hit = hit;
	}
	public long getRefNo() {
		return refNo;
	}
	public void setRefNo(long refNo) {
		this.refNo = refNo;
	}
	public long getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(long ordNo) {
		this.ordNo = ordNo;
	}
	public long getLevNo() {
		return levNo;
	}
	public void setLevNo(long levNo) {
		this.levNo = levNo;
	}
	public long getParentNo() {
		return parentNo;
	}
	public void setParentNo(long parentNo) {
		this.parentNo = parentNo;
	}
	@Override
	public String toString() {
		return "QuizVO [no=" + no + ", title=" + title + ", content=" + content + ", ans=" + ans + ", writer=" + writer
				+ ", writeDate=" + writeDate + ", hit=" + hit + ", refNo=" + refNo + ", ordNo=" + ordNo + ", levNo="
				+ levNo + ", parentNo=" + parentNo + "]";
	}

}
