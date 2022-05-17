package com.example.twitterapp.repository;

import com.example.twitterapp.beans.SearchHistory;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SearchRepository extends CrudRepository<SearchHistory, Integer> {

}
