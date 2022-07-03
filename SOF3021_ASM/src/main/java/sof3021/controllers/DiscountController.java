package sof3021.controllers;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.bytebuddy.agent.builder.AgentBuilder.FallbackStrategy.Simple;
import sof3021.bean.Discount;
import sof3021.repositories.DiscountRepository;
import sof3021.service.SessionService;

@Controller
@RequestMapping("/admin/discount")
public class DiscountController {
	@Autowired
	DiscountRepository disRepo;
	@Autowired
	SessionService session;
	
	@GetMapping("index")
	public String index(Model model) {
		List<Discount> listDC = this.disRepo.findAll();
		model.addAttribute("data", listDC);
		model.addAttribute("view", "/views/admin/discount/index.jsp");
		return "layout";
	}
	
	@GetMapping("edit/{id}")
	public String edit(Model model,@PathVariable("id") Discount discount) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String startDate = sdf.format(discount.getCreateDate());
		String endDate = sdf.format(discount.getEndDate());
		model.addAttribute("start", startDate);
		model.addAttribute("end",endDate);
		model.addAttribute("discount", discount);
		model.addAttribute("view", "/views/admin/discount/update.jsp");
		return "layout";
	}
	
	@GetMapping("create")
	public String create(@ModelAttribute("discount") Discount discount,Model model) {
		model.addAttribute("view", "/views/admin/discount/create.jsp");
		return "layout";
	}
	
	@PostMapping("store")
	public String store(Model model, @Valid @ModelAttribute("discount") Discount discount, BindingResult rs,
			@RequestParam("start") String startDate,
			@RequestParam("end") String endDate
			) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (rs.hasErrors()) {
			if (discount.getId() != 0) {
				model.addAttribute("view", "/views/admin/discount/update.jsp");
				return "layout";
			} else {
				model.addAttribute("view", "/views/admin/discount/create.jsp");
				return "layout";
			}
		} else {
			try {
				Date start = sdf.parse(startDate);
				Date end = sdf.parse(endDate);
				discount.setCreateDate(start);
				discount.setEndDate(end);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			if (discount.getId() == 0) {
				this.session.set("message", "Thêm thành công");
			}else {
				this.session.set("message", "Cập nhật thành công");
			}
			this.disRepo.save(discount);
			return "redirect:/admin/discount/index";
		}
	}
	
	@GetMapping("delete/{id}")
	public String delele(@PathVariable("id") Discount discount) {
		this.disRepo.delete(discount);
		this.session.set("message", "Xóa thành công");
		return "redirect:/admin/discount/index";
	}
}
