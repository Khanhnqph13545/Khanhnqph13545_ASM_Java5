<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<c:if
	test="${ sessionScope.user.admin == 0 || empty sessionScope.user }">
	<div class="text-center mt-4">
		<h2 class="fw-bold"color:black";>Danh sách sản phẩm</h2>
	</div>
	<hr>
	<div class="row mb-3">
		<div class="col-8">
			<form action="/SOF3021_ASM/home" method="get" class="row">
				<div class="col-8">
					<input type="text" name="search" class="form-control">
				</div>
				<div class="col-auto">
					<button class=" btn btn-outline-dark ">Tìm kiếm</button>
				</div>
			</form>
		</div>
		<div class=" col-4 text-end">
			<div class="dropdown">
				<button class="btn btn-outline-dark dropdown-toggle" type="button"
					id="dropdownMenuButton1" data-bs-toggle="dropdown"
					aria-expanded="false">Thể loại</button>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
					<li><a class="dropdown-item" href="/SOF3021_ASM/home">Tất
							cả </a></li>
					<c:forEach items="${ categories }" var="cate">
						<li><a class="dropdown-item"
							href="/SOF3021_ASM/home?cate=${ cate.id }">${ cate.name }</a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	<div class="row">
		<c:forEach items="${data.content}" var="pro">
			<div class="col-12 col-md-6 col-xl-3 p-1 text-center">
				<div class="border border-danger rounded-3">
					<div class="m-1 rounded-3 p-2" style="background-color: white;">
						<img src="images/product/${ pro.image }" alt=""
							class="img-fluid rounded-2" style="height: 200px">
						<p class="mt-2">
							<b class="fw-bold text-uppercase">${ pro.name }</b>
						</p>
						<p>
						<h4 class="text-danger fw-bold">
							<fmt:formatNumber value="${ pro.price}" pattern="#,###"></fmt:formatNumber>
							₫
						</h4>
						</p>
						<a class="btn btn-dark rounded"
							href="/SOF3021_ASM/user/cart/create?id=${ pro.id }" role="button">Thêm
							vào giỏ hàng</a>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>

	<div class="row mt-3">
		<div class="Page navigation example">
			<ul class="justify-content-center pagination">
				<li class="page-item"><a class="page-link"
					href="/SOF3021_ASM/home"><i class="fas fa-angle-double-left"></i>
				</a></li>
				<li class="page-item"><a class="page-link"
					href="${ data.number ==0 ? '' :'/SOF3021_ASM/home?page='}${ data.number == 0? '#' : data.number -1}">
						<i class="fas fa-angle-left"></i>
				</a></li>
				<li class="page-item"><a class="page-link">${ data.number + 1}</a>
				</li>
				<li class="page-item"><a class="page-link"
					href="${ data.number == data.totalPages - 1  ? '' :'/SOF3021_ASM/home?page='}${ data.number == data.totalPages - 1? '#' :data.number + 1 }"><i
						class="fas fa-angle-right"></i></a></li>
				<li class="page-item"><a class="page-link"
					href="/SOF3021_ASM/home?page=${ data.totalPages -1 }"><i
						class="fas fa-angle-double-right"></i></a></li>
			</ul>
		</div>
		<div class="col-6"></div>
	</div>
</c:if>
<c:if test="${ sessionScope.user.admin==1 }">

	<div class="row mt-3 p-4">
		<div class="col-2  " ng-controller="homeCtrl">
			<button type="button" class="btn btn-primary btn-outline-dark"
				style="height: 80px;width: 180px" data-bs-toggle="modal" data-bs-target="#create">Tạo
				đơn hàng mới</button>
			<div class="modal fade" id="create" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div
					class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">Vui lòng chọn
								khách hàng</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form ng-submit="serach($event)"
								action="/SOF3021_ASM/home/search" method="get" class="row">
								<div class="col-8">
									<input type="text" ng-model="keyword" name="keyword"
										class="form-control">
								</div>
								<div class="col-auto">
									<button class=" btn btn-outline-dark ">Tìm kiếm</button>
								</div>
								<div ng-show="show">
									<table class="table table-bodered">
										<thead>
											<tr>
												<th>Fullname</th>
												<th>Email</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
											<tr ng-repeat="us in user">
												<td>{{us.fullname}}</td>
												<td>{{us.email}}</td>
												<td><a class="btn btn-secondary"
													href="/SOF3021_ASM/admin/order/create?user={{us.id}}">Chọn</a></td>
											</tr>
										</tbody>
									</table>
								</div>
							</form>
							<hr>
							<form action="/SOF3021_ASM/admin/order/create" method="get">
								<select name="user" class="form-select">
									<c:forEach items="${ listAcc }" var="acc">
										<option value="${ acc.id }">${ acc.fullname }-${ acc.email }</option>
									</c:forEach>
								</select>
								<div class="modal-footer">
									<a type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Hủy</a>
									<button class="btn btn-primary">Xác nhận</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-2  ">
			<a class="btn btn-success btn-outline-warning pt-4"
				style="height: 80px; width: 180px"
				href="/SOF3021_ASM/admin/product/index">Quản lý Product</a>
		</div>
		<div class="col-2  ">
			<a class="btn btn-success btn-outline-warning pt-4"
				style="height: 80px; width: 180px"
				href="/SOF3021_ASM/admin/account/index">Quản lý Account</a>
		</div>
		<div class="col-2  ">
			<a class="btn btn-success btn-outline-warning pt-4"
				style="height: 80px; width: 180px"
				href="/SOF3021_ASM/admin/category/index">Quản lý Category</a>
		</div>
		<div class="col-2  ">
			<a class="btn btn-success btn-outline-warning pt-4"
				style="height: 80px; width: 180px"
				href="/SOF3021_ASM/admin/order/index">Quản lý Order</a>
		</div>
		<div class="col-2  ">
			<a class="btn btn-success btn-outline-warning pt-4"
				style="height: 80px; width: 180px"
				href="/SOF3021_ASM/admin/discount/index">Quản lý Discount</a>
		</div>

	</div>
	<div class="row mt-3 p-4">
		<div class="col-2   ">
			<a class="btn btn-warning btn-outline-dark pt-4"
				style="height: 80px; width: 180px"
				href="/SOF3021_ASM/admin/statistical/index">Sản phẩm bán chạy</a>
		</div>
		<div class="col-2   ">
			<a class="btn btn-warning btn-outline-dark pt-4"
				style="height: 80px; width: 180px"
				href="/SOF3021_ASM/admin/sales/index">Thống kê doanh thu</a>
		</div>
	</div>
</c:if>