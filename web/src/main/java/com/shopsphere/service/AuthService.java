package com.shopsphere.service;

import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;

import com.shopsphere.dao.UserDAO;
import com.shopsphere.model.User;

public class AuthService {

    private final UserDAO dao = new UserDAO();

    public User login(String email, String password) throws SQLException {
        if (email == null || password == null
                || email.isBlank() || password.isBlank()) {
            return null;
        }

        String normalizedEmail = email.trim().toLowerCase();
        String hash = dao.passwordHash(normalizedEmail);

        if (hash == null || !BCrypt.checkpw(password, hash)) {
            return null;
        }

        return dao.findByEmail(normalizedEmail);
    }

    public void register(String name, String email, String password, String mobile)
            throws SQLException {

        if (name == null || name.trim().length() < 2) {
            throw new IllegalArgumentException(
                    "Name must contain at least 2 characters.");
        }

        if (email == null || !email.matches(
                "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
            throw new IllegalArgumentException(
                    "Enter a valid email address.");
        }

        if (password == null || password.length() < 8) {
            throw new IllegalArgumentException(
                    "Password must be at least 8 characters.");
        }

        String normalizedEmail = email.trim().toLowerCase();

        if (dao.findByEmail(normalizedEmail) != null) {
            throw new IllegalArgumentException(
                    "An account with this email already exists.");
        }

        String passwordHash = BCrypt.hashpw(password, BCrypt.gensalt(12));

        dao.create(
                name.trim(),
                normalizedEmail,
                passwordHash,
                mobile == null ? "" : mobile.trim()
        );
    }
}
