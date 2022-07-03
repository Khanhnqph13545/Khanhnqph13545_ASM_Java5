package sof3021.bean;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
@Entity
@Table(name = "discount")
public class Discount implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;

	@NotBlank(message = "Không được để trống")
	@Column(name = "name")
	private String name;
	
	
	@Temporal(TemporalType.DATE)
	@Column(name="start_date")
	Date createDate = new Date();
	
	@Temporal(TemporalType.DATE)
	@Column(name="end_date")
	Date endDate = new Date();
	
	@NotNull ( message = "Không được để trống")
	@Min(value = 1, message = "Phải lớn hơn 0")
	@Max(value = Integer.MAX_VALUE-1, message = "Price nhỏ hơn " + Integer.MAX_VALUE)
	@Column(name = "minimum")
	private int toiThieu;
	
	@NotNull ( message = "Không được để trống")
	@Min(value = 1, message = "Phải lớn hơn 0")
	@Max(value = Integer.MAX_VALUE-1, message = "Price nhỏ hơn " + Integer.MAX_VALUE)
	@Column(name = "maximum")
	private int maximum;
	
	@Column(name = "value")
	private int value;
}
