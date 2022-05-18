package com.example.twitterapp.repository;

import com.example.twitterapp.beans.SearchHistory;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public interface SearchRepository extends CrudRepository<SearchHistory, Integer> {
    @Query("select s from SearchHistory s where s.search_type = :type and s.user_id = :userID")
    ArrayList<SearchHistory> searchHistoriesByID(@Param("type") String searchType, @Param("userID") Integer userID);

    @Query("select s from SearchHistory s where s.search_type =:type and s.search_term =:term and s.user_id = :userID")
    ArrayList<SearchHistory> searchTrackTweet(@Param("type") String searchType, @Param("term") String searchTerm, @Param("userID") Integer userID);
}
