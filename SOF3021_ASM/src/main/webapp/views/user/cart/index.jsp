<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>


<div class="row mt-2">
	<div class="col-8">
		<div class="row">
			<div class="col-6">
				<h3>Giỏ hàng</h3>
			</div>
			<div class="text-end col-6">
				<a class="btn btn-warning" href="/SOF3021_ASM/home">Tiếp tục mua
					hàng</a>
			</div>
		</div>
		<hr>
		<c:if test="${ empty listOrderdt  }">
			<h4>Giỏ hàng trống</h4>
		</c:if>
		<c:if test="${ !empty listOrderdt }">


			<table class="table table-bordered container text-center">
				<thead class="text-center">
					<tr>
						<th>#</th>
						<th>Product</th>
						<th>Price</th>
						<th>Quantity</th>
						<th>Total</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ listOrderdt }" var="ordt" varStatus="index">
						<tr>
							<td class="text-center fw-bold">${ index.count }</td>
							<td>${ ordt.product.name}</td>
							<td><fmt:formatNumber value="${ ordt.price }"
									pattern="#,###"></fmt:formatNumber> ₫</td>
							<td>
								<form action="/SOF3021_ASM/user/cart/update/${ ordt.id }"
									class="text-center">
									<div>
										<input name="qtt" value="${ ordt.quantity }"
											onblur="this.form.submit()"
											class="form-control m-auto text-center" style="width: 70px">
									</div>
								</form>
							</td>
							<td><fmt:formatNumber
									value="${ ordt.price * ordt.quantity }" pattern="#,###"></fmt:formatNumber>
								₫</td>
							<td class="text-center">
								<button type="button" class="btn btn-danger"
									data-bs-toggle="modal"
									data-bs-target="#exampleModal_${ ordt.id }">Xóa</button>
								<div class="modal fade" id="exampleModal_${ ordt.id }"
									tabindex="-1" aria-labelledby="exampleModalLabel2"
									aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalLabel2">Delete</h5>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">Bạn có muốn xóa sản phẩm này
												không?</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">Hủy</button>
												<a type="button"
													href="/SOF3021_ASM/user/cart/delete/${ ordt.id }"
													class="btn btn-primary">Xóa</a>
											</div>
										</div>
									</div>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
	<div class="col-4 border border-dark pt-1">

		<h4>Thông tin đơn hàng</h4>
		<hr>
		Khách hàng: ${ account.fullname }
		<hr>
		<form action="/SOF3021_ASM/user/cart/discount/${ order.id }"
			method="get">
			Mã giảm giá <input name="discount" value="${ param.ma }" onblur="this.form.submit()"
				class="form-control ">
			<c:if test="${ !empty sessionScope.discountmessage }">
				<div class="alert alert-danger">${ sessionScope.discountmessage }</div>
				<c:remove var="discountmessage" scope="session" />
			</c:if>
		</form>
		<hr>
		<p class="row">
			<span class="col-4">Tổng tiền: </span> <span
				class="col-8 text-end text-danger fw-bold"> <fmt:formatNumber
					value="${ orderRP.total }" pattern="#,###"></fmt:formatNumber> ₫
			</span>
			<c:if test="${ param.discount == true }">
				<span class="col-4 fs-7">Khuyến mại: </span>
				<span class="col-8 text-end text-danger fw-bold"> -<fmt:formatNumber
						value="${ orderRP.order.discount }" pattern="#,###"></fmt:formatNumber> ₫
				</span>
				<span class="col-4">Thanh toán: </span>
				<span class="col-8 text-end text-danger fw-bold"> <fmt:formatNumber
						value="${ orderRP.total - orderRP.order.discount }" pattern="#,###"></fmt:formatNumber>
					₫
				</span>
			</c:if>
		</p>
		<hr>
		<form action="/SOF3021_ASM/user/cart/payment/${ orderRP.order.id }"
			method="post">
			Địa chỉ: <input class="form-control" name="address">
			<hr>
			<a class="btn btn-dark form-control mb-2" data-bs-toggle="modal"
				data-bs-target="#payment">Thanh toán</a>
			<div class="modal fade" id="payment" tabindex="-1"
				aria-labelledby="exampleModalLabel2" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel2">Payment</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">Bạn xác nhận thanh toán?</div>
						<div class="modal-footer">
							<a type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Hủy</a>
							<button class="btn btn-primary">Xác nhận</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>