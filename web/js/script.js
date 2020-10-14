/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//Reload basket size
/* global fetch, modal, parseFloat, item */
function reloadBasketSize(productID) {
    var selection = document.getElementById('sizeID-' + productID);
    var sizeID = selection.value;
    var quantity = document.getElementById('quantity-' + productID).value;
    var name = document.getElementById('name-' + productID).value;
    var price = document.getElementById('price-' + productID).value;
    var size = selection.options[selection.selectedIndex].text;
    //must prepare data via URLSearchParams AND send with content-type x-www-form-urlencoded
    //=> only that way, we can get parameter normal in servlet!
    var headers = {
        "Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    var data = new URLSearchParams();
    data.append('sizeID', sizeID);
    data.append('productID', productID);
    data.append('quantity', quantity);
    data.append('action', 'add');
    //check - not include in main code
    var param = {
        "sizeID": sizeID,
        "productID": productID,
        "quantity": quantity
    };
    console.log(param);
    //~~~~~~~~~~~~~~~~ JQUERY ~~~~~~~~~~~~~~~~~~~~
//    $.ajax({
//        type: "POST",
//        url: "basketAPI",
//        contentType: "application/json",
//        data: JSON.stringify(param),
//        success: function (response) {
//            // cart - size in rightside.jsp
//            var cartsize = document.getElementById('cart-size');
//            cartsize.innerText = response;
//        }
//    });
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



    //~~~~~~~~~~~~~~~~ JS ~~~~~~~~~~~~~~~~~~~~~~~~~~
    fetch('http://localhost:8080/MarketPlace/basketAPI', {
        method: "POST",
        headers: headers,
        body: data
    }).then(response => response.json()).then(response => {
        if (response.error === undefined) {
            var cartsize = document.getElementById('cart-size');
            cartsize.innerText = response.basketsize;
            displayAlertAddToBasket(name, price, size, quantity);
            document.getElementById("btnCheckout").style.display = "block";
        } else {
            displayAlert(response.error);
        }

    }).catch(err => {
        console.log(err);
    });
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}


//Alert popup
var alert = document.getElementsByClassName("alert")[0];
var alert_close = document.getElementById("alert-close");

function displayAlertAddToBasket(name, price, size, quantity) {
    var mess = '';
    mess += "You have added product to basket:<br>";
    mess += "Product Name: " + name + "<br>";
    mess += "Price: " + price + "<br>";
    mess += "Size: " + size + "<br>";
    mess += "Quantity: " + quantity + "<br>";
    displayAlert(mess);
}

function displayAlert(mess) {
    var inner = '';
    inner += '<div class="alert-content">';
    inner += '    <span class="close" onclick="closeAlert()">&times;</span>';
    inner += '    <p>' + mess + '</p>';
    inner += '</div>';
    alert.innerHTML = inner;
    alert.style.display = "block";
}

function closeAlert() {
    alert.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function (event) {
    if (event.target === alert) {
        alert.style.display = "none";
    }
};
// When the user clicks on <span> (x), remove an orderitem from basket
function removeOrderItem(pid, sid) {
    var headers = {
        "Content-Type": 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    var data = new URLSearchParams();
    data.append('action', 'remove');
    data.append('productID', pid);
    data.append('sizeID', sid);
    fetch('http://localhost:8080/MarketPlace/basketAPI', {
        method: "POST",
        headers: headers,
        body: data
    }).then(response => response.json()).then(response => {
        if (response.error === undefined) {
            var basket = response.basket;
            if (basket.length === 0) {
                var inner = "";
                inner += "<p class='text-red'>You currently have no products in your basket. </p>";
                inner += "<p class='text-red'>Please go to the online shop via the top menu to add new products. </p>";
                document.getElementById("basket").innerHTML = inner;
                document.getElementById("btnCheckout").style.display = "none";
            } else {
                var inner = '';
                for (var i = 0; i < basket.length; i++) {
                    var item = basket[i];
                    inner += '        <tr>';
                    inner += '            <td>';
                    inner += '                <div class="flex items-center">';
                    inner += '                    <img src="' + item.product.img + '" style="width: 100px; height: 100px;" class="rounded">';
                    inner += '                    <div class="ma-4">';
                    inner += '                        <a href="homepage?main=detail&id=' + item.product.id + '" class="text-black font-bold">' + item.product.name + '</a>';
                    inner += '                        <p>Delivery: ' + item.product.delivery + '</p>';
                    inner += '                        <p>Size: ' + item.size.name + '</p>';
                    inner += '                    </div>';
                    inner += '                </div>';
                    inner += '            </td>';
                    inner += '            <td>' + parseFloat(item.product.price).toFixed(1) + ' USD</td>';
                    inner += '            <td>' + item.quantity + '</td>';
                    inner += '            <td>' + parseFloat(item.product.price * item.quantity).toFixed(1) + ' USD</td>';
                    inner += '            <td>';
                    inner += '                <span class="close" onclick="removeOrderItem(' + item.product.id + ',' + item.size.id + ')">&times;</span>';
                    inner += '            </td>';
                    inner += '        </tr>';
                }
                document.getElementById("basket").innerHTML = inner;
            }
            calculateTotalPrice();
        } else {
            displayAlert(response.error);
        }

    }).catch(err => {
        console.log(err);
    });
}


//Calculate Total Price
function calculateTotalPrice() {
    if (document.getElementById("basket") === null) {
        return;
    }
    var rows = document.getElementById("basket").getElementsByTagName("tr");
    var total = 0;
    for (var i = 0; i < rows.length; i++) {
        total = total + parseFloat(rows[i].getElementsByTagName("td")[3].textContent.replace(' USD', ''));
    }
    document.getElementById("subtotal").textContent = total.toFixed(1) + ' USD';
    document.getElementById("total").textContent = total.toFixed(1) + ' USD';
}


//Popup/Hide Billing Address in Checkout
function reloadBillingAddress() {
    var same_address = document.getElementById("same-address");
    if (same_address === null) {
        return;
    }
    if (same_address.checked) {
        document.getElementById("billing-form").style.display = "none";
        input = document.getElementById("billing-form").getElementsByTagName('input');
        for (i = 0; i < input.length; i++) {
            input[i].required = false;
        }
    } else {
        document.getElementById("billing-form").style.display = "flex";
        input = document.getElementById("billing-form").getElementsByTagName('input');
        input_template = document.getElementById("shipping-form").getElementsByTagName('input');
        for (i = 0; i < input.length; i++) {
            if (input_template[i].required === true) {
                input[i].required = true;
            }
        }
    }
}

//Reload button place order
function reloadBtnConfirm() {
    if (document.getElementById("cbxConfirm").checked) {
        document.getElementById("btnPlaceorder").style.display = "inline";
    } else {
        document.getElementById("btnPlaceorder").style.display = "none";
    }
}

//Loading Window
window.onload = (event) => {
    reloadBillingAddress();
    calculateTotalPrice();
    reloadBtnConfirm();
};


