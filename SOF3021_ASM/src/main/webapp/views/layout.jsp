<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SATOSHOP</title>
<link rel="stylesheet" href="/SOF3021_ASM/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/SOF3021_ASM/fontawesome-free-5.15.4-web/css/all.min.css">
<style>
.navbar-light .navbar-nav .nav-link {
	color: #000;
}

@font-face {
	font-family: pacifico;
	src: url(/SOF3021_ASM/font/Pacifico-Regular.ttf);
}
</style>
</head>
<body ng-app="myapp" style="background-color: #fff">
	<!-- Navbar -->
	<nav
		class="navbar navbar-expand-lg fixed-top bg-primary text-white navbar-light mb-5">
		<div class="container">
			<a class="navbar-brand" href="/SOF3021_ASM/home"
				style="font-size: 25px; font-family: pacifico; color: black;">SATO
				SHOP</a>
			<button class="navbar-toggler" type="button"
				data-mdb-toggle="collapse" data-mdb-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto align-items-center">
					<c:if
						test="${ !empty sessionScope.user && sessionScope.user.admin ==0  }">
						<li class="nav-item"><a class="nav-link mx-2"
							href="/SOF3021_ASM/user/order/index"><i
								class="fas fa-cart-plus"></i> Đơn hàng </a></li>
					</c:if>
					<c:if test="${ sessionScope.user.admin==1 }">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
							role="button" data-bs-toggle="dropdown" aria-expanded="false">
								<i class="fas fa-user me-2"></i>Quản lý
						</a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<li><a class="dropdown-item"
									href="/SOF3021_ASM/admin/account/index">Account</a></li>
								<li><a class="dropdown-item"
									href="/SOF3021_ASM/admin/product/index">Product</a></li>
								<li><a class="dropdown-item"
									href="/SOF3021_ASM/admin/category/index">Category</a></li>
								<li><a class="dropdown-item"
									href="/SOF3021_ASM/admin/order/index">Order</a></li>
								<li><a class="dropdown-item"
									href="/SOF3021_ASM/admin/discount/index">Discount</a></li>
							</ul></li>
					</c:if>
					<c:if
						test="${ !empty sessionScope.user && sessionScope.user.admin ==0 }">
						<li class="nav-item"><a class="nav-link mx-2"
							href="/SOF3021_ASM/user/cart/index"><i
								class="fas fa-cart-plus"></i>Giỏ hàng </a></li>
					</c:if>
					<c:if test="${ empty sessionScope.user }">
						<li class="nav-item ms-3"><a class="btn btn-dark btn-rounded"
							href="/SOF3021_ASM/login">Đăng nhập</a></li>
					</c:if>
					<c:if test="${ !empty sessionScope.user }">
						<li class="nav-item ms-3"><a class="btn btn-dark btn-rounded"
							href="/SOF3021_ASM/login">Đăng xuất</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Navbar -->


	<div class="mt-5 pt-4 container shadow-lg pb-3 p-5"
		style="border-radius: 15px;">
		<c:if test="${ !empty sessionScope.error }">
			<div class="alert alert-danger">${ sessionScope.error }</div>
			<c:remove var="error" scope="session" />
		</c:if>
		<c:if test="${ !empty sessionScope.message }">
			<div class="alert alert-success">${ sessionScope.message	 }</div>
			<c:remove var="message" scope="session" />
		</c:if>
		<jsp:include page="${ view }"></jsp:include>
	</div>
	<script src="/SOF3021_ASM/js/angularjs.min.js"></script>
	<script src="/SOF3021_ASM/js/jquery.min.js"></script>
	<script src="/SOF3021_ASM/js/popper.min.js"></script>
	<script src="/SOF3021_ASM/js/bootstrap.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.8.0/chart.min.js"
		integrity="sha512-sW/w8s4RWTdFFSduOTGtk4isV1+190E/GghVffMA9XczdJ2MDzSzLEubKAs5h0wzgSJOQTRYyaz73L3d6RtJSg=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script>
		var app = angular.module("myapp",[]);
		app.controller("homeCtrl",function($scope,$http){
			$scope.serach = function(event){
				event.preventDefault();
					$scope.show = false;
					$scope.message ="";
					$scope.user = [];
					$http.get("http://localhost:8080/SOF3021_ASM/search?keyword="+$scope.keyword)
					.then(function(response){
						$scope.user = response.data;
						$scope.show = true;
					})
					.catch(function(error) {
                        $scope.message = "Không có khách hàng";
                    });
			}
		});
		app.controller("orderCtrl",function($scope,$http){
			$scope.show = false;
			$scope.serachpro = function(event){
				event.preventDefault();
				$scope.message ="";
				$scope.user = [];
				$http.get("http://localhost:8080/SOF3021_ASM/admin/order/search?keyword="+$scope.keyword)
				.then(function(response){
					$scope.products = response.data;
					$scope.show = true;
				})
				.catch(function(error) {
					$scope.show = false;
                });
			}
		})
		
		
		app.controller("salesCtrl",function($scope,$http){
			$scope.start = new Date();
			$scope.end = new Date();
			const ctx = document.getElementById('myChart').getContext('2d');
			var myChart = new Chart(ctx, {
	    	type: 'bar', 
	   		data: {},
	    		options: {
	        scales: {
	    		        y: {
	                beginAtZero: true
	            }
	     		   }
	    		}
				});
		$scope.search = function(event){
					event.preventDefault();
					$scope.show = false;
					$scope.message ="";
					$scope.sales = [];
					$scope.label = [];
					$scope.data = [];
					$http.get("http://localhost:8080/SOF3021_ASM/admin/sales/search?start="+$scope.start+"&end="+$scope.end)
					.then(function(response){
						$scope.sales = response.data;
						$scope.show = true;
						for (let i = 0; i < $scope.sales.length; i++) {
							console.log($scope.sales[i].ngay);
							$scope.label.push($scope.sales[i].ngay);
							$scope.data.push($scope.sales[i].tongDoanhThu);
						}
						myChart.data = {
					        labels: $scope.label,
					        datasets: [{
					            label: 'Tổng doanh thu',
					            data: $scope.data,
					            backgroundColor: [
					            	'rgba(0, 0, 255, 0.1)'
					            ],
					            borderColor: [
					                'rgba(0, 0, 255, 0.1)'
					            ],
					            borderWidth: 1
					        	}]
					  	 	 };
						myChart.update();
						})
					.catch(function(error) {
                        $scope.message = "Không có dữ liệu";
                    });
		}
		})
		
		
	</script>
</body>
</html>