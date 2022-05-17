package com.example.twitterapp.twitter;

import com.fasterxml.jackson.annotation.JsonAlias;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.*;

@Transactional
@Service
public class TweetAnalyzeImpl implements TweetAnalyzeService{

    private String maxLikeCount = "0";
    private String maxReplyCount = "0";
    private String maxRetweetCount = "0";

    @Override
    public JSONObject transform(JSONObject recentTweets, JSONArray filteredTweet) {
        Map<String,Integer> domainFrequency= new HashMap<>();
        Map<String,Integer> entityFrequency= new HashMap<>();
        Map<String, Integer> hashtagsFrequency = new HashMap<>();
        Map<String, Integer> mentionFrequency = new HashMap<>();
        Map<String, Integer> annotationFrequency = new HashMap<>();

        JSONObject result = new JSONObject();
        JSONArray sortedData = new JSONArray();

        try {
            if(recentTweets != null) {
                JSONArray data = (JSONArray) recentTweets.get("data");
                sortedData = sortTweet(data, "like_count", "recent");
            }else{
                sortedData = sortTweet(filteredTweet, "like_count", "filtered");

            }

            for (int i = 0; i < sortedData.length(); i++) {
                JSONObject tweet = (JSONObject) sortedData.get(i);
                //JSONObject tweetData = (JSONObject) tweet.get("data");
                analyzeContextAnnotation(tweet, domainFrequency, entityFrequency);
                //getCreatedAt(tweet);
                getEntities(tweet, hashtagsFrequency, mentionFrequency, annotationFrequency);
                getPublicMetrics(tweet);
            }

            JSONObject maxMetrics = constructMaxMetrics(maxLikeCount,maxReplyCount,maxRetweetCount);

            //System.out.println(sortFrequencyAttributes(entityFrequency));
            map2JSONArray(sortFrequencyAttributes(entityFrequency));
            result =  constructJSON4Client(sortedData,maxMetrics, map2JSONArray(sortFrequencyAttributes(domainFrequency)), map2JSONArray(sortFrequencyAttributes(entityFrequency)),
                    map2JSONArray(sortFrequencyAttributes(hashtagsFrequency)), map2JSONArray(sortFrequencyAttributes(mentionFrequency)), map2JSONArray(sortFrequencyAttributes(annotationFrequency)));
        }catch (Exception e){
            e.printStackTrace();
        }
        /*
        for(String domainName: domainFrequency.keySet()){
            System.out.println(domainName + " Frequency: " + domainFrequency.get(domainName));
        }
         */

        return result;
    }

    @Override
    public JSONObject constructMaxMetrics(String maxLike, String maxReply, String maxRetweet) {
        JSONObject metric = new JSONObject();
        metric.put("max_like", Integer.parseInt(maxLike));
        metric.put("max_reply", Integer.parseInt(maxReply));
        metric.put("max_retweet", Integer.parseInt(maxRetweet));
        return metric;
    }

    @Override
    public JSONObject analyzeContextAnnotation(JSONObject tweet, Map<String,Integer> domainFrequency, Map<String,Integer> entityFrequency) {
        try {
            JSONArray contextAnnotations = (JSONArray) tweet.get("context_annotations");
            for (int j = 0; j < contextAnnotations.length(); j++) {
                JSONObject iterator = (JSONObject) contextAnnotations.get(j);
                JSONObject domain = (JSONObject) iterator.get("domain");
                String domainName = (String) domain.get("name");
                JSONObject entity = (JSONObject) iterator.get("entity");
                String entityName = (String) entity.get("name");
                //System.out.println(domainName + " " + entityName);
                if (domainFrequency.containsKey(domainName)) {
                    domainFrequency.put(domainName, domainFrequency.get(domainName) + 1);
                } else {
                    domainFrequency.put(domainName, 1);
                }
                if (entityFrequency.containsKey(entityName)) {
                    entityFrequency.put(entityName, entityFrequency.get(entityName) + 1);
                } else {
                    entityFrequency.put(entityName, 1);
                }
            }
        }catch (JSONException e){

        }
        return null;
    }

    @Override
    public JSONObject getCreatedAt(JSONObject tweet) {
        String tweetDateTime = (String) tweet.get("created_at");
        System.out.println(tweetDateTime);
        return null;
    }

    @Override
    public JSONObject getEntities(JSONObject tweet, Map<String, Integer> hashtagsFrequency, Map<String, Integer> mentionFrequency, Map<String, Integer> annotationFrequency) {

        try {
            JSONObject entities = (JSONObject) tweet.get("entities");
            JSONArray hashtags = (JSONArray) entities.get("hashtags");

            for (int i = 0; i < hashtags.length(); i++) {
                JSONObject iterator = (JSONObject) hashtags.get(i);
                String tag = (String) iterator.get("tag");
                //System.out.println("tag: "+ tag);
                if(hashtagsFrequency.containsKey(tag)){
                    hashtagsFrequency.put(tag, hashtagsFrequency.get(tag) + 1);
                }else{
                    hashtagsFrequency.put(tag, 1);
                }
            }


            JSONArray annotations = (JSONArray) entities.get("annotations");
            for (int i = 0; i < annotations.length(); i++) {
                JSONObject iterator = (JSONObject) annotations.get(i);
                String normalized_text = (String) iterator.get("normalized_text");
                //System.out.println("annotation: " + normalized_text);
                if(annotationFrequency.containsKey(normalized_text)){
                    annotationFrequency.put(normalized_text, annotationFrequency.get(normalized_text)+1);
                }else{
                    annotationFrequency.put(normalized_text, 1);
                }
            }



            JSONArray mentions = (JSONArray) entities.get("mentions");
            for (int i = 0; i < mentions.length(); i++) {
                JSONObject iterator = (JSONObject) mentions.get(i);
                String username = (String) iterator.get("username");
                String id = (String) iterator.get("id");
                //System.out.println("username: " + username +", Id: " + id);
                if(mentionFrequency.containsKey(username)){
                    mentionFrequency.put(username, mentionFrequency.get(username) + 1);
                }else{
                    mentionFrequency.put(username, 1);
                }
            }
        }catch (JSONException e) {
            //e.printStackTrace();
        }

        return null;
    }

    @Override
    public JSONObject getPublicMetrics(JSONObject tweet) {
        JSONObject publicMetrics = (JSONObject) tweet.get("public_metrics");
        int likeCount = (int) publicMetrics.get("like_count");
        int quoteCount = (int) publicMetrics.get("quote_count");
        int replyCount = (int) publicMetrics.get("reply_count");
        int retweetCount = (int) publicMetrics.get("retweet_count");
        //System.out.println("Likes: "+likeCount +", Quotes: "+ quoteCount + ", Replies: " + replyCount + ", Retweet: " + retweetCount);

        maxLikeCount =  Integer.toString(Math.max(likeCount, Integer.parseInt(maxLikeCount)));
        maxReplyCount = Integer.toString(Math.max(replyCount, Integer.parseInt(maxReplyCount)));
        maxRetweetCount = Integer.toString(Math.max(retweetCount, Integer.parseInt(maxRetweetCount)));
        return null;
    }

    @Override
    public List<JSONObject> cleanData(List<JSONObject> data){
        Set<JSONObject> unique = new HashSet<>();
        List<JSONObject> result = new ArrayList<>();
        for(int i = 0; i < data.size(); i++){
            unique.add(data.get(i));
        }

        Iterator value = unique.iterator();
        while (value.hasNext()){
            result.add((JSONObject) value.next());
        }
        return result;
    }

    @Override
    public JSONArray sortTweet(JSONArray tweet, String sortKey, String type) {
        JSONArray sorted = new JSONArray();
        List<JSONObject> tweetList = new ArrayList<>();
        if(type.equals("recent")) {
            for (int i = 0; i < tweet.length(); i++) {
                tweetList.add(tweet.getJSONObject(i));
            }
        }else{
            for (int i = 0; i < tweet.length(); i++) {
                JSONObject data = (JSONObject) tweet.get(i);
                JSONObject innerData = (JSONObject) data.get("data");
                tweetList.add(innerData);
            }
        }
        tweetList = cleanData(tweetList);
        Collections.sort(tweetList, new Comparator<JSONObject>() {
            @Override
            public int compare(JSONObject o1, JSONObject o2) {
                int likeCount1 = 0;
                int likeCount2 = 0;
                JSONObject o1PublicMetric = (JSONObject) o1.get("public_metrics");
                JSONObject o2PublicMetric = (JSONObject) o2.get("public_metrics");
                try{
                    likeCount1 = (int) o1PublicMetric.get(sortKey);
                    likeCount2 = (int) o2PublicMetric.get(sortKey);
                }catch(JSONException e){
                }
                return Integer.compare(likeCount2,likeCount1);
            }
        });
        for(int i = 0; i < tweetList.size(); i++){
            sorted.put(tweetList.get(i));
        }

        return sorted;
    }
    public Map<String, Integer>  sortFrequencyAttributes(Map<String, Integer> map){
        List<Map.Entry<String, Integer>> sorted = new ArrayList<>(map.entrySet());
        sorted.sort(Map.Entry.comparingByValue(Comparator.reverseOrder()));
        //sorted.forEach(System.out::println);
        Map<String, Integer> sortedMap = new LinkedHashMap<>();
        for (Map.Entry<String, Integer> entry : sorted) {
            sortedMap.put(entry.getKey(), entry.getValue());
        }
        return sortedMap;

    }

    @Override
    public JSONObject constructJSON4Client(JSONArray sortedData, JSONObject maxMetrics,JSONArray sortedDomainFrequency, JSONArray sortedEntityFrequency,
                                           JSONArray sortedHashtagsFrequency, JSONArray sortedMentionFrequency, JSONArray sortedAnnotationFrequency){


        //System.out.println(sortedEntityFrequency);
        JSONObject clientJSON = new JSONObject();
        clientJSON.put("max_metrics", maxMetrics);
        clientJSON.put("domain_frequency", sortedDomainFrequency);
        clientJSON.put("entity_frequency", sortedEntityFrequency);
        clientJSON.put("hashtag_frequency", sortedHashtagsFrequency);
        clientJSON.put("mention_frequency", sortedMentionFrequency);
        clientJSON.put("annotation_frequency", sortedAnnotationFrequency);
        clientJSON.put("sorted_tweet", sortedData);
        //System.out.println(clientJSON);
        return clientJSON;
    }

    @Override
    public JSONArray map2JSONArray(Map<String, Integer> map) {
        JSONArray jsonArray = new JSONArray();

        Iterator<Map.Entry<String, Integer>> itr = map.entrySet().iterator();

        while(itr.hasNext()) {
            Map.Entry<String, Integer> entry = itr.next();
            Map<String, Integer> item = new HashMap<>();
            item.put(entry.getKey(), entry.getValue());
            JSONObject newObj = new JSONObject();
            newObj.put("attribute",item);
            jsonArray.put(newObj);
        }
        return jsonArray;
    }


}
