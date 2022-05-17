package com.example.twitterapp.beans;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "search_history", schema = "public")
public class SearchHistory {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private int search_id;

    private int user_id;
    private String port;
    private String search_term;
    private String search_type;
    private String search_data;
    private LocalDateTime date_time;

    public void setDate_time(LocalDateTime date_time) {
        this.date_time = date_time;
    }

    public LocalDateTime getDate_time() {
        return date_time;
    }

    public void setSearch_data(String search_data) {
        this.search_data = search_data;
    }

    public String getSearch_data() {
        return search_data;
    }

    public void setSearch_type(String search_type) {
        this.search_type = search_type;
    }

    public String getSearch_type() {
        return search_type;
    }

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

    @Override
    public String toString() {
        return "SearchHistory{" +
                "search_id=" + search_id +
                ", search_term='" + search_term + '\'' +
                ", search_type='" + search_type + '\'' +
                ", date_time=" + date_time +
                '}';
    }
}
