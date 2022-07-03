<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
	<h3>THÊM SẢN PHẨM</h3>
	<hr>
	<form:form method="POST"
		action="/SOF3021_ASM/admin/discount/store"
		modelAttribute="discount">
		<div class="mb-2">
			<label class="mb-2" class="mb-2">Mã giảm giá</label>
			<form:input class="form-control" path="name" />
			<form:errors path="name" class="text-danger"></form:errors>
		</div>
		<div class="mb-2">
			<label class="mb-2">Ngày bắt đầu</label>
			<form:input class="form-control" path="" name="start" type="date" />
		</div>
		<div class="mb-2">
			<label class="mb-2">Ngày kết thúc</label>
			<form:input class="form-control" path="" name="end" type="date" />
		</div>
		<div class="mb-2">
			<label class="mb-2">Đơn hàng áp dụng</label>
			<form:input class="form-control" path="toiThieu" type="number" />
			<form:errors path="toiThieu" class="text-danger"></form:errors>
		</div>
		<div class="mb-2">
			<label class="mb-2">Giảm giá</label>
			<form:select path="value" class="form-select">
				<form:option value="5">5%</form:option>
				<form:option value="10">10%</form:option>
				<form:option value="15">15%</form:option>
				<form:option value="20">20%</form:option>
				<form:option value="25">25%</form:option>
				<form:option value="30">30%</form:option>
				<form:option value="35">35%</form:option>
				<form:option value="40">40%</form:option>
				<form:option value="45">45%</form:option>
				<form:option value="50">50%</form:option>
				<form:option value="55">55%</form:option>
				<form:option value="60">60%</form:option>
				<form:option value="65">65%</form:option>
				<form:option value="70">70%</form:option>
				<form:option value="75">75%</form:option>
				<form:option value="80">80%</form:option>
				<form:option value="85">85%</form:option>
				<form:option value="90">90%</form:option>
				<form:option value="95">95%</form:option>
				<form:option value="100">100%</form:option>
			</form:select>
		</div>
		<div class="mb-2">
			<label class="mb-2">Giảm tối đa</label>
			<form:input class="form-control" path="maximum" type="number" />
			<form:errors path="maximum" class="text-danger"></form:errors>
			<form:errors path="*"></form:errors>
		</div>
		<div class="">
		<button class="btn btn-success" style="width: 100px">Thêm</button>
		<a href="/SOF3021_ASM/admin/discount/index" class="btn btn-danger">Hủy</a>
		</div>
	</form:form>