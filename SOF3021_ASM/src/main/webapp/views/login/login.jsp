<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true" %>
	<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<form method="post"
	action="/SOF3021_ASM/login"
	class="text-center">
	<div class="rounded bg-light text-center p-4 pb-2 m-auto"
		style="max-width: 700px">
		<c:remove var="user" scope="session" />
		<h1>Đăng nhập</h1>
		<h3>Vui lòng nhập tài khoản và mật khẩu</h3>
		<div class="form-floating mb-3">
			<input type="text"
				class="form-control ng-pristine ng-valid ng-empty ng-touched"
				name="username" placeholder=" "> <label><i
				class="fas fa-user me-2"></i>Tài khoản</label>
		</div>
		<div class="form-floating ">
			<input type="password"
				class="form-control ng-pristine ng-untouched ng-valid ng-empty"
				name="password" placeholder=" "> <label><i
				class="fas fa-lock me-2"></i> Password</label>
		</div>
				<span class="text-danger text-start">${ sessionScope.loginfail }</span>
				<c:remove var="loginfail" scope="session"/>
		<div class="mt-3">
			<button class="btn btn-primary rounded form-control">Đăng
				nhập</button>
		</div>
		<p class="text-end">
			Bạn chưa có tài khoản?<a href="/SOF3021_ASM/register"
				style="color: red;">Đăng ký</a>
		</p>
	</div>
</form>
</body>