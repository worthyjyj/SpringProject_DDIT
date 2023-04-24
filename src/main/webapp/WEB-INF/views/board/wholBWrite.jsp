<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- jQuery -->
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/js/jquery-3.6.3.min.js"></script>

<script src="/resources/ckeditor/ckeditor.js"></script>
<script src="/resources/soft-dashboard/assets/js/plugins/dropzone.min.js"></script>

<script src="https://rawgit.com/enyo/dropzone/master/dist/dropzone.js"></script>
<link rel="stylesheet"
	href="https://rawgit.com/enyo/dropzone/master/dist/dropzone.css">

<style>
.lb{
	width: 100px;
}
</style>



<!-- 부서게시글 쓰기 -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/boardAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
		<!-- body_center -->

			<form action="/board/wholBWritePost" enctype="multipart/form-data" method="post">
				<div class="card">
					<div class="table-responsive">
						<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<div class="dataTable-top">
								<h4>전사게시글 등록</h4>
								<div class="dataTable-search">
								</div>
							</div>

								<div class="dataTable-top">
										<div class="col-sm-1">
								    		<label for="inputtitle3" class="col-sm-2 col-form-label lb">제목</label>
								    	</div>
									    <div class="col-sm-11">
	<!-- 							    		<div class="form-check" style="width:100%;"> -->
										      	<div style="float:left; margin-top: 5px;"></div>
										        <div style="float:left; margin-top: 5px;"></div>
										        <div style="float:left;margin-left:10px;width:80%;">
										        	<input type="text" name="wholBbsTtl" class="form-control" id="inputtitle3" placeholder="Title" style="width:110%;" />
										        </div>
	<!-- 							     		</div>							     -->
										</div>
								</div>
								<div class="dataTable-top">
									<!-- 파일첨부 -->
								  <div class="form-group w-85">
					                <label for="notice-img" class="col-form-label">파일첨부</label>
									<input class="form-control" type="file"  name="uploadFile" id="notice-img" />
					              </div>
								    <div class="col-sm-10">
								    </div>

								</div>
							</div>
						</div>
						<!-- ckeditor -->
						<div class="form-group row" style="margin-left:20px;">
							<label class="col-sm-2"></label>
							<div style="width:90%;">
							<!-- 세로 : cols, 가로 : rows -->
								<textarea class="form-control" cols="70" rows="2" id="wholBbsCn" name="wholBbsCn"></textarea>
							</div>
						</div>
						<div style="text-align: center;">
						<button type="submit" class="btn btn-outline-dark btn-sm">등록</button>
						</div>
					</div>
					<sec:csrfInput />
				</form>
			</div>
		</div>













	

<!-- 							<h4>전사게시글 등록</h4>																 -->
<!-- 							<div class="dataTable-search">								 -->
<!-- 							</div> -->
<!-- 						</div> -->

<!-- 							<div class="dataTable-top"> -->
<!-- 									<div class="col-sm-1"> -->
<!-- 							    		<label for="inputtitle3" class="col-sm-2 col-form-label lb">제목</label> -->
<!-- 							    	</div>					     -->
<!-- 								    <div class="col-sm-11"> -->

<!-- <!-- 							    		<div class="form-check" style="width:100%;"> --> 
<!-- 									      	<div style="float:left; margin-top: 5px;"> -->

<!-- 									        </div> -->
<!-- 									        <div style="float:left; margin-top: 5px;"> -->

<!-- 									        </div> -->
<!-- 									        <div style="float:left;margin-left:10px;width:80%;"> -->
<!-- 									        	<input type="text" name="wholBbsTtl" class="form-control" id="inputtitle3" placeholder="Title" style="width:110%;" /> -->
<!-- 									        </div>								    -->
<!-- <!-- 							     		</div>							     --> 
<!-- 									</div> 		 -->
<!-- 							</div>							   -->

<!-- 							<div class="dataTable-top"> -->
<!-- 							    <label for="inputfile3" class="col-sm-2 col-form-label lb">파일첨부</label> -->


<!-- 							    <div action="/file-upload" class="form-control dropzone dz-clickable" id="dropzone"> -->

<!-- 									<div class="dz-default dz-message" style="width: 400px;"><button class="dz-button" type="button">Drop files here to upload</button> -->
<!-- 									</div> -->
<!-- 								</div> -->


<!-- 							    <div class="col-sm-10"> -->
<!-- <!-- 							    <input type="button" name="file" id="file" value="파일선택" > --> 
<!-- <!-- 							     <input type="file" class="form-control" id="inputfile3" placeholder="여기에 첨부파일을 끌어오세요. 또는 파일선택"> -->
<!-- <!-- 							     <form action="/file-upload" class="form-control dropzone" id="dropzone" /> -->
<!-- <!-- 								  <div class="fallback"> --> 
<!-- 								    <input name="uploadFile" type="file" id="file" multiple /> -->
<!-- <!-- 								  </div> --> 
<!-- <!-- 								</form> --> 
<!-- 							    </div> -->
<!-- 							</div>						 -->

<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					ckeditor -->
<!-- 					<div class="form-group row" style="margin-left:20px;"> -->
<!-- 						<label class="col-sm-2"></label> -->
<!-- 						<div style="width:90%;"> -->
<!-- 						세로 : cols, 가로 : rows -->
<!-- 							<textarea class="form-control" cols="70" rows="2" id="wholBbsCn" name="wholBbsCn"></textarea> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div style="text-align: center;"> -->
<!-- 					<button type="submit" class="btn btn-outline-dark btn-sm">등록</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
<%-- 				<sec:csrfInput /> --%>
<!-- 			</form> -->



		</div>
	</div>
</div>
<script type="text/javascript">
CKEDITOR.replace('wholBbsCn');

CKEDITOR.resize("300px", "500px");
</script>