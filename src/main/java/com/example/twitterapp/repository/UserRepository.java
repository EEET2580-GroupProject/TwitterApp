package com.example.twitterapp.repository;

import com.example.twitterapp.beans.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends CrudRepository<User, Integer> {
    // Write customer handler to search for username
    @Query("select u from User u where u.email = :name")
    User searchByName(@Param("name") String emailName);

}
