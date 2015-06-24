package com.isoftstone.demo.mail.service;

public interface SendMailService {

    /**
     * 发送邮件
     *
     * @param email   邮件地址
     * @param title   邮件标题
     * @param content 邮件内容
     * @return 是否发送成功
     */
    public boolean send(String email, String title, String content);
}
