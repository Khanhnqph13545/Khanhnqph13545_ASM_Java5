package sof3021.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import sof3021.bean.Account;

public interface AccountRepository extends JpaRepository<Account, Integer> {
	
	@Query("SELECT a FROM Account a WHERE a.deleted = 0")
	public Page<Account> findAlll(Pageable pageable);
	
	@Query("SELECT a FROM Account a WHERE a.deleted = 0")
	public List<Account> findAlll();
	
	public Account findByEmailEqualsOrUsernameEquals(String email, String username);
	
	@Query("SELECT a FROM Account a WHERE a.deleted = 0 and (a.fullname like %:keyword% or a.email like %:keyword%)")
	public List<Account> selectByKeyword(@Param("keyword") String keyword);
} 
