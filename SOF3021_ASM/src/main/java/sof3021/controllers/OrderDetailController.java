package sof3021.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import sof3021.bean.Order;
import sof3021.bean.Orderdetail;
import sof3021.bean.Product;
import sof3021.repositories.OrderdetailRepository;
import sof3021.repositories.ProductRepository;

@Controller
@RequestMapping("admin/orderdetail")
public class OrderDetailController {
	@Autowired
	OrderdetailRepository odetailRepo;
	@Autowired
	ProductRepository proRepo;
	
	@GetMapping("index/{id}")
	public String index(Model model, @PathVariable("id") Order order) {
		List<Product> listProduct = this.proRepo.selectAll();
		model.addAttribute("listPro", listProduct);
		List<Orderdetail> listOrdetail = order.getOrderdetailOrder();
		model.addAttribute("listOrderdt", listOrdetail);
		model.addAttribute("order", order);
		model.addAttribute("view", "/views/admin/orderdetail/index.jsp");
		return "layout";
	}
	
	@GetMapping("update/{id}")
	public String update(
			@PathVariable("id") Orderdetail orderdt,
			@RequestParam("qtt") int qtt
			) {
		orderdt.setQuantity(qtt);
		this.odetailRepo.save(orderdt);
		return "redirect:/admin/orderdetail/index/" + orderdt.getOrder().getId();
	}
	
	@GetMapping("delete/{id}")
	public String delete(@PathVariable("id") Orderdetail orderdt) {
		this.odetailRepo.delete(orderdt);	
		return "redirect:/admin/orderdetail/index/" + orderdt.getOrder().getId();
	}
	
	@GetMapping("insert")
	public String insert(
			@RequestParam("order") Order order,
			@RequestParam("product") Product product
			) {
		Orderdetail orderdt = this.odetailRepo.selectByPro(order, product);
		if (orderdt == null) {
			orderdt = new Orderdetail();
			orderdt.setOrder(order);
			orderdt.setProduct(product);
			orderdt.setPrice(product.getPrice());
			orderdt.setQuantity(1);
			this.odetailRepo.save(orderdt);
		}else {
			orderdt.setQuantity(orderdt.getQuantity()+1);
			this.odetailRepo.save(orderdt);
		}
		
		return "redirect:/admin/orderdetail/index/"+ order.getId();
	}
	
	
}
