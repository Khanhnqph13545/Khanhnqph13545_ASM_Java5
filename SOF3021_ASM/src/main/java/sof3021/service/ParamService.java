package sof3021.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ParamService {
	@Autowired
	HttpServletRequest request;
	@Autowired
	ServletContext app;
	
	public String getString(String name, String defaultValue) {
		String chuoi = this.request.getParameter(name);
		if (chuoi == null) {
			return defaultValue;
		}else {
			return chuoi;			
		}
	}
	
	public int getInt(String name, int defaultValue) {
		try {
			int so = Integer.parseInt(this.request.getParameter(name));
			return so;
		} catch (Exception e) {
			return defaultValue;
		}
	}
	
	public double getDouble(String name, double defaultValue) {
		try {
			double so = Double.parseDouble(this.request.getParameter(name));
			return so;
		} catch (Exception e) {
			return defaultValue;
		}
	}
	
	public boolean getBoolean (String name, boolean defaultValue) {
		String value = this.request.getParameter(name);
		if (value == null) {
			return defaultValue;
		}else {
			boolean bl = Boolean.parseBoolean(value);
			return bl;
		} 
	}
	
	public Date getDate(String name, String pattern) {
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		String dateStr = this.request.getParameter(name);
		try {
			Date date = sdf.parse(dateStr);
			return date;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public File save(MultipartFile file, String path) {
		File dir = new File(app.getRealPath(path));
		if (!dir.exists()) {
			dir.mkdirs();
		}
		try {
			File saveFile = new File(dir,file.getOriginalFilename());
			file.transferTo(saveFile);
			return saveFile;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
