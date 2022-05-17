package com.example.twitterapp.controller;

import com.example.twitterapp.beans.Login;
import com.example.twitterapp.beans.User;
import com.example.twitterapp.repository.UserRepository;
import com.example.twitterapp.twitter.TweetAnalyzeService;
import com.example.twitterapp.twitter.TweetSearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URISyntaxException;

@Controller
public class HomeController {
    @Autowired
    TweetSearchService tweetSearchService;
    @Autowired
    TweetAnalyzeService tweetAnalyzeService;
    @Autowired
    UserRepository userRepository;

    @GetMapping("/home")
    public String goHome(Login login, Model model, HttpSession session) {
        System.out.println("At Home");
        //Check whether user logged in ore not
        if(session.getAttribute("login")!=null){

            return "session";
        }
        return "index";     // This is the name of the view
        // DispatcherServlet picks view name, and work with vieController to resolve that to the index jsp template
    }

    @GetMapping("/login")
    public String goLogin() {
        System.out.println("In Login");
        return "login";
    }

    @GetMapping("/registration")
    public String goRegistration() {
        System.out.println("In Registraion");
        return "register";
    }

    @GetMapping("/twitter")
    public String goToTwitterAPI(Model model, @SessionAttribute("login") Login login) throws URISyntaxException, IOException {
        User user = userRepository.searchByName(login.getUsername());
        model.addAttribute("username",user.getUsername());

        System.out.println("Twitter Port");
        System.out.println("Deleted all rules");
        tweetSearchService.deleteAllRules();

        try {
            //JSONObject jsonObject = tweetAnalyzeService.transform(tweetSearchService.getRecentTweets(), null);
            //model.addAttribute("data",tweetSearchService.getRecentTweets());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "twittersearch";
    }
}

