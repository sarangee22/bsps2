package com.bsps2.community.controller;

import java.awt.Color;
import java.io.File;
import java.nio.file.Paths;
import java.util.UUID;

import com.bsps2.community.vo.CommunityVO;
import com.bsps2.main.controller.Controller;
import com.bsps2.main.controller.Init;
import com.bsps2.main.service.Execute;
import com.bsps2.util.image.ImageUtil;
import com.bsps2.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;


public class CommunityController implements Controller {

	@SuppressWarnings("unchecked")
	@Override
	public String execute(HttpServletRequest request) {
		request.setAttribute("url", request.getRequestURL()); // 오류 페이지의 URL
		
		HttpSession session = request.getSession();
		
		String uri = request.getServletPath();
		System.out.println("CommunityController.execute(). uri = " + uri);
		
		try {
			Integer result;
			switch (uri) {
			
			//1.리스트
			case "/community/list.do":
				PageObject pageObject = PageObject.getInstance(request);
				request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
				request.setAttribute("pageObject", pageObject);
				return "community/list";
				
			//2.글보기
			case "/community/view.do":
				Long no = Long.parseLong(request.getParameter("no"));
				Long inc = Long.parseLong(request.getParameter("inc"));
				
				request.setAttribute("vo", Execute.execute(Init.getService(uri), new Long[] {no,inc}));				
				return "community/view";
				
			//3-1.글등록 폼
			case "/community/writeForm.do":
				return "community/writeForm";
			
			//3-2 글등록 처리
			case "/community/write.do":
				CommunityVO vo = new CommunityVO();
				vo.setTitle(request.getParameter("title"));
				vo.setContent(request.getParameter("content"));
				vo.setWriter(request.getParameter("writer"));
				vo.setPw(request.getParameter("pw"));
				
				// 2. 파일 업로드 설정
			    String path = "/upload/image"; // 저장할 가상 폴더
			    String savePath = request.getServletContext().getRealPath(path); // 실제 서버 경로
			    
			    // 저장 폴더가 없으면 생성
			    File savedDir = new File(savePath);
			    if(!savedDir.exists()) savedDir.mkdirs();

			    // 3. 파일 처리 (Part 이용)
			    Part filePart = request.getPart("imageFile"); // writeForm의 name과 일치해야 함
			    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
			    
			    // 파일명 중복 방지를 위한 UUID 적용
			    String uuid = UUID.randomUUID().toString();
			    String savedFileName = uuid + "_" + fileName;
			    
			    // 서버 하드디스크에 실제 파일 저장
			    filePart.write(savePath + File.separator + savedFileName);
			    
			    // DB에 저장할 상대 경로 세팅 (이래야 리스트에서 사진이 잘 보입니다!)
			    vo.setFileName(path + "/" + savedFileName);

			    // 4. 이미지 리사이징 (선택 사항: 필요 없으면 삭제하세요)
			    // 리스트에서 작은 이미지를 빨리 띄우기 위해 s_ 접두사를 붙여 300x250 사이즈로 저장
			    ImageUtil.resizing(savePath, savedFileName, "s_", 300, 250, Color.WHITE);

			    // 5. 서비스 실행 및 결과 처리
			    Execute.execute(Init.getService(uri), vo);
			    
			    session.setAttribute("msg", "새로운 제보 글이 등록되었습니다.");
			    
			    // 이미지 처리 시간을 고려한 잠깐의 대기 (참고 코드 반영)
			    Thread.sleep(1000);
			    
			    return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");
			
			//4-1 글수정 폼
			case "/community/updateForm.do":
				no = Long.parseLong(request.getParameter("no"));
				request.setAttribute("vo", Execute.execute(Init.getService("/community/view.do"), new Long[] {no, 0L}));
				return"community/updateForm";
				
			//4-2 글수정 처리
			case "/community/update.do":
				vo = new CommunityVO();
				vo.setNo(Long.parseLong(request.getParameter("no")));
				vo.setTitle(request.getParameter("title"));
				vo.setContent(request.getParameter("content"));
				vo.setWriter(request.getParameter("writer"));
				vo.setPw(request.getParameter("pw"));
				vo.setFileName(request.getParameter("fileName"));
				
				result = (Integer) Execute.execute(Init.getService(uri), vo);
				
				if(result == 1) {
					session.setAttribute("msg", "제보 게시판 " + vo.getNo() + "번 글 수정이 되었습니다."); // 성공 메시지
					return "redirect:view.do?no=" + vo.getNo() + "&inc=0&" + PageObject.getInstance(request).getNotPageQuery();
				} else {
					session.setAttribute("msg", "제보 게시판 " + vo.getNo() + "번 글 수정에 실패하였습니다. 정보를 확인 후 다시 시도해 주세요."); // 실패 메시지
					return "redirect:updateForm.do?no=" + vo.getNo();
				}
				
			//5.이미지 파일 변경 처리..
			case "/community/changeImage.do":			
				// 1. 파일 업로드 설정 및 폴더 생성
			    path = "/upload/image";
			    savePath = request.getServletContext().getRealPath(path);
			    savedDir = new File(savePath);
			    if(!savedDir.exists()) savedDir.mkdirs();

			    // 2. 새로운 파일 수집 (Part 이용)
			    filePart = request.getPart("imageFile");
			    fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
			    uuid = UUID.randomUUID().toString();
			    savedFileName = uuid + "_" + fileName;
			    
			    // 서버에 실제 파일 저장
			    filePart.write(savePath + File.separator + savedFileName);

			    // 3. VO에 데이터 담기
			    vo = new CommunityVO();
			    vo.setNo(Long.parseLong(request.getParameter("no")));
			    vo.setFileName(path + "/" + savedFileName);

			    // 4. 서비스 실행 (DB 업데이트)
			    Execute.execute(Init.getService(uri), vo);

			    // 5. 기존 파일 삭제 (선택 사항이지만 추천!)
			    String delFileName = request.getParameter("delFileName");
                if(delFileName != null && !delFileName.equals("")) {
                    File delFile = new File(request.getServletContext().getRealPath(delFileName));
                    if(delFile.exists()) delFile.delete();
                }

			    session.setAttribute("msg", "이미지가 성공적으로 변경되었습니다.");
			    
			    // 6. 상세보기로 돌아가기 (검색/페이지 정보 유지)
			    return "redirect:view.do?no=" + vo.getNo() + "&inc=0" 
			           + "&page=" + request.getParameter("page")
			           + "&perPageNum=" + request.getParameter("perPageNum")
			           + "&key=" + request.getParameter("key")
			           + "&word=" + request.getParameter("word");
				
			//6. 글삭제 처리
			case "/community/delete.do":
				vo = new CommunityVO();
				vo.setNo(Long.parseLong(request.getParameter("no")));
				vo.setPw(request.getParameter("pw"));
				
				result = (Integer) Execute.execute(Init.getService(uri), vo);
				
				if(result == 1) {
					session.setAttribute("msg", "제보게시판" + vo.getNo()+ "번 글을 삭제하였습니다.");
				    return "redirect:list.do?perPageNum=" + request.getParameter("perPageNum");

				}else {
					session.setAttribute("msg", "제보 게시판 " + vo.getNo() + "번 글 삭제를 실패하였습니다. 정보를 확인 후 다시 시도해 주세요.");
					return "redirect:view.do?no=" + vo.getNo() + "&inc=0";
				}
				
				
				
			default:
				return "error/noPage";
			}
		}catch (Exception e) {
			e.printStackTrace();
			return "error/err_500";
		
			
		}
		
	}

}
