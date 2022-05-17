package com.example.twitterapp.controller;

import com.example.twitterapp.beans.User;
import com.example.twitterapp.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;

@Controller
public class RegistrationController {
    @Autowired
    private UserRepository userRepository;


    @PostMapping("/registeruser")
    // Run the  @Valid of hibernate validation first before saving user
    // BindingResult parameter has to be next to model attribute
    public String registerUser(@Valid @ModelAttribute("newuser") User user, BindingResult bindingResult, Model model){
        System.out.println("In registration controller");

        //This means if any of the validation step has error, return to the register page
        if(bindingResult.hasErrors()){
            return "register";
        }
        userRepository.save(user);
        model.addAttribute("dataSaved", "Yo data has been saved");
        return "login";  // After registration redirect the user back to the login page
    }
}
