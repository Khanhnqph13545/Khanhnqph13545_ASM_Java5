<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<h2>QUẢN LÝ MÃ GIẢM GIÁ</h2>
<hr>
<span class="col-auto"><a class=" btn btn-success"
		href="/SOF3021_ASM/admin/discount/create">Thêm</a></span>
		<hr>
<table class=" mt-3 table table-bordered container text-center">
	<thead class="text-center"> 
		<tr>
			<th>#</th>
			<th>Mã giảm giá</th>
			<th>Ngày bắt đầu</th>
			<th>Ngày kết thúc</th>
			<th>Áp dụng</th>
			<th>Giảm giá</th>
			<th>Giảm tối đa</th>
			<th colspan="2">Action</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${ data }" var="dis" varStatus="index">
			<tr>
				<td class="text-center fw-bold">${ index.count }</td>
				<td>${ dis.name }</td>
				<td><fmt:formatDate value="${ dis.createDate }" pattern="dd/MM/yyyy" /></td>
				<td><fmt:formatDate value="${ dis.endDate }" pattern="dd/MM/yyyy" /> </td>
				<td>Đơn hàng từ <fmt:formatNumber value="${ dis.toiThieu }" pattern="#,###"></fmt:formatNumber>
					₫</td>
				<td>${ dis.value }%</td>
				<td>Tối đa <fmt:formatNumber value="${ dis.maximum }" pattern="#,###"></fmt:formatNumber>
					₫ </td>
				<td><a class="btn btn-info"
					href="/SOF3021_ASM/admin/discount/edit/${ dis.id }">Sửa</a></td>
				<td>
					<button type="button" class="btn btn-danger" data-bs-toggle="modal"
						data-bs-target="#exampleModal_${ dis.id }">Xóa</button>
					<div class="modal fade" id="exampleModal_${ dis.id }" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">Delete</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">Bạn có muốn xóa mã giảm giá này
									không?</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Hủy</button>
									<a type="button"
										href="/SOF3021_ASM/admin/discount/delete/${ dis.id }"
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