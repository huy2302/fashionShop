<!-- #include file="connect.asp" -->
<%
	connDB.Open()
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function
%>
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
    <link rel="icon" href="./img/core-img/favicon.ico">
    <link rel="stylesheet" href="./css/add.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- Core Style CSS -->
    <link rel="stylesheet" href="css/core-style.css">
    <link rel="stylesheet" href="style.css">

</head>

<body>
    <!-- ##### Header Area Start ##### -->

    <!-- #include file="header.asp" -->
    
    <!-- ##### Header Area End ##### -->

    <!-- #include file="cart.asp" -->

    <!-- ##### Welcome Area Start ##### -->
    <section class="welcome_area bg-img background-overlay" style="background-image: url(img/bg-img/bg-1.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="hero-content">
                        <h6>asoss</h6>
                        <h2>New Collection</h2>
                        <a href="./shop_new.asp" class="btn essence-btn">view collection</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Welcome Area End ##### -->

    <!-- ##### Top Catagory Area Start ##### -->
    <div class="top_catagory_area section-padding-80 clearfix">
        <div class="container">
            <div class="row justify-content-center">
                <!-- Single Catagory -->
                <div class="col-12 col-sm-6 col-md-4">
                    <div class="single_catagory_area d-flex align-items-center justify-content-center bg-img" style="background-image: url(img/bg-img/bg-2.jpg);">
                        <div class="catagory-content">
                            <a href="#">Clothing</a>
                        </div>
                    </div>
                </div>
                <!-- Single Catagory -->
                <div class="col-12 col-sm-6 col-md-4">
                    <div class="single_catagory_area d-flex align-items-center justify-content-center bg-img" style="background-image: url(img/bg-img/bg-3.jpg);">
                        <div class="catagory-content">
                            <a href="#">Shoes</a>
                        </div>
                    </div>
                </div>
                <!-- Single Catagory -->
                <div class="col-12 col-sm-6 col-md-4">
                    <div class="single_catagory_area d-flex align-items-center justify-content-center bg-img" style="background-image: url(img/bg-img/bg-4.jpg);">
                        <div class="catagory-content">
                            <a href="#">Accessories</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ##### Top Catagory Area End ##### -->

    <!-- ##### CTA Area Start ##### -->
    <div class="cta-area">
        <div class="container">
        <%
        Set Conn = Server.CreateObject("ADODB.Connection")
        Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"
        
        sql = "select max(sale_percent) as sale from discount where discount.end_day > GETDATE()"

        Set rs_sale = Conn.execute(sql)
        if not rs_sale.EOF then
        %>
            <div class="row">
                <div class="col-12">
                    <div class="cta-content bg-img background-overlay" style="background-image: url(img/bg-img/bg-5.jpg);">
                        <div class="h-100 d-flex align-items-center justify-content-end">
                            <div class="cta--text">
                                <h6>-<%=rs_sale("sale")%>%</h6>
                                <h2>Global Sale</h2>
                                <a href="shop_sale.asp" class="btn essence-btn">Buy Now</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <%
        end if
        %>
        </div>
    </div>
    <!-- ##### CTA Area End ##### -->

    <!-- ##### New Arrivals Area Start ##### -->
    <section class="new_arrivals_area section-padding-80 clearfix">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="section-heading text-center">
                        <h2>Popular Products</h2>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="popular-products-slides owl-carousel">
                        <%
                        Set Connn = Server.CreateObject("ADODB.Connection")
                        Connn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

                        if (NOT IsEmpty(Session("ID_user"))) then
                            sql = "SELECT users.ID_user, product.name, product.ID_product, new, sale_percent, end_day, brand, price, link1, link2 FROM product inner join discount on discount.ID_product = product.ID_product inner join brand on product.ID_product = brand.ID_product inner join imageProduct on product.ID_product = imageProduct.ID_product join users on users.ID_user = "&Session("ID_user")&" GROUP BY users.ID_user, product.name, product.ID_product, new, sale_percent, end_day, brand, price, link1, link2"
                        else 
                            sql = "SELECT product.name, product.ID_product, new, sale_percent, end_day, brand, price, link1, link2 FROM product inner join discount on discount.ID_product = product.ID_product inner join brand on product.ID_product = brand.ID_product inner join imageProduct on product.ID_product = imageProduct.ID_product GROUP BY product.name, product.ID_product, new, sale_percent, end_day, brand, price, link1, link2"
                        end if

                        Set Result = Connn.execute(sql)
                        do while not Result.EOF
                        %>
                            <!-- Single Product -->
                            <div class="single-product-wrapper">
                                <!-- Product Image -->
                                <div class="product-img">
                                    <img src="../../resources/imgProduct/<%=Result("link1")%>" alt="">
                                    <!-- Hover Thumb -->
                                    <img class="hover-img" src="../../resources/imgProduct/<%=Result("link2")%>" alt="">
                                    <!-- Favourite -->
                                    <%
                                        percent = CInt(Result("sale_percent"))

                                        Dim currentDate
                                        currentDate = Date()

                                        Dim datee
                                        datee = FormatDateTime(Result("end_day"),2)

                                        if (CStr(datee) < CStr(currentDate)) then
                                            percent = 0
                                        end if
                                        if (percent > 0) then
                                        %>
                                        <div class="product-badge offer-badge">
                                            <span>-<%=percent%>%</span>
                                        </div>
                                        <% end if %>

                                        <% if (Result("new")) then%>
                                            <% if (percent > 0) then %>
                                                <div class="product-badge new-badge" style="margin-top: 3em;">
                                                    <span>New</span>
                                                </div>
                                            <% else %>
                                                <div class="product-badge new-badge">
                                                    <span>New</span>
                                                </div>
                                            <% end if %>
                                        <% end if %>

                                        <!-- Favourite -->
                                        <% if (NOT IsEmpty(Session("ID_user"))) then %>
                                        <div class="product-favourite">
                                        <%
                                            Set Conn = Server.CreateObject("ADODB.Connection")
                                            Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"
                                            Dim sql 
                                            sql = "select * from favorite where ID_user = "&Result("ID_user")&" and ID_product = "&Result("ID_product")
                                            set rs = Conn.Execute(sql)

                                            if not rs.EOF then %>
                                            <a id="favo_<%=Result("ID_product")%>" href="#" class="favorite_btn favme fa fa-heart active "></a>
                                        <%  else   %>
                                            <a id="favo_<%=Result("ID_product")%>" href="#" class="favorite_btn favme fa fa-heart "></a>
                                        <%
                                            end if
                                        %>
                                        </div>
                                        <% else %>
                                        <div class="product-favourite">
                                            <a href="#" class="favorite_btn favme fa fa-heart"></a>
                                        </div>
                                    <% end if %>
                                </div>
                                <!-- Product Description -->
                                <div class="product-description">
                                    <span><%=Result("brand")%></span>
                                    <a href="product_ex.asp?product=<%=CInt(Result("ID_product"))%>">
                                        <h6><%=Result("name")%></h6>
                                    </a>
                                    <%
                                    dim priceSale
                                    ' percent = CInt(Result("sale_percent"))
                                    if (percent > 0) then 
                                        priceSale = CInt(Result("price")) - CInt(Result("price")) * percent / 100
                                    %>

                                    <p class="product-price"><span class="old-price">$<%=Result("price")%>.00</span>$<%=Ceil(priceSale)%>.00</p>
                                    
                                    <% else %>
                                    <p class="product-price">$<%=Result("price")%>.00</p>
                                    <% end if%>

                                    <!-- Hover Content -->
                                    <div class="hover-content">
                                        <!-- Add to Cart -->
                                        <div class="add-to-cart-btn">
                                            <a href="product_ex.asp?product=<%=CInt(Result("ID_product"))%>" class="btn essence-btn">Shop now</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        
                        <%
                        Result.MoveNext
                        loop
                        %>

                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### New Arrivals Area End ##### -->

    <!-- ##### Brands Area Start ##### -->
    <div class="brands-area d-flex align-items-center justify-content-between">
        <!-- Brand Logo -->
        <div class="single-brands-logo">
            <img src="img/core-img/brand1.png" alt="">
        </div>
        <!-- Brand Logo -->
        <div class="single-brands-logo">
            <img src="img/core-img/brand2.png" alt="">
        </div>
        <!-- Brand Logo -->
        <div class="single-brands-logo">
            <img src="img/core-img/brand3.png" alt="">
        </div>
        <!-- Brand Logo -->
        <div class="single-brands-logo">
            <img src="img/core-img/brand4.png" alt="">
        </div>
        <!-- Brand Logo -->
        <div class="single-brands-logo">
            <img src="img/core-img/brand5.png" alt="">
        </div>
        <!-- Brand Logo -->
        <div class="single-brands-logo">
            <img src="img/core-img/brand6.png" alt="">
        </div>
    </div>
    <!-- ##### Brands Area End ##### -->

    <!-- ##### Footer Area Start ##### -->
    <footer class="footer_area clearfix">
        <div class="container">
            <div class="row">
                <!-- Single Widget Area -->
                <div class="col-12 col-md-6">
                    <div class="single_widget_area d-flex mb-30">
                        <!-- Logo -->
                        <div class="footer-logo mr-50">
                            <a href="#"><img src="img/core-img/logo2.png" alt=""></a>
                        </div>
                        <!-- Footer Menu -->
                        <div class="footer_menu">
                            <ul>
                                <li><a href="shop.html">Shop</a></li>
                                <li><a href="blog.html">Blog</a></li>
                                <li><a href="contact.html">Contact</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- Single Widget Area -->
                <div class="col-12 col-md-6">
                    <div class="single_widget_area mb-30">
                        <ul class="footer_widget_menu">
                            <li><a href="#">Order Status</a></li>
                            <li><a href="#">Payment Options</a></li>
                            <li><a href="#">Shipping and Delivery</a></li>
                            <li><a href="#">Guides</a></li>
                            <li><a href="#">Privacy Policy</a></li>
                            <li><a href="#">Terms of Use</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="row align-items-end">
                <!-- Single Widget Area -->
                <div class="col-12 col-md-6">
                    <div class="single_widget_area">
                        <div class="footer_heading mb-30">
                            <h6>Subscribe</h6>
                        </div>
                        <div class="subscribtion_form">
                            <form action="#" method="post">
                                <input type="email" name="mail" class="mail" placeholder="Your email here">
                                <button type="submit" class="submit"><i class="fa fa-long-arrow-right" aria-hidden="true"></i></button>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- Single Widget Area -->
                <div class="col-12 col-md-6">
                    <div class="single_widget_area">
                        <div class="footer_social_area">
                            <a href="#" data-toggle="tooltip" data-placement="top" title="Facebook"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                            <a href="#" data-toggle="tooltip" data-placement="top" title="Instagram"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                            <a href="#" data-toggle="tooltip" data-placement="top" title="Twitter"><i class="fa fa-twitter" aria-hidden="true"></i></a>
                            <a href="#" data-toggle="tooltip" data-placement="top" title="Pinterest"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
                            <a href="#" data-toggle="tooltip" data-placement="top" title="Youtube"><i class="fa fa-youtube-play" aria-hidden="true"></i></a>
                        </div>
                    </div>
                </div>
            </div>

<div class="row mt-5">
                <div class="col-md-12 text-center">
                    <p>
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
    Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | Made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>, distributed by <a href="https://themewagon.com/" target="_blank">ThemeWagon</a>
    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    </p>
                </div>
            </div>

        </div>
    </footer>
    <!-- ##### Footer Area End ##### -->

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