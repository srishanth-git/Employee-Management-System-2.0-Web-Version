package util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppStartupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("[App] Starting Employee Management System Web...");
        DBInitializer.initialize();
        System.out.println("[App] Ready.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("[App] Shutting down.");
    }
}
