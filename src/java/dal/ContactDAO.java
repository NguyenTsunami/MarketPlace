/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Contact;

/**
 *
 * @author thuy
 */
public class ContactDAO extends BaseDAO {

    public boolean addContact(Contact fb) {
        String sql = "insert into Contact values (?,?,?)";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, fb.getName());
            statement.setString(2, fb.getEmail());
            statement.setString(3, fb.getMess());
            statement.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(ContactDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}
