package com.example.twitterapp.twitter;

import com.example.twitterapp.beans.SearchHistory;
import com.example.twitterapp.repository.SearchRepository;
import com.fasterxml.jackson.annotation.JsonAlias;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.*;

@Transactional
@Service
public class TweetAnalyzeImpl implements TweetAnalyzeService{

    @Autowired
    SearchRepository searchRepository;

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

    @Override
    public JSONObject mapHistory2JSON(ArrayList<SearchHistory> recentTweetHistory, ArrayList<SearchHistory> lookUpTweetHistory, ArrayList<SearchHistory> advancedTweetHistory) {
        JSONArray recentHistory = extractHistory(recentTweetHistory);
        JSONArray lookupHistory = extractHistory(lookUpTweetHistory);
        JSONArray advancedHistory = extractHistory(advancedTweetHistory);
        JSONObject result = new JSONObject();
        result.put("recent_history", recentHistory);
        result.put("lookup_history", lookupHistory);
        result.put("advanced_history", advancedHistory);
        return result;
    }

    @Override
    public JSONArray extractHistory(ArrayList<SearchHistory> tweetSearchHistory) {
        JSONArray historyArray = new JSONArray();
        for (SearchHistory i: tweetSearchHistory){
            JSONObject history = new JSONObject();
            String dateTime = i.getDate_time().toString();
            //System.out.println(dateTime);
            history.put("date", dateTime.substring(0,dateTime.indexOf("T")));
            history.put("time", dateTime.substring(dateTime.indexOf("T") +1,dateTime.length()));
            history.put("search_term", i.getSearch_term());
            historyArray.put(history);
        }
        return historyArray;
    }

    @Override
    public JSONArray sortOldTweetBy(JSONArray data, String sortBy) {
        JSONArray sorted = new JSONArray();
        List<JSONObject> tweetList = new ArrayList<>();
        for (int i = 0; i < data.length(); i++) {
            tweetList.add(data.getJSONObject(i));
        }

        Collections.sort(tweetList, new Comparator<JSONObject>() {
            @Override
            public int compare(JSONObject o1, JSONObject o2) {
                String id1 = "";
                String id2 = "";
                try{
                    id1 = (String) o1.get(sortBy);
                    id2 = (String) o2.get(sortBy);
                }catch(JSONException e){
                }
                return id1.compareTo(id2);
            }
        });
        for(int i = 0; i < tweetList.size(); i++){
            sorted.put(tweetList.get(i));
        }

        return sorted;
    }

    @Override
    public JSONArray extract4Sorting(JSONArray data, ArrayList<String> dateTime) {
        JSONArray allOldTweets = new JSONArray();
        for (int i =0; i<data.length(); i++){
            JSONObject oldData = (JSONObject) data.get(i);
            JSONArray oldTweets = (JSONArray) oldData.get("sorted_tweet");
            JSONObject oldTweetsWithTimePulled = new JSONObject();
            oldTweetsWithTimePulled.put("date_time_pulled", dateTime.get(i));
            oldTweetsWithTimePulled.put("data",oldTweets);
            /*
            for(int j =0; j<oldTweets.length(); j++){
                allOldTweets.put(oldTweets.get(j));
            }
             */
            allOldTweets.put(oldTweetsWithTimePulled);
        }
        JSONArray allOldTweetsWithTimePulled = new JSONArray();
        for (int i = 0; i< allOldTweets.length(); i++){
            JSONObject temp = allOldTweets.getJSONObject(i);
            JSONArray tempArray = temp.getJSONArray("data");
            String tempDateTime = temp.getString("date_time_pulled");
            for(int j =0;j < tempArray.length(); j++) {
                //JSONObject oldTweetsWithTimePulledIncluded = new JSONObject();
                //oldTweetsWithTimePulledIncluded.put("date_time_pulled", tempDateTime);
                JSONObject tempItem = tempArray.getJSONObject(j);
                tempItem.put("date_time_pulled", tempDateTime);
                allOldTweetsWithTimePulled.put(tempItem);
            }
        }

        return allOldTweetsWithTimePulled;
    }

    @Override
    public JSONArray sortOldTweetByDateTime(JSONArray data) {
        JSONArray sorted = new JSONArray();
        JSONArray batch = new JSONArray();
        for (int i =1; i< data.length();i++){
            JSONObject previousItem = data.getJSONObject(i-1);
            JSONObject currentItem = data.getJSONObject(i);
            batch.put(previousItem);
            if((!previousItem.getString("id").equals(currentItem.getString("id"))) || i == data.length() -1){
                if(i== data.length()-1){
                    batch.put(currentItem);
                }
                JSONArray batchSorted =  sortOldTweetBy(batch,"date_time_pulled");
                batch = new JSONArray();
                for(int j =0; j<batchSorted.length();j++){
                    sorted.put(batchSorted.get(j));
                }
            }
        }
        return sorted;
    }

    @Override
    public JSONArray constructOldTweetsJSON(JSONArray data) {
        JSONArray constructed = new JSONArray();
        JSONArray batch = new JSONArray();
        for (int i =1; i< data.length();i++){
            JSONObject previousItem = data.getJSONObject(i-1);
            JSONObject currentItem = data.getJSONObject(i);
            JSONObject wrapper = new JSONObject();
            wrapper.put("date_time_pulled",previousItem.getString("date_time_pulled"));
            wrapper.put("data",previousItem.get("public_metrics"));
            batch.put(wrapper);
            if((!previousItem.getString("id").equals(currentItem.getString("id"))) || i == data.length() -1){
                //JSONArray batchSorted =  sortOldTweetBy(batch,"date_time_pulled");
                if(i== data.length()-1){
                    JSONObject wrapperCurrent = new JSONObject();
                    wrapperCurrent.put("date_time_pulled",currentItem.getString("date_time_pulled"));
                    wrapperCurrent.put("data",currentItem.get("public_metrics"));
                    batch.put(wrapperCurrent);
                }
                JSONObject item = new JSONObject();
                item.put("id", previousItem.getString("id"));
                item.put("data",batch);
                constructed.put(item);
                batch = new JSONArray();
            }
        }
        return constructed;
    }

    @Override
    public JSONArray trackData(String searchTerm, Integer userID) {
        JSONArray trackTweetArray = new JSONArray();
        ArrayList<SearchHistory> collectionTrackTweets = searchRepository.searchTrackTweet("lookup",searchTerm,userID);

        ArrayList<String> timePulled = new ArrayList<>();
        ArrayList<JSONObject> colllectionOldTweets = new ArrayList<>();
        for(SearchHistory s: collectionTrackTweets){
            JSONObject oldTweets = new JSONObject(s.getSearch_data());
            String dateTime = s.getDate_time().toString();
            //System.out.println(oldTweets);
            colllectionOldTweets.add(oldTweets);
            timePulled.add(dateTime);
        }
        for(JSONObject j : colllectionOldTweets){
            trackTweetArray.put(j);
        }

        JSONArray extracted = extract4Sorting(trackTweetArray, timePulled);
        JSONArray idSorted =  sortOldTweetBy(extracted,"id");
        JSONArray dateTimeSorted = sortOldTweetByDateTime(idSorted);

        return constructOldTweetsJSON(dateTimeSorted);
    }
}
