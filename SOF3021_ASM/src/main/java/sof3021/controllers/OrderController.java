package sof3021.controllers;

import java.awt.Window;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.lang.model.element.ModuleElement.Directive;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import sof3021.bean.Account;
import sof3021.bean.Order;
import sof3021.bean.OrderRP;
import sof3021.bean.Orderdetail;
import sof3021.bean.Product;
import sof3021.repositories.AccountRepository;
import sof3021.repositories.OrderRepository;
import sof3021.repositories.OrderdetailRepository;
import sof3021.repositories.ProductRepository;
import sof3021.service.SessionService;

@Controller
@RequestMapping("admin/order")
public class OrderController {
	@Autowired
	OrderRepository orderRepo;
	@Autowired
	AccountRepository accRepo;
	@Autowired
	ProductRepository proRepo;
	@Autowired
	OrderdetailRepository orderdtRepo;
	@Autowired
	SessionService session;

	@GetMapping("index")
	public String index(Model model,@RequestParam(value = "status", defaultValue = "") String status) {
		try {
			int stt = Integer.parseInt(status);
			if (stt == 0) {
				List<OrderRP> lstOrder= this.orderRepo.selectAllByStatus(1,1);
				model.addAttribute("orders", lstOrder);
				model.addAttribute("stt", 0);
			}else {
				List<OrderRP> lstOrder= this.orderRepo.selectAllByStatus(stt,0);
				model.addAttribute("orders", lstOrder);
			}
			model.addAttribute("stt", stt);
		} catch (Exception e) {
			List<OrderRP> lstOrder = this.orderRepo.orders();
			model.addAttribute("orders", lstOrder);
			model.addAttribute("stt", status);
		}
		
		List<Account> listAcc = this.accRepo.findAlll();
		model.addAttribute("listAcc", listAcc);
		model.addAttribute("view", "/views/admin/order/index.jsp");
		return "layout";
	}

	@GetMapping("create")
	public String createOrder(Model model, @RequestParam("user") Account acc) {
		List<Product> listProduct = this.proRepo.selectAll();
		model.addAttribute("listPro", listProduct);
		Order order = this.orderRepo.selectByAcc(acc);
		OrderRP orderRP = this.orderRepo.selectTotal(acc);
		model.addAttribute("orderRP", orderRP);
		if (order == null) {
			order = new Order();
			order.setAccount(acc);
			order.setAddress("");
			this.orderRepo.save(order);
		} else {
			List<Orderdetail> listOrdt = order.getOrderdetailOrder();
			model.addAttribute("listOrderdt", listOrdt);
		}
		
		model.addAttribute("account", acc);
		model.addAttribute("order", order);
		model.addAttribute("view", "/views/admin/order/create.jsp");
		return "layout";
	}

	@GetMapping("insert")
	public String insertOrderDetail(Model model, @RequestParam("pro") Product product,
			@RequestParam("order") Order order) {
		Orderdetail orderdt = this.orderdtRepo.selectByPro(order, product);
		if (orderdt == null) {
			orderdt = new Orderdetail();
			orderdt.setOrder(order);
			orderdt.setProduct(product);
			orderdt.setPrice(product.getPrice());
			orderdt.setQuantity(1);
			this.orderdtRepo.save(orderdt);
		} else {
			orderdt.setQuantity(orderdt.getQuantity() + 1);
			this.orderdtRepo.save(orderdt);
		}
		return "redirect:/admin/order/create?user=" + order.getAccount().getId();
	}

	@GetMapping("update/{id}")
	public String updateQuantity(Model model, @RequestParam("qtt") int qtt, @PathVariable("id") Orderdetail orderdt) {
		orderdt.setQuantity(qtt);
		this.orderdtRepo.save(orderdt);
		return "redirect:/admin/order/create?user=" + orderdt.getOrder().getAccount().getId();
	}

	@GetMapping("deleteorderdt/{id}")
	public String deleteOrderDetail(Model model, @PathVariable("id") Orderdetail orderdt) {
		this.orderdtRepo.delete(orderdt);
		return "redirect:/admin/order/create?user=" + orderdt.getOrder().getAccount().getId();
	}

	@PostMapping("payment/{id}")
	public String payment(@PathVariable("id") Order order, @RequestParam("address") String address) {
		order.setAddress(address);
		order.setStatus(1);
		order.setCreateDate(new Date());
		this.orderRepo.save(order);
		this.session.set("message", "Tạo đơn hàng thành công");
		return "redirect:/admin/order/index";
	}

	@GetMapping("delete/{id}")
	public String deleteOrder(@PathVariable("id") Order order) {
		order.setDeleted(1);
		this.orderRepo.save(order);
		this.session.set("message", "Xóa thành công");
		return "redirect:/admin/order/index";
	}

	@PostMapping("edit/{id}")
	public String edit(@PathVariable("id") Order order) {
		order.setStatus(2);
		try {
			inHoaDonPDF(order);
			this.session.set("message", "Xác nhận thành công");
		} catch (IOException e) {
			e.printStackTrace();
		}
		this.orderRepo.save(order);
		return "redirect:/admin/order/index";
	}
	
	@PostMapping("ship/{id}")
	public String ship(@PathVariable("id") Order order) {
		order.setStatus(4);
		this.orderRepo.save(order);
		this.session.set("message", "Thành công");
		return "redirect:/admin/order/index";
	}
	
	@ResponseBody
	@GetMapping("/search")
	public List<Product>  search(@RequestParam("keyword") String keyword){
		List<Product> lst = this.proRepo.selectByKeyword(keyword);
		return lst;
	}
	
	private void inHoaDonPDF(Order order) throws IOException {
        try {
        	Locale localeVN = new Locale("vi", "VN");
            NumberFormat currencyVN = NumberFormat.getCurrencyInstance(localeVN);
        	
        	double thanhTien=0;
            SimpleDateFormat sdf2 = new SimpleDateFormat("dd/MM/yyyy hh:mm:aa");
            Font f = new Font(BaseFont.createFont("font/SVN-Arial 2.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED));
//            Font f = new Font();
            f.setColor(BaseColor.BLACK);
            f.setSize(40);
            f.setStyle(Font.BOLD);
            Document document = new Document();
            document.setMargins(60, 60, 60, 60);
            // Tạo đối tượng PdfWriter
            PdfWriter.getInstance(document, new FileOutputStream("HoaDon.pdf"));
            // Mở file để thực hiện ghi
            document.open();
            Paragraph tieuDe = new Paragraph("SATO SHOP", f);
            tieuDe.setSpacingAfter(30); // 
            tieuDe.setAlignment(1); // Căn giữa
            document.add(tieuDe);
            f.setSize(22);
            Paragraph hoaDon = new Paragraph("HÓA ĐƠN BÁN HÀNG", f);
            hoaDon.setAlignment(1);
            document.add(hoaDon);
            f.setSize(15);
            Paragraph thongTin = new Paragraph("Ngày: " + sdf2.format(new Date())
                    + "\nKhách hàng: "+order.getAccount().getFullname()
                    + "\nĐịa chỉ: "+order.getAddress(), f);
            thongTin.setSpacingBefore(30);
            document.add(thongTin);
            f.setSize(20);
            Paragraph keNgang = new Paragraph("- - - - - - - - - - - - - - - - - - - - - - - - -"
                    + " - - - - - - - - - - - - - -", f);
            document.add(keNgang);
            PdfPTable table = new PdfPTable(3);
            table.setWidthPercentage(100);
            f.setSize(15);
            PdfPCell c1 = new PdfPCell(new Phrase("   SL", f));
            c1.setFixedHeight(30);
            c1.setBorder(0);
            table.addCell(c1);
            PdfPCell c2 = new PdfPCell(new Phrase("Đơn giá", f));
            c2.setBorder(0);
            c2.setHorizontalAlignment(1);
            table.addCell(c2);
            PdfPCell c3 = new PdfPCell(new Phrase("Thành tiền", f));
            c3.setBorder(0);
            c3.setHorizontalAlignment(2);
            table.addCell(c3);

            //for
            for (int i = 0; i < order.getOrderdetailOrder().size(); i++) {
                int soLuong = order.getOrderdetailOrder().get(i).getQuantity();
                double donGia = order.getOrderdetailOrder().get(i).getPrice();
                String tenMH = order.getOrderdetailOrder().get(i).getProduct().getName();
                PdfPCell tenSP = new PdfPCell(new Phrase(tenMH, f)); // TENSP
                tenSP.setColspan(3);
                tenSP.setBorder(0);
                tenSP.setFixedHeight(30);
                table.addCell(tenSP);
                PdfPCell soluong = new PdfPCell(new Phrase("   " + soLuong + "", f));    // SOLUONG
                soluong.setBorder(0);
                PdfPCell donGiaHD = new PdfPCell(new Phrase(currencyVN.format(donGia) +" đ", f)); // DON GIA
                donGiaHD.setHorizontalAlignment(1);
                donGiaHD.setBorder(0);
                double tongtien = soLuong*donGia;
                PdfPCell thanhtien = new PdfPCell(new Phrase(currencyVN.format(tongtien) +" đ", f)); // THANH TIEN
                thanhtien.setHorizontalAlignment(2);
                thanhtien.setBorder(0);
                table.addCell(soluong);
                table.addCell(donGiaHD);
                table.addCell(thanhtien);
                f.setSize(20);
                thanhTien += soLuong*donGia;
            }
            document.add(table);
            document.add(keNgang);
            f.setSize(15);

            //TongTienHang
            PdfPTable tblTongTien = new PdfPTable(2);
            tblTongTien.setWidthPercentage(100);
            PdfPCell tongTien1 = new PdfPCell(new Phrase("Tổng tiền hàng:", f));
            tongTien1.setFixedHeight(30);
            tongTien1.setBorder(0);
            PdfPCell tongTien2 = new PdfPCell(new Phrase(currencyVN.format(thanhTien) +" đ", f));
            tongTien2.setHorizontalAlignment(2);
            tongTien2.setFixedHeight(30);
            tongTien2.setBorder(0);
            tblTongTien.addCell(tongTien1);
            tblTongTien.addCell(tongTien2);
            // KhuyenMai
            PdfPCell khuyenMai1 = new PdfPCell(new Phrase("Khuyến mãi:", f));
            khuyenMai1.setFixedHeight(30);
            khuyenMai1.setBorder(0);
            PdfPCell khuyenMai2 = new PdfPCell(new Phrase("-" + currencyVN.format(order.getDiscount()) +" đ", f));
            khuyenMai2.setHorizontalAlignment(2);
            khuyenMai2.setFixedHeight(30);
            khuyenMai2.setBorder(0);
            tblTongTien.addCell(khuyenMai1);
            tblTongTien.addCell(khuyenMai2);
            // TongThanhToan
            PdfPCell tongTT1 = new PdfPCell(new Phrase("Tổng thanh toán:", f));
            tongTT1.setFixedHeight(30);
            tongTT1.setBorder(0);
            PdfPCell tongTT2 = new PdfPCell(new Phrase(currencyVN.format(thanhTien - order.getDiscount()) +" đ", f));
            tongTT2.setHorizontalAlignment(2);
            tongTT2.setFixedHeight(30);
            tongTT2.setBorder(0);
            tblTongTien.addCell(tongTT1);
            tblTongTien.addCell(tongTT2);
            document.add(tblTongTien);
            f.setSize(20);
            document.add(keNgang);
            f.setSize(15);

            //Footer
            Paragraph fooTer = new Paragraph("Quý khách vui lòng kiểm tra kỹ hàng"
                    + "\n - - - - - - - - - - - - -"
                    + "\n Cảm ơn quý khách, hẹn gặp lại!", f);
            fooTer.setSpacingBefore(15);
            fooTer.setAlignment(1);
            document.add(fooTer);

            document.close();
            System.out.println("Write file succes!");
        } catch (FileNotFoundException | DocumentException e) {
            e.printStackTrace();
        }
    }
	
}
