package org.momento.security;
import org.springframework.security.web.csrf.CsrfToken;

public class CustomCsrfToken implements CsrfToken {
    // CsrfToken 인터페이스의 구현 내용 추가

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public CustomCsrfToken() {
        // 기본 생성자 내용 추가 (필요에 따라)
    }

	@Override
	public String getHeaderName() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getParameterName() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getToken() {
		// TODO Auto-generated method stub
		return null;
	}
}