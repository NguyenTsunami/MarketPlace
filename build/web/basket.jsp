<%-- 
    Document   : basket
    Created on : Oct 9, 2020, 4:55:09 PM
    Author     : thuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="ma-5">
            <!--Title and Button-->
            <div class="flex justify-between items-center">
                <p class="ma-5 font-cursive text-5 font-bold"> Your Basket</p>
                <div class="ma-5 flex">
                    <a href="homepage?main=list" class="ma-2">
                        <button class="rounded bg-darkred text-white text-3 pa-1 font-cursive pointer border-none pa-2" 
                                style="width: 100%;">Buy more</button>
                    </a>
                    <a id="btnCheckout" href="homepage?main=checkout" class="ma-2 ${basket.size() > 0?'block':'nodisplay'}">
                        <button class="rounded bg-darkred text-white text-3 pa-1 font-cursive pointer border-none pa-2" 
                                style="width: 100%;">Check out</button>
                    </a>
                </div>
            </div>

            <!--Table-->
            <div>
                <table cellpadding="0" cellspacing="0" style="width: 100%;" class="text-left">
                    <tr>
                        <th style="border-bottom: 1px solid black;">Product</th>
                        <th style="border-bottom: 1px solid black;">Price</th>
                        <th style="border-bottom: 1px solid black;">Quantity</th>
                        <th colspan="2" style="border-bottom: 1px solid black;">Total</th>
                    </tr>

                    <c:if test="${basket.size()==0}">
                        <p class="text-red">You currently have no products in your basket. </p>
                        <p class="text-red">Please go to the online shop via the top menu to add new products. </p>
                    </c:if>
                    <tbody id="basket">
                        <c:forEach var="orderitem" items="${basket}">
                            <!--no change this tr-tag ~ use for script.js-->
                            <tr>
                                <td>
                                    <div class="flex items-center">
                                        <img src="${orderitem.product.img}" style="width: 100px; height: 100px;" class="rounded">
                                        <div class="ma-4">
                                            <a href="homepage?main=detail&id=${orderitem.product.id}" class="text-black font-bold"> ${orderitem.product.name} </a>
                                            <p>Delivery: ${orderitem.product.delivery}</p>
                                            <p>Size: ${orderitem.size.name}</p>
                                        </div>
                                    </div>
                                </td>
                                <td>${orderitem.product.price} USD</td>
                                <td>${orderitem.quantity}</td>
                                <td>${orderitem.product.price * orderitem.quantity} USD</td>
                                <td>
                                    <span class="close" onclick="removeOrderItem(${orderitem.product.id}, ${orderitem.size.id})">&times;</span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>

                    <tr>
                        <td style="border-top: 1px solid black;"></td>
                        <td style="border-top: 1px solid black;">Subtotal</td>
                        <td style="border-top: 1px solid black;"></td>
                        <td style="border-top: 1px solid black;" id="subtotal"></td>
                        <td style="border-top: 1px solid black;"></td>
                    </tr>
                    <tr>
                        <td style="border-bottom: 1px solid black;"></td>
                        <td style="border-bottom: 1px solid black;">Shipping</td>
                        <td style="border-bottom: 1px solid black;"></td>
                        <td style="border-bottom: 1px solid black;" id="shipping">0.0 USD</td>
                        <td style="border-bottom: 1px solid black;"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td class="font-bold">Total</td>
                        <td></td>
                        <td id="total"></td>
                        <td></td>
                    </tr>
                </table>
            </div>

        </div>
    </body>
</html>
