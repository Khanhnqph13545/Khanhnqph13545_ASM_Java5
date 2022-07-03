<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<h2>QUẢN LÝ SẢN PHẨM</h2>
<hr>


<div class="row">
	<div class="col-8 row">
	
	<span class="col-auto"><a class=" btn btn-success"
		href="/SOF3021_ASM/admin/product/create">Thêm</a></span>
	<div class="col-auto">	
		<form action="/SOF3021_ASM/admin/product/index" method="get" class="row" >
			<div class="col-8">
				<input type="text" name="search" class="form-control">			
			</div>
			<div class="col-auto"> 
				<button class=" btn btn-outline-dark ">Tìm kiếm</button>			
			</div>
			</form>
	</div>
	</div>
	<div class="col-4 text-end">
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
			<th colspan="2">Action</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${ data.content }" var="pro" varStatus="index">
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
				<td><a class="btn btn-info"
					href="/SOF3021_ASM/admin/product/edit/${ pro.id }">Sửa</a></td>
				<td>
					<button type="button" class="btn btn-danger" data-bs-toggle="modal"
						data-bs-target="#exampleModal_${ pro.id }">Xóa</button>
					<div class="modal fade" id="exampleModal_${ pro.id }" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">Delete</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">Bạn có muốn xóa sản phẩm này
									không?</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Hủy</button>
									<a type="button"
										href="/SOF3021_ASM/admin/product/delete/${ pro.id }"
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

<div class="row">
	<div class="Page navigation example">
		<ul class="justify-content-center pagination">
			<li class="page-item"><a class="page-link"
				href="/SOF3021_ASM/admin/product/index"><i
					class="fas fa-angle-double-left"></i> </a></li>
			<li class="page-item"><a class="page-link"
				href="${ data.number ==0 ? '' :'/SOF3021_ASM/admin/product/index?page='}${ data.number == 0? '#' : data.number -1}">
					<i class="fas fa-angle-left"></i>
			</a></li>
			<li class="page-item"><a class="page-link">${ data.number + 1}</a>
			</li>
			<li class="page-item"><a class="page-link"
				href="${ data.number == data.totalPages - 1  ? '' :'/SOF3021_ASM/admin/product/index?page='}${ data.number == data.totalPages - 1? '#' :data.number + 1 }"><i
					class="fas fa-angle-right"></i></a></li>
			<li class="page-item"><a class="page-link"
				href="/SOF3021_ASM/admin/product/index?page=${ data.totalPages -1 }"><i
					class="fas fa-angle-double-right"></i></a></li>
		</ul>
	</div>
	<div class="col-6"></div>
</div>