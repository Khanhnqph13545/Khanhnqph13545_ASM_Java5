<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
	<h3>Đăng ký</h3>
	<hr>
	<form:form method="POST"
		action="/SOF3021_ASM/register"
		modelAttribute="account" enctype="multipart/form-data">
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
			<form:password class="form-control" path="password" />
			<form:errors path="password" class="text-danger"></form:errors>
		</div>
		<div class="mb-2">
			<label class="mb-2">Photo</label>
			<form:input class="form-control" type="file"  path="" name="file" />
		</div>
		<div class="">
		<button class="btn btn-success" style="width: 100px">Đăng ký</button>
		<a href="/SOF3021_ASM/login" class="btn btn-danger">Hủy</a>
		</div>
	</form:form>