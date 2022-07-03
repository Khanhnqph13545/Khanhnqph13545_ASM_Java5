<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<div ng-controller="salesCtrl">
	<form ng-submit="search($event)" action="/SOF3021_ASM/admin/sales/search"  method="get">
		<label>Ngày bắt đầu:</label>
		<input  type="date" id="start" ng-model="start" >
		<label>Ngày kết thúc:</label>
		<input  type="date" id="end" ng-model="end" >
		<button class="btn btn-success"> Thống kê </button>
	</form>
		<canvas id="myChart" width="400" height="200"></canvas>
		</div>