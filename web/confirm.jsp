<%-- 
    Document   : confirm
    Created on : Oct 9, 2020, 4:55:22 PM
    Author     : thuy
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="ma-8 font-cursive">
            <p class="text-5 font-bold">Order summary</p>

            <!--Notify after place order success-->
            <c:if test="${notify != null}">
                <p class="rounded bg-white italic text-green pa-2 text-center">${notify}</p>
            </c:if>

            <!--Address-->
            <c:if test="${billingAddress.equals(shippingAddress)}">
                <div class="border-dashed pa-5 ma-2">
                    <p class="font-bold text-4">Shipping and Billing Address</p>
                    <div class="flex">
                        <div style="width: 30%">
                            <p>Name: ${shippingAddress.name}</p>
                            <p>Company: ${shippingAddress.company.equals("")?'---':shippingAddress.company}</p>
                            <p>Address Line 1: ${shippingAddress.addressline1}</p>
                            <p>Address Line 2: ${shippingAddress.addressline2.equals("")?'---':shippingAddress.addressline2}</p>
                            <p>Phone: ${shippingAddress.phone}</p>
                        </div>
                        <div style="width: 30%">
                            <p>ZIP: ${shippingAddress.zip}</p>
                            <p>City: ${shippingAddress.city}</p>
                            <p>State: ${shippingAddress.state}</p>
                            <p>Country: ${shippingAddress.country}</p>
                            <p>Email: ${shippingAddress.email.equals("")?'---':shippingAddress.email}</p>
                        </div>
                        <div style="width: 30%">
                            <p>Comment: ${shippingAddress.comment.equals("")?'---':shippingAddress.comment}</p>
                        </div>
                    </div>
                    <a href="homepage?main=checkout" class="text-black">Change</a>
                </div>
            </c:if>
            <c:if test="${!billingAddress.equals(shippingAddress)}">
                <div class="border-dashed pa-5 ma-2">
                    <p class="font-bold text-4">Shipping Address</p>
                    <div class="flex">
                        <div style="width: 30%">
                            <p>Name: ${shippingAddress.name}</p>
                            <p>Company: ${shippingAddress.company.equals("")?'---':shippingAddress.company}</p>
                            <p>Address Line 1: ${shippingAddress.addressline1}</p>
                            <p>Address Line 2: ${shippingAddress.addressline2.equals("")?'---':shippingAddress.addressline2}</p>
                            <p>Phone: ${shippingAddress.phone}</p>
                        </div>
                        <div style="width: 30%">
                            <p>ZIP: ${shippingAddress.zip}</p>
                            <p>City: ${shippingAddress.city}</p>
                            <p>State: ${shippingAddress.state}</p>
                            <p>Country: ${shippingAddress.country}</p>
                            <p>Email: ${shippingAddress.email.equals("")?'---':shippingAddress.email}</p>
                        </div>
                        <div style="width: 30%">
                            <p>Comment: ${shippingAddress.comment.equals("")?'---':shippingAddress.comment}</p>
                        </div>
                    </div>
                    <a href="homepage?main=checkout" class="text-black">Change</a>
                </div>
                <div class="border-dashed pa-5 ma-2">
                    <p class="font-bold text-4">Billing Address</p>
                    <div class="flex">
                        <div style="width: 30%">
                            <p>Name: ${billingAddress.name}</p>
                            <p>Company: ${billingAddress.company.equals("")?'---':billingAddress.company}</p>
                            <p>Address Line 1: ${billingAddress.addressline1}</p>
                            <p>Address Line 2: ${billingAddress.addressline2.equals("")?'---':billingAddress.addressline2}</p>
                            <p>Phone: ${billingAddress.phone}</p>
                        </div>
                        <div style="width: 30%">
                            <p>ZIP: ${billingAddress.zip}</p>
                            <p>City: ${billingAddress.city}</p>
                            <p>State: ${billingAddress.state}</p>
                            <p>Country: ${billingAddress.country}</p>
                            <p>Email: ${billingAddress.email.equals("")?'---':billingAddress.email}</p>
                        </div>
                        <div style="width: 30%">
                            <p>Comment: ${billingAddress.comment.equals("")?'---':billingAddress.comment}</p>
                        </div>
                    </div>
                    <a href="homepage?main=checkout" class="text-black">Change</a>
                </div>
            </c:if>
            <!--End: Address-->

            <!--Your Order-->
            <div class="border-dashed pa-5 ma-2">
                <p class="font-bold text-4">Your Order</p>

                <table cellpadding="0" cellspacing="0" style="width: 100%;" class="text-left">
                    <tr>
                        <th style="border-bottom: 1px solid black;">Product</th>
                        <th style="border-bottom: 1px solid black;">Price</th>
                        <th style="border-bottom: 1px solid black;">Quantity</th>
                        <th style="border-bottom: 1px solid black;">Total</th>
                    </tr>

                    <c:if test="${basket.size()==0}">
                        <p class="text-red">You currently have no products in your basket. </p>
                        <p class="text-red">Please go to the online shop via the top menu to add new products. </p>
                    </c:if>
                    <tbody id="basket">
                        <c:forEach var="orderitem" items="${basket}">
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
            <!--End: Your Order-->

            <!--Confirm and Button-->
            <c:if test="${!empty sessionScope.basket}">
                <div class="text-right">
                    <input type="checkbox" id="cbxConfirm" onchange="reloadBtnConfirm()"> 
                    I agree to the <a href="">Terms and Condition</a> 
                </div>
                <div class="text-right my-5">
                    <a href="homepage?main=checkout" class="in-underline">
                        <button class="rounded bg-darkred text-white text-3 pa-1 font-cursive pointer border-none pa-2">Go back</button>
                    </a>
                    <a href="basketAPI" class="in-underline" id="btnPlaceorder">
                        <button class="rounded bg-darkred text-white text-3 pa-1 font-cursive pointer border-none pa-2">Place order</button>
                    </a>
                </div>
            </c:if>

        </div>
    </body>
</html>
