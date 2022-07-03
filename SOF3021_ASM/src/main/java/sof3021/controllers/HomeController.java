package sof3021.controllers;

import java.io.File;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import sof3021.bean.Account;
import sof3021.bean.Category;
import sof3021.bean.Product;
import sof3021.repositories.AccountRepository;
import sof3021.repositories.CategoryRepository;
import sof3021.repositories.ProductRepository;
import sof3021.service.EncryptUtil;
import sof3021.service.ParamService;
import sof3021.service.SessionService;

@Controller
public class HomeController {
	@Autowired
	ProductRepository proRepo;
	@Autowired
	CategoryRepository cateRepo;
	@Autowired
	AccountRepository accRepo;
	@Autowired
	EncryptUtil encrypt;
	@Autowired
	SessionService session;
	@Autowired
	ParamService param;

	@GetMapping("/home")
	public String home(Model model, @RequestParam(name = "page", defaultValue = "0") Integer page,
			@RequestParam(name = "size", defaultValue = "8") Integer size,
			@RequestParam(name = "cate", defaultValue = "") Category cate,
			@RequestParam(name = "search",defaultValue = "") String search
			) {
		List<Category> lstCate = this.cateRepo.selectAll();
		model.addAttribute("categories", lstCate);
		Pageable pageable = PageRequest.of(page, size);
		if (cate == null) {
			Page<Product> data = this.proRepo.selectAll(pageable,search);
			model.addAttribute("data", data);
		} else {
			Page<Product> data = this.proRepo.selectByCate(cate, pageable);
			model.addAttribute("data", data);
		}
		List<Account> listAcc = this.accRepo.findAlll();
		model.addAttribute("listAcc", listAcc);
		model.addAttribute("view", "/views/home/home.jsp");
		return "layout";
	}

	@GetMapping("/login")
	public String loginform(Model model) {
		this.session.remove("user");
		model.addAttribute("view", "/views/login/login.jsp");
		return "layout";
	}

	@PostMapping("/login")
	public String login(Model model, @RequestParam("username") String username,
			@RequestParam("password") String password) {
		Account acc = this.accRepo.findByEmailEqualsOrUsernameEquals(username, username);
		if (acc != null) {
			if (this.encrypt.check(password, acc.getPassword())) {
				System.out.println("Đăng nhập thành công");
				this.session.set("user", acc);
				this.session.set("message", "Đăng nhập thành công");
				return "redirect:/home";
			} else {
				model.addAttribute("view", "/views/login/login.jsp");
				this.session.set("loginfail", "Tài khoản hoặc mật khẩu không chính xác");
				return "layout";
			}
		} else {
			this.session.set("loginfail", "Tài khoản hoặc mật khẩu không chính xác");
			model.addAttribute("view", "/views/login/login.jsp");
			return "layout";
		}
	}

	@GetMapping("/register")
	public String registerform(Model model, @ModelAttribute("account") Account acc) {
		model.addAttribute("view", "/views/login/register.jsp");
		return "layout";
	}

	@PostMapping("/register")
	public String register(@RequestParam("file") MultipartFile file, Model model,
			@Valid @ModelAttribute("account") Account acc, BindingResult rs) {
		if (rs.hasErrors()) {
			model.addAttribute("view", "/views/login/register.jsp");
			return "layout";
		} else {
			if (!file.isEmpty()) {
				File filephoto = this.param.save(file, "/images/account");
				acc.setPhoto(filephoto.getName());
			} else {
				acc.setPhoto(this.param.getString("photo", ""));
			}
			acc.setPassword(this.encrypt.encrypt(acc.getPassword()));
			acc.setAdmin(0);
			this.accRepo.save(acc);
			return "redirect:/login";
		}
	}
	
	@ResponseBody
	@RequestMapping("/search")
	public List<Account> search(@RequestParam("keyword") String keyword){
		List<Account> lst = this.accRepo.selectByKeyword(keyword);
		return lst;
	}
}
