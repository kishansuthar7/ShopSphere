import java.text.*;import java.util.*;
public class InternationalizationDemo {public static void main(String[] args){for(Locale l:new Locale[]{Locale.US,new Locale("hi","IN")}){System.out.println(l+" => "+NumberFormat.getCurrencyInstance(l).format(12345.67));System.out.println(DateFormat.getDateInstance(DateFormat.LONG,l).format(new Date()));}}}
