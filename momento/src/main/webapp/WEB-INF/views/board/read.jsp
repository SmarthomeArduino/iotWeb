<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<style>
.uploadResult {
	display: inline-block;
}

.uploadResult span {
	cursor: pointer;
}

.uploadResult span:hover {
	text-decoration: underline;
}

.fileModify button {
	padding: 0px;
	width: 25px;
	height: 25px;
}

.fileModify i {
	margin: auto;
}

.fileModify label {
	display: inline-block;
	padding: 10px 20px;
	color: #fff;
	vertical-align: middle;
	background-color: #999999;
	cursor: pointer;
	margin-left: 10px;
}

.fileModify input[type="file"] {
	position: absolute;
	width: 0;
	height: 0;
	padding: 0;
	overflow: hidden;
	border: 0;
}

#editorBody {
	padding: 16px 24px;
	height: 300px;
	overflow-y: scroll;
	border: 1px solid #d6d6d6;
	border-radius: 4px;
}

.editorMenu {
	background-color: rgb(255, 255, 255, 0.5);
	border: 1px solid rgb(200, 200, 200);
}

.active {
	background-color: #FFCC00;
	color: white;
}
</style>
<script>

// 해당 글에 업로드된 파일 불러오기
function read_file() {
	
	var bno = '<c:out value="${board.bno}"/>';
	var str1 = "";
	var str2 = "";
	var fileCallPath = ""
	
	$.getJSON("/board/getAttachVO", {bno: bno}, function(uploadFile){
		if(uploadFile!=null) {
			fileCallPath = encodeURIComponent(uploadFile.uploadPath + "/" + uploadFile.uuid + "_" + uploadFile.fileName);
		
			str1 += "<img src='/resources/images/exel_icon.png' style='display:inline-box'>";
			str1 += "<span ";
			str1 += "data-path='" + uploadFile.uploadPath + "' data-uuid='" + uploadFile.uuid + "' "
				+"data-filename='" + uploadFile.fileName + "' data-type='" + uploadFile.fileType + "'>";
			str1 += uploadFile.fileName + "</span>";
			str2 += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' "
					+"class='btn-warning'><i class='fa fa-times'></i></button>";
			str2 += "<label for='file'>파일찾기</lable>";
			str2 += "<input type='file' id='file' name='uploadFile'>";
			
			$(".upload-name").html(str1);
			$(".fileModify").html(str2);
	
			oldFile = uploadFile.uuid;
		} else {
				str1 += "첨부파일";
				str2 += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' "
					 +"class='btn-warning' style='display: none;'><i class='fa fa-times'></i></button>";
				str2 += "<label for='file'>파일찾기</lable>";
				str2 += "<input type='file' id='file' name='uploadFile'>";
				
				$(".upload-name").append(str1);
				$(".fileModify").append(str2);
		}
		
	});

};
</script>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시글 보기</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<form role="form" id="modifyForm">
	<input type="hidden" name="${_csrf.parameterName}"
		value="${_csrf.token}" />
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">

				<div class="panel-heading">${board.bno}번게시글</div>
				<!-- /.panel-heading -->
				<div class="panel-body">


					<div class="form-group">
						<label>번호</label> <input class="form-control" name='bno'
							value='<c:out value="${board.bno }"/>' readonly>
					</div>

					<div class="form-group">
						<label>제목</label><input class="form-control" name='title'
							id="title" value='<c:out value="${board.title}"/>' readOnly>
						<label id="fixedArea" style="display: none">고정글 등록<input
							type="checkbox" name="fixed" id="fixedPost" value="1" /></label>
					</div>

					<div class="form-group">
						<label>내용</label>
						<div id="editorHeader" style="display: none">
							<button type="button" class="editorMenu" id="boldBtn">
								<b>B</b>
							</button>
							<button type="button" class="editorMenu" id="italicBtn">
								<i>I</i>
							</button>
							<button type="button" class="editorMenu" id="underlineBtn">
								<u>U</u>
							</button>
							<button type="button" class="editorMenu" id="strikeBtn">
								<s>S</s>
							</button>
							<button type="button" class="editorMenu" id="olBtn">OL</button>
							<button type="button" class="editorMenu" id="ulBtn">UL</button>
							<input class="editorMenu" type="color" id="color-picker">
						</div>
						<div id="editorBody" contentEditable="false">${board.content}</div>
						<textarea style="display: none" class="form-control" rows="3"
							name='content'></textarea>
					</div>

					<input type='hidden' name='pageNum'
						value='<c:out value="${cri.pageNum}"/>'> <input
						type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
					<input type='hidden' name='keyword'
						value='<c:out value="${cri.keyword}"/>'> <input
						type='hidden' name='type' value='<c:out value="${cri.type}"/>'>

					<button data-oper='modify' class="btn btn-info">수정</button>
					<button style="display: none;" data-oper='modifyConfirm'
						class="btn btn-info">확인</button>
					<button style="display: none;" data-oper='modifyCancel'
						class="btn btn-default">취소</button>
					<button data-oper='delete' class="btn btn-danger">삭제</button>
					<button data-oper='list' class="btn btn-default">목록</button>

				</div>
				<!--  end panel-body -->

			</div>
			<!--  end panel-body -->
		</div>
		<!-- end panel -->
	</div>
	<!-- /.row -->

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">

				<div class="panel-heading">Files</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<div class="uploadResult">
						<div class='upload-name' style='display: inline-block'></div>
						<div class='fileModify' style='display: none;'></div>
						<script>read_file();</script>
					</div>
				</div>
				<!-- end panel-body -->

			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel -->
	</div>
	<!-- /.row -->
</form>

<%@include file="../includes/modal.jsp"%>

<script>
// 텍스트 편집기

      const editor = document.getElementById("editorBody");
      const btnBold = document.getElementById("boldBtn");
      const btnItalic = document.getElementById("italicBtn");
      const btnUnderline = document.getElementById("underlineBtn");
      const btnStrike = document.getElementById("strikeBtn");
      const btnOrderedList = document.getElementById("olBtn");
      const btnUnorderedList = document.getElementById("ulBtn");
      const colorPicker = document.getElementById("color-picker");
  
  colorPicker.addEventListener("change", function() {
    const selectedColor = colorPicker.value;
    setFontColor(selectedColor);
  });
  
  function setFontColor(color) {
    document.execCommand("foreColor", false, color);
    focusEditor();
  }
      btnBold.addEventListener("click", function () {
        setStyle("bold");
      });

      btnItalic.addEventListener("click", function () {
        setStyle("italic");
      });

      btnUnderline.addEventListener("click", function () {
    	setStyle("underline");
      });

      btnStrike.addEventListener("click", function () {
        setStyle("strikeThrough");
      });

      btnOrderedList.addEventListener("click", function () {
        setStyle("insertOrderedList");
      });

      btnUnorderedList.addEventListener("click", function () {
        setStyle("insertUnorderedList");
      });

      function setStyle(style) {
        document.execCommand(style);
        focusEditor();
      }

      // 버튼 클릭 시 에디터가 포커스를 잃기 때문에 다시 에디터에 포커스를 해줌
      function focusEditor() {
        editor.focus({ preventScroll: true });
      }
      editor.addEventListener("keydown", function () {
        checkStyle();
      });

      editor.addEventListener("mousedown", function () {
        checkStyle();
      });

      function setStyle(style) {
        document.execCommand(style);
        focusEditor();
        checkStyle();
      }

      function checkStyle() {
        if (isStyle("bold")) {
          btnBold.classList.add("active");
        } else {
          btnBold.classList.remove("active");
        }
        if (isStyle("italic")) {
          btnItalic.classList.add("active");
        } else {
          btnItalic.classList.remove("active");
        }
        if (isStyle("underline")) {
          btnUnderline.classList.add("active");
        } else {
          btnUnderline.classList.remove("active");
        }
        if (isStyle("strikeThrough")) {
          btnStrike.classList.add("active");
        } else {
          btnStrike.classList.remove("active");
        }
        if (isStyle("insertOrderedList")) {
          btnOrderedList.classList.add("active");
        } else {
          btnOrderedList.classList.remove("active");
        }
        if (isStyle("insertUnorderedList")) {
          btnUnorderedList.classList.add("active");
        } else {
          btnUnorderedList.classList.remove("active");
        }
      }

      function isStyle(style) {
        return document.queryCommandState(style);
      }
</script>
<script type="text/javascript">
	var title = document.getElementById("title");
	var content = document.getElementById("editorBody");
	$(document).ready(function() {
		
		var newFile = "";
		var oldFile = "";

		var modifyForm = $("#modifyForm");
		// 수정	
		$("button[data-oper='modify']").on("click", function(e) {
			
			e.preventDefault();
			
			title.readOnly = false;
			$("#fixedArea").css("display", "inline-block");
			$("#editorHeader").css("display", "block");
			content.contentEditable = true;
			
			$("button[data-oper='modify']").css("display","none");
			$("button[data-oper='modifyConfirm']").css("display","inline-block");
			$("button[data-oper='modifyCancel']").css("display","inline-block");
			$(".fileModify").css("display", "inline-block");
			
		});
			
		
		// 수정 확인 -> 모달 창 오픈
		$("button[data-oper='modifyConfirm']").on("click", function(e) {
			
			e.preventDefault();
			$("#modalSubmitBtn").css("display", "inline-block");
			
			// 수정 항목 홖인
			$(".modal-title").text("글 수정");
			console.log($("#fixedPost").val());
			console.log(${board.fixed});
			if (title.value=="${board.title}" && content.innerHTML=="${board.content}" && oldFile == newFile && $("#fixedPost").val()=="${board.fixed}") {
				$("#modal-content").text("수정된 내용이 없습니다.");
				$("#modalSubmitBtn").css("display", "none");
			} else {
				$("#modal-content").text("정말로 수정 하시겠습니까?");
				$("#modifyForm").attr("action","/board/modify").attr("method","post");
			}
			
			$(".modal").modal("show");
			
		});
		
		// 수정 취소
		$("button[data-oper='modifyCancel']").on("click", function(e) {
			
			e.preventDefault();
			
			$("uploadResult").children().remove();
// 			read_file();
			
			title.value = "${board.title}";
			content.innerHTML = "${board.content}";
			
			title.readOnly = true;
			$("#fixedArea").css("display", "none");
			$("#editorHeader").css("display", "none");
			content.contentEditable = true;
			
			$("button[data-oper='modify']").css("display","inline-block");
			$("button[data-oper='modifyConfirm']").css("display","none");
			$("button[data-oper='modifyCancel']").css("display","none");
			$(".fileModify").css("display", "none");
			
		});

		// 삭제 -> 모달 창 오픈
		$("button[data-oper='delete']").on("click", function(e) {
			
			e.preventDefault();
			$("#modalSubmitBtn").css("display", "inline-block");

			$(".modal-title").text("글 삭제");
			$("#modal-content").text("정말로 삭제 하시겠습니까?");
			$("#modifyForm").attr("action","/board/remove").attr("method","post");
			
			$(".modal").modal("show");

		});
		
		$("#modalSubmitBtn").on("click", function(e) {
			
			var textArea = $("textArea[name=content]");
			
			inputCheck();
			
			if ($(".upload-name").text() !== "첨부파일") {
				fileData();
			}
			
			textArea.val(content.innerHTML);
			
			modifyForm.submit();
			
		});

		// 목록으로 돌아가기			
		$("button[data-oper='list']").on("click", function(e) {
		
			modifyForm.find("input[name='bno']").remove();
			modifyForm.find("input[name='title']").remove();
			modifyForm.find("textarea[name='content']").remove();

			modifyForm.attr("action", "/board/list").attr("method", "get");;
			modifyForm.submit();
			
		});
		
		// 파일 다운로드
		$(".uploadResult").on("click", "span", function(e) {
			
			var obj = $(this);
			var path = encodeURIComponent(obj.data("path") + "/" + obj.data("uuid") + "_" + obj.data("filename"));
			
			self.location = "/download?fileName=" + path;
			
		});
		
		var regex = /(.*?)\.(csv)/;
		var maxSize = 5242880; //5MB
		  
		// 업로드 파일 체크
		function checkExtension(fileName, fileSize) {
			  
			$(".modal-title").text("파일 첨부");
			if (fileSize >= maxSize) {
				$("#modal-content").text("파일 크기가 5MB 미만인 파일을 첨부 해주세요.");
				return false;
			}
			  
			if (!regex.test(fileName)) {
				$("#modal-content").text("업로드 가능한 파일 형식 : CSV");
				return false;
			}
			  
			return true;
		}
		  
		// 파일 업로드 이벤트
		$(".fileModify input").change(function(e) {

			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			var fileName = files[0].name;
			var fileSize = files[0].size;

			if (!checkExtension(fileName, fileSize)) {
				$("#modalSubmitBtn").css("display", "none");
				$(".modal").modal("show");
				return false;
			}
			if (oldFile == "") {
				$(".fileModify button").css("display", "inline-block");
			}
			  
			formData.append("uploadFile",files[0]);

			$.ajax({
				 
				url: '/uploadAjaxAction',
				processData: false,
				contentType: false,
				data: formData,
				type: 'POST',
				dataType: 'json',
				success: function(uploadFile) {
					showUploadFile(uploadFile);
				}
				  
			});
			  
		});
		  
		// 업로드 파일 출력
		function showUploadFile(uploadFile) {

			if (!(uploadFile || uploadFile.length == 0)) { return; }

			var uploadArea = $(".upload-name");
			var fileCallPath = encodeURIComponent(uploadFile.uploadPath + "/" + uploadFile.uuid + "_" + uploadFile.fileName);
			var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
			var str = "";
			  
			str += "<img src='/resources/images/exel_icon.png' style='display:inline-box'>";
			str += "<span ";
			str += "data-path='" + uploadFile.uploadPath + "' data-uuid='" + uploadFile.uuid + "' "
			  	+"data-filename='" + uploadFile.fileName + "' data-type='" + uploadFile.fileType + "'>";
			str += uploadFile.fileName + "</span>";
			  
			$(".fileModify button").attr("data-file", fileCallPath);
			  		
			uploadArea.children().remove();
			uploadArea.text("");
			uploadArea.append(str);
			
			newFile = uploadFile.uuid;
			  
		}
		
		// 업로드 파일 전송
		function fileData() {
			  
			var formObj = $("form[role='form']");
			var obj = $(".upload-name span");
			var str = "";

		    str += "<input type='hidden' name='attachVO.fileName' value='"+obj.data("filename")+"'>";
		    str += "<input type='hidden' name='attachVO.uuid' value='"+obj.data("uuid")+"'>";
		    str += "<input type='hidden' name='attachVO.uploadPath' value='"+obj.data("path")+"'>";
		    str += "<input type='hidden' name='attachVO.fileType' value='"+ obj.data("type")+"'>";
			  
		    formObj.append(str);
		      
		}
		
		// 업로드 파일 삭제  
		$(".fileModify").on("click", "button", function(e) {

			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			var targetDiv = $(".upload-name");

			$.ajax({
				 
				url: '/deleteFile',
				data: {fileName: targetFile, type: type},
				dataType: 'text',
				type: 'POST',
				success: function(result) {
					targetDiv.children().remove();
					targetDiv.text("첨부파일");
				}
				  
			});
				  		  
		});
		
		// 입력값 체크
		function inputCheck() {
			  
			var textInput = $(".form-control");
			var uploadArea = $(".upload-name");
			  
			var titleLength = textInput[0].value.length;
			var contentLength = textInput[1].value.length;
			  
			var titleIsNull = titleLength == 0;
			var contentIsNull = contentLength == 0;
			  
			var titleIsOver = titleLength > 200;
			var contentIsOver = contentLength > 2000;

			if (titleIsNull) {
				textInput[0].focus();
			} else if (contentIsNull) {
				textInput[1].focus();
			} else if (titleIsOver) {
				textInput[0].focus();
				alert("제목을 200자 미만으로 작성해주세요.\n글자 수 : " + titleLength + "자");
			} else if (contentIsOver) {
				textInput[1].focus();
				alert("내용을 2000자 미만으로 작성해주세요.\n글자 수 : " + contentLength + "자");
			}
			  
			return false;

		}
		
		// 페이지 이동 시 처리
		  $(window).on('beforeunload', function(){
	        return "페이지 이동 주의";
	      });
		  
	    // 제출 시 동작 제어
	    $(document).on("submit", "form", function(event){
	    	$(window).off('beforeunload');
	    });
		
	});
</script>


<%@include file="../includes/footer.jsp"%>
