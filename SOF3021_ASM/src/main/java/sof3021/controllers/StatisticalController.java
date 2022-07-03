package sof3021.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import sof3021.bean.Report;
import sof3021.bean.Statistical;
import sof3021.repositories.OrderdetailRepository;

@Controller
@RequestMapping("/admin/statistical")
public class StatisticalController {
	@Autowired
	OrderdetailRepository orderdtRepo;
	
	@GetMapping("index")
	public String index(Model model, @RequestParam(name = "status",defaultValue = "") String status) {
		try {
			int stt = Integer.parseInt(status);
			Page<Report> lst = this.orderdtRepo.reportByProduct(PageRequest.of(0, 10));
			model.addAttribute("statistical", lst);
		} catch (Exception e) {
			Page<Statistical> lst = this.orderdtRepo.staticticalByProduct(PageRequest.of(0, 10));
			model.addAttribute("statistical", lst);
		}
		
		model.addAttribute("view", "/views/admin/selling/index.jsp");
		return "layout";
	}
	
}
