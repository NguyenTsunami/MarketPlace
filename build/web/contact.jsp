<%-- 
    Document   : contact
    Created on : Oct 9, 2020, 4:55:46 PM
    Author     : thuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                <!--Shop-->
                <div class="ma-5 pb-10 font-cursive">
                    <p class="text-5 font-serif font-bold">Contact</p>
                    <img src="images/shopimg.jpg" class="float-left rounded mr-3" style="width: 300px; ">
                    <p class="text-5 font-serif font-bold">Handmade by Tsunami</p>
                    <p>Address: FPT University</p>
                    <p>City: Hanoi</p>
                    <p>Country: Vietnam</p>
                    <p>Tel: 123456</p>
                    <p>Email: thuynhhe140997@fpt.edu.vn</p>
                </div>
                <hr>

                <!--Contact Form-->
                <form action="contact" method="post" class="font-cursive ma-5">
                    <p class="font-bold">Write your message here. Fill out the form:</p>
                    <input type="text" name="name" required placeholder="Write your name here" 
                           style="width: 45%; height: 30px" class="rounded my-2 pa-2"
                           pattern="[a-zA-Z ']{1,500}">
                    <input type="email" name="email" required placeholder="Write your email here"
                           style="width: 45%; height: 30px" class="rounded my-2 pa-2">
                    <textarea rows="5" placeholder="Write your message here" name="mess" required
                              class="rounded my-2 pa-2" style="width: 95%"></textarea>
                    <p class="italic font-cursive text-green">${contactdone}</p>
                    <input type="submit" value="Send - Click here" 
                           class="rounded text-white font-cursive pa-2 float-right bg-darkred ma-3">
                </form>
            </div>

            <!--Right-->
            <jsp:include page="rightside.jsp"/>
        </div>
    </body>
</html>
