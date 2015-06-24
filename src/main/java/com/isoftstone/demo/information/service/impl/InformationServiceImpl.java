package com.isoftstone.demo.information.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.isoftstone.demo.information.model.InformationText;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.information.dao.InformationDao;
import com.isoftstone.demo.information.model.Information;
import com.isoftstone.demo.information.service.InformationService;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Group: 姚丰利（lidey）
 * Date: 2015-04-24
 * Time: 09:43
 * To change this template use File | Settings | File Templates.
 */
@Service
@Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
public class InformationServiceImpl implements InformationService {

    @Autowired
    private InformationDao informationDao;


    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void saveInformation(Information information) {
        information.setCreateDate(new Date());
        information.setModifyDate(new Date());
        informationDao.save(information);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void updateInformation(Information information) {
        try {
            Information tmp = informationDao.get(information.getUuid());
            tmp.setTitle(information.getTitle());
            tmp.setPictureUrl(information.getPictureUrl());
            tmp.setAuthorName(information.getAuthorName());
            tmp.setSummary(information.getSummary());
            tmp.setModifyDate(new Date());
            if (tmp instanceof InformationText) {
                ((InformationText) tmp).setContent(((InformationText) information).getContent());
            }

            informationDao.update(information);
        } catch (CustomException e) {
            e.printStackTrace();
            this.saveInformation(information);
        }
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteInformation(String uuid) {
        try {
            Information information = informationDao.load(uuid);
            information.setDeleteDate(new Date());
            informationDao.update(information);
        } catch (CustomException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Information findInformationByUuid(String uuid) {
        try {
            Information information = informationDao.get(uuid);
            return information;
        } catch (CustomException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public PageModel<Information> findInformationGridByParam(Map<String, Object> params, int page, int size, Map<String, String> order) {
        PageModel<Information> pageBean = new PageModel<Information>();
        pageBean.setPage(page);
        pageBean.setLimit(size);

        pageBean.setRecords(informationDao.countInformationByParams(params));
        if (pageBean.getRecords() > 0) {
            List<Information> informationList = informationDao.findInformationByParams(params, pageBean.getPage(), pageBean.getLimit(), order);
            for (Information information : informationList) {
                pageBean.addRow(information);
            }
        } else {
            pageBean.setPage(1);
        }
        return pageBean;
    }
}
