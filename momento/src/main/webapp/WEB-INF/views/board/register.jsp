<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=, initial-scale=1.0" />
<title>텍스트 편집기</title>
<style>
.filebox .upload-name {
	display: inline-block;
	height: 40px;
	line-height: 40px;
	padding: 0 10px;
	vertical-align: middle;
	border: 1px solid #dddddd;
	width: 25%;
	color: #999999;
}

.upload-name button {
	padding: 0px;
	width: 25px;
	height: 25px;
}

.upload-name i {
	margin: auto;
}

.filebox label {
	display: inline-block;
	padding: 10px 20px;
	color: #fff;
	vertical-align: middle;
	background-color: #999999;
	cursor: pointer;
	margin-left: 10px;
}

.filebox input[type="file"] {
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
</head>
<%@include file="../includes/header.jsp"%>

<form role="form" action="/board/register" method="post">
	<input type="hidden" name="${_csrf.parameterName}"
		value="${_csrf.token}" />
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">게시글 등록</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->

	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-info">

				<div class="panel-heading">공지사항 등록</div>
				<!-- /.panel-heading -->
				<div class="panel-body">

					<div class="form-group">
						<label>제목</label><input class="form-control" name='title'>
						<label>고정글 등록<input type="checkbox" name="fixed"
							id="fixedPost" value="1" /></label>
					</div>

					<div class="form-group">
						<label>내용</label>
						<div id="editorHeader">
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
						<div id="editorBody" contenteditable="true"></div>
						<textarea style="display: none" class="form-control" rows="3"
							name='content'></textarea>
					</div>

					<button type="button" id="submitBtn" class="btn btn-default">등록</button>

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
			<div class="panel panel-info">

				<div class="panel-heading">파일 첨부</div>
				<!-- / .panel-heading -->
				<div class="panel-body">
					<div class="form-group uploadDiv">
						<div class="filebox">
							<div class="upload-name">첨부파일</div>
							<label for="file">파일찾기</label> <input type="file" id="file"
								name="uploadFile">
						</div>
					</div>
				</div>
				<!-- end panel-body -->
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel -->
	</div>
	<!-- end row -->
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
	btnBold.addEventListener("click", function() {
		setStyle("bold");
	});

	btnItalic.addEventListener("click", function() {
		setStyle("italic");
	});

	btnUnderline.addEventListener("click", function() {
		setStyle("underline");
	});

	btnStrike.addEventListener("click", function() {
		setStyle("strikeThrough");
	});

	btnOrderedList.addEventListener("click", function() {
		setStyle("insertOrderedList");
	});

	btnUnorderedList.addEventListener("click", function() {
		setStyle("insertUnorderedList");
	});

	function setStyle(style) {
		document.execCommand(style);
		focusEditor();
	}

	// 버튼 클릭 시 에디터가 포커스를 잃기 때문에 다시 에디터에 포커스를 해줌
	function focusEditor() {
		editor.focus({
			preventScroll : true
		});
	}
	editor.addEventListener("keydown", function() {
		checkStyle();
	});

	editor.addEventListener("mousedown", function() {
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
<script>
	$(document)
			.ready(
					function(e) {

						var regex = /(.*?)\.(csv)/;
						var maxSize = 5242880; //5MB

						// 업로드 파일 체크
						function checkExtension(fileName, fileSize) {

							$(".modal-title").text("파일 첨부");
							if (fileSize >= maxSize) {
								$("#modal-content").text(
										"파일 크기가 5MB 미만인 파일을 첨부 해주세요.");
								return false;
							}

							if (!regex.test(fileName)) {
								$("#modal-content").text("업로드 가능한 파일 형식 : CSV");
								return false;
							}

							return true;
						}

						// 파일 업로드 이벤트
						$("input[type='file']").change(function(e) {

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

							formData.append("uploadFile", files[0]);

							$.ajax({

								url : '/uploadAjaxAction',
								processData : false,
								contentType : false,
								data : formData,
								type : 'POST',
								dataType : 'json',
								success : function(uploadFile) {
									showUploadFile(uploadFile);
								}

							});

						});

						// 업로드 파일 출력
						function showUploadFile(uploadFile) {

							if (!(uploadFile || uploadFile.length == 0)) {
								return;
							}

							var uploadArea = $(".upload-name");
							var fileCallPath = encodeURIComponent(uploadFile.uploadPath
									+ "/"
									+ uploadFile.uuid
									+ "_"
									+ uploadFile.fileName);
							var fileLink = fileCallPath.replace(new RegExp(
									/\\/g), "/");
							var str = "";

							str += "<img src='/resources/images/exel_icon.png' style='display:inline-box'>";
							str += "<span ";
		  str += "data-path='" + uploadFile.uploadPath + "' data-uuid='" + uploadFile.uuid + "' "
		  		+"data-filename='" + uploadFile.fileName + "' data-type='" + uploadFile.fileType + "'>";
							str += uploadFile.fileName + "</span>";
							str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' "
		  		+"class='btn-warning'><i class='fa fa-times'></i></button>";

							uploadArea.text("");
							uploadArea.append(str);

						}

						// 업로드 파일 삭제	  
						$(".upload-name").on("click", "button", function(e) {

							var targetFile = $(this).data("file");
							var type = $(this).data("type");
							var targetDiv = $(".upload-name");

							$.ajax({

								url : '/deleteFile',
								data : {
									fileName : targetFile,
									type : type
								},
								dataType : 'text',
								type : 'POST',
								success : function(result) {
									targetDiv.children().remove();
									targetDiv.text("첨부파일");
								}

							});

						});

						// 업로드 파일 전송
						function fileData() {

							var formObj = $("form[role='form']");
							var obj = $(".upload-name span");
							var str = "";

							str += "<input type='hidden' name='attachVO.fileName' value='"
									+ obj.data("filename") + "'>";
							str += "<input type='hidden' name='attachVO.uuid' value='"
									+ obj.data("uuid") + "'>";
							str += "<input type='hidden' name='attachVO.uploadPath' value='"
									+ obj.data("path") + "'>";
							str += "<input type='hidden' name='attachVO.fileType' value='"
									+ obj.data("type") + "'>";

							formObj.append(str);

						}

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
								alert("제목을 200자 미만으로 작성해주세요.\n글자 수 : "
										+ titleLength + "자");
							} else if (contentIsOver) {
								textInput[1].focus();
								alert("내용을 2000자 미만으로 작성해주세요.\n글자 수 : "
										+ contentLength + "자");
							}

							return false;

						}

						// 페이지 이동 시 처리
						$(window).on('beforeunload', function() {
							return "페이지 이동 주의";
						});

						// 제출 시 동작 제어
						$("#submitBtn").on("click", function(e) {
							$(window).off('beforeunload');

							var editor = $("#editorBody");
							var textArea = $("textArea[name=content]");
							var form = $("form[role='form']");

							inputCheck();

							if ($(".upload-name").text() !== "첨부파일") {
								fileData();
							}

							textArea.val(editor.html());

							form.submit();

						});

					});
</script>
<%@include file="../includes/footer.jsp"%>