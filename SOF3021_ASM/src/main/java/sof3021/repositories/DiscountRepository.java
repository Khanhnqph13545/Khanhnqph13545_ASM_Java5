package sof3021.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import sof3021.bean.Discount;

public interface DiscountRepository extends JpaRepository<Discount, Integer>{
	
	public Discount findByNameEquals(String name);
}
