import java.rmi.*;import java.rmi.server.*;
public class InventoryServiceImpl extends UnicastRemoteObject implements InventoryService {public InventoryServiceImpl()throws RemoteException{}public String getStock(int productId)throws RemoteException{return "Demo inventory response for product "+productId+": 10 units";}}
