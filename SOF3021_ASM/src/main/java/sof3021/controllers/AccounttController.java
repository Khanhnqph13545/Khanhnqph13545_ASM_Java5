package sof3021.controllers;

import java.io.File;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import sof3021.bean.Account;
import sof3021.repositories.AccountRepository;
import sof3021.service.CookieService;
import sof3021.service.EncryptUtil;
import sof3021.service.ParamService;
import sof3021.service.SessionService;

@Controller
@RequestMapping("/admin/account")
public class AccounttController {
	@Autowired
	EncryptUtil encryp;
	@Autowired
	ParamService param;
	@Autowired
	SessionService session;
	
	@Autowired
	AccountRepository accountRepo;

	@GetMapping("index")
	public String index(Model model, @RequestParam(name = "page", defaultValue = "0") Integer page,
			@RequestParam(name = "size", defaultValue = "10") Integer size) {
		Pageable pageable = PageRequest.of(page, size);
		Page<Account> data = this.accountRepo.findAlll(pageable);
		System.out.println(data.getSize());
		model.addAttribute("data", data);
		model.addAttribute("view", "/views/admin/account/index.jsp");
		return "layout";
	}

	@GetMapping("create")
	public String create(Model model, @ModelAttribute("account") Account acc) {
		model.addAttribute("view", "/views/admin/account/create.jsp");
		return "layout";
	}

	@RequestMapping(value = "store", method = RequestMethod.POST)
	public String store(@RequestParam("file") MultipartFile file, Model model,
			@Valid @ModelAttribute("account") Account acc, BindingResult rs) {
		if (rs.hasErrors()) {
			if (acc.getId() != 0) {
				model.addAttribute("view", "/views/admin/account/update.jsp");
				return "layout";
			} else {
				model.addAttribute("view", "/views/admin/account/create.jsp");
				return "layout";
			}
		} else {
			if (!file.isEmpty()) {
				File filephoto = this.param.save(file, "/images/account");
				acc.setPhoto(filephoto.getName());
			} else {
				acc.setPhoto(this.param.getString("photo", ""));
			}
			if (acc.getId()==0) {
				acc.setPassword(this.encryp.encrypt(acc.getPassword()));
				this.session.set("message", "Thêm thành công");
			}else {
				this.session.set("message", "Cập nhật thành công");
			}
			
			this.accountRepo.save(acc);
			return "redirect:/admin/account/index";
		}
	}

	@GetMapping("edit/{id}")
	public String edit(@PathVariable("id") Account acc, Model model) {
		model.addAttribute("account", acc);
		model.addAttribute("view", "/views/admin/account/update.jsp");
		return "layout";
	}

	@GetMapping("delete/{id}")
	public String delete(@PathVariable("id") Account acc) {
		acc.setDeleted(1);
		this.accountRepo.save(acc);
		this.session.set("message", "Xóa thành công");
		return "redirect:/admin/account/index";
	}
}
