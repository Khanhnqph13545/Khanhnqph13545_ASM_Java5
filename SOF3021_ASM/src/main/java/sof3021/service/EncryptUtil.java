package sof3021.service;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

@Service
public class EncryptUtil {
	public String encrypt(String origin) {
		String encrypted = BCrypt.hashpw(origin, BCrypt.gensalt());
		return encrypted;
	}

	public boolean check(String origin, String encrypted) {
		return BCrypt.checkpw(origin, encrypted);
	}
}
