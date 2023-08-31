<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="title">
				<h2>Notice</h2>
				<span>공지사항</span>
				<div class="divider divider-lg"></div>
				<p>복구 페이지</p>
			</div>
		</div>
	</div>
	<div class="row team"></div>
</div>


<!-- 공지사항 -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-info">
			<div class="panel-heading">
				삭제 게시글 목록
				<div class='pull-right'>
					<div class="col-lg-12">

						<form id='searchForm' action="/board/deleted" method='get'>
							<select name='type'>
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
							value="${_csrf.token}" />
					<input type="hidden" name="del_res" value="restore">
					<table class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th style="display: none;" class="toggle">선택</th>
								<th>번호</th>
								<th>제목</th>
								<th>작성일</th>
								<th>수정일</th>
								<th>추천수</th>
								<th>조회수</th>
								<th>삭제일</th>
							</tr>
						</thead>

						<c:forEach items="${deletedList}" var="deleted">
							<tr>
								<td style="display: none;" class="toggle"><input
									name="checklist" type="checkbox" value="${deleted.bno}"></td>
								<td><c:out value="${deleted.bno}" /></td>
								<td><a class='move' href='<c:out value="${deleted.bno}"/>'
									data-del="${deleted.deleted}"> <c:out
											value="${deleted.title}" />
								</a></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${deleted.regDate}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${deleted.updateDate}" /></td>
								<td><c:out value="${deleted.referrals}" /></td>
								<td><c:out value="${deleted.views}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${deleted.delDate}" /></td>
							</tr>
						</c:forEach>
					</table>
				</form>

				<div class='adminArea'>
					<div class='pull-right'>
						<button id='restoreBtn' type="button"
							class="btn btn-info pull-left">복구</button>
						<button id='resConfirmBtn' type="button"
							class="btn btn-info pull-left toggle" style="display: none;">확인</button>
						<button id='resCancelBtn' type="button"
							class="btn btn-default pull-left toggle" style="display: none;">취소</button>
						<button id='listBtn' type="button"
							class="btn btn-default pull-left">목록</button>
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

		<form id='actionForm' action="/board/deleted" method='get'>
			<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
			<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>

			<input type='hidden' name='type'
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