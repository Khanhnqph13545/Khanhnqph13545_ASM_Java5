<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<h2>HÓA ĐƠN CHI TIẾT</h2>
<hr>

<div class="row">
	<div class="col-6">
		<%-- <button type="button" class="btn btn-success" data-bs-toggle="modal"
			data-bs-target="#createCate">Thêm</button>
		<div class="modal fade " id="createCate" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-xl modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">DANH SÁCH SẢN
							PHẨM</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div>
							<jsp:include page="/views/admin//orderdetail/create.jsp"></jsp:include>
						</div>
					</div>
				</div>
			</div>
		</div> --%>
	</div>
	<div class="col-6 text-end"> <a class="btn btn-danger" href="/SOF3021_ASM/admin/order/index"> trở về</a> </div>
</div>
<table class=" mt-3 table table-bordered container text-center">
	<thead class="text-center">
		<tr>
			<th>#</th>
			<th>Product</th>
			<th>Price</th>
			<th>Quantity</th>
			<th>Total</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${ orders.order.OrderdetailOrder }" var="ordt" varStatus="index">
			<tr>
				<td class="text-center fw-bold">${ index.count }</td>
				<td>${ ordt.product.name}</td>
				<td><fmt:formatNumber value="${ ordt.price }" pattern="#,###"></fmt:formatNumber>
					₫</td>
				<td>
					${ ordt.quantity }
					<%-- <form action="/SOF3021_ASM/admin/orderdetail/update/${ ordt.id }"
						class="text-center">
						<div>
							<input name="qtt" value="${ ordt.quantity }"
								onblur="this.form.submit()"
								class="form-control m-auto text-center" style="width: 70px">
						</div>
					</form> --%>
				</td>
				<td><fmt:formatNumber value="${ ordt.price * ordt.quantity }"
						pattern="#,###"></fmt:formatNumber> ₫</td>
				<%-- <td class="text-center">
					<button type="button" class="btn btn-danger" data-bs-toggle="modal"
						data-bs-target="#exampleModal_${ acc.id }">Xóa</button>
					<div class="modal fade" id="exampleModal_${ acc.id }" tabindex="-1"
						aria-labelledby="exampleModalLabel2" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel2">Delete</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">Bạn có muốn xóa hóa đơn này không?</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Hủy</button>
									<a type="button"
										href="/SOF3021_ASM/admin/orderdetail/delete/${ ordt.id }"
										class="btn btn-primary">Xóa</a>
								</div>
							</div>
						</div>
					</div>
				</td> --%>
			</tr>

		</c:forEach>
	</tbody>
</table>


