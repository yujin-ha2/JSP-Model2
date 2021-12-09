package net.action;

import java.util.HashMap;

public class CategoryName {
    
    static HashMap<Integer, String> categoryMap = new HashMap<Integer, String>();

    static
    {
        categoryMap.put(100, "가전제품");
        categoryMap.put(200, "패션");
        categoryMap.put(300, "영유아 용품");
        categoryMap.put(400, "식품");
        categoryMap.put(500, "뷰티");
    }

    public static String get(int key){
    	return categoryMap.get(key);
   }

}
