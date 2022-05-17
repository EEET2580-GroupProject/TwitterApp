package com.example.twitterapp.twitter;

import com.example.twitterapp.beans.SearchHistory;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface TweetAnalyzeService {
    public JSONObject transform(JSONObject recentTweets, JSONArray filteredTweet);

    public List<JSONObject> cleanData(List<JSONObject> data);

    public JSONObject constructMaxMetrics(String maxLike, String maxReply, String maxRetweet);

    public JSONObject analyzeContextAnnotation(JSONObject tweet, Map<String, Integer> domainFrequency, Map<String, Integer> entityFrequency);

    public JSONObject getCreatedAt(JSONObject tweet);

    public JSONObject getEntities(JSONObject tweet, Map<String, Integer> hashtagsFrequency, Map<String, Integer> mentionFrequency, Map<String, Integer> annotationFrequency);

    public JSONObject getPublicMetrics(JSONObject tweet);

    public JSONArray sortTweet(JSONArray tweet, String sortKey, String type);

    public JSONObject constructJSON4Client(JSONArray sortedData,JSONObject maxMetrics, JSONArray sortedDomainFrequency, JSONArray sortedEntityFrequency,
                                           JSONArray sortedHashtagsFrequency, JSONArray sortedMentionFrequency, JSONArray sortedAnnotationFrequency);

    public JSONArray map2JSONArray(Map<String, Integer> map);

    public JSONObject mapHistory2JSON(ArrayList<SearchHistory> recentTweetHistory, ArrayList<SearchHistory> lookUpTweetHistory, ArrayList<SearchHistory> advancedTweetHistory );

    public JSONArray extractHistory(ArrayList<SearchHistory> tweetSearchHistory);
}
