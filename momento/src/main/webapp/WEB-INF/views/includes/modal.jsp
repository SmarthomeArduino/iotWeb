<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel"></h4>
			</div>
			<div class="modal-body">
				<h3 id="modal-content" align="center"></h3>
			</div>
			<div class="modal-footer">
				<button id='modalSubmitBtn' type="button" class="btn btn-danger">예</button>
				<button id='modalCloseBtn' type="button" class="btn btn-default"
					data-dismiss='modal'>닫기</button>
			</div>
		</div>
		<!-- / .modal-content -->
	</div>
	<!-- / .modal-dialog -->
</div>
<!-- / .modal -->