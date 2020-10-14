/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package api;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import dal.MarketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Address;
import model.OrderItem;
import model.Product;
import model.Size;

/**
 *
 * @author thuy
 */
public class BasketAPI extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductAPI</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductAPI at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        ArrayList<OrderItem> basket = (ArrayList<OrderItem>) session.getAttribute("basket");
        Address shippingAddress = (Address) session.getAttribute("shippingAddress");
        Address billingAddress = (Address) session.getAttribute("billingAddress");

        //upload to database
        MarketDAO da = new MarketDAO();
        da.insertAddress(shippingAddress);
        int shipping_address_id = da.getLastAddressID();
        da.insertAddress(billingAddress);
        int billing_address_id = da.getLastAddressID();
        String sessionID = session.getId();
        da.insertOrder(shipping_address_id, billing_address_id, sessionID);
        int orderID = da.getLastOrderID();
        for (OrderItem item : basket) {
            da.insertOrderItem(orderID, item);
        }

        //finally
        response.sendRedirect("homepage?main=confirm&notify=yes");
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Gson gson = new Gson();
        JsonObject jObj = new JsonObject();

        if (request.getParameter("action").equals("add")) {
            //get param
            MarketDAO da = new MarketDAO();
            int sizeID = Integer.parseInt(request.getParameter("sizeID"));
            int productID = Integer.parseInt(request.getParameter("productID"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            //update basket in session
            HttpSession session = request.getSession(true);
            ArrayList<OrderItem> basket = (ArrayList<OrderItem>) session.getAttribute("basket");
            boolean added = false;
            for (OrderItem item : basket) {
                if (item.getProduct().getId() == productID && item.getSize().getId() == sizeID) {
                    added = true;
                    if (item.getQuantity() + quantity <= da.getProductViaID(productID).getQuantity()) {
                        item.setQuantity(item.getQuantity() + quantity);
                    } else {
                        jObj.addProperty("error", "Out of stock!");
                    }
                    break;
                }
            }
            if (!added) {
                if (quantity <= da.getProductViaID(productID).getQuantity()) {
                    Product product = da.getProductViaID(productID);
                    Size size = da.getSizeViaID(sizeID);
                    basket.add(new OrderItem(product, size, quantity));
                    session.setAttribute("basket", basket);
                } else {
                    jObj.addProperty("error", "You have added too much, there is not enough product!");
                }
            }
            jObj.addProperty("basketsize", basket.size());
        } else if (request.getParameter("action").equals("remove")) {
            // get param
            MarketDAO da = new MarketDAO();
            int sizeID = Integer.parseInt(request.getParameter("sizeID"));
            int productID = Integer.parseInt(request.getParameter("productID"));

            //update basket in session
            HttpSession session = request.getSession(true);
            ArrayList<OrderItem> basket = (ArrayList<OrderItem>) session.getAttribute("basket");
            for (int i = 0; i < basket.size(); i++) {
                OrderItem item = basket.get(i);
                if (item.getProduct().getId() == productID && item.getSize().getId() == sizeID) {
                    basket.remove(i);
                    break;
                }
            }

            JsonArray jArray = new Gson().toJsonTree(basket).getAsJsonArray();
            jObj.add("basket", jArray);
        }

        //send back data
        String basketJson = gson.toJson(jObj);

        PrintWriter writer = response.getWriter();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        writer.write(basketJson);
        writer.close();

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
