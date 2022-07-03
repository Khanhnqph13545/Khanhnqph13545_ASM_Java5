<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
	<h3>THÊM SẢN PHẨM</h3>
	<hr>
	<form:form method="POST"
		action="/SOF3021_ASM/admin/product/store"
		modelAttribute="product" enctype="multipart/form-data">
		<div class="mb-2">
			<label class="mb-2" class="mb-2">Name</label>
			<form:input class="form-control" path="name" />
			<form:errors path="name" class="text-danger"></form:errors>
		</div>
		<div class="mb-2">
			<label class="mb-2">Price</label>
			<form:input class="form-control" path="price" type="number" />
			<form:errors path="price" class="text-danger"></form:errors>
		</div>
		<div class="mb-2">
			<label class="mb-2">Available</label>
			<form:input class="form-control" path="available" type="number" />
			<form:errors path="available" class="text-danger"></form:errors>
		</div>
		<div class="mb-2">
			<label class="mb-2">Category</label>
			<form:select class="form-select" path="category">
				<form:options items="${ categories }" itemLabel="name" itemValue="id"></form:options>
			</form:select>
		</div>
		<div class="mb-2">
			<label class="mb-2">Photo</label>
			<form:input class="form-control" type="file"  path="" name="file" />
		</div>
		<div class="">
		<button class="btn btn-success" style="width: 100px">Thêm</button>
		<a href="/SOF3021_ASM/admin/product/index" class="btn btn-danger">Hủy</a>
		</div>
	</form:form>