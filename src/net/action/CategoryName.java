package net.action;

import java.util.HashMap;

public class CategoryName {
    
    static HashMap<Integer, String> categoryMap = new HashMap<Integer, String>();

    static
    {
        categoryMap.put(100, "������ǰ");
        categoryMap.put(200, "�м�");
        categoryMap.put(300, "������ ��ǰ");
        categoryMap.put(400, "��ǰ");
        categoryMap.put(500, "��Ƽ");
    }

    public static String get(int key){
    	return categoryMap.get(key);
   }

}
