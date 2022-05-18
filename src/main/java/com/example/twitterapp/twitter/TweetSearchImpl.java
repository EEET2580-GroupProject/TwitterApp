package com.example.twitterapp.twitter;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.io.*;
import java.net.URISyntaxException;
import java.util.*;


@Transactional
@Service
public class TweetSearchImpl implements TweetSearchService {
    private String bearerToken = "AAAAAAAAAAAAAAAAAAAAAKvvbQEAAAAA%2Bja54KQwMZGnN3zvB7AYekBoxk4%3DdYbh0Yk2l8brMiVaySjseHuu7EosFTDcdw4vnKwhtbgizUGlWZ";


    public String modifyString(String mode, String modifier, String str) {
        if(str==null || str.isEmpty()){
            return "";
        }
        if(str.equals("/on/")){
            return " "+ modifier;
        }
        String result = str.trim();
        result = modifier+result;
        if(mode.equals("prefix")){
            result = result.replace(" "," "+modifier);
        }
        if(mode.equals("bitwise")){
            result = result.replace(" ", " "+modifier+" ");
        }
        if(mode.equals("wrap")){
            result = result.replace(" ", modifier+" "+modifier);
            result = result +modifier;
        }
        return " "+result;
    }

    public int importRules(Map<String,String> rules) throws IOException, URISyntaxException {
        return createRules(bearerToken,rules);
    }
    public JSONArray getTweet(int limit) throws IOException, URISyntaxException {
        JSONArray result = new JSONArray();
        result = connectStream(bearerToken,limit);
        return result;
    }

    /*
     * This method calls the filtered stream endpoint and streams Tweets from it
     * */
    private static JSONArray connectStream(String bearerToken, int limit) throws IOException, URISyntaxException {

        CloseableHttpClient httpClient = HttpClients.custom()
                .setDefaultRequestConfig(RequestConfig.custom()
                        .setCookieSpec(CookieSpecs.STANDARD).build())
                .build();

        URIBuilder uriBuilder = new URIBuilder("https://api.twitter.com/2/tweets/search/stream");

        ArrayList<NameValuePair> queryParameters;
        queryParameters = new ArrayList<>();
        queryParameters.add(new BasicNameValuePair("tweet.fields", "context_annotations,created_at,entities,geo,public_metrics,possibly_sensitive,referenced_tweets"));
        queryParameters.add(new BasicNameValuePair("expansions", "author_id"));
        uriBuilder.addParameters(queryParameters);

        HttpGet httpGet = new HttpGet(uriBuilder.build());
        httpGet.setHeader("Authorization", String.format("Bearer %s", bearerToken));

        CloseableHttpResponse response = httpClient.execute(httpGet);
        ArrayList<JSONObject> dataJson = new ArrayList<>();
        JSONArray allTweet = new JSONArray();
        try {
            HttpEntity entity = response.getEntity();
            if (null != entity) {

                BufferedReader reader = new BufferedReader(new InputStreamReader((entity.getContent())));
                String line = reader.readLine();
                while (true) {
                        for(JSONObject i: dataJson){
                            System.out.println(i);
                            allTweet.put(i);
                        }
                    try {
                        dataJson.add(new JSONObject(line));
                    }catch (JSONException e){
                        e.printStackTrace();
                    }
                    //System.out.println(line);
                    if (limit == 0) {
                        return allTweet;
                    }else{
                        line = reader.readLine();
                        limit--;
                    }
                }
            }
        }finally {
            System.out.println("Reach limit");
            response.close();
        }
        return null;
    }

    /*
     * Helper method to setup rules before streaming data
     * */
    private static void setupRules(String bearerToken, Map<String, String> rules) throws IOException, URISyntaxException {
        List<String> existingRules = getRules(bearerToken);
        if (existingRules.size() > 0) {
            deleteRules(bearerToken, existingRules);
        }
        createRules(bearerToken, rules);
    }
    public void deleteAllRules() throws URISyntaxException, IOException {
        List<String> existingRules = getRules(bearerToken);
        if (existingRules.size() > 0) {
            deleteRules(bearerToken, existingRules);
        }
    }
    public boolean hasRules() throws URISyntaxException, IOException {
        List<String> existingRules = getRules(bearerToken);
        return existingRules.size() > 0;
    }

    /*
     * Helper method to create rules for filtering
     * */
    private static int createRules(String bearerToken, Map<String, String> rules) throws URISyntaxException, IOException {
        HttpClient httpClient = HttpClients.custom()
                .setDefaultRequestConfig(RequestConfig.custom()
                        .setCookieSpec(CookieSpecs.STANDARD).build())
                .build();

        URIBuilder uriBuilder = new URIBuilder("https://api.twitter.com/2/tweets/search/stream/rules");

        HttpPost httpPost = new HttpPost(uriBuilder.build());
        httpPost.setHeader("Authorization", String.format("Bearer %s", bearerToken));
        httpPost.setHeader("content-type", "application/json");
        StringEntity body = new StringEntity(getFormattedString("{\"add\": [%s]}", rules));
        httpPost.setEntity(body);
        HttpResponse response = httpClient.execute(httpPost);
        HttpEntity entity = response.getEntity();
        JSONObject importResponse = new JSONObject();
        int valid = 0;
        if (null != entity) {
            //System.out.println(EntityUtils.toString(entity, "UTF-8"));
            importResponse = new JSONObject(EntityUtils.toString(entity, "UTF-8"));
            JSONObject meta = (JSONObject) importResponse.get("meta");
            JSONObject summary = (JSONObject) meta.get("summary");
            valid  = (int) summary.get("valid");
        }

        return valid;
    }

    /*
     * Helper method to get existing rules
     * */
    private static List<String> getRules(String bearerToken) throws URISyntaxException, IOException {
        List<String> rules = new ArrayList<>();
        HttpClient httpClient = HttpClients.custom()
                .setDefaultRequestConfig(RequestConfig.custom()
                        .setCookieSpec(CookieSpecs.STANDARD).build())
                .build();

        URIBuilder uriBuilder = new URIBuilder("https://api.twitter.com/2/tweets/search/stream/rules");

        HttpGet httpGet = new HttpGet(uriBuilder.build());
        httpGet.setHeader("Authorization", String.format("Bearer %s", bearerToken));
        httpGet.setHeader("content-type", "application/json");
        HttpResponse response = httpClient.execute(httpGet);
        HttpEntity entity = response.getEntity();
        if (null != entity) {
            JSONObject json = new JSONObject(EntityUtils.toString(entity, "UTF-8"));
            if (json.length() > 1) {
                JSONArray array = (JSONArray) json.get("data");
                for (int i = 0; i < array.length(); i++) {
                    JSONObject jsonObject = (JSONObject) array.get(i);
                    rules.add(jsonObject.getString("id"));
                }
            }
        }
        return rules;
    }

    /*
     * Helper method to delete rules
     * */
    private static void deleteRules(String bearerToken, List<String> existingRules) throws URISyntaxException, IOException {
        HttpClient httpClient = HttpClients.custom()
                .setDefaultRequestConfig(RequestConfig.custom()
                        .setCookieSpec(CookieSpecs.STANDARD).build())
                .build();

        URIBuilder uriBuilder = new URIBuilder("https://api.twitter.com/2/tweets/search/stream/rules");

        HttpPost httpPost = new HttpPost(uriBuilder.build());
        httpPost.setHeader("Authorization", String.format("Bearer %s", bearerToken));
        httpPost.setHeader("content-type", "application/json");
        StringEntity body = new StringEntity(getFormattedString("{ \"delete\": { \"ids\": [%s]}}", existingRules));
        httpPost.setEntity(body);
        HttpResponse response = httpClient.execute(httpPost);
        HttpEntity entity = response.getEntity();
        if (null != entity) {
            System.out.println(EntityUtils.toString(entity, "UTF-8"));
        }
    }

    private static String getFormattedString(String string, List<String> ids) {
        StringBuilder sb = new StringBuilder();
        if (ids.size() == 1) {
            return String.format(string, "\"" + ids.get(0) + "\"");
        } else {
            for (String id : ids) {
                sb.append("\"" + id + "\"" + ",");
            }
            String result = sb.toString();
            return String.format(string, result.substring(0, result.length() - 1));
        }
    }

    private static String getFormattedString(String string, Map<String, String> rules) {
        StringBuilder sb = new StringBuilder();
        if (rules.size() == 1) {
            String key = rules.keySet().iterator().next();
            return String.format(string, "{\"value\": \"" + key + "\", \"tag\": \"" + rules.get(key) + "\"}");
        } else {
            for (Map.Entry<String, String> entry : rules.entrySet()) {
                String value = entry.getKey();
                String tag = entry.getValue();
                sb.append("{\"value\": \"" + value + "\", \"tag\": \"" + tag + "\"}" + ",");
            }
            String result = sb.toString();
            return String.format(string, result.substring(0, result.length() - 1));
        }
    }

    public JSONObject getTweets(String query, String type) throws IOException, URISyntaxException {
        JSONObject response;
        //Replace the search term with a term of your choice
        if (type.equals("recent")) {
            response = search(query, bearerToken, type);
        }else{
            response = search(query,bearerToken,type);
        }

        return response;
    }

    /*
     * This method calls the recent search endpoint with a the search term passed to it as a query parameter
     * */
    private static JSONObject search(String searchString, String bearerToken, String type) throws IOException, URISyntaxException {
        String searchResponse = null;

        HttpClient httpClient = HttpClients.custom()
                .setDefaultRequestConfig(RequestConfig.custom()
                        .setCookieSpec(CookieSpecs.STANDARD).build())
                .build();


        ArrayList<NameValuePair> queryParameters;
        queryParameters = new ArrayList<>();
        URIBuilder uriBuilder = new URIBuilder();
        if(type.equals("recent")) {
            uriBuilder = new URIBuilder("https://api.twitter.com/2/tweets/search/recent");
            queryParameters.add(new BasicNameValuePair("query", searchString));
        }else {
            uriBuilder = new URIBuilder("https://api.twitter.com/2/tweets");
            queryParameters.add(new BasicNameValuePair("ids", searchString));
        }
        queryParameters.add(new BasicNameValuePair("tweet.fields", "context_annotations,created_at,entities,geo,public_metrics,possibly_sensitive,referenced_tweets"));
        queryParameters.add(new BasicNameValuePair("expansions", "author_id"));
        uriBuilder.addParameters(queryParameters);

        HttpGet httpGet = new HttpGet(uriBuilder.build());
        httpGet.setHeader("Authorization", String.format("Bearer %s", bearerToken));
        httpGet.setHeader("Content-Type", "application/json");

        HttpResponse response = httpClient.execute(httpGet);
        HttpEntity entity = response.getEntity();
        JSONObject jsonObject = new JSONObject();
        if (null != entity) {
            searchResponse = EntityUtils.toString(entity, "UTF-8");
            jsonObject = new JSONObject(searchResponse);
        }
        return jsonObject;
    }

}
