package sof3021.controllers;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import sof3021.bean.Category;
import sof3021.bean.Product;
import sof3021.repositories.CategoryRepository;
import sof3021.repositories.ProductRepository;
import sof3021.service.ParamService;
import sof3021.service.SessionService;

@Controller
@RequestMapping("/admin/product")
public class ProductController {
	@Autowired
	ProductRepository proRepo;
	@Autowired
	ParamService param;
	@Autowired
	CategoryRepository cateRepo;
	@Autowired
	SessionService session;

	@GetMapping("index")
	public String index(Model model, @RequestParam(name = "page", defaultValue = "0") Integer page,
			@RequestParam(name = "size", defaultValue = "10") Integer size,
			@RequestParam(name = "cate", defaultValue = "") Category cate,
			@RequestParam(name = "search", defaultValue = "") String search) {
		List<Category> lstCate = this.cateRepo.selectAll();
		model.addAttribute("categories", lstCate);
		Pageable pageable = PageRequest.of(page, size);
		if (cate == null) {
			Page<Product> data = this.proRepo.selectAll(pageable, search);
			model.addAttribute("data", data);
		} else {
			Page<Product> data = this.proRepo.selectByCate(cate, pageable);
			model.addAttribute("data", data);
		}
		model.addAttribute("view", "/views/admin/product/index.jsp");
		return "layout";
	}

	@GetMapping("create")
	public String create(Model model, @ModelAttribute("product") Product pro) {
		List<Category> lstCate = this.cateRepo.selectAll();
		model.addAttribute("categories", lstCate);
		model.addAttribute("view", "/views/admin/product/create.jsp");
		return "layout";
	}

	@PostMapping("store")
	public String store(Model model, @Valid @ModelAttribute("product") Product pro, BindingResult rs,
			@RequestParam("file") MultipartFile file) {
		if (rs.hasErrors()) {
			if (pro.getId() != 0) {
				List<Category> lstCate = this.cateRepo.selectAll();
				model.addAttribute("categories", lstCate);
				model.addAttribute("view", "/views/admin/product/update.jsp");
				return "layout";
			} else {
				List<Category> lstCate = this.cateRepo.selectAll();
				model.addAttribute("categories", lstCate);
				model.addAttribute("view", "/views/admin/product/create.jsp");
				return "layout";
			}
		} else {
			if (!file.isEmpty()) {
				File filePhoto = this.param.save(file, "/images/product");
				pro.setImage(filePhoto.getName());
			} else {
				pro.setImage(this.param.getString("image", ""));
			}
			if (pro.getId() == 0) {
				this.session.set("message", "Thêm thành công");
			}else {
				this.session.set("message", "Cập nhật thành công");
			}
			this.proRepo.save(pro);
			return "redirect:/admin/product/index";
		}
	}

	@GetMapping("edit/{id}")
	public String edit(Model model, @PathVariable("id") Product pro) {
		List<Category> lstCate = this.cateRepo.selectAll();
		model.addAttribute("categories", lstCate);
		model.addAttribute("product", pro);
		model.addAttribute("view", "/views/admin/product/update.jsp");
		return "layout";
	}

	@GetMapping("delete/{id}")
	public String delete(@PathVariable("id") Product pro) {
		pro.setDeleted(1);
		this.proRepo.save(pro);
		this.session.set("message", "Xóa thành công");
		return "redirect:/admin/product/index";
	}
}
