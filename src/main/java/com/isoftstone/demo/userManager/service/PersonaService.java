package com.isoftstone.demo.userManager.service;

import java.util.Map;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.userManager.model.UserPersona;

/**
 * Created by lidey on 14-6-25.
 */
public interface PersonaService extends UserService<UserPersona> {

    /**
     *
     * @param UserPersona
     * @throws CustomException 
     */
    public void updatePersonaInfo(UserPersona UserPersona) throws CustomException;

    /**
     *
     * @param params
     * @param page
     * @return
     */
    public PageModel<UserPersona> findPersonaGridByParams(Map<String, Object> params, String page,String rows);
    public PageModel<UserPersona> findPersonaGridByParams(Map<String, Object> params, String page,String rows,String sortBy,String ascDesc);
    
    public void savePersonaInfo(UserPersona userPersona)throws CustomException;
}
