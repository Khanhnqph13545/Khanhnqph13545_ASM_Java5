package sof3021.bean;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
@Entity
@Table(name = "orders")
public class Order  implements Serializable{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private Account account;
	
	@Temporal(TemporalType.DATE)
	@Column(name="create_date")
	Date createDate = new Date();
	
	@OneToMany(mappedBy = "order")
	private List<Orderdetail> OrderdetailOrder;
	
	@Column(name = "deleted")
	private int deleted;
	
	@Column(name = "address")
	private String address;
	
	@Column(name = "status")
	private int status;
	
	@Column(name = "discount")
	private int discount;
}
