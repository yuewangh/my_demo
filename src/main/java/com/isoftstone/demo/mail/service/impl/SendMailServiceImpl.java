package com.isoftstone.demo.mail.service.impl;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.isoftstone.demo.mail.service.SendMailService;

public class SendMailServiceImpl implements SendMailService {
    private JavaMailSender mailSender;
    final Logger logger = LoggerFactory.getLogger(this.getClass());
    private String address;

    public void setMailSender(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public boolean send(String email, String title, String content) {

        boolean sended = false;

        try {
         	MimeMessage mail1 = mailSender.createMimeMessage();  
         	MimeMessageHelper mail = new MimeMessageHelper(mail1, "UTF-8");
            mail.setTo(email);
            mail.setFrom(address);
            mail.setSubject(title);
            mail.setText(content, true);
            mailSender.send(mail1);
            sended = true;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getLocalizedMessage());
        }
        return sended;

    }

}
