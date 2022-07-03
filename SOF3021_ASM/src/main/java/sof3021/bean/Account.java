package sof3021.bean;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Null;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
@Entity
@Table(name="accounts")
public class Account implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;
	
	@NotBlank(message = "Không được để trống username")
	@Column(name = "username")
	private String username;
	
	@NotBlank(message = "Không được để trống password")
	@Column(name = "password")
	private String password;
	
	@NotBlank(message = "Không được để trống full name")
	@Column(name = "fullname")
	private String fullname;
	
	@NotBlank(message = "Không được để trống email")
	@Email(message = "Không đúng định dạng email")
	@Column(name = "email")
	private String email;
	
	@Column(name = "photo")
	private String photo;
	
	@Column(name = "activated")
	private int activated;
	
	@Column(name = "admin")
	private int admin;
	
	@Column(name = "deleted")
	private int deleted;
	
	@JsonIgnore
	@OneToMany(mappedBy = "account")
	private List<Order> listOrder;
}

