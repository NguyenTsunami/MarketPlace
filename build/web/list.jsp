<%-- 
    Document   : list
    Created on : Oct 9, 2020, 4:54:54 PM
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

        <div class="flex font-cursive">
            <!--Left-->
            <div class="left">
                <p class="text-6 font-bold mx-5">Online store</p>

                <!--Notify when list empty-->
                <p class="text-notify text-3 text-left">${notify}</p>

                <!--List-->
                <div class="flex flex-wrap justify-center">
                    <c:forEach var="productItem" items="${productList}">
                        <div class="flex flex-col mx-2 mb-7">
                            <!--image-->
                            <div class="my-0">
                                <a href="homepage?main=detail&id=${productItem.id}">
                                    <img src="${productItem.img}" style="width: 200px; height: 200px; border-radius: 10px;"/>
                                </a>
                            </div>

                            <!--name-->
                            <a href="homepage?main=detail&id=${productItem.id}">
                                <p class="text-4 font-bold underline my-0 text-black">${productItem.name}</p> 
                            </a>

                            <!--price-->
                            <p class="text-3 my-0">Price: ${productItem.price} USD</p>

                            <!--add to basket via API-->
                            <div>
                                Size: 
                                <select class="h-5 rounded border-none px-2" id="sizeID-${productItem.id}">
                                    <c:forEach var="size" items="${sizeList}">
                                        <option value="${size.id}">
                                            ${size.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <input type="text" id="quantity-${productItem.id}" value="1" hidden>

                            <input type="text" id="name-${productItem.id}" value="${productItem.name}" hidden>

                            <input type="text" id="price-${productItem.id}" value="${productItem.price}" hidden>

                            <input class="text-3 font-cursive bg-darkred text-white rounded my-4 mr-7 pointer" 
                                   
                                   type="submit" value="Add to basket" onclick="reloadBasketSize(${productItem.id})">
                        </div>
                    </c:forEach>
                </div>

                <!--Pagination-->
                <div class="pagination flex justify-center text-2">
                    <a class="${page-1<1?'inactiveLink':''}"
                       href="homepage?main=list&page=${page-1}">&laquo;</a>
                    <c:forEach var="p" begin="1" end="${totalPage}">
                        <a class="${page eq p ? 'active' : ''}" 
                           href="homepage?main=list&page=${p}">${p}</a>
                    </c:forEach>
                    <a class="${page+1>totalPage?'inactiveLink':''}"
                       href="homepage?main=list&page=${page+1}">&raquo;</a>
                </div>
            </div>

            <!--Right-->
            <jsp:include page="rightside.jsp"/>
        </div>

    </body>
</html>
