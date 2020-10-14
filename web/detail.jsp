<%-- 
    Document   : detail
    Created on : Oct 9, 2020, 4:55:00 PM
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
        <div class="flex">
            <!--Left-->
            <div class="left ma-5">
                <p class="text-5 font-bold font-cursive">
                    ${currentProduct.name}
                    <input type="text" id="name-${currentProduct.id}" value="${currentProduct.name}" hidden>
                </p>
                <div class="flex">
                    <img src="${currentProduct.img}" class="rounded" style="width: 320px; height: 320px">
                    <div class="mx-3">
                        <p class="mt-0 text-4">
                            Price: ${currentProduct.price} USD
                            <input type="text" id="price-${currentProduct.id}" value="${currentProduct.price}" hidden>
                        </p>
                        <p class="text-4">
                            Quantity: 
                            <input id="quantity-${currentProduct.id}" value="1"
                                   type="number" min="1" max="${currentProduct.quantity}" required class="text-4">
                            / ${currentProduct.quantity}
                        </p>
                        <div class="text-4">
                            Size: 
                            <select class="h-5 rounded px-2" id="sizeID-${currentProduct.id}">
                                <c:forEach var="size" items="${sizeList}">
                                    <option value="${size.id}">
                                        ${size.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <input class="text-3 font-cursive bg-darkred text-white rounded my-4 mr-7 pointer"
                               type="submit" value="Add to basket" onclick="reloadBasketSize(${currentProduct.id})">
                        <p class="font-bold">Description</p>
                        <p class="text-4">${currentProduct.description}</p>
                        <p class="font-bold">Delivery: ${currentProduct.delivery}</p>
                    </div>
                </div>
            </div>

            <!--Right-->
            <jsp:include page="rightside.jsp"/>
        </div>
    </body>
</html>
