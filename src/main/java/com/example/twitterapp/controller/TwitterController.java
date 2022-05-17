package com.example.twitterapp.controller;

import com.example.twitterapp.beans.Login;
import com.example.twitterapp.beans.SearchHistory;
import com.example.twitterapp.beans.User;
import com.example.twitterapp.repository.SearchRepository;
import com.example.twitterapp.repository.UserRepository;
import com.example.twitterapp.twitter.TweetAnalyzeService;
import com.example.twitterapp.twitter.TweetSearchService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Callable;

@Controller
public class TwitterController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private SearchRepository searchRepository;

    @Autowired
    private TweetSearchService tweetSearchService;

    @Autowired
    private TweetAnalyzeService tweetAnalyzeService;


    @GetMapping("/twitter/connectStream")
    public Callable<String> getTweet(@RequestParam(value="q-max") int maxTweet,SearchHistory history, Model model, @SessionAttribute("login") Login login){
        User user = userRepository.searchByName(login.getUsername());
        model.addAttribute("username",user.getUsername());

        int max = maxTweet;
        if (maxTweet > 40){
            max = 40;
        }else if(maxTweet < 0){
            max = 0;
        }
        int finalMax = max;
        return ()->{
            JSONObject jsonObject = new JSONObject();
            try {
                jsonObject = tweetAnalyzeService.transform(null, tweetSearchService.getTweet(finalMax));
            }catch (NullPointerException n){
                System.out.println("Try again, Connection error");
            }
            model.addAttribute("data",jsonObject);
            return "twitterapi";
        };
    }

    @GetMapping("/twitter/setrules")
    public Callable<String> searchTwitter(@RequestParam(value="q-term") String search_term,
                                          @RequestParam(value="q-exclude",required=false) String exclude,
                                          @RequestParam(value="q-or",required=false) String anyWord,
                                          @RequestParam(value="q-exact",required=false) String exactWord,
                                          @RequestParam(value="q-usertag",required=false) String userTag,
                                          @RequestParam(value="q-hashtag",required=false) String hashTag,
                                          @RequestParam(value="q-fromuser",required=false) String fromUser,
                                          @RequestParam(value="q-touser",required=false) String toUser,
                                          @RequestParam(value="q-retweetof",required=false) String retweetOf,
                                          @RequestParam(value="q-isretweet",required=false) String isRetweet,
                                          @RequestParam(value="q-isreply",required=false) String isReply,
                                          @RequestParam(value="q-isquote",required=false) String isQuote,
                                          @RequestParam(value="q-isverified",required=false) String isVerified,
                                          @RequestParam(value="q-hashashtag",required=false) String hasHashtag,
                                          @RequestParam(value="q-haslink",required=false) String hasLinks,
                                          @RequestParam(value="q-mentions",required=false) String hasMentions,
                                          @RequestParam(value="q-media",required=false) String hasMedia,
                                          @RequestParam(value="q-hasimages",required=false) String hasImages,
                                          @RequestParam(value="q-hasvideos",required=false) String hasVideos,
                                          @RequestParam(value="q-language",required=false) String language,
                                          @RequestParam(value="q-tag") String tag,
                                          SearchHistory history, @SessionAttribute("login") Login login,
                                          Model model, HttpServletRequest request) throws IOException,
                                            URISyntaxException {

        User user = userRepository.searchByName(login.getUsername());
        model.addAttribute("username",user.getUsername());

        System.out.println("In twitter Search");
        System.out.println("Async enabled: "+ request.isAsyncSupported());
        System.out.println("Thread from servlet: "+ Thread.currentThread().getName());



        //filteredSearch.importRules(rules);

        return ()->{
            String query;

            query = search_term + tweetSearchService.modifyString("prefix", "-", exclude)
                    + tweetSearchService.modifyString("bitwise", "OR", anyWord)
                    + tweetSearchService.modifyString("wrap", "\"", exactWord)
                    + tweetSearchService.modifyString("prefix", "@", userTag)
                    + tweetSearchService.modifyString("prefix", "#", hashTag)
                    + tweetSearchService.modifyString("prefix", "from:", fromUser)
                    + tweetSearchService.modifyString("prefix", "to:",toUser)
                    + tweetSearchService.modifyString("prefix", "retweets_of", retweetOf)
                    + tweetSearchService.modifyString("prefix", "is:retweet", isRetweet)
                    + tweetSearchService.modifyString("prefix", "is:reply", isReply)
                    + tweetSearchService.modifyString("prefix", "is:quote", isQuote)
                    + tweetSearchService.modifyString("prefix", "is:verified", isVerified)
                    + tweetSearchService.modifyString("prefix", "has:hashtags", hasHashtag)
                    + tweetSearchService.modifyString("prefix", "has:links", hasLinks)
                    + tweetSearchService.modifyString("prefix", "has:mentions", hasMentions)
                    + tweetSearchService.modifyString("prefix", "has:media", hasMedia)
                    + tweetSearchService.modifyString("prefix", "has:images", hasImages)
                    + tweetSearchService.modifyString("prefix", "has:videos", hasVideos)
                    + tweetSearchService.modifyString("prefix", "lang:", language);



            Map<String,String> rules = new HashMap<>();
            rules.put(query.trim(),tag);

            int response =  tweetSearchService.importRules(rules);
            if(response > 0) {
                history.setPort("twitter");
                history.setUser_id(user.getId());
                history.setSearch_term(search_term);
                model.addAttribute("query", "Query: "+ query.trim());
                model.addAttribute("report", "Create rules successfully");
                searchRepository.save(history);
            }else {
                model.addAttribute("report", "Your query is invalid");
            }
            return "twittersearch";
        };
    }

    @GetMapping("/twitter/lookupTweet")
    public Callable<String> lookUpTweet(@RequestParam(value = "q-ids") String ids, Model model, @SessionAttribute("login") Login login){
        User user = userRepository.searchByName(login.getUsername());
        model.addAttribute("username",user.getUsername());
        return ()->{
            JSONObject jsonObject = new JSONObject();
            if (ids.isEmpty()){
                model.addAttribute("report", "Please enter something");
                return "twittersearch";
            }
            try {
                JSONObject tweets = tweetSearchService.getTweets(ids,"ids");
                System.out.println(tweets);
                jsonObject = tweetAnalyzeService.transform(tweets,null);
            }catch (Exception e){
                e.printStackTrace();
            }
            model.addAttribute("data",jsonObject);
            return "twitterapi";
        };
    }

    @GetMapping("/twitter/getRecent")
    public Callable<String> getRecent(@RequestParam(value = "q-query") String query, Model model, @SessionAttribute("login") Login login){
        User user = userRepository.searchByName(login.getUsername());
        model.addAttribute("username",user.getUsername());
        return ()->{
            JSONObject jsonObject = new JSONObject();
            try {
                JSONObject tweets = tweetSearchService.getTweets(query,"recent");
                jsonObject = tweetAnalyzeService.transform(tweets,null);
                System.out.println("in controller "+ tweets);

                JSONObject meta = (JSONObject) tweets.get("meta");
                Integer result_count = (Integer) meta.get("result_count");
                if(result_count == 0){
                    model.addAttribute("report","No tweet found");
                    return "twittersearch";
                }

            }catch (Exception e){
                e.printStackTrace();
                model.addAttribute("report","Your request is error");
                return "twittersearch";
            }
            model.addAttribute("data",jsonObject);
            return "twitterapi";
        };
    }

}
