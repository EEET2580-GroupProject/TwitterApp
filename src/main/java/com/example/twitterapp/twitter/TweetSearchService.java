package com.example.twitterapp.twitter;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.Map;

public interface TweetSearchService {
    public int importRules(Map<String,String> rules) throws IOException, URISyntaxException;

    public JSONArray getTweet(int limit) throws IOException, URISyntaxException;

    public void deleteAllRules() throws URISyntaxException, IOException;

    public String modifyString(String mode,String modifier, String str);

    public JSONObject getTweets(String query, String type) throws IOException, URISyntaxException;
}
