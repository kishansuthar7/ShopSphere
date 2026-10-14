package com.shopsphere.listener;
import jakarta.servlet.*; import jakarta.servlet.annotation.WebListener;
@WebListener public class AppListener implements ServletContextListener {public void contextInitialized(ServletContextEvent e){e.getServletContext().setAttribute("appName","ShopSphere");e.getServletContext().setAttribute("appVersion","1.0.0");}public void contextDestroyed(ServletContextEvent e){}}
