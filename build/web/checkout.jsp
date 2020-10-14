<%-- 
    Document   : checkout
    Created on : Oct 9, 2020, 4:55:15 PM
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
        <div class="ma-8 font-cursive">
            <p class="text-5 font-bold">Check out</p>

            <form action="homepage" method="POST">
                <!--Shipping Address-->
                <p class="font-bold">Shipping Address</p>
                <div class="flex justify-between" id="shipping-form">
                    <div style="width: 45%">
                        <p class="mb-0">Name*</p>
                        <input type="text" required name="name" style="width: 100%;" class="rounded border-none pa-2"
                               pattern="[a-zA-Z ']{1,500}" value="${shippingAddress.name}">
                        <p class="mb-0">Company</p>
                        <input type="text" name="company" style="width: 100%;" class="rounded border-none pa-2"
                               pattern="[a-zA-Z ']{1,500}" value="${shippingAddress.company}">
                        <p class="mb-0">Address line 1*</p>
                        <input type="text" required name="addressline1" style="width: 100%;" class="rounded border-none pa-2"
                               pattern="[a-zA-Z '-]{1,1000}" value="${shippingAddress.addressline1}">
                        <p class="mb-0">Address line 2</p>
                        <input type="text" name="addressline2" style="width: 100%;" class="rounded border-none pa-2"
                               pattern="[a-zA-Z '-]{1,1000}" value="${shippingAddress.addressline2}">

                        <div class="flex">
                            <div style="width: 45%" class="mr-7">
                                <p class="mb-0">ZIP*</p>
                                <input type="text" required name="zip" style="width: 100%;" class="rounded border-none pa-2"
                                       pattern="[0-9]{6}" value="${shippingAddress.zip}">
                                <p class="mb-0">State*</p>
                                <input type="text" required name="state" style="width: 100%;" class="rounded border-none pa-2"
                                       pattern="[a-zA-Z '-]{1,100}" value="${shippingAddress.state}">
                                <p class="mb-0">Phone*</p>
                                <input type="tel" required name="phone" style="width: 100%;" class="rounded border-none pa-2"
                                       pattern="[0-9]{10,11}" value="${shippingAddress.phone}">
                            </div>
                            <div style="width: 45%">
                                <p class="mb-0">City*</p>
                                <input type="text" required name="city" style="width: 100%;" class="rounded border-none pa-2"
                                       pattern="[a-zA-Z '-]{1,100}" value="${shippingAddress.city}">
                                <p class="mb-0">Country*</p>
                                <input type="text" required name="country" style="width: 100%;" class="rounded border-none pa-2"
                                       pattern="[a-zA-Z '-]{1,100}" value="${shippingAddress.country}">
                                <p class="mb-0">Email</p>
                                <input type="email" name="email" style="width: 100%;" class="rounded border-none pa-2" value="${shippingAddress.email}">
                            </div>
                        </div>
                    </div>
                    <div style="width: 45%">
                        <p class="mb-0">Comment</p>
                        <textarea rows="15" name="comment" style="width: 100%;" class="rounded border-none pa-2">${shippingAddress.comment}</textarea>
                    </div>
                </div>
                <!--End: Shipping Address-->

                <p class="text-right mb-0">* Required</p>
                <hr>

                <!--Billing Address-->
                <p class="font-bold">Billing Address</p>
                <div class="flex">
                    <p><input id="same-address" type="radio" name="same" value="true" checked onclick="reloadBillingAddress()">Same as shipping address</p>
                    <p><input type="radio" name="same" value="false" onclick="reloadBillingAddress()">Different</p>
                </div>
                <div class="flex justify-between" id="billing-form">
                    <div style="width: 45%">
                        <p class="mb-0">Name*</p>
                        <input type="text" required name="name" style="width: 100%;" class="rounded border-none pa-2"
                               pattern="[a-zA-Z ']{1,500}" value="${billingAddress.name}">
                        <p class="mb-0">Company</p>
                        <input type="text" name="company" style="width: 100%;" class="rounded border-none pa-2"
                               pattern="[a-zA-Z ']{1,500}" value="${billingAddress.company}">
                        <p class="mb-0">Address line 1*</p>
                        <input type="text" required name="addressline1" style="width: 100%;" class="rounded border-none pa-2"
                               pattern="[a-zA-Z '-]{1,1000}" value="${billingAddress.addressline1}">
                        <p class="mb-0">Address line 2</p>
                        <input type="text" name="addressline2" style="width: 100%;" class="rounded border-none pa-2"
                               pattern="[a-zA-Z '-]{1,1000}" value="${billingAddress.addressline2}">

                        <div class="flex">
                            <div style="width: 45%" class="mr-7">
                                <p class="mb-0">ZIP*</p>
                                <input type="text" required name="zip" style="width: 100%;" class="rounded border-none pa-2"
                                       pattern="[0-9]{6}" value="${billingAddress.zip}">
                                <p class="mb-0">State*</p>
                                <input type="text" required name="state" style="width: 100%;" class="rounded border-none pa-2"
                                       pattern="[a-zA-Z '-]{1,100}" value="${billingAddress.state}">
                                <p class="mb-0">Phone*</p>
                                <input type="tel" required name="phone" style="width: 100%;" class="rounded border-none pa-2"
                                       pattern="[0-9]{10,11}" value="${billingAddress.phone}">
                            </div>
                            <div style="width: 45%">
                                <p class="mb-0">City*</p>
                                <input type="text" required name="city" style="width: 100%;" class="rounded border-none pa-2"
                                       pattern="[a-zA-Z '-]{1,100}" value="${billingAddress.city}">
                                <p class="mb-0">Country*</p>
                                <input type="text" required name="country" style="width: 100%;" class="rounded border-none pa-2"
                                       pattern="[a-zA-Z '-]{1,100}" value="${billingAddress.country}">
                                <p class="mb-0">Email</p>
                                <input type="email" name="email" style="width: 100%;" class="rounded border-none pa-2" value="${billingAddress.email}">
                            </div>
                        </div>
                    </div>
                    <div style="width: 45%">
                        <p class="mb-0">Comment</p>
                        <textarea rows="15" name="comment" style="width: 100%;" class="rounded border-none pa-2">${billingAddress.comment}</textarea>
                    </div>
                </div>
                <!--End: Billing Address-->

                <!--Submit-->
                <div class="text-right">
                    <a href="homepage?main=basket" class="in-underline">
                        <button type="button" class="rounded bg-darkred text-white text-3 pa-1 font-cursive pointer border-none pa-2">Go back</button>
                    </a>
                    <input type="submit" value="Continue" 
                           class="rounded bg-darkred text-white text-3 pa-1 font-cursive pointer border-none pa-2">
                </div>
            </form>
        </div>
    </body>
</html>
