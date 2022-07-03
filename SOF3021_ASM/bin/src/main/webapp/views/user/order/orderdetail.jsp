<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<h2>HÓA ĐƠN CHI TIẾT</h2>
<hr>

<div class="row">
	<div class="col-6">
	</div>
	<div class="col-6 text-end"> <a class="btn btn-danger" href="/SOF3021_ASM/user/order/index"> trở về</a> </div>
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
		<c:forEach items="${ listOrderdt }" var="ordt" varStatus="index">
			<tr>
				<td class="text-center fw-bold">${ index.count }</td>
				<td>${ ordt.product.name}</td>
				<td><fmt:formatNumber value="${ ordt.price }" pattern="#,###"></fmt:formatNumber>
					₫</td>
				<td>
					${ ordt.quantity }
				</td>
				<td><fmt:formatNumber value="${ ordt.price * ordt.quantity }"
						pattern="#,###"></fmt:formatNumber> ₫</td>
			</tr>

		</c:forEach>
	</tbody>
</table>