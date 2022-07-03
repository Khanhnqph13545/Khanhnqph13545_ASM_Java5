package sof3021.controllers;	

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import sof3021.bean.Category;
import sof3021.repositories.CategoryRepository;
import sof3021.service.SessionService;

@Controller
@RequestMapping("/admin/category")
public class CategoryyController {
	@Autowired
	CategoryRepository cateRepo; 

	@Autowired
	SessionService session;
	
	@GetMapping("index")
	public String index(Model model, @RequestParam(name = "page", defaultValue = "0") Integer page,
			@RequestParam(name = "size", defaultValue = "10") Integer size, @ModelAttribute("category") Category cate) {
		Pageable pageable = PageRequest.of(page, size);
		Page<Category> data = this.cateRepo.selectAll(pageable);
		model.addAttribute("data", data);
		model.addAttribute("view", "/views/admin/category/index.jsp");
		return "layout";
	}
	
	@PostMapping("store")
	public String store(Model model, @ModelAttribute("category") Category cate) {
		this.cateRepo.save(cate);
		if (cate.getId() == 0) {
			this.session.set("message", "Thêm thành công");
		}else {
			this.session.set("message", "Cập nhật thành công");
		}
		return "redirect:/admin/category/index";
	}
	
	@GetMapping("delete/{id}")
	public String delete(@PathVariable("id") Category cate) {
		cate.setDeleted(1);
		this.cateRepo.save(cate);
		this.session.set("message", "Xóa thành công");
		return "redirect:/admin/category/index";
	}
}
