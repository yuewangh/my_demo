package com.isoftstone.demo.common.exception;

public enum CustomExceptionEnum {

	RETURN_NULL(""), QUERY_NULL(""), OBJECT_NULL(""), NO_CONFIGURATION(""), NO_FILE(
			""), IO_EXCEPTION(""), FORMAT_ERROR(""), ERR0002("");
	// 异常信息
	private String message;

	CustomExceptionEnum(String message) {
		this.message = message;
	}

	public String getMessage() {
		return message;
	}
}
