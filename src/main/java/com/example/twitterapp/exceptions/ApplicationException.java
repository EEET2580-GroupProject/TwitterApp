package com.example.twitterapp.exceptions;

public class ApplicationException extends RuntimeException{
    public ApplicationException(String message){
        super(message);
    }
}
