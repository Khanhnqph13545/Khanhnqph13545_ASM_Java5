package sof3021.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import sof3021.bean.Account;
import sof3021.bean.Category;
import sof3021.bean.Product;

public interface ProductRepository extends JpaRepository<Product, Integer> {
	@Query("SELECT p FROM Product p WHERE p.deleted = 0 and p.category.deleted = 0 and p.name like %:name%")
	public Page<Product> selectAll(Pageable pageable,@Param("name") String name);

	
	@Query("SELECT p FROM Product p WHERE p.deleted = 0 and  p.name like %:name%")
	public List<Product> selectByKeyword(@Param("name") String name);
	
	@Query("SELECT p FROM Product p WHERE p.deleted = 0 and p.category = :category")
	public Page<Product> selectByCate(@Param("category") Category cate, Pageable pageable);
	
	@Query("SELECT p FROM Product p WHERE p.deleted = 0 and p.category.deleted = 0")
	public List<Product> selectAll();
}
