<%-- 
    Document   : homepage
    Created on : Oct 9, 2020, 4:54:48 PM
    Author     : thuy
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="./css/style.css" />
        <!--        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>-->
    </head>
    <body>
        <div class="wrapper bg-pink">
            <!--Header-->
            <div>
                <!--Banner-->
                <div class="container bg-red">
                    <p class="ma-0 px-5 pt-5 text-7 text-white font-bold">Handmade by Tsunami</p>
                    <p class="ma-0 px-5 pb-5 text-5 text-white">Welcome to My Online Store</p>
                </div>

                <!--Navigation-->
                <div class="container navigation bg-darkred">
                    <ul class="list-reset my-0 h-6 flex flex-row items-center">
                        <li class="text-white mx-5 navlink ${main eq null || main eq 'list' ? 'active' : ''}">
                            <a href="homepage?main=list" class="text-white in-underline">Online Store</a>
                        </li>
                        <li class="text-white mx-5 navlink ${main eq 'about' ? 'active' : ''}">
                            <a href="homepage?main=about" class="text-white in-underline">About</a>
                        </li>
                        <li class="text-white mx-5 navlink ${main eq 'contact' ? 'active' : ''}">
                            <a href="homepage?main=contact" class="text-white in-underline">Contact</a>
                        </li>
                    </ul>
                </div>
            </div>

            <!--Content-->
            <div class="container">
                <!--Alert after user add to basket-->
                <div class="alert">
                </div>

                <!--For each main value-->
                <c:if test="${main eq 'list'}">
                    <jsp:include page="list.jsp"/>
                </c:if>
                <c:if test="${main eq 'detail'}">
                    <jsp:include page="detail.jsp"/>
                </c:if>
                <c:if test="${main eq 'basket'}">
                    <jsp:include page="basket.jsp"/>
                </c:if>
                <c:if test="${main eq 'checkout'}">
                    <jsp:include page="checkout.jsp"/>
                </c:if>
                <c:if test="${main eq 'confirm'}">
                    <jsp:include page="confirm.jsp"/>
                </c:if>
                <c:if test="${main eq 'about'}">
                    <jsp:include page="about.jsp"/>
                </c:if>
                <c:if test="${main eq 'contact'}">
                    <jsp:include page="contact.jsp"/>
                </c:if>
            </div>
            <!--Footer-->
            <footer class="footer container font-cursive px-5 pb-2 my-7"> 
                <hr><br>
                <div class="flex justify-between">
                    <p class="mt-0">This website was created by Tsunami</p>

                    <div>
                        <span class="bg-white rounded shadow pa-1">${Math.floor(viewer % 1000000 / 100000).toString().charAt(0)}</span>
                        <span class="bg-white rounded shadow pa-1">${Math.floor(viewer % 100000 / 10000).toString().charAt(0)}</span>
                        <span class="bg-white rounded shadow pa-1">${Math.floor(viewer % 10000 / 1000).toString().charAt(0)}</span>
                        <span class="bg-white rounded shadow pa-1">${Math.floor(viewer % 1000 / 100).toString().charAt(0)}</span>
                        <span class="bg-white rounded shadow pa-1">${Math.floor(viewer % 100 / 10).toString().charAt(0)}</span>
                        <span class="bg-white rounded shadow pa-1">${Math.floor(viewer % 10).toString().charAt(0)}</span>
                    </div>
                </div>
            </footer>
        </div>



        <script src="js/script.js"></script>
    </body>
</html>
