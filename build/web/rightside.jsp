<%-- 
    Document   : rightside
    Created on : Oct 12, 2020, 10:14:14 PM
    Author     : thuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="right mr-6 font-cursive">
            <div class="shadow rounded pa-2 my-7">
                <div class="flex items-center">
                    <img src="images/basket.png" class="rounded">
                    <span id="cart-size" class="cart-number text-2 font-bold">${fn:length(basket)}</span>
                    <a href="homepage?main=basket" class="underline text-3 text-black">Your Basket</a>
                </div>

                <a id="btnCheckout" href="homepage?main=checkout" class="${basket.size() > 0?'block':'nodisplay'}">
                    <button class="rounded bg-darkred text-white text-3 pa-1 font-cursive pointer" 
                            style="width: 100%;">Check out</button>
                </a>
            </div>

            <div class="shadow rounded pa-3 my-7">
                <p class="text-4 font-bold mt-0"> Share this page</p>
                <a href="" class="underline text-3 text-black items-center">
                    <img src="images/facebook.png" style="width: 15px; height: 15px;">
                    Share on Facebook
                </a>
                <br>
                <a href="" class="underline text-3 text-black items-center">
                    <img src="images/twitter.png" style="width: 15px; height: 15px;">
                    Share on Twitter
                </a>
            </div>

            <div class="shadow rounded pa-3 my-7">
                <p class="text-4 font-bold mt-0">Create a website</p>
                <p>Everybody can create a website, it's easy.</p>
                <button class="rounded bg-darkred text-white text-3 pa-2 font-cursive" 
                        style="width: 100%;">Try it for FREE now!</button>
            </div>
        </div>
    </body>
</html>
