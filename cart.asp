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
' 	Next
' 	Dim sqlString
    Dim idList, mycarts, totalProduct, subtotal, statusViews, statusButtons, rs

    Set Conn = Server.CreateObject("ADODB.Connection")
    Set RSprice = Server.CreateObject("ADODB.Recordset")
    Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"
    totalProduct = 0
    sqlPrice = "select cart.ID_product, cart.ID_size, cart.ID_color, product.price, cart.quantity, discount.sale_percent from cart inner join product_size_color p on cart.ID_product = p.ID_product inner join size on cart.ID_size = size.ID_size inner join color on cart.ID_color = color.ID_color inner join product on product.ID_product = cart.ID_product inner join brand on brand.ID_product = cart.ID_product inner join discount on discount.ID_product = cart.ID_product group by cart.ID_product, cart.ID_size, cart.ID_color, product.price, cart.quantity, discount.sale_percent"
    RSprice.Open sqlPrice, Conn
    do while not RSprice.EOF 
        totalProduct = CDbl(RSprice("price")) * CDbl(RSprice("quantity")) * (100 - CDbl(RSprice("sale_percent")))
    loop
    Response.Write "totalProduct: "&totalProduct

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
            

            Dim size, sql, RScolorSize
            ' sql = "SELECT quantity FROM Product WHERE size='" & size & "'"
            Set RScolorSize = Server.CreateObject("ADODB.Recordset")
            sql = "select cart.ID_product, product.name, cart.ID_size, size.size, cart.ID_color, color.color, brand, product.price, cart.quantity, link1 from cart inner join product_size_color p on cart.ID_product = p.ID_product inner join size on cart.ID_size = size.ID_size inner join color on cart.ID_color = color.ID_color inner join product on product.ID_product = cart.ID_product inner join brand on brand.ID_product = cart.ID_product inner join imageProduct on imageProduct.ID_product = cart.ID_product group by cart.ID_product, product.name, cart.ID_size, size.size, cart.ID_color, color.color, brand, product.price, cart.quantity, link1"
            RScolorSize.Open sql, conn
            
            do while not RScolorSize.EOF
        %>
                <!-- Single Cart Item -->
                <div class="single-cart-item">
                    <a href="#" class="product-image">
                        <img src="<%=RScolorSize("link1")%>" class="cart-thumb" alt="">
                        <!-- Cart Item Desc -->
                        <div class="cart-item-desc">
                            <span class="product-remove"><i class="fa fa-close" aria-hidden="true"></i></span>
                            <span class="badge"><%=RScolorSize("brand")%></span>
                            <h6><%=RScolorSize("name")%></h6>    
                            <p class="size">Size: <%=RScolorSize("size")%></p>
                            <p class="color">Color: <%=RScolorSize("color")%></p>
                            <div class="quantity">
                                <button><i class="fa-solid fa-minus"></i></button>
                                <input type="number" placeholder="0" value="<%=RScolorSize("quantity")%>">
                                <button><i class="fa-solid fa-plus"></i></button>
                            </div>
                            <p class="price">$<%=RScolorSize("price")%>.00</p>
                        </div>
                    </a>
                </div>
        <%
            RScolorSize.MoveNext
            loop
        %>
            
            
            
        </div>

        <!-- Cart Summary -->
        <div class="cart-amount-summary">

            <h2>Summary</h2>
            <ul class="summary-table">
                <li><span>subtotal:</span> <span>$274.00</span></li>
                <li><span>delivery:</span> <span>Free</span></li>
                <li><span>discount:</span> <span>-15%</span></li>
                <li><span>total:</span> <span>$232.00</span></li>
            </ul>
            <div class="checkout-btn mt-100">
                <a href="checkout.html" class="btn essence-btn">check out</a>
            </div>
        </div>
    </div>
</div>
<!-- ##### Right Side Cart End ##### -->