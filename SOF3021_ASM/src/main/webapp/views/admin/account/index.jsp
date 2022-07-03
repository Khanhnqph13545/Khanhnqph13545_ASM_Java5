<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<h2>QUẢN LÝ NGƯỜI DÙNG</h2>
<hr>

<a class="btn btn-success" href="/SOF3021_ASM/admin/account/create">Thêm</a>

<table class=" mt-3 table table-bordered container text-center">
	<thead class="text-center">
		<tr>
			<th>#</th>
			<th>Fullname</th>
			<th>Username</th>
			<th>Email</th>
			<th>Photo</th>
			<th>Activated</th>
			<th>Role</th>
			<th colspan="2">Action</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${ data.content }" var="acc" varStatus="index">
			<tr>
				<td class="text-center fw-bold">${ index.count }</td>
				<td>${ acc.fullname }</td>
				<td>${ acc.username }</td>
				<td>${ acc.email }</td>
				<td class="text-center"> <img alt="" style="width: 100px" src="/SOF3021_ASM/images/account/${ acc.photo }"></td>
				<td><c:if test="${ acc.activated == 1 }">Đã kích hoạt</c:if> <c:if
						test="${ acc.activated == 0 }">Chưa kích hoạt</c:if></td>
				<td><c:if test="${ acc.admin == 1 }">Admin</c:if> <c:if
						test="${ acc.admin == 0 }">Member</c:if></td>
				<td>
					<a class="btn btn-info" href="/SOF3021_ASM/admin/account/edit/${ acc.id }">Sửa</a>
				</td>
				<td>
					<button type="button" class="btn btn-danger"
						data-bs-toggle="modal" data-bs-target="#exampleModal_${ acc.id }">
						Xóa</button>
					<div class="modal fade" id="exampleModal_${ acc.id }" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">Delete</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">Bạn có muốn xóa người dùng này không?</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Hủy</button>
									<a type="button" href="/SOF3021_ASM/admin/account/delete/${ acc.id }" class="btn btn-primary">Xóa</a>
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
				href="/SOF3021_ASM/admin/account/index"><i
					class="fas fa-angle-double-left"></i> </a></li>
			<li class="page-item"><a class="page-link"
				href="${ data.number ==0 ? '' :'/SOF3021_ASM/admin/account/index?page='}${ data.number == 0? '#' : data.number -1}" >
					<i class="fas fa-angle-left"></i>
			</a></li>
			<li class="page-item"><a class="page-link">${ data.number + 1}</a>
			</li>
			<li class="page-item"><a class="page-link"
				href= "${ data.number == data.totalPages - 1  ? '' :'/SOF3021_ASM/admin/account/index?page='}${ data.number == data.totalPages - 1? '#' :data.number + 1 }"><i
					class="fas fa-angle-right"></i></a></li>
			<li class="page-item"><a class="page-link"
				href="/SOF3021_ASM/admin/account/index?page=${ data.totalPages -1 }"><i
					class="fas fa-angle-double-right"></i></a></li>
		</ul>
	</div>
	<div class="col-6"></div>
</div>