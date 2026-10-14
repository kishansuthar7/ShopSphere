import java.rmi.registry.*;import java.rmi.*;
public class InventoryServer {public static void main(String[] a)throws Exception{LocateRegistry.createRegistry(1099);Naming.rebind("InventoryService",new InventoryServiceImpl());System.out.println("RMI inventory service ready on port 1099");}}
