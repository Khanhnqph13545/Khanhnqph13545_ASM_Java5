<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
	<h3>SỬA NGƯỜI DÙNG</h3>
	<hr>
	<form:form method="POST"
		action="/SOF3021_ASM/admin/account/store"
		modelAttribute="account" enctype="multipart/form-data">
		<form:hidden class="form-control"  path="id" />
		<div class="mb-2">
			<label class="mb-2" class="mb-2">Fullname</label>
			<form:input class="form-control" path="fullname" />
			<form:errors path="fullname" class="text-danger"></form:errors>
		</div>
		<div class="mb-2">
			<label class="mb-2">Email</label>
			<form:input class="form-control" path="email" type="email" />
			<form:errors path="email" class="text-danger"></form:errors>
		</div>
		<div class="mb-2">
			<label class="mb-2">Username</label>
			<form:input class="form-control" path="username" />
			<form:errors path="username" class="text-danger"></form:errors>
		</div>	
		<div class="mb-2">
			<label class="mb-2">Password</label>
			<form:hidden class="form-control" path="password" />
		</div>
		<div class="mb-2">
			<label class="mb-2">Photo</label>
			<form:hidden path="photo"/>
			<form:input class="form-control" type="file" path="" name="file" />
		</div>
		<div class="mb-2">
			<label class="mb-2">Admin</label>
			<form:select class="form-select" path="admin">
				<form:option value="0">Member</form:option>
				<form:option value="1">Admin</form:option>
			</form:select>
		</div>
		<div class="">
		<button class="btn btn-success" style="width: 100px">Sửa</button>
		<a href="/SOF3021_ASM/admin/account/index" class="btn btn-danger">Hủy</a>
		</div>
	</form:form>