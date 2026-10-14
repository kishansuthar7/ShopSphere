import java.rmi.*;
public interface InventoryService extends Remote {String getStock(int productId)throws RemoteException;}
