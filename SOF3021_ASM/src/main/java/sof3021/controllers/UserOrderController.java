package sof3021.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import sof3021.bean.Account;
import sof3021.bean.Order;
import sof3021.bean.OrderRP;
import sof3021.bean.Orderdetail;
import sof3021.repositories.OrderRepository;
import sof3021.service.SessionService;

@Controller
@RequestMapping("/user/order")
public class UserOrderController {
	@Autowired
	OrderRepository orderRepo;
	@Autowired
	SessionService session;

	@GetMapping("index")
	public String index(Model model,@RequestParam(value = "status",defaultValue = "") String status) {
		try {
			int stt = Integer.parseInt(status);
			if (stt == 0) {
				List<OrderRP> lstOrder= this.orderRepo.selectByStatusAndAcc(this.session.get("user"),1,1);
				model.addAttribute("orders", lstOrder);
			}else {
				List<OrderRP> lstOrder = this.orderRepo.selectByStatusAndAcc(this.session.get("user"),stt,0);
				model.addAttribute("orders", lstOrder);
			}
			model.addAttribute("stt", stt);
		} catch (Exception e) {
			List<OrderRP> lstOrder = this.orderRepo.selectByUser(this.session.get("user"));
			model.addAttribute("orders", lstOrder);
		}
		model.addAttribute("stt", status);
		model.addAttribute("view", "/views/user/order/index.jsp");
		return "layout";
	}

	@GetMapping("orderdetail/{id}")
	public String orderDetail(@PathVariable("id") Order order, Model model) {
		List<Orderdetail> listOrderdt = order.getOrderdetailOrder();
		model.addAttribute("listOrderdt", listOrderdt);
		model.addAttribute("view", "/views/user/order/orderdetail.jsp");
		return "layout";
	}

	@GetMapping("delete/{id}")
	public String delete(@PathVariable("id") Order order, Model model) {
		order.setDeleted(1);
		this.orderRepo.save(order);
		this.session.set("message", "Hủy thành công");
		return "redirect:/user/order/index";
	}

	@GetMapping("accept/{id}")
	public String accept(@PathVariable("id") Order order) {
		order.setStatus(3);
		this.orderRepo.save(order);
		this.session.set("message", "Đã xác nhận đơn hàng");
		return "redirect:/user/order/index";
	}
}
