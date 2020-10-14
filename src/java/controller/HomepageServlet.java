/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

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
public class HomepageServlet extends HttpServlet {

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
            out.println("<title>Servlet HomepageServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomepageServlet at " + request.getContextPath() + "</h1>");
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
        //da
        MarketDAO da = new MarketDAO();
        request.setAttribute("da", da);

        //session
        HttpSession session = request.getSession(true);
        if (session.getAttribute("visited") == null) {
            session.setAttribute("visited", true);
            da.increaseViewer();
            ArrayList<OrderItem> basket = new ArrayList<>();
            session.setAttribute("basket", basket);
            session.setAttribute("shippingAddress", new Address());
            session.setAttribute("billingAddress", new Address());
            session.setAttribute("orderdone", 0);
        }

        //viewer
        int viewer = da.getViewer();
        request.setAttribute("viewer", viewer);

        //basketList
        //for each type main:
        if (request.getParameter("main") == null || request.getParameter("main").equals("list")) {
            //get page
            int page;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            } else {
                page = 1;
            }

            //get begin and end index of product via page
            int totalProductsEachPage = 9;
            int begin = (page - 1) * totalProductsEachPage + 1;
            int end = (page - 1) * totalProductsEachPage + totalProductsEachPage;

            //get amount products and total page
            int amountProducts = da.getTotalProducts();
            int totalPage = amountProducts / totalProductsEachPage + (amountProducts % totalProductsEachPage == 0 ? 0 : 1);

            //for each case:
            if (amountProducts == 0) {
                //notify 
                request.setAttribute("notify", "Shop is out of stock!");
            } else {
                //send list found
                ArrayList<Product> productList = da.getProductListViaPage(begin, end);
                request.setAttribute("productList", productList);
            }

            //page info
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("page", page);

            //sizelist
            ArrayList<Size> sizeList = da.getSizeList();
            request.setAttribute("sizeList", sizeList);

            //main
            request.setAttribute("main", "list");
        } else if (request.getParameter("main").equals("detail")) {
            //current product
            int id = Integer.parseInt(request.getParameter("id"));
            Product currentProduct = da.getProductViaID(id);
            request.setAttribute("currentProduct", currentProduct);

            //sizelist
            ArrayList<Size> sizeList = da.getSizeList();
            request.setAttribute("sizeList", sizeList);

            //main
            request.setAttribute("main", "detail");
        } else if (request.getParameter("main").equals("basket")) {

            //main
            request.setAttribute("main", "basket");
        } else if (request.getParameter("main").equals("checkout")) {

            //main
            request.setAttribute("main", "checkout");
        } else if (request.getParameter("main").equals("confirm")) {
            //get param
            if (request.getParameter("notify") != null) {
                if ((int) session.getAttribute("orderdone") == 0) {
                    request.setAttribute("notify", "Your order has been saved!");
                    request.setAttribute("basket", session.getAttribute("basket"));
                    request.setAttribute("shippingAddress", session.getAttribute("shippingAddress"));
                    request.setAttribute("billingAddress", session.getAttribute("billingAddress"));
                    ArrayList<OrderItem> newBasket = new ArrayList<>();
                    session.setAttribute("basket", newBasket);
                    session.setAttribute("orderdone", 1);
                } else if ((int) session.getAttribute("orderdone") == 1) {
                    session.setAttribute("orderdone", 0);
                    response.sendRedirect("homepage");
                    return;
                }
            }

            //main
            request.setAttribute("main", "confirm");
        } else if (request.getParameter("main").equals("about")) {

            //main
            request.setAttribute("main", "about");
        } else if (request.getParameter("main").equals("contact")) {
            //get param
            if (session.getAttribute("contactdone") != null) {
                request.setAttribute("contactdone", session.getAttribute("contactdone"));
                session.removeAttribute("contactdone");
            }

            //main
            request.setAttribute("main", "contact");
        }

        //forward
        request.getRequestDispatcher("homepage.jsp").forward(request, response);
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
        HttpSession session = request.getSession(true);

        ArrayList<OrderItem> basket = (ArrayList<OrderItem>) session.getAttribute("basket");
        if (basket.isEmpty()) {
            response.sendRedirect("homepage?main=basket");
            return;
        }

        String name = request.getParameterValues("name")[0];
        String company = request.getParameterValues("company")[0];
        String addressline1 = request.getParameterValues("addressline1")[0];
        String addressline2 = request.getParameterValues("addressline2")[0];
        String zip = request.getParameterValues("zip")[0];
        String city = request.getParameterValues("city")[0];
        String state = request.getParameterValues("state")[0];
        String country = request.getParameterValues("country")[0];
        String phone = request.getParameterValues("phone")[0];
        String email = request.getParameterValues("email")[0];
        String comment = request.getParameterValues("comment")[0];

        session.setAttribute("shippingAddress", new Address(name, company, addressline1, addressline2, zip, city, state, country, phone, email, comment));

        if (!request.getParameter("same").equals("true")) {
            name = request.getParameterValues("name")[1];
            company = request.getParameterValues("company")[1];
            addressline1 = request.getParameterValues("addressline1")[1];
            addressline2 = request.getParameterValues("addressline2")[1];
            zip = request.getParameterValues("zip")[1];
            city = request.getParameterValues("city")[1];
            state = request.getParameterValues("state")[1];
            country = request.getParameterValues("country")[1];
            phone = request.getParameterValues("phone")[1];
            email = request.getParameterValues("email")[1];
            comment = request.getParameterValues("comment")[1];

            session.setAttribute("billingAddress", new Address(name, company, addressline1, addressline2, zip, city, state, country, phone, email, comment));
        } else {
            session.setAttribute("billingAddress", new Address(name, company, addressline1, addressline2, zip, city, state, country, phone, email, comment));
        }

        response.sendRedirect("homepage?main=confirm");
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
