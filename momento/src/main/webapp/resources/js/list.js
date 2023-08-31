	$(document).ready(
					function() {

						var toggle = $(".toggle");
						var result = '<c:out value="${result}"/>';

/*						checkModal(result);


						history.replaceState({}, null, null);

						function checkModal(result) {
							
							if (result === '' || history.state) {
								return;
							}

							if (parseInt(result) > 0) {
								$(".modal-body").html(
										"게시글 " + parseInt(result)
												+ " 번이 등록되었습니다.");
							}

							$("#myModal").modal("show");
						}
*/						

						$("#regBtn").on("click", function(e) {

							self.location = "/board/register";

						});
						
						$("#restorePageBtn").on("click", function(e) {
						
							self.location = "/board/deleted";
						
						});
						
						$("#listBtn").on("click", function(e) {
						
							self.location = "/board/list";
						
						});
						
						$("#delBtn").on("click", function(e) {
							
							for (let i=0 ; i<toggle.length-2 ; i++) {
								toggle[i].style.display = "block";
							}
							for (let i=toggle.length-2 ; i<toggle.length ; i++) {
								toggle[i].style.display = "inline-block";
							}
							$("#delBtn").css("display", "none");
						
						});
						
						$("#restoreBtn").on("click", function(e) {
							
							for (let i=0 ; i<toggle.length-2 ; i++) {
								toggle[i].style.display = "block";
							}
							for (let i=toggle.length-2 ; i<toggle.length ; i++) {
								toggle[i].style.display = "inline-block";
							}
							$("#restoreBtn").css("display", "none");
						
						});
						
						$("#delConfirmBtn").on("click", function(e) {
						
							e.preventDefault();
							$("#modalSubmitBtn").css("display", "inline-block");
						
							var deleteCheck = $("input:checkbox[name='checklist']").is(":checked");
							
							$(".modal-title").text("글 삭제");
							
							if ( deleteCheck.length == 0 ) {
								$("#modal-content").text("삭제할 글을 선택 해주세요.");
								$("#modalSubmitBtn").css("display", "none");
							} else {
								$("#modal-content").text("정말로 삭제 하시겠습니까?");
							}
						
							$(".modal").modal("show");
						
						});
						
						$("#delCancelBtn").on("click", function(e) {
						
							for (let i=0 ; i<toggle.length ; i++) {
								toggle[i].style.display = "none";
							}
							$("#delBtn").css("display", "inline-block");
						
						});
						
						$("#resConfirmBtn").on("click", function(e) {
						
							e.preventDefault();
							$("#modalSubmitBtn").css("display", "inline-block");
						
							var restoreCheck = $("input:checkbox[name='checklist']").is(":checked");
							
							$(".modal-title").text("글 복구");
							
							if ( restoreCheck.length == 0 ) {
								$("#modal-content").text("복구할 글을 선택 해주세요.");
								$("#modalSubmitBtn").css("display", "none");
							} else {
								$("#modal-content").text("정말로 복구 하시겠습니까?");
							}
						
							$(".modal").modal("show");
						
						});
						
						$("#resCancelBtn").on("click", function(e) {
						
							for (let i=0 ; i<toggle.length ; i++) {
								toggle[i].style.display = "none";
							}
							$("#restoreBtn").css("display", "inline-block");
						
						});
						
						
						$("#modalSubmitBtn").on("click", function(e) {
						
							var form = $("#form");
							form.submit();
						
						});
						

						var actionForm = $("#actionForm");

						$(".paginate_button a").on(
								"click",
								function(e) {

									e.preventDefault();

									console.log('click');

									actionForm.find("input[name='pageNum']")
											.val($(this).attr("href"));
									actionForm.submit();
								});

						$(".move")
								.on(
										"click",
										function(e) {
	
											e.preventDefault();
											actionForm
													.append("<input type='hidden' name='bno' value='"
															+ $(this).attr(
																	"href")
															+ "'>");
											actionForm
													.append("<input type='hidden' name='deleted' value='"
															+ $(this).data(
																	"del")
															+ "'>");				
											actionForm.attr("action",
													"/board/read");
											actionForm.submit();

										});

						var searchForm = $("#searchForm");

						$("#searchForm button").on(
								"click",
								function(e) {

									if (!searchForm.find("option:selected")
											.val()) {
										alert("검색종류를 선택하세요");
										return false;
									}

									if (!searchForm.find(
											"input[name='keyword']").val()) {
										alert("키워드를 입력하세요");
										return false;
									}

									searchForm.find("input[name='pageNum']")
											.val("1");
									e.preventDefault();

									searchForm.submit();

								});

					});