<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/myPageAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
<!-- 상단에 들어가는 마이페이지 회원정보 시작 -->
	<jsp:include page="/WEB-INF/views/aside/myPageSection.jsp" />
<!-- 상단에 들어가는 마이페이지 회원정보 끝 -->

<script type="text/javascript">
//새로고침 하는 함수
function refresh(){
	   location.reload();
	}

$(function(){
	$("#del").on("click",function(){
		let msgNoArray = [];
		$("input:checkbox[name='customCheck1']:checked").each(function(i,d){
			let msgNo = $(this).data("msgNo");
			console.log("msgNo:"+msgNo);

			msgNoArray.push(msgNo);
		});

		let data = {"msgNoArray" : msgNoArray};
		console.log("msgNoArray : " + msgNoArray);

		$.ajax({
			url:"/note/sendDeletePost",
			type:"post",
			contentType:"application/json;charset:utf-8",
			dataType:"json",
			data:JSON.stringify(data),
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
			success:function(result){
				if (result>0) {
					console.log("삭제성공");
					swal({
						title: "쪽지가 삭제되었습니다.",
						icon: "success", //success, warning, error
						button: "확인",
					}).then(function () {
						refresh();
				    });
				}else{
					swal({
						title: "쪽지가 삭제되었습니다.",
						icon: "error", //success, warning, error
						button: "확인",
					});
				}
			}
		});
	});
});
</script>

<div class="container-fluid py-4">
			<div class="row">

				<div class="dataTable-top">
					<a href="javascript:;" class="card-title h5 d-block text-darker">
						보낸쪽지함</a>
					<p class="text-sm mb-0">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
			  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
			  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
						</svg>
						보낸 쪽지 목록을 긴급/일반 태그를 나누어 최신순으로 조회할 수 있습니다.
					</p>
				</div>
				<div class="row mx-0">
					<div class="col-9"></div>
					<div class="col-3 w-100 px-0" style="text-align:right;">
					<!-- 												<button type="button" class="btn btn-outline-dark btn-sm">전달</button> -->
					<button type="button" class="btn btn-outline-danger btn-sm mb-0" id="del" style="background-color:white;">삭제</button>
					</div>
				</div>

						<div class="card-body pt-2">
							<div>
								<div class="author align-items-center"></div>
								<div class="row" style="padding: 10px;">
									<div class="col">
										<div class="card" style="font-weight: bold; border-style: solid; border-color: #FAE58C;">
											<div class="card-body pt-2">
											</div>

											<div class="pt-3 pb-3 table-responsive">
												<table class="table align-items-center mb-0 w-90 mx-auto">
													<thead>
														<tr>
															<th class="text-uppercase text-center text-secondary text font-weight-bolder opacity-7">순번</th>
															<th class="text-uppercase text-center text-secondary text font-weight-bolder opacity-7">분류</th>
															<th class="text-uppercase text-center text-secondary text font-weight-bolder opacity-7 ps-2">쪽지내용</th>
															<th class="text-uppercase text-center text-secondary text font-weight-bolder opacity-7 ps-2">수신자</th>
															<th class="text-uppercase text-center text-secondary text font-weight-bolder opacity-7 ps-2">보낸시각</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="noteVO" items="${data}" varStatus="stat">
															<tr>
														<c:choose>
															<c:when test="${empty noteVO}"><td  class="text-center"><div class="d-flex px-2 py-1">보낸 쪽지가 없습니다.</div></td></c:when>
															<c:otherwise>
																<td  class="text-center">
																	<div class="d-flex px-2 py-1">
																		<div class="d-flex flex-column justify-content-center">
																			<h6 class="mb-0 text-sm">
																				<div class="form-check">
																					<input class="form-check-input" type="checkbox" name="customCheck1"
																						data-msg-no="${noteVO.msgNo}" id="customCheck1">${noteVO.rnum}
																				</div>
																			</h6>
																		</div>
																	</div>
																</td>
																	<td  class="text-center">
																		<p class="text-sm text-center text-secondary mb-0"><c:if test="${noteVO.msgCateTag eq '일반'}"><span class="badge badge-secondary">일반</span></c:if>
																			<c:if test="${noteVO.msgCateTag eq '긴급'}"><span class="badge badge-danger">긴급</span></c:if>
																		</p>
																	</td>
																	<td  class="text-center"><span class="badge badge-dot me-4"> <i
																			${noteVO.msgNo},${noteVO.empNoRcvr}
																			class=""></i> <span class="text-dark text">
																			<a style="color:#344767!important;"
																			href="/note/detail?msgNo=${noteVO.msgNo}&empNoRcvr=${noteVO.empNoRcvr}">${noteVO.msgCn} </a>
																			</span>
																	</span></td>
																	<td  class="text-center"><span class="badge badge-dot me-4"> <i
																			class=""></i> <span class="text-center text-dark text">${noteVO.rcvr}</span>
																	</span></td>
																	<td  class="text-center"><span class="badge badge-dot me-4"> <i
																			class="bg-info"></i><span class="text-center text-dark text">
																			<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${noteVO.msgDsptchDt}"/>
																			</span>
																	</span></td>
															</c:otherwise>
														</c:choose>
																</tr>
														</c:forEach>
													</tbody>

												</table>

<!-- 											삭제 모달창 띄우기? -->
<!-- 											전달 누르면 주소록 연동 -->
<!-- 											<div style="float: right"> -->
<!-- <!-- 												<button type="button" class="btn btn-outline-dark btn-sm">전달</button> -->
<!-- 												<button type="button" class="btn btn-outline-danger btn-sm" id="del">삭제</button> -->
<!-- 											</div> -->


											</div>
											<div class="author align-items-center"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
