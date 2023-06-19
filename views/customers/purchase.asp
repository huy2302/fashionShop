<!-- #include file="connect.asp" -->

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title  -->
    <title>Essence - Fashion Ecommerce Template</title>

    <!-- Favicon  -->
    <link rel="icon" href="img/core-img/favicon.ico">
    <link rel="stylesheet" href="./css/add.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- Core Style CSS -->
    <link rel="stylesheet" href="style.css">
    <link rel="icon" href="img/core-img/favicon.ico">

    <!-- Core Style CSS -->
    <link rel="stylesheet" href="css/core-style.css">
    <link rel="stylesheet" href="./css/purchase.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<style>
    .action {
        color: #0009ff;
        font-size: 20px;
        display: block;
        padding: 10px;
        margin: 10px 0;
    }

    .action:hover {
        font-size: 20px;
    }

    .action_container {
        flex-direction: column;
    }
</style>

<body>
    <!-- ##### Header Area Start ##### -->
   
    <!-- #include file="header.asp" -->

    <!-- ##### Header Area End ##### -->

    <!-- #include file="cart.asp" -->
    <!-- ##### Breadcumb Area Start ##### -->
    <div class="breadcumb_area bg-img" style="background-image: url(img/bg-img/breadcumb.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="page-title text-center">
                        <h2>Purchase</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ##### Breadcumb Area End ##### -->

    <!-- ##### Checkout Area Start ##### -->
    <div class="checkout_area section-padding-80">
        <div class="container">
            <div class="row">
            
                <div class="list-purchase">
                    <%
                    Set Conn = Server.CreateObject("ADODB.Connection")
                    Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

                    sql = "select billDetails.ID_product, billDetails.ID_color, billDetails.ID_size, billDetails.price, billDetails.species, sale_percent, oder_day, product.name, brand, size, color, billDetails.quantity, bill.delivery_day, link1 from billDetails join bill on billDetails.ID_bill = bill.ID_bill join product on billDetails.ID_product = product.ID_product join brand on billDetails.ID_product = brand.ID_product join size on billDetails.ID_size = size.ID_size join color on billDetails.ID_color = color.ID_color join imageProduct on imageProduct.ID_product = product.ID_product join users on bill.ID_user = users.ID_user where users.ID_user = "&Session("ID_user")&" order by bill.oder_day desc"

                    Set Result = Conn.execute(sql)
                    if not Result.EOF then 
                        do while not Result.EOF
                        %>
                        <div class="single-purchase">
                            <div class="purchase-header">
                                <!-- Species -->
                                <h4><%=Result("species")%></h4>
                                <% if IsNull(Result("delivery_day")) then %>
                                    <p class="delivery_status-process"><i class="fa-solid fa-truck-fast"></i> Order is being processed</p>
                                <% else %>
                                    <p class="delivery_status-success"><i class="fa-solid fa-truck-fast"></i> Order has been successfully delivered</p>
                                <% end if %>
                            </div>
                            <a href="./product_ex.asp?product=<%=Result("ID_product")%>" class="purchase-content">
                                <div style="display: flex;">
                                    <div class="img">
                                        <img src="/fashionShop/resources/imgProduct/<%=Result("link1")%>" alt="">
                                    </div>
                                    <div class="content">
                                        <h3><%=Result("name")%></h3>
                                        <p>Size: <%=Result("size")%></p>
                                        <p>Color: <%=Result("color")%></p>
                                        <p>x<%=Result("quantity")%></p>
                                    </div>
                                </div>
                                <div class="purchase-price">
                                    <% if not IsNull(Result("sale_percent")) then 
                                        sale = CInt(Result("sale_percent"))
                                        price = CInt(Result("price"))
                                        sum_price = (price - price * sale / 100)
                                    %>
                                        <p style="margin-right: 0.6em; color: #999; text-decoration: line-through;">$<%=price%>.00</p>
                                        <p>$<%=sum_price%>.00</p>
                                    <% 
                                        sale = 0
                                        price = 0
                                    else
                                        sum_price = CInt(Result("price"))
                                    %>
                                        <p>$<%=Result("price")%>.00</p>
                                    <% 
                                    end if
                                    %>
                                </div>
                            </a>
                            <div class="purchase-end">
                                <div class="total">
                                    <p><i class="fa-solid fa-shield-halved"></i> Order Total: <span>$<%
                                    quantity = CInt(Result("quantity"))
                                    response.write sum_price * quantity
                                    sum_price = 0

                                    %>.00</span></p>
                                </div>
                                <div class="desc">
                                    <p>Bought on <span><%
                                    Dim myDate
                                    Dim formattedDay
                                    myDate = Result("oder_day")
                                    formattedDay = FormatDateTime(myDate, 2)
                                    days = Day(myDate)
                                    months = Month(myDate)
                                    years = Year(myDate)

                                    response.write days&"-"&months&"-"&years
                                    %></span></p>
                                    <input class="input_id" type="hidden" name="ID_product" value="<%=Result("ID_product")%>">
                                    <a class="buyAgain-btn" href="./product_ex.asp?product=<%=Result("ID_product")%>">Buy Again</a>
                                </div>
                            </div>
                        </div>
                        <%
                            Result.MoveNext
                            loop
                        %>
                    <% else %>
                    <h3>Purchase history is empty, <a href="shop.asp" style="font-size: 1em; color: #0067ff; border-bottom: 3px solid; padding: 0 5px;">Buy Here</a>.</h3>
                    <% end if %>
                </div>

            </div>
        </div>
    </div>
    <!-- <script>
        var buyAgain = function() {
            var text = "Would you like to buy this product again?";
            if (confirm(text) == true) {
                window.location.href = './product_ex.asp?product=<%=Result("ID_product")%>';
            } 
        }
        var buyAgainBtns = document.querySelectorAll('.buyAgain-btn');
        var id_products = document.querySelectorAll('.input_id');

        buyAgainBtns.forEach((btn, index) => {
            console.log(id_products[index].value)
            btn.addEventListener('click', buyAgain);
        })
    </script> -->
    <!-- ##### Checkout Area End ##### -->

    <!-- #include file="footer.asp" -->
    
    <!-- jQuery (Necessary for All JavaScript Plugins) -->
    <script src="js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="js/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="js/bootstrap.min.js"></script>
    <!-- Plugins js -->
    <script src="js/plugins.js"></script>
    <!-- Classy Nav js -->
    <script src="js/classy-nav.min.js"></script>
    <!-- Active js -->
    <script src="js/active.js"></script>
    
</body>

</html>