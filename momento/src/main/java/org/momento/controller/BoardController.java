package org.momento.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.momento.domain.BoardAttachVO;
import org.momento.domain.BoardVO;
import org.momento.domain.Criteria;
import org.momento.domain.PageDTO;
import org.momento.service.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	private BoardService service;

	@GetMapping("/list")
	public void list(Criteria cri, Model model) {

		model.addAttribute("fixedList", service.getFixedPosts());
		model.addAttribute("hotList", service.getHotPosts());
		model.addAttribute("list", service.getList(cri));

		int total = service.getTotal(cri);

		model.addAttribute("pageMaker", new PageDTO(cri, total));

	}

	@GetMapping("/deleted")
	public void deletedList(Criteria cri, Model model) {

		model.addAttribute("deletedList", service.getDeletedList(cri));

		int deleted = service.getDeleted(cri);

		model.addAttribute("pageMaker", new PageDTO(cri, deleted));

	}

	@PostMapping("/checkedAll")
	public String deleteCheckedAll(@RequestParam("checklist") Long[] bnos, @RequestParam("del_res") String del_res,
			Criteria cri, Model model) {

		service.removeMulti(bnos, del_res);

		return "redirect:/board/list";

	}

	@GetMapping("/register")
	public void register() {
	}

	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {

	
		if (board.getAttachVO() != null) {
			log.info(board.getAttachVO());
		}

		if (board.getFixed() != '1') {
			board.setFixed('0');
		}

		service.register(board);

		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/board/list";

	}

	@GetMapping("/read")
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {

		model.addAttribute("board", service.get(bno));

	}

	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {

		if (board.getAttachVO() != null) {
			log.info(board.getAttachVO());
		}

		if (board.getFixed() != '1') {
			board.setFixed('0');
		}

		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/board/list" + cri.getListLink();

	}

	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr) {

		BoardAttachVO attach = service.getAttachVO(bno);

		if (service.remove(bno)) {

			deleteFiles(attach);

			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/board/list" + cri.getListLink();

	}

	@GetMapping(value = "/getAttachVO", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<BoardAttachVO> getAttachVO(Long bno) {

		log.info("getAttachVO" + bno);

		BoardAttachVO vo = service.getAttachVO(bno);

		return vo == null ? new ResponseEntity<>(HttpStatus.NO_CONTENT) : new ResponseEntity<>(vo, HttpStatus.OK);

	}

	private void deleteFiles(BoardAttachVO attach) {

		if (attach == null) {
			return;
		}

		log.info("delete attach file...................");
		log.info(attach);

		try {
			Path file = Paths.get(
					"C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());

			Files.deleteIfExists(file);

			if (Files.probeContentType(file).startsWith("image")) {

				Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_"
						+ attach.getFileName());

				Files.delete(thumbNail);
			}

		} catch (Exception e) {
			log.error("delete file error" + e.getMessage());
		} // end catch

	}

}
