import java.io.*;import java.net.*;
/** Educational line-based Socket/ServerSocket demonstration. Run server first. */
public class InventoryServer {public static void main(String[] args)throws IOException{try(ServerSocket server=new ServerSocket(5050)){System.out.println("Inventory server listening on 5050");while(true){try(Socket client=server.accept();BufferedReader in=new BufferedReader(new InputStreamReader(client.getInputStream()));PrintWriter out=new PrintWriter(client.getOutputStream(),true)){String command=in.readLine();out.println("OK demo response for: "+command);}}}}}
