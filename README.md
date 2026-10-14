# ShopSphere — Java E-Commerce Management System

A student capstone built around **Java 17, Jakarta Servlet/JSP, Tomcat 11, Maven, JDBC and MySQL**. It uses an MVC/layered structure and includes separate educational Socket, RMI and Swing examples.

## Implemented core flow

- Responsive product catalogue with search, discount pricing and stock display
- Customer registration and login; BCrypt password hashing
- Session-based authentication, logout, protected cart/checkout/orders routes
- PreparedStatement-based JDBC access
- Cart add/remove, server-side stock validation and totals
- Checkout with transaction, order/order-item/payment records and stock decrement
- Customer order history
- Role-protected admin dashboard, product add/deactivate, customer/order/sales summary
- ServletContextListener, JSP fragments, EL/JSTL, JSP tag file, deployment descriptor
- SQL schema covering users, addresses, categories, products, cart, wishlist, orders, order items, payments, reviews and coupons
- Separate Java Socket, RMI, Swing, internationalization and URLConnection syllabus demos

## Requirements

- JDK 17 or newer
- Apache Tomcat 11
- Maven 3.9+
- MySQL 8+
- VS Code with Extension Pack for Java (or IntelliJ/Eclipse)

## Setup on Windows (PowerShell)

1. Extract the ZIP. Open the `ShopSphere` folder in VS Code.
2. In MySQL Workbench or the MySQL CLI, run `database/shopsphere.sql`.
3. Set database credentials in PowerShell **before starting Tomcat**. Update these to match your local MySQL account:

   ```powershell
   $env:SHOPSPHERE_DB_URL = "jdbc:mysql://localhost:3306/shopsphere?useSSL=false&serverTimezone=Asia/Kolkata"
   $env:SHOPSPHERE_DB_USER = "root"
   $env:SHOPSPHERE_DB_PASSWORD = "YOUR_MYSQL_PASSWORD"
   ```

   If you start Tomcat from a different terminal/service, set the environment variables there too. Do not commit credentials to GitHub.

4. From the project root:

   ```powershell
   mvn clean package
   ```

5. Copy `target\shopsphere.war` into Tomcat 11's `webapps` folder and start Tomcat. Or configure the WAR as a deployment in your IDE.
6. Open `http://localhost:8080/shopsphere/` (if your Tomcat uses port 8080).
7. Register a customer account. To promote that account to admin, run the following SQL using the exact email you registered:

   ```sql
   USE shopsphere;
   UPDATE users SET role='ADMIN' WHERE email='your-email@example.com';
   ```

   Log out and log back in; the admin link and `/admin` route will be available.

## VS Code quick checks

```powershell
java -version
mvn -version
mvn clean package
```

Use **Tomcat 11**. The code uses `jakarta.servlet.*`; it will not run unchanged on Tomcat 9, which uses the older `javax.servlet.*` namespace. Ensure your MySQL service is running before opening the application.

## Project structure

```text
ShopSphere/
├── pom.xml
├── database/shopsphere.sql
├── web/src/main/java/com/shopsphere/
│   ├── controller/       # Servlets / request controllers
│   ├── dao/              # JDBC queries
│   ├── filter/           # Customer and admin protection
│   ├── listener/         # ServletContext lifecycle
│   ├── model/            # Product/User models
│   ├── service/          # Authentication rules
│   └── util/              # Database connection
├── web/src/main/webapp/
│   ├── WEB-INF/views/    # JSP views and fragments
│   ├── WEB-INF/tags/     # JSP tag files
│   └── css/style.css
└── extras/                # Socket, RMI, Swing and syllabus demos
```

## Security and project limitations

- Passwords are hashed with BCrypt. SQL uses PreparedStatement.
- Checkout calculates totals from database prices and wraps order creation, item insertion, stock decrement and cart clearing in a transaction.
- Payments are **mock only**; this project does not collect real payment credentials or charge money.
- Configure HTTPS and secure cookies before any real deployment. This student project is not a production-ready commerce platform.
- Some RTU syllabus topics (JSTL XML/SQL, JNDI datasource, detailed JSP lifecycle/scriptlet demo, full category/coupon/review/wishlist CRUD, address book and order status administration) are listed as extension/viva work rather than integrated full features. The schema and tag-file examples provide starting points.
- Demo images load from remote URLs and require internet access; catalogue works without them.

## Troubleshooting

- **Access denied for MySQL:** check `SHOPSPHERE_DB_USER` and `SHOPSPHERE_DB_PASSWORD`.
- **Unknown database:** run `database/shopsphere.sql` first.
- **404:** confirm the WAR is named `shopsphere.war`, wait for Tomcat deployment, and use `/shopsphere/`.
- **`javax.servlet` errors:** use Tomcat 11 and the Jakarta imports in this project.
- **Build fails:** check `java -version`, `mvn -version`, internet access for first-time Maven dependency downloads, and review the first Maven `ERROR` lines.

## Testing checklist

1. Register with a new email; duplicate email should fail.
2. Log in with correct and incorrect passwords.
3. Open `/cart` while logged out; expect redirect to login.
4. Add a product to cart, remove it, and add it again.
5. Checkout; confirm an order appears in `/orders`, stock decreases, and cart empties.
6. Promote your account to `ADMIN`, sign in again, add a product and deactivate a product.
7. Sign in as a normal customer and open `/admin`; expect HTTP 403.
8. Run the Socket/RMI/Swing demos as documented in `extras/README.md`.

## RTU viva map

| Topic | Location / demonstration |
|---|---|
| Servlet, request/response, lifecycle | `controller/` servlets; lifecycle theory for viva |
| MVC / N-tier | JSP → Servlet → DAO/Service → JDBC → MySQL |
| JDBC and PreparedStatement | `dao/`, `util/DB.java`, `controller/CheckoutServlet.java` |
| Session and filters | `AuthServlet`, `AuthenticationFilter`, `AdminFilter` |
| Listener and context | `listener/AppListener.java` |
| JSP, EL, JSTL, fragments, tag file | `WEB-INF/views/`, `fragments/`, `WEB-INF/tags/productCard.tag` |
| Serialization | `model/Product.java` implements `Serializable` |
| Socket / ServerSocket | `extras/network/` |
| RMI / registry | `extras/rmi/` |
| Swing components | `extras/swing-admin/` |
| Internationalization / URLConnection | `extras/syllabus-demo/` |
| Database tables / relationships | `database/shopsphere.sql` |

## Before submitting

Build and run it locally, capture your own screenshots, draw the ER/system/use-case diagrams, and write the final report based on your actual testing. Never claim a module is integrated unless you have demonstrated it running.
