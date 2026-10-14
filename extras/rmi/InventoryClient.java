import java.rmi.*;
public class InventoryClient {public static void main(String[] a)throws Exception{InventoryService s=(InventoryService)Naming.lookup("rmi://localhost/InventoryService");System.out.println(s.getStock(a.length==0?1:Integer.parseInt(a[0])));}}
