package sof3021.controllers;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import sof3021.bean.Account;
import sof3021.bean.Discount;
import sof3021.bean.Order;
import sof3021.bean.OrderRP;
import sof3021.bean.Orderdetail;
import sof3021.bean.Product;
import sof3021.repositories.DiscountRepository;
import sof3021.repositories.OrderRepository;
import sof3021.repositories.OrderdetailRepository;
import sof3021.repositories.ProductRepository;
import sof3021.service.SessionService;

@Controller
@RequestMapping("/user/cart")
public class CartController {
	@Autowired
	ProductRepository proRepo;
	@Autowired
	OrderRepository orderRepo;
	@Autowired
	SessionService session;
	@Autowired
	OrderdetailRepository orderdtRepo;
	@Autowired
	DiscountRepository dcRepo;
	
	@GetMapping("index")
	public String indexCart(Model model) {
		List<Product> listProduct = this.proRepo.selectAll();
		model.addAttribute("listPro", listProduct);
		Account acc = this.session.get("user");
		Order order = this.orderRepo.selectByAcc(acc);
		OrderRP orderRP = this.orderRepo.selectTotal(acc);
		model.addAttribute("orderRP", orderRP);
		if (order == null) {
			order = new Order();
			order.setAccount(acc);
			order.setAddress("");
			order = this.orderRepo.save(order);
		} else {
			List<Orderdetail> listOrdt = order.getOrderdetailOrder();
			model.addAttribute("listOrderdt", listOrdt);
		}
		this.orderRepo.save(order);
		model.addAttribute("account", acc);
		model.addAttribute("order", order);
		model.addAttribute("view", "/views/user/cart/index.jsp");
		return "layout";
	}

	@GetMapping("create")
	public String createOrder(Model model, @RequestParam("id") Product pro) {
		List<Product> listProduct = this.proRepo.selectAll();
		model.addAttribute("listPro", listProduct);
		Account acc = this.session.get("user");
		Order order = this.orderRepo.selectByAcc(acc);
		OrderRP orderRP = this.orderRepo.selectTotal(acc);
		model.addAttribute("orderRP", orderRP);
		if (order == null) {
			order = new Order();
			order.setAccount(acc);
			order.setAddress("");
			order = this.orderRepo.save(order);
			Orderdetail orderdt = this.orderdtRepo.selectByPro(order, pro);
			orderdt = new Orderdetail();
			orderdt.setOrder(order);
			orderdt.setProduct(pro);
			orderdt.setPrice(pro.getPrice());
			orderdt.setQuantity(1);
			this.orderdtRepo.save(orderdt);
		} else {
			Orderdetail orderdt = this.orderdtRepo.selectByPro(order, pro);
			if (orderdt == null) {
				orderdt = new Orderdetail();
				orderdt.setOrder(order);
				orderdt.setProduct(pro);
				orderdt.setPrice(pro.getPrice());
				orderdt.setQuantity(1);
				this.orderdtRepo.save(orderdt);
			} else {
				orderdt.setQuantity(orderdt.getQuantity() + 1);
				this.orderdtRepo.save(orderdt);
			}
		}
		this.session.set("message","Thêm vào giỏ hàng thành công");
		return "redirect:/home";
	}

	@GetMapping("update/{id}")
	public String update(@PathVariable("id") Orderdetail orderdt, @RequestParam("qtt") String qtt) {
		try {
			int quantity = Integer.parseInt(qtt);
			if (quantity < 1) {
				return "redirect:/user/cart/index";
			}
			orderdt.setQuantity(quantity);
			this.orderdtRepo.save(orderdt);
			return "redirect:/user/cart/index";			
		} catch (Exception e) {
			return "redirect:/user/cart/index";
		}
	}
	
	@GetMapping("delete/{id}")
	public String delete(@PathVariable("id") Orderdetail orderdt) {
		this.orderdtRepo.delete(orderdt);
		this.session.set("message", "Xóa thành công");
		return "redirect:/user/cart/index";
	}
	
	@PostMapping("payment/{id}")
	public String payment(@PathVariable("id") Order order,@RequestParam("address") String address) {
		order.setAddress(address);
		order.setCreateDate(new Date());
		order.setStatus(1);
		this.orderRepo.save(order);
		this.session.set("message", "Đặt hàng thành công");
		return "redirect:/user/cart/index";
	}
	
	@GetMapping("discount/{id}")
	public String discount(Model model,@PathVariable("id") Order order,
			@RequestParam("discount") String discount,
			RedirectAttributes params
			) {
		if (discount == "") {
			return "redirect:/user/cart/index";
		}
		Account acc = this.session.get("user");
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Discount dc = this.dcRepo.findByNameEquals(discount);
		OrderRP orderRP = this.orderRepo.selectTotal(acc);
		if (dc == null) {
			this.session.set("discountmessage", "Mã giảm giá không đúng");
		}else {
			if (orderRP.getTotal()<dc.getToiThieu()) {
				this.session.set("discountmessage", "Áp dụng đơn hàng từ "+dc.getToiThieu()+"đ");
				return "redirect:/user/cart/index";
			}
			if (dc.getCreateDate().compareTo(new Date()) <= 0 && dc.getEndDate().compareTo(new Date()) >=0) {
				double giamgia = orderRP.getTotal() * dc.getValue();
				if (giamgia > dc.getMaximum()) {
					order.setDiscount(dc.getMaximum());
				}else {
					int km = (int) giamgia;
					order.setDiscount(km);
				}
				this.orderRepo.save(order);
				params.addAttribute("discount", true);
				params.addAttribute("ma", dc.getName());
				model.addAttribute("orderRP", orderRP);
			}else {
				this.session.set("discountmessage", "Mã giảm giá áp dụng từ "+sdf.format(dc.getCreateDate()) + " đến "+ sdf.format(dc.getEndDate()));
			}
		}
		
		return "redirect:/user/cart/index";
	}

}
