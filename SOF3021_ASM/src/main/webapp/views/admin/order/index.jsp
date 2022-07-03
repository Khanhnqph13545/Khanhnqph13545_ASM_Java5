<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<h2>QUẢN LÝ HÓA ĐƠN</h2>
<hr>
<table class=" mt-3 table table-bordered container text-center">
	<thead class="text-center">
		<tr>
			<th><a class="btn fw-bold" href="/SOF3021_ASM/admin/order/index">Tất
					cả</a></th>
			<th><a class="btn fw-bold"
				href="/SOF3021_ASM/admin/order/index?status=3">Đã nhận được hàng</a>
			</th>
			<th><a class="btn fw-bold"
				href="/SOF3021_ASM/admin/order/index?status=2">Đã xác nhận</a></th>
			<th><a class="btn fw-bold"
				href="/SOF3021_ASM/admin/order/index?status=4">Đang giao</a></th>
			<th><a class="btn fw-bold"
				href="/SOF3021_ASM/admin/order/index?status=1">Chưa xác nhận</a></th>
			<th><a class="btn fw-bold"
				href="/SOF3021_ASM/admin/order/index?status=0">Đã hủy</a></th>
		</tr>
	</thead>
</table>
<hr>
<button type="button" class="btn btn-success" data-bs-toggle="modal"
	data-bs-target="#create">Thêm</button>
<div class="modal fade" ng-controller="homeCtrl" id="create"
	tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
				<form ng-submit="serach($event)" action="/SOF3021_ASM/home/search"
					method="get" class="row">
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
						<a type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</a>
						<button class="btn btn-primary">Xác nhận</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<table class=" mt-3 table table-bordered container text-center">
	<thead class="text-center">
		<tr>
			<th>#</th>
			<th>Full name</th>
			<th>Address</th>
			<th>Create</th>
			<th>Status</th>
			<th>Total</th>
			<th colspan="${ stt<2?'3':'3' }">Action</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${ orders }" var="orders" varStatus="index">
			<tr>
				<td class="text-center fw-bold">${ index.count }</td>
				<td>${ orders.order.account.fullname }</td>
				<td>${ orders.order.address }</td>
				<td><fmt:formatDate value="${ orders.order.createDate }"
						pattern="dd/MM/yyyy" /></td>
				<td><c:if test="${ orders.order.status == 1 }">
						<c:if test="${ orders.order.deleted  == 0}">
							Chưa xác nhận
						</c:if>
						<c:if test="${orders.order.deleted == 1}">
							Đã bị hủy
						</c:if>
					</c:if> <c:if test="${ orders.order.status == 2 }">
						Đã xác nhận
					</c:if> <c:if test="${ orders.order.status == 3 }">
						Đã nhận được hàng
					</c:if> <c:if test="${ orders.order.status == 4 }">
						Đang giao hàng
					</c:if></td>
				<td><fmt:formatNumber value="${ orders.total }" pattern="#,###"></fmt:formatNumber>
					₫</td>


				<!-- CHI TIẾT -->


				<td class="text-start"
					colspan="${ orders.order.deleted == 0 ?'1':'3' }">
					<button type="button" class="btn btn-primary"
						data-bs-toggle="modal"
						data-bs-target="#detail_${ orders.order.id }">Chi tiết</button>
					<div class="modal fade" id="detail_${ orders.order.id }"
						tabindex="-1" aria-labelledby="exampleModalLabel"
						aria-hidden="true">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">Chi tiết</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<h2>HÓA ĐƠN CHI TIẾT</h2>
									<hr>
									<p class="fs-5">Khách hàng: ${ orders.order.account.fullname }</p>
									<p class="fs-5">Địa chỉ : ${ orders.order.address }</p>
									<hr>
									<table class=" mt-3 table table-bordered container text-center">
										<thead class="text-center">
											<tr>
												<th>#</th>
												<th>Product</th>
												<th>Image</th>
												<th>Price</th>
												<th>Quantity</th>
												<th>Total</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${ orders.order.orderdetailOrder }"
												var="ordt" varStatus="index">
												<tr>
													<td class="text-center fw-bold">${ index.count }</td>
													<td>${ ordt.product.name}</td>
													<td><img alt="" style="width: 100px"
														src="/SOF3021_ASM/images/product/${ ordt.product.image }"></td>
													<td><fmt:formatNumber value="${ ordt.price }"
															pattern="#,###"></fmt:formatNumber> ₫</td>
													<td>${ ordt.quantity }</td>
													<td><fmt:formatNumber
															value="${ ordt.price * ordt.quantity }" pattern="#,###"></fmt:formatNumber>
														₫</td>
												</tr>
											</c:forEach>
										</tbody>
										<tfoot>
											<tr>
												<td colspan="4">Tổng tiền:</td>
												<td colspan="2"><fmt:formatNumber
														value="${ orders.total }" pattern="#,###"></fmt:formatNumber>
													₫</td>
											</tr>
											<tr>
												<td colspan="4">Khuyến mãi:</td>
												<td colspan="2"><fmt:formatNumber
														value="${ orders.order.discount }" pattern="#,###"></fmt:formatNumber>
													₫</td>
											</tr>
											<tr>
												<td colspan="4">Tổng thanh toán:</td>
												<td colspan="2"><fmt:formatNumber
														value="${ orders.total - orders.order.discount }" pattern="#,###"></fmt:formatNumber>
													₫</td>
											</tr>
										</tfoot>
									</table>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div> <%-- <a class="btn btn-info"
					href="/SOF3021_ASM/admin/orderdetail/index/${ orders.order.id }">Chi
						tiết</a> --%>
				</td>

				<!-- XÁC NHẬN -->

				<c:if
					test="${ stt == 1 || stt==2 || stt == '' && orders.order.deleted == 0 }">
					<td class="text-center"><c:if
							test="${ orders.order.status == 1 }">
							<c:if test="${ orders.order.deleted == 0 }">
								<button type="button" class="btn btn-info"
									data-bs-toggle="modal"
									data-bs-target="#edit_${ orders.order.id }">Xác nhận</button>
								<div class="modal fade" id="edit_${ orders.order.id }"
									tabindex="-1" aria-labelledby="exampleModalLabel"
									aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<form
												action="/SOF3021_ASM/admin/order/edit/${ orders.order.id }"
												method="post">
												<div class="modal-header">
													<h5 class="modal-title" id="exampleModalLabel">Xác
														nhận</h5>
													<button type="button" class="btn-close"
														data-bs-dismiss="modal" aria-label="Close"></button>
												</div>
												<div class="modal-body">Bạn có muốn xác nhận đơn hàng
													này không?</div>
												<div class="modal-footer">
													<a type="button" class="btn btn-secondary"
														data-bs-dismiss="modal">Hủy</a>
													<button class="btn btn-primary">Xác nhận và in hóa
														đơn</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</c:if>
						</c:if> <!-- VẬN CHUYỂN --> <c:if test="${ orders.order.status == 2 }">
							<button type="button" class="btn btn-warning"
								data-bs-toggle="modal"
								data-bs-target="#ship_${ orders.order.id }">Giao hàng</button>
							<div class="modal fade" id="ship_${ orders.order.id }"
								tabindex="-1" aria-labelledby="exampleModalLabel"
								aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<form
											action="/SOF3021_ASM/admin/order/ship/${ orders.order.id }"
											method="post">
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalLabel">Xác nhận</h5>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">Bạn có muốn vận chuyển đơn hàng
												này không?</div>
											<div class="modal-footer">
												<a type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">Hủy</a>
												<button class="btn btn-primary">Xác nhận</button>
											</div>
										</form>
									</div>
								</div>
							</div>
						</c:if></td>
				</c:if>


				<!-- XÓA -->

				<c:if test="${ stt == 1  || stt=='' && orders.order.deleted == 0 }">
					<td class="text-center"><c:if
							test="${ orders.order.status == 1 }">
							<c:if test="${ orders.order.deleted == 0 }">
								<button type="button" class="btn btn-danger"
									data-bs-toggle="modal"
									data-bs-target="#exampleModal_${ orders.order.id }">Hủy
									đơn hàng</button>
								<div class="modal fade" id="exampleModal_${ orders.order.id }"
									tabindex="-1" aria-labelledby="exampleModalLabel"
									aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalLabel">Delete</h5>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">Bạn có muốn hủy đơn hàng này
												không?</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">Close</button>
												<a type="button"
													href="/SOF3021_ASM/admin/order/delete/${ orders.order.id }"
													class="btn btn-danger">Hủy đơn hàng</a>
											</div>
										</div>
									</div>
								</div>
							</c:if>
						</c:if></td>
				</c:if>
			</tr>

		</c:forEach>
	</tbody>

</table>

<div class="row">
	<div class="Page navigation example">
		<ul class="justify-content-center pagination">
			<li class="page-item"><a class="page-link"
				href="/SOF3021_ASM/admin/order/index"><i
					class="fas fa-angle-double-left"></i> </a></li>
			<li class="page-item"><a class="page-link"
				href="${ data.number ==0 ? '' :'/SOF3021_ASM/admin/order/index?page='}${ data.number == 0? '#' : data.number -1}">
					<i class="fas fa-angle-left"></i>
			</a></li>
			<li class="page-item"><a class="page-link">${ data.number + 1}</a>
			</li>
			<li class="page-item"><a class="page-link"
				href="${ data.number == data.totalPages - 1  ? '' :'/SOF3021_ASM/admin/order/index?page='}${ data.number == data.totalPages - 1? '#' :data.number + 1 }"><i
					class="fas fa-angle-right"></i></a></li>
			<li class="page-item"><a class="page-link"
				href="/SOF3021_ASM/admin/order/index?page=${ data.totalPages -1 }"><i
					class="fas fa-angle-double-right"></i></a></li>
		</ul>
	</div>
	<div class="col-6"></div>
</div>