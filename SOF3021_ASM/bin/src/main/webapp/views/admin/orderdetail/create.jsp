<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>


<div class="row">
	<div class="col text-end">
		<div class="dropdown">
			<button class="btn btn-outline-dark dropdown-toggle" type="button"
				id="dropdownMenuButton1" data-bs-toggle="dropdown"
				aria-expanded="false">Thể loại</button>
			<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
				<li><a class="dropdown-item"
					href="/SOF3021_ASM/admin/product/index">Tất cả </a></li>
				<c:forEach items="${ categories }" var="cate">
					<li><a class="dropdown-item"
						href="/SOF3021_ASM/admin/product/index?cate=${ cate.id }">${ cate.name }</a></li>
				</c:forEach>
			</ul>
		</div>

	</div>
</div>

<table class=" mt-3 table table-bordered container text-center">
	<thead class="text-center"> 
		<tr>
			<th>#</th>
			<th>Name</th>
			<th>Image</th>
			<th>Price</th>
			<th>Date</th>
			<th>Available</th>
			<th>Category</th>
			<th >Action</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${ listPro }" var="pro" varStatus="index">
			<tr>
				<td class="text-center fw-bold">${ index.count }</td>
				<td>${ pro.name }</td>
				<td class="text-center"><img alt="" style="width: 100px"
					src="/SOF3021_ASM/images/product/${ pro.image }"></td>
				<td><fmt:formatNumber value="${ pro.price}" pattern="#,###"></fmt:formatNumber>
					₫</td>
				<td>${ pro.createDate }</td>
				<td>${ pro.available }</td>
				<td>${ pro.category.name }</td>
				<td> <a class="btn btn-primary" href="/SOF3021_ASM/admin/orderdetail/insert?order=${ order.id }&product=${pro.id}">Thêm</a> </td>
			</tr>

		</c:forEach>
	</tbody>

</table>