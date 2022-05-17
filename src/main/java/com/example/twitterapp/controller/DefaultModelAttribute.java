package com.example.twitterapp.controller;

import com.example.twitterapp.beans.Login;
import com.example.twitterapp.beans.SearchHistory;
import com.example.twitterapp.beans.User;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.Arrays;
import java.util.List;

@ControllerAdvice       // This tag apply across the flow of applicaton
public class DefaultModelAttribute {
    @ModelAttribute("newsearch")
    public SearchHistory getDefaultSearchHistory(){return new SearchHistory();}

    @ModelAttribute("newuser")
    public User getDefault(){
        return new User();
    }

    @ModelAttribute("returnGenderList")
    public List<String> getGenderItem(){
        return Arrays.asList("Male","Female", "Other");
    }

    @ModelAttribute("login")
    public Login getDefaultUser(){
        return new Login();
    }


}
