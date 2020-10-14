/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Address;
import model.OrderItem;
import model.Product;
import model.Size;

/**
 *
 * @author thuy
 */
public class MarketDAO extends BaseDAO {

    public int getViewer() {
        int res = 0;
        String sql = "select total from Viewer";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                res = rs.getInt("total");

            }
        } catch (SQLException ex) {
            Logger.getLogger(MarketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return res;
    }

    public void increaseViewer() {
        String sql = "update Viewer set total = total + 1";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MarketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<Size> getSizeList() {
        ArrayList<Size> list = new ArrayList<>();

        String sql = "select * from Size";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                list.add(new Size(rs.getInt("id"), rs.getString("name")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(MarketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Size getSizeViaID(int id) {
        String sql = "select * from Size where id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                return new Size(rs.getInt("id"), rs.getString("name"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(MarketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int getTotalProducts() {
        int res = 0;

        String sql = "select * from Product";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                res++;
            }
        } catch (SQLException ex) {
            Logger.getLogger(MarketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return res;
    }

    public ArrayList<Product> getProductListViaPage(int begin, int end) {
        ArrayList<Product> list = new ArrayList<>();

        String sql = "select id, name, img, price, description, delivery, quantity from "
                + " ("
                + "     select *, ROW_NUMBER() over (order by price) as rownum"
                + "     from [Product]"
                + " ) as [DataFound]"
                + " where rownum between ? and ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, begin);
            statement.setInt(2, end);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Product c = new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("img"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getString("delivery"),
                        rs.getInt("quantity"));
                list.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(MarketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Product getProductViaID(int id) {
        String sql = "select id, name, img, price, description, delivery, quantity "
                + " from Product"
                + " where id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Product c = new Product(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("img"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getString("delivery"),
                        rs.getInt("quantity"));
                return c;
            }
        } catch (SQLException ex) {
            Logger.getLogger(MarketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertAddress(Address add) {
        String sql = "insert into Address values (?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, add.getName());
            statement.setString(2, add.getCompany());
            statement.setString(3, add.getAddressline1());
            statement.setString(4, add.getAddressline2());
            statement.setString(5, add.getZip());
            statement.setString(6, add.getCity());
            statement.setString(7, add.getState());
            statement.setString(8, add.getCountry());
            statement.setString(9, add.getPhone());
            statement.setString(10, add.getEmail());
            statement.setString(11, add.getComment());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MarketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int getLastAddressID() {
        String sql = "select top 1 id from Address order by id desc";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                return rs.getInt("id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(MarketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public void insertOrder(int shipping_address_id, int billing_address_id, String sessionID) {
        String sql = "insert into Orders values (?,?,?,?)";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, shipping_address_id);
            statement.setInt(2, billing_address_id);
            statement.setString(3, sessionID);
            statement.setFloat(4, 0);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MarketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int getLastOrderID() {
        String sql = "select top 1 id from Orders order by id desc";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                return rs.getInt("id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(MarketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public void insertOrderItem(int orderID, OrderItem item) {
        try {
            //insert into OrderItem
            String sql = "insert into OrderItem values (?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, orderID);
            statement.setInt(2, item.getProduct().getId());
            statement.setInt(3, item.getSize().getId());
            statement.setFloat(4, item.getQuantity());
            statement.executeUpdate();

            //Decrease Quantity from Product
            sql = "update Product \n"
                    + "set quantity = quantity - ?\n"
                    + "where id = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, item.getQuantity());
            statement.setInt(2, item.getProduct().getId());
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MarketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
