package sof3021.bean;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Negative;
import javax.validation.constraints.NegativeOrZero;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.PositiveOrZero;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Entity
@Table(name = "Products")
public class Product implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;

	@NotBlank ( message = "Không được để trống name")
	@Column(name = "name")
	private String name;

	@Column(name = "image")
	private String image;

	@NotNull ( message = "Không được để trống price")
	@Min(value = 1, message = "Price phải lớn hơn 0")
	@Max(value = Integer.MAX_VALUE-1, message = "Price nhỏ hơn " + Integer.MAX_VALUE)
	@Column(name = "price")
	private int price;

	@NotNull(message = "Không được để trống available")
	@Min(value = 1, message = "Available phải lớn hơn 0")
	@Max(value = Integer.MAX_VALUE-1, message = "Available nhỏ hơn " + Integer.MAX_VALUE)
	@Column(name = "available")
	private int available;

	@Column(name = "deleted")
	private int deleted;

	@Temporal(TemporalType.DATE)
	@Column(name = "created_date")
	Date createDate = new Date();

	@ManyToOne
	@JoinColumn(name = "category_id")
	private Category category;
	
	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY , mappedBy = "product")
	private List<Orderdetail> listOrderdetail;
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getAvailable() {
		return available;
	}

	public void setAvailable(int available) {
		this.available = available;
	}

	public int getDeleted() {
		return deleted;
	}

	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}
	
	@JsonIgnore
	public List<Orderdetail> listOrderdetail() {
		return listOrderdetail;
	}

	public void setOrderdetailPro(List<Orderdetail> orderdetailPro) {
		listOrderdetail = orderdetailPro;
	}

}
