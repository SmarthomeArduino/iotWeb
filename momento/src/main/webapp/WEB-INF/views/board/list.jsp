<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@include file="../includes/header.jsp"%>

<div class="notiveHeader"
	style="width: 100%; display: flex; padding: 0 70px; justify-content: space-around; align-items: center;">
	<!-- 고정글 -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">고정글</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<form id="form" action="/checkedAll" method="post">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" /> <input type="hidden" name="del_res"
							value="delete"> <input type="hidden" name="del_res"
							value="delete">
						<table class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th style="display: none;" class="toggle">선택</th>
									<th>번호</th>
									<th>제목</th>
									<th>추천수</th>
									<th>조회수</th>

								</tr>
							</thead>


							<c:forEach items="${fixedList}" var="fixedlist">

								<tr>
									<td style="display: none;" class="toggle"><input
										name="checklist" type="checkbox" value="${fixedlist.bno}"></td>
									<td><c:out value="${fixedlist.bno}" /></td>
									<td><a id="readLink" class='move'
										href='<c:out value="${fixedlist.bno}"/>'
										data-del="${fixedlist.deleted}"> <c:out
												value="${fixedlist.title}" />
									</a></td>
									<td><c:out value="${fixedlist.referrals}" /></td>
									<td><c:out value="${fixedlist.views}" /></td>
								</tr>
							</c:forEach>
						</table>
					</form>
				</div>
				<!--  end panel-body -->
			</div>
		</div>
		<!-- end panel -->
	</div>
	<!-- /.row -->

	<div class="container" style="width: 50%; margin: 0;">
		<div>
			<div class="col-md-8 col-md-offset-2" style="margin: 0;">
				<div class="title" style="margin: 0 auto;">
					<h2>Notice</h2>
					<span>공지사항</span>
					<div class="divider divider-lg"></div>
					<p>The way a team plays as a whole determines its success. You
						may have the greatest bunch of individual stars in the world, but
						if they don’t play together, the club won’t be worth a dime.</p>
				</div>
			</div>
		</div>
	</div>

	<!-- 인기글 -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-danger">
				<div class="panel-heading">인기글</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<form id="form" action="/checkedAll" method="post">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" /> <input type="hidden" name="del_res"
							value="delete">
						<table class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th style="display: none;" class="toggle">선택</th>
									<th>번호</th>
									<th>제목</th>
									<th>추천수</th>
									<th>조회수</th>
								</tr>
							</thead>

							<c:forEach items="${hotList}" var="hotlist">
								<tr>
									<td style="display: none;" class="toggle"><input
										name="checklist" type="checkbox" value="${hotlist.bno}"></td>
									<td><c:out value="${hotlist.bno}" /></td>
									<td><a id="readLink" class='move'
										href='<c:out value="${hotlist.bno}"/>'
										data-del="${hotlist.deleted}"> <c:out
												value="${hotlist.title}" />
									</a></td>
									<td><c:out value="${hotlist.referrals}" /></td>
									<td><c:out value="${hotlist.views}" /></td>
								</tr>
							</c:forEach>
						</table>
					</form>
				</div>
				<!--  end panel-body -->
			</div>
		</div>
		<!-- end panel -->
	</div>
	<!-- /.row -->
</div>

<!-- 공지사항 -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-info">
			<div class="panel-heading">
				전체 게시글 목록
				<div class='pull-right'>
					<div class="col-lg-12">

						<form id='searchForm' action="/board/list" method='get'>
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <select name='type'>
								<option value=""
									<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
								<option value="T"
									<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
								<option value="C"
									<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
							</select> <input type='text' name='keyword'
								value='<c:out value="${pageMaker.cri.keyword}"/>' /> <input
								type='hidden' name='pageNum'
								value='<c:out value="${pageMaker.cri.pageNum}"/>' /> <input
								type='hidden' name='amount'
								value='<c:out value="${pageMaker.cri.amount}"/>' />
							<button class='btn btn-default'>Search</button>
						</form>
					</div>
				</div>
			</div>

			<!-- /.panel-heading -->
			<div class="panel-body">
				<form id="form" action="checkedAll" method="post">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type="hidden" name="del_res"
						value="delete">
					<table class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th style="display: none;" class="delToggle">선택</th>
								<th>번호</th>
								<th>제목</th>
								<th>작성일</th>
								<th>수정일</th>
								<th>추천수</th>
								<th>조회수</th>
								
							</tr>
						</thead>

						<c:forEach items="${list}" var="notice">
							<tr>
								<td style="display: none;" class="toggle"><input
									name="checklist" type="checkbox" value="${notice.bno}"></td>
								<td><c:out value="${notice.bno}" /></td>
								<td><a id="readLink" class='move'
									href='<c:out value="${notice.bno}"/>'
									data-del="${notice.deleted}"> <c:out
											value="${notice.title}" />
								</a></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${notice.regDate}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${notice.updateDate}" /></td>
								<td><c:out value="${notice.referrals}" /></td>
								<td><c:out value="${notice.views}" /></td>
							</tr>
						</c:forEach>
					</table>
				</form>

				<div class='adminArea'>
					<div class='pull-right'>
						<button id='regBtn' type="button"
							class="btn btn-default pull-left">등록</button>
						<button id='restorePageBtn' type="button"
							class="btn btn-info pull-left">복구</button>
						<button id='delConfirmBtn' type="button"
							class="btn btn-danger pull-left toggle" style="display: none;">확인</button>
						<button id='delCancelBtn' type="button"
							class="btn btn-default pull-left toggle" style="display: none;">취소</button>
						<button id='delBtn' type="button" class="btn btn-danger pull-left">삭제</button>
					</div>
				</div>

			</div>
			<!--  end panel-body -->
			<div class='pull-right'>
				<ul class="pagination">

					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous"><a
							href="${pageMaker.startPage -1}">Previous</a></li>
					</c:if>

					<c:forEach var="num" begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}">
						<li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""} ">
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>

					<c:if test="${pageMaker.next}">
						<li class="paginate_button next"><a
							href="${pageMaker.endPage +1 }">Next</a></li>
					</c:if>


				</ul>
			</div>
			<!--  end Pagination -->
		</div>

		<form id='actionForm' action="/board/list" method='get'>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input type='hidden' name='pageNum'
				value='${pageMaker.cri.pageNum}'> <input type='hidden'
				name='amount' value='${pageMaker.cri.amount}'> <input
				type='hidden' name='type'
				value='<c:out value="${ pageMaker.cri.type }"/>'> <input
				type='hidden' name='keyword'
				value='<c:out value="${ pageMaker.cri.keyword }"/>'>


		</form>
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->

<%@include file="../includes/modal.jsp"%>

<script src="/resources/js/list.js"></script>

<%@include file="../includes/footer.jsp"%>
