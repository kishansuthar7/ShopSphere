# Advanced Java syllabus demonstrations

These are intentionally small educational modules, separate from the core web application.

- `network/`: compile with `javac extras/network/*.java`, run `java -cp extras/network InventoryServer` in one terminal and `java -cp extras/network InventoryClient GET_STOCK 1` in another.
- `rmi/`: from `extras/rmi`, run `javac *.java`, then start `java InventoryServer`, then `java InventoryClient 1` in another terminal. Use a JDK compatible with your security policy.
- `swing-admin/`: run `javac extras/swing-admin/ShopSphereAdminDemo.java` then `java -cp extras/swing-admin ShopSphereAdminDemo`.
- `syllabus-demo/`: contains locale/currency and URLConnection examples.

These are syllabus demos, not production integrations with the MySQL application. The Socket server accepts a command but intentionally returns a demo response; the RMI service is similarly a remote-call demonstration. Connect them to DAO/service classes as an extension exercise.
