package com.example.demo.twitter;

import javax.validation.constraints.Max;

public class test {
    public static String modifyString(String mode, String modifier, String str){
        String result = str.trim();
        result = modifier+result;
        if(mode.equals("prefix")){
            result = result.replace(" "," "+modifier);
        }
        if(mode.equals("wrap")){
            result = result.replace(" ", modifier+" "+modifier);
            result = result +modifier;
        }
        return result;
    }
    public static void pagination(){
        System.out.println(19/10);
    }

    public static int num = 0;
    public static int getMax(int number){
        num = Math.max(number, num);
        return num;
    }
    public static void main(String[] args) {
        System.out.println(getMax(10));
        System.out.println(getMax(8));
        System.out.println(getMax(11));
        pagination();
        System.out.println(modifyString("wrap","\"","en vn "));
    }
}
