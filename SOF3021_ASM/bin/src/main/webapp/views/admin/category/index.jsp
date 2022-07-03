<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<h2>QUẢN LÝ LOẠI SẢN PHẨM</h2>
<hr>

<button type="button" class="btn btn-success" data-bs-toggle="modal"
	data-bs-target="#createCate">Thêm</button>
<div class="modal fade" id="createCate" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Create</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<form:form action="/SOF3021_ASM/admin/category/store" method="post"
				modelAttribute="category">
				<div class="modal-body">
					<h3>Mời bạn nhập tên thể loại</h3>
					<form:input class="form-control" path="name" />

				</div>
				<div class="modal-footer">
					<button class="btn btn-primary">Thêm</button>
					<a type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</a>
				</div>
			</form:form>
		</div>
	</div>
</div>


<table class=" mt-3 table table-bordered container text-center">
	<thead class="text-center">
		<tr>
			<th>#</th>
			<th>Name</th>
			<th colspan="2">Action</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${ data.content }" var="cate" varStatus="index">
			<tr>
				<td class="text-center fw-bold">${ index.count }</td>
				<td>${ cate.name }</td>

				<!-- MODAL SỬA -->

				<td>
					<button type="button" class="btn btn-info" data-bs-toggle="modal"
						data-bs-target="#editCate_${ cate.id }">Sửa</button>
					<div class="modal fade" id="editCate_${ cate.id }" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">Update</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<form:form action="/SOF3021_ASM/admin/category/store"
									method="post" modelAttribute="category">
									<div class="modal-body">
										<h3>Tên thể loại</h3>
										<form:hidden path="id" value="${ cate.id }" />
										<form:input class="form-control" value="${ cate.name }" path="name" />

									</div>
									<div class="modal-footer">
										<button class="btn btn-primary">Sửa</button>
										<a type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">Hủy</a>
									</div>
								</form:form>
							</div>
						</div>
					</div></td>

				<!-- MODAL XÓA -->

				<td>
					<button type="button" class="btn btn-danger" data-bs-toggle="modal"
						data-bs-target="#exampleModal_${ cate.id }">Xóa</button>
					<div class="modal fade" id="exampleModal_${ cate.id }"
						tabindex="-1" aria-labelledby="exampleModalLabel"
						aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">Delete</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">Bạn có muốn xóa thể loại này
									không?</div>
								<div class="modal-footer">
									<a type="button"
										href="/SOF3021_ASM/admin/category/delete/${ cate.id }"
										class="btn btn-primary">Xóa</a>
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Hủy</button>
								</div>
							</div>
						</div>
					</div>
				</td>
			</tr>

		</c:forEach>
	</tbody>

</table>

<div class="row">
	<div class="Page navigation example">
		<ul class="justify-content-center pagination">
			<li class="page-item"><a class="page-link"
				href="/SOF3021_ASM/admin/category/index"><i
					class="fas fa-angle-double-left"></i> </a></li>
			<li class="page-item"><a class="page-link"
				href="${ data.number ==0 ? '' :'/SOF3021_ASM/admin/category/index?page='}${ data.number == 0? '#' : data.number -1}">
					<i class="fas fa-angle-left"></i>
			</a></li>
			<li class="page-item"><a class="page-link">${ data.number + 1}/${ data.totalPages }</a>
			</li>
			<li class="page-item"><a class="page-link"
				href="${ data.number == data.totalPages - 1  ? '' :'/SOF3021_ASM/admin/category/index?page='}${ data.number == data.totalPages - 1? '#' :data.number + 1 }"><i
					class="fas fa-angle-right"></i></a></li>
			<li class="page-item"><a class="page-link"
				href="/SOF3021_ASM/admin/category/index?page=${ data.totalPages -1 }"><i
					class="fas fa-angle-double-right"></i></a></li>
		</ul>
	</div>
	<div class="col-6"></div>
</div>