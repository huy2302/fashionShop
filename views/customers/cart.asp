<%
' lay ve danh sach product theo id trong my cart
' If (NOT IsEmpty(Session("mycarts"))) Then
'   statusViews = "d-none"
'   statusButtons = "d-block"
' true
	' Set mycarts = Session("mycarts")
	' totalProduct = mycarts.Count    

    
' 	For Each List In mycarts.Keys

' 		If (idList="") Then
' ' true
' 			idList = List
' 		Else
' 			idList = idList & ", " & List
' 		End if                               
' ' 	Next
'     Dim idList, mycarts, totalProduct, subtotal, statusViews, statusButtons, rs

    Set Conn = Server.CreateObject("ADODB.Connection")
    Conn.Open "Provider=SQLOLEDB.1;Data Source=THUY092\THUYDEV;Database=shop;User Id=sa;Password=123"

    totalProduct = 0
    totalSale = 0
    ' sqlPrice = "select cart.ID_product, cart.ID_size, cart.ID_color, product.price, cart.quantity, discount.sale_percent from cart inner join product_size_color p on cart.ID_product = p.ID_product inner join size on cart.ID_size = size.ID_size inner join color on cart.ID_color = color.ID_color inner join product on product.ID_product = cart.ID_product inner join brand on brand.ID_product = cart.ID_product inner join discount on discount.ID_product = cart.ID_product group by cart.ID_product, cart.ID_size, cart.ID_color, product.price, cart.quantity, discount.sale_percent"
    ' RSprice.Open sqlPrice, Conn
    ' do while not RSprice.EOF 
    '     Response.Write "totalProduct: "&RSprice("ID_product")
    ' loop
    ' Response.Write "totalProduct: "&totalProduct

%>
<!-- ##### Right Side Cart Area ##### -->
<div class="cart-bg-overlay"></div>

<div class="right-side-cart-area">

    <!-- Cart Button -->
    <div class="cart-button">
        <a href="#" id="rightSideCart"><img src="img/core-img/bag.svg" alt=""> <span>3</span></a>
    </div>

    <div class="cart-content d-flex">
        <!-- Cart List Area -->
        <div class="cart-list">
        <%
            if NOT IsEmpty(Session("ID_user")) then
                ' Dim size, sql, RScolorSize
                ' sql = "SELECT quantity FROM Product WHERE size='" & size & "'"
                Set RScolorSize = Server.CreateObject("ADODB.Recordset")
                sql = "select cart.ID_product, product.name, cart.ID_size, size.size, cart.ID_color, color.color, brand, product.price, cart.quantity, link1, sale_percent from cart inner join product_size_color p on cart.ID_product = p.ID_product inner join size on cart.ID_size = size.ID_size inner join color on cart.ID_color = color.ID_color inner join product on product.ID_product = cart.ID_product inner join brand on brand.ID_product = cart.ID_product inner join imageProduct on imageProduct.ID_product = cart.ID_product inner join discount on discount.ID_product = cart.ID_product where cart.ID_user = "&Session("ID_user")&" group by cart.ID_product, product.name, cart.ID_size, size.size, cart.ID_color, color.color, brand, product.price, cart.quantity, link1, sale_percent"
            
                RScolorSize.Open sql, conn
                do while not RScolorSize.EOF
                    totalProduct = totalProduct + CDbl(RScolorSize("price")) * CDbl(RScolorSize("quantity"))
                    totalSale = totalSale + CDbl(RScolorSize("price")) * CDbl(RScolorSize("quantity")) * (100 - CDbl(RScolorSize("sale_percent")))/100   

                    priceSale = CDbl(RScolorSize("price")) * (100 - CDbl(RScolorSize("sale_percent")))/100
        %>
                <!-- Single Cart Item -->
                <div class="single-cart-item">
                    <a href="#" class="product-image">
                        <img src="<%=RScolorSize("link1")%>" class="cart-thumb" alt="">
                        <!-- Cart Item Desc -->
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
                </div>
        <%
                RScolorSize.MoveNext
                loop
            end if
        %>
        </div>

        <!-- Cart Summary -->
        <div class="cart-amount-summary">

            <h2>Summary</h2>
            <ul class="summary-table">
                <li><span>subtotal:</span> <span>$<%=totalProduct%>.00</span></li>
                <li><span>delivery:</span> <span>Free</span></li>
                <li><span>total:</span> <span>$<%=totalSale%>.00</span></li>
            </ul>
            <div class="checkout-btn mt-100">
                <a href="checkout.asp" class="btn essence-btn">check out</a>
            </div>
        </div>
    </div>
</div>

<script>
    // delete product from cart
    const idProducts = document.querySelectorAll(".id_product_cart");
    const idSizes = document.querySelectorAll(".id_size_cart");
    const idColors = document.querySelectorAll(".id_color_cart");
    const removeProductBtns = document.querySelectorAll(".product-remove");
    const singleProducts = document.querySelectorAll(".single-cart-item");

    // plus and sub quantity product
    const plusBtn = document.querySelectorAll('.plus_product-btn');
    const quantityBtn = document.querySelectorAll('.quantity_product');
    const subBtn = document.querySelectorAll('.sub_product-btn');

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
            } else {
                quantityBtn[index].value = quantity;
                updateQuantity(quantity, index);                
            }
        })
    })
    // call ajax update quantity 
    const updateQuantity = (quantity, index) => {
        console.log(1)
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
            // console.log(ID_product)
            xmlhttp.send();
        })
    })
</script>
<!-- ##### Right Side Cart End ##### -->