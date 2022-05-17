package com.example.twitterapp.beans;

import javax.persistence.*;

@Entity
@Table(name = "search_history", schema = "public")
public class SearchHistory {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private int search_id;

    private int user_id;
    private String port;
    private String search_term;

    public int getSearch_id() {
        return search_id;
    }

    public void setSearch_id(int search_id) {
        this.search_id = search_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getPort() {
        return port;
    }

    public void setPort(String port) {
        this.port = port;
    }

    public String getSearch_term() {
        return search_term;
    }

    public void setSearch_term(String search_term) {
        this.search_term = search_term;
    }
}
