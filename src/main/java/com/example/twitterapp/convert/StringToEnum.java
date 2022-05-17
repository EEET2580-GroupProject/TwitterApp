package com.example.twitterapp.convert;

import com.example.twitterapp.beans.Gender;
import org.springframework.core.convert.converter.Converter;

public class StringToEnum implements Converter<String, Gender> {
    @Override
    public Gender convert(String s){
        if(s.equals("Male")){
            return Gender.MALE;
        }
        else if(s.equals("Female")){
            return Gender.FEMALE;
        }
        else{
            return Gender.OTHER;
        }
    }
}
