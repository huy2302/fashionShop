<%
    Set Conn = Server.CreateObject("ADODB.Connection")
    Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

    totalProduct = 0
    totalSale = 0
    
%>
<!-- ##### Right Side Cart Area ##### -->
<div class="cart-bg-overlay"></div>

<div class="right-side-cart-area">

    <!-- Cart Button -->
    <div class="cart-button">
        <% 
        if NOT IsEmpty(Session("ID_user")) then
        Set RScart = Server.CreateObject("ADODB.Recordset")
        sql = "select COUNT(cart.ID_cart) as id from cart join users on users.ID_user = cart.ID_user where cart.ID_user = "&Session("ID_user")
    
        RScart.Open sql, conn
        %>
        <a href="#" id="rightSideCart"><img src="img/core-img/bag.svg" alt=""> <span id="cartQuantity"><%=RScart("id")%></span></a>
        <%
        else 
        %>
        <a href="#" id="rightSideCart"><img src="img/core-img/bag.svg" alt=""> <span id="cartQuantity">0</span></a>
        <% end if %>
    </div>

    <div class="cart-content d-flex">
        <!-- Cart List Area -->
        <div id="cart-list" class="cart-list">
        <%
            if NOT IsEmpty(Session("ID_user")) then
                Set RScolorSize = Server.CreateObject("ADODB.Recordset")
                sql = "select cart.ID_product, product.name, cart.ID_size, size.size, cart.ID_color, color.color, brand, product.price, cart.quantity, link1, sale_percent, end_day from cart inner join product_size_color p on cart.ID_product = p.ID_product inner join size on cart.ID_size = size.ID_size inner join color on cart.ID_color = color.ID_color inner join product on product.ID_product = cart.ID_product inner join brand on brand.ID_product = cart.ID_product inner join imageProduct on imageProduct.ID_product = cart.ID_product inner join discount on discount.ID_product = cart.ID_product where cart.ID_user = "&Session("ID_user")&" group by cart.ID_product, product.name, cart.ID_size, size.size, cart.ID_color, color.color, brand, product.price, cart.quantity, link1, sale_percent, end_day"
            
                RScolorSize.Open sql, conn
                do while not RScolorSize.EOF
                    totalProduct = totalProduct + CDbl(RScolorSize("price")) * CDbl(RScolorSize("quantity"))
                    totalSale = totalSale + CDbl(RScolorSize("price")) * CDbl(RScolorSize("quantity")) * (100 - CDbl(RScolorSize("sale_percent")))/100   
                    priceSale = CDbl(RScolorSize("price")) * (100 - CDbl(RScolorSize("sale_percent")))/100

                    price = CInt(RScolorSize("price"))
                    quantity = CInt(RScolorSize("quantity"))
                    percent = CInt(RScolorSize("sale_percent"))

                    ' tạo biến currentDate lấy ra ngày hiện tại
                    ' so sánh với ngày hết hạn sale để tính giá tiền
                    currentDate_cart = Date()

                    datee = FormatDateTime(RScolorSize("end_day"),2)

                    if (CStr(datee) < CStr(currentDate_cart)) then
                        percent = 0
                    end if

                    ' tính giá tổng đơn hàng
                    subtotal_sale = (price * (100 - percent))/100 * quantity
                    subtotal = price * quantity
                    total = total + subtotal
                    total_sale = total_sale + subtotal_sale
        %>
                <!-- Single Cart Item -->
                <!--<div class="single-cart-item">
                    <a href="#" class="product-image">
                        <img src="/fashionShop/resources/imgProduct/<%=RScolorSize("link1")%>" class="cart-thumb" alt="">
                        <div class="cart-item-desc">
                            <input class="id_product_cart" style="display: none;" value="<%=RScolorSize("ID_product")%>">
                            <input class="id_size_cart" style="display: none;" value="<%=RScolorSize("ID_size")%>">
                            <input class="id_color_cart" style="display: none;" value="<%=RScolorSize("ID_color")%>">

                            <span class="product-remove"><i class="fa fa-close" aria-hidden="true"></i></span>
                            <span class="badge"><%=RScolorSize("brand")%></span>
                            <h6><%=RScolorSize("name")%></h6>    
                            <p class="size">Size: <%=RScolorSize("size")%></p>
                            <p class="color">Color: <%=RScolorSize("color")%></p>
                            <div class="quantity">
                                <button class="sub_product-btn"><i class="fa-solid fa-minus"></i></button>
                                <input class="quantity_product" type="number" placeholder="0" value="<%=RScolorSize("quantity")%>">
                                <button class="plus_product-btn"><i class="fa-solid fa-plus"></i></button>
                            </div>
                            <div class="price-block">
                            <% if(CInt(RScolorSize("sale_percent")) = 0) then %>
                                <p class="price">$<%=RScolorSize("price")%>.00</p>
                            <% else %>
                                <p class="price price-disable">$<%=RScolorSize("price")%>.00</p>
                                <p class="price price-sale">$<%=priceSale%>.00</p>
                            <% end if %>
                            </div>
                        </div>
                    </a>
                </div>-->
        <%
                RScolorSize.MoveNext
                loop
            end if
        %>
        </div>

        <!-- Cart Summary -->
        <div class="cart-amount-summary">

            <h2>Summary</h2>
            <ul class="summary-table" id="summary-table">
                <li><span>subtotal:</span> <span>$<%=total%>.00</span></li>
                <li><span>sale off:</span> <span>$<%=total - total_sale%>.00</span></li>
                <li><span>delivery:</span> <span>Free</span></li>
                <li><span>total:</span> <span>$<%=total_sale%>.00</span></li>
            </ul>
            <div class="checkout-btn mt-100">
                <a href="checkout.asp" class="btn essence-btn">check out</a>
            </div>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>

<script>
    var getTotal = function (){
        $.ajax({
            url: '/fashionShop/controllers/getTotalCheckout.asp',
            // data: data,
            dataType: 'json',
            success: function (response) {
                console.log(response)
                document.getElementById('summary-table').innerHTML = "";
                document.getElementById('summary-table').innerHTML += `
                <li><span>subtotal:</span> <span>$${response.subtotal}.00</span></li>
                <li><span>sale off:</span> <span>$${response.saleoff}.00</span></li>
                <li><span>delivery:</span> <span>Free</span></li>
                <li><span>total:</span> <span>$${response.total}.00</span></li>
                `;
            },
            error: function (response){
                alert('Lỗi AJAX');
            }
        });
    }
    var LoadData = function (){
        // var data = {ID_productDetail: <%=ID_productDetail%>};
        // console.log(data);
        $.ajax({
            url: '/fashionShop/controllers/getCart.asp',
            // data: data,
            dataType: 'json',
            success: function (response) {
                console.log(response)
                response.forEach(function(item) {
                    if (item.id == "-1") {
                        return
                    }
                    var id = item.id;
                    var id_size = item.id_size;
                    var id_color = item.id_color;
                    var name = item.name;
                    var color = item.color;
                    var size = item.size;
                    var brand = item.brand;
                    var price = item.price;
                    var quantity = item.quantity;
                    var sale_percent = item.sale_percent;
                    var link1 = item.link1;
                    
                    // // Xử lý thông tin từng phần tử trong mảng
                    // console.log("id: " + id + ", name: " + name);
                    // console.log("size: " + size + ", brand: " + brand);
                    // console.log("price: " + price + ", quantity: " + quantity);
                    // console.log("sale_percent: " + sale_percent + ", link1: " + link1);
                    // var string = "123"
                    // // $('#cart-list').html()
                    document.getElementById('cart-list').innerHTML += `
                    <div class="single-cart-item">
                        <a href="#" class="product-image">
                            <img src="/fashionShop/resources/imgProduct/${link1}" class="cart-thumb" alt="">
                            <div class="cart-item-desc">
                                <input class="id_product_cart" style="display: none;" value="${id}">
                                <input class="id_size_cart" style="display: none;" value="${id_size}">
                                <input class="id_color_cart" style="display: none;" value="${id_color}">

                                <span class="product-remove"><i class="fa fa-close" aria-hidden="true"></i></span>
                                <span class="badge">${brand}</span>
                                <h6>${name}</h6>    
                                <p class="size">Size: ${size}</p>
                                <p class="color">Color: ${color}</p>
                                <div class="quantity">
                                    <button class="sub_product-btn"><i class="fa-solid fa-minus"></i></button>
                                    <input class="quantity_product" type="number" placeholder="0" value="${quantity}">
                                    <button class="plus_product-btn"><i class="fa-solid fa-plus"></i></button>
                                </div>
                                <div class="price-block">
                                
                                </div>
                            </div>
                        </a>
                    </div>
                    `;
                    var idProducts = document.querySelectorAll(".id_product_cart");
                    var idSizes = document.querySelectorAll(".id_size_cart");
                    var idColors = document.querySelectorAll(".id_color_cart");
                    var removeProductBtns = document.querySelectorAll(".product-remove");
                    var singleProducts = document.querySelectorAll(".single-cart-item");

                    // plus and sub quantity product
                    var plusBtn = document.querySelectorAll('.plus_product-btn');
                    var quantityBtn = document.querySelectorAll('.quantity_product');
                    var subBtn = document.querySelectorAll('.sub_product-btn');

                    // var spanQuantityCart = document.getElementById('span-quantity');

                    // var cartQuantity = document.getElementById('cartQuantity');

                    var quantity = "";
                    quantityBtn.forEach((btn, index) => {
                        btn.addEventListener('change', () => {
                            quantity = parseInt(quantityBtn[index].value);
                            updateQuantity(quantity, index);
                            setTimeout(() => {
                                getTotal();
                            }, 500);
                        })
                    })
                    plusBtn.forEach((btn, index) => {        
                        btn.addEventListener('click', (e) => {
                            quantity = parseInt(quantityBtn[index].value);
                            e.preventDefault();
                            quantity += 1;
                            quantityBtn[index].value = quantity;
                            updateQuantity(quantity, index)
                            setTimeout(() => {
                                getTotal();
                            }, 500);
                        })
                    })
                    subBtn.forEach((btn, index) => {        
                        btn.addEventListener('click', (e) => {
                            quantity = parseInt(quantityBtn[index].value);
                            e.preventDefault();
                            quantity -= 1;
                            if(quantity <= 0) {
                                quantity = 0
                                quantityBtn[index].value = quantity;
                                singleProducts[index].remove();

                                var xmlhttp = new XMLHttpRequest();
                                xmlhttp.open("GET", "/fashionShop/controllers/deleteProduct.asp?id=" + idProducts[index].value + "&size=" + idSizes[index].value + "&color=" + idColors[index].value, true);
                                // console.log(ID_product)
                                xmlhttp.send();
                                setTimeout(() => {
                                    getQuantity();
                                }, 300);    
                            } else {
                                quantityBtn[index].value = quantity;
                                updateQuantity(quantity, index);                
                            }
                            // getQuantity();
                            setTimeout(() => {
                                getTotal();
                            }, 500);
                        })
                    })
                    // call ajax update quantity 
                    var updateQuantity = (quantity, index) => {
                        var xmlhttp = new XMLHttpRequest();
                        xmlhttp.open("GET", "/fashionShop/controllers/updateQuantity.asp?id=" + idProducts[index].value + "&size=" + idSizes[index].value + "&color=" + idColors[index].value + "&quantity=" + quantity, true);
                        // console.log(ID_product)
                        xmlhttp.send();
                    }

                    removeProductBtns.forEach((btn, index) => {
                        btn.addEventListener('click', (e) => {
                            singleProducts[index].remove();
                            e.preventDefault();
                            var xmlhttp = new XMLHttpRequest();
                            xmlhttp.open("GET", "/fashionShop/controllers/deleteProduct.asp?id=" + idProducts[index].value + "&size=" + idSizes[index].value + "&color=" + idColors[index].value, true);
                            xmlhttp.send();
                            setTimeout(() => {
                                getQuantity();
                            }, 300);
                            setTimeout(() => {
                                getTotal();
                            }, 500);
                        })
                    })
                    

                    var getQuantity = function () {
                        var xhr = new XMLHttpRequest();
                        xhr.open("GET", "/fashionShop/controllers/getQuantityCart.asp", true);
                        
                        xhr.onreadystatechange = function() {
                            if (xhr.readyState === XMLHttpRequest.DONE) {
                                var status = xhr.status;
                                if (status === 0 || (status >= 200 && status < 400)) {
                                    // console.log("Success" + xhr.responseText);
                                    spanQuantityCart.innerHTML = xhr.responseText;
                                    cartQuantity.innerHTML = xhr.responseText;
                                } else {
                                    console.log("Error" + xhr.responseText);
                                }
                            }
                        };
                        xhr.send();
                    }
                }
            )},
            error: function (response){
                alert('Lỗi AJAX');
            }
        });
    }

    function CloseConfirm(){
        document.getElementById('confirm-delete').style.display = "none";
    }
    document.getElementById('essenceCartBtn').addEventListener('click', function() {
        LoadData();
        getTotal();
    })
</script>
<script>
    var spanQuantityCart = document.getElementById('span-quantity');
    var cartQuantity = document.getElementById('cartQuantity');
</script>
<!--<script>

    var updateQuantityPage = function() {
        // delete product from cart
        var idProducts = document.querySelectorAll(".id_product_cart");
        var idSizes = document.querySelectorAll(".id_size_cart");
        var idColors = document.querySelectorAll(".id_color_cart");
        var removeProductBtns = document.querySelectorAll(".product-remove");
        var singleProducts = document.querySelectorAll(".single-cart-item");

        // plus and sub quantity product
        var plusBtn = document.querySelectorAll('.plus_product-btn');
        var quantityBtn = document.querySelectorAll('.quantity_product');
        var subBtn = document.querySelectorAll('.sub_product-btn');

        var spanQuantityCart = document.getElementById('span-quantity');

        var cartQuantity = document.getElementById('cartQuantity');

        var quantity = "";
        quantityBtn.forEach((btn, index) => {
            btn.addEventListener('change', () => {
                quantity = parseInt(quantityBtn[index].value);
                updateQuantity(quantity, index);
            })
        })
        plusBtn.forEach((btn, index) => {        
            btn.addEventListener('click', (e) => {
                quantity = parseInt(quantityBtn[index].value);
                e.preventDefault();
                quantity += 1;
                quantityBtn[index].value = quantity;
                updateQuantity(quantity, index)
            })
        })
        subBtn.forEach((btn, index) => {        
            btn.addEventListener('click', (e) => {
                quantity = parseInt(quantityBtn[index].value);
                e.preventDefault();
                quantity -= 1;
                if(quantity <= 0) {
                    quantity = 0
                    quantityBtn[index].value = quantity;
                    singleProducts[index].remove();

                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.open("GET", "/fashionShop/controllers/deleteProduct.asp?id=" + idProducts[index].value + "&size=" + idSizes[index].value + "&color=" + idColors[index].value, true);
                    // console.log(ID_product)
                    xmlhttp.send();
                    setTimeout(() => {
                        getQuantity();
                    }, 300);    
                } else {
                    quantityBtn[index].value = quantity;
                    updateQuantity(quantity, index);                
                }
                // getQuantity();
            })
        })
        // call ajax update quantity 
        var updateQuantity = (quantity, index) => {
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.open("GET", "/fashionShop/controllers/updateQuantity.asp?id=" + idProducts[index].value + "&size=" + idSizes[index].value + "&color=" + idColors[index].value + "&quantity=" + quantity, true);
            // console.log(ID_product)
            xmlhttp.send();
        }

        removeProductBtns.forEach((btn, index) => {
            btn.addEventListener('click', (e) => {
                singleProducts[index].remove();
                e.preventDefault();
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("GET", "/fashionShop/controllers/deleteProduct.asp?id=" + idProducts[index].value + "&size=" + idSizes[index].value + "&color=" + idColors[index].value, true);
                xmlhttp.send();
                setTimeout(() => {
                    getQuantity();
                }, 300);
            })
        })
        

        var getQuantity = function () {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "/fashionShop/controllers/getQuantityCart.asp", true);
            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    var status = xhr.status;
                    if (status === 0 || (status >= 200 && status < 400)) {
                        console.log("Success" + xhr.responseText);
                        spanQuantityCart.innerHTML = xhr.responseText;
                        cartQuantity.innerHTML = xhr.responseText;
                    } else {
                        console.log("Error" + xhr.responseText);
                    }
                }
            };
            xhr.send();
        }
    }
    
</script>-->

<!-- ##### Right Side Cart End ##### -->