package sof3021.repositories;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import sof3021.bean.Account;
import sof3021.bean.Order;
import sof3021.bean.OrderRP;
import sof3021.bean.Sales;

public interface OrderRepository extends JpaRepository<Order, Integer> {
	@Query("SELECT new OrderRP( o.order, sum(o.price * o.quantity))" + " FROM Orderdetail o"
			+ " WHERE  o.order.status > 0" + " GROUP BY o.order ORDER BY o.order.createDate DESC"  )
	public List<OrderRP> orders();	
	
	@Query("SELECT new OrderRP( o.order, sum(o.price * o.quantity))" + " FROM Orderdetail o"
			+ " WHERE o.order.status > 0 and o.order.account =:account" + " GROUP BY o.order ORDER BY o.order.createDate DESC")
	public List<OrderRP> selectByUser(@Param("account") Account acc);	

	@Query("SELECT new OrderRP( o.order, sum(o.price * o.quantity))" + " FROM Orderdetail o"
			+ " WHERE o.order.deleted = 0 and o.order.status = 0 and o.order.account = :account" + " GROUP BY o.order")
	public OrderRP selectTotal(@Param("account") Account acc);
	
	@Query("SELECT new OrderRP( o.order, sum(o.price * o.quantity))" + " FROM Orderdetail o"
			+ " WHERE o.order.deleted = 0 and o.order.status = 1" + " GROUP BY o.order")
	public List<OrderRP> selectSort(Sort sort);
	
	@Query("SELECT o FROM Order o WHERE o.account = :account and status = 0")
	public Order selectByAcc(@Param("account") Account acc);
	
	@Query("SELECT new OrderRP( o.order, sum(o.price * o.quantity))" + " FROM Orderdetail o"
			+ " WHERE o.order.status = :status and o.order.deleted =:deleted and o.order.account =:account" + " GROUP BY o.order ORDER BY o.order.createDate DESC")
	public List<OrderRP> selectByStatusAndAcc(@Param("account") Account acc,@Param("status") int status,@Param("deleted") int deleted);
	
	@Query("SELECT new OrderRP( o.order, sum(o.price * o.quantity))" + " FROM Orderdetail o"
			+ " WHERE o.order.status = :status and o.order.deleted =:deleted GROUP BY o.order ORDER BY o.order.createDate DESC")
	public List<OrderRP> selectAllByStatus(@Param("status") int status,@Param("deleted") int deleted);
	
	@Query("SELECT new Sales( o.order.createDate, sum(o.quantity * o.price)) FROM Orderdetail o WHERE o.order.createDate BETWEEN :start and :end and o.order.deleted = 0 and o.order.status > 1 group by o.order.createDate")
	public List<Sales> selectDaySales(@Param("start") Date start, @Param("end") Date end );
	
}
