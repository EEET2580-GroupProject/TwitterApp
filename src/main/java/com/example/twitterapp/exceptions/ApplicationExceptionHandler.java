package com.example.twitterapp.exceptions;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.async.AsyncRequestTimeoutException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@ControllerAdvice
public class ApplicationExceptionHandler {

    @ExceptionHandler({ApplicationException.class})
    public String handleException(){
        System.out.println("In Global Exception handler");
        return "error";
    }
    @ExceptionHandler({ AsyncRequestTimeoutException.class})
    public String timeOutException(RedirectAttributes re){
        System.out.println("Search time out");
        re.addFlashAttribute("report","The request took too long, please try again later");
        return "redirect:/twitter";
    }
}
