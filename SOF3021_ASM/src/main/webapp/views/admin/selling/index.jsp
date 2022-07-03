<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<hr>
<table class=" mt-3 table table-bordered container text-center">
	<thead class="text-center">
		<tr>
			<th><a class="btn fw-bold" href="/SOF3021_ASM/admin/statistical/index">Top 10 sản phẩm bán chạy nhất</a></th>
			<th><a class="btn fw-bold"
				href="/SOF3021_ASM/admin/statistical/index?status=1">Top 10 sản phẩm doanh thu cao nhất</a>
			</th>
		</tr>
	</thead>
</table>
<hr>
<table class=" mt-3 table table-bordered container text-center">
	<thead class="text-center">
		<tr>
			<th>#</th>
			<th>Name</th>
			<th>Image</th>
			<th>Quantity</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${ statistical.content }" var="sta" varStatus="index">
			<tr>
				<td class="text-center fw-bold">${ index.count }</td>
				<td>${ sta.product.name }</td>
				<td> <img alt="" style="width: 100px"
					src="/SOF3021_ASM/images/product/${ sta.product.image }"> </td>
				<td><fmt:formatNumber value="${ sta.total }" pattern="#,###"></fmt:formatNumber>
					</td>
			</tr>
		</c:forEach>
	</tbody>

</table>