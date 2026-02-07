package com.tmis.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBUtil {

	private static String URL;
    private static String USER;
    private static String PASSWORD;

    static {
        try {
            Properties props = new Properties();
            InputStream is = DBUtil.class
                    .getClassLoader()
                    .getResourceAsStream("db.properties");

            props.load(is);

            URL = props.getProperty("db.url");
            USER = props.getProperty("db.user");
            PASSWORD = props.getProperty("db.password");

            Class.forName("org.postgresql.Driver");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private DBUtil() {}

    public static Connection getConnection() throws Exception {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}