package com.isoftstone.demo.common.exception;

public class CustomException extends Exception {

    /**
	 * 
	 */
	private static final long serialVersionUID = -8654896590982217017L;
	private CustomExceptionEnum exceptionEnum;

    public CustomException() {
        super();
    }

    public CustomException(String msg) {
        super(msg);
    }

    public CustomException(CustomExceptionEnum customExceptionEnum) {
        super(customExceptionEnum.getMessage());
        this.exceptionEnum = customExceptionEnum;
    }

    public CustomExceptionEnum getExceptionEnum() {
        return exceptionEnum;
    }
}
