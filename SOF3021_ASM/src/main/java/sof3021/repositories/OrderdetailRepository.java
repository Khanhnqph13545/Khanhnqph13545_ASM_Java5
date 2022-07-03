package sof3021.repositories;


import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import sof3021.bean.Order;
import sof3021.bean.Orderdetail;
import sof3021.bean.Product;
import sof3021.bean.Report;
import sof3021.bean.Statistical;

public interface OrderdetailRepository extends JpaRepository<Orderdetail, Integer> {
		@Query("SELECT od FROM Orderdetail od WHERE od.order = :order and od.product = :product")
		public Orderdetail selectByPro(@Param("order") Order order, @Param("product") Product product);
		
		@Query("SELECT new Statistical(d.product, sum(d.quantity)) FROM Orderdetail d where d.order.status>1 GROUP BY d.product ORDER BY sum(d.quantity) DESC ")
		public Page<Statistical> staticticalByProduct(Pageable pageable);
		
		@Query("SELECT new Report(d.product, sum(d.quantity*d.price)) FROM Orderdetail d where d.order.status>1 GROUP BY d.product ORDER BY sum(d.quantity*d.price) DESC ")
		public Page<Report> reportByProduct(Pageable pageable);
}
