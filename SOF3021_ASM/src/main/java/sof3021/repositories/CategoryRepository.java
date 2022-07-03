package sof3021.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import sof3021.bean.Category;

public interface CategoryRepository extends JpaRepository<Category, Integer> {
	@Query("SELECT c FROM Category c WHERE c.deleted = 0")
	public Page<Category> selectAll(Pageable pageable); 
	
	
	@Query("SELECT c FROM Category c WHERE c.deleted = 0")
	public List<Category> selectAll(); 
}
