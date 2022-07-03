package sof3021.controllers;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import sof3021.bean.Sales;
import sof3021.repositories.OrderRepository;

@Controller
@RequestMapping("/admin/sales")
public class SalesController {
	@Autowired
	OrderRepository orderRepo;

	@GetMapping("index")
	public String index(Model model) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(new Date());
		model.addAttribute("date", date);
		model.addAttribute("view", "/views/admin/sales/index.jsp");
		return "layout";
	}

	@ResponseBody
	@RequestMapping("/search")
	public List<Sales> search(RedirectAttributes params, @RequestParam("start") String start,
			@RequestParam("end") String end) {
		System.out.println(start);
		SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM d yyyy hh:mm:ss z");
		try {
			start = start.substring(0, 29);
			end = end.substring(0, 29);
			Date startDate = sdf.parse(start);
			Date endDate = sdf.parse(end);
			long date = Math.abs((startDate.getTime()-endDate.getTime()))/1000/60/60/24;
			if (startDate.compareTo(endDate)<0) {
					List<Sales> sales = this.orderRepo.selectDaySales(startDate, endDate);
					return sales;
			} else {
					List<Sales> sales = this.orderRepo.selectDaySales(endDate, startDate);
					return sales;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	 
}
