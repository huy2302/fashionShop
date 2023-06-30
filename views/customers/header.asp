<!-- ##### Header Area Start ##### -->
<link rel="stylesheet" href="./css/search.css">
<% 
Set Conn=Server.CreateObject("ADODB.Connection") 
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"
%>
    <header class="header_area">
        <div class="classy-nav-container breakpoint-off d-flex align-items-center justify-content-between">
            <!-- Classy Menu -->
            <nav class="classy-navbar" id="essenceNav">
                <!-- Logo -->
                <a class="nav-brand" href="./index.asp"><img src="./img/core-img/logo.png" alt=""></a>
                <!-- Navbar Toggler -->
                <div class="classy-navbar-toggler">
                    <span class="navbarToggler"><span></span><span></span><span></span></span>
                </div>
                <!-- Menu -->
                <div class="classy-menu">
                    <!-- close btn -->
                    <div class="classycloseIcon">
                        <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                    </div>
                    <!-- Nav Start -->
                    <div class="classynav">
                        <ul>
                            <li><a href="./shop.asp">Shop</a>
                                <div class="megamenu">
                                    <ul class="single-mega cn-col-4">
                                        <li class="title">Wommen's Collection</li>
                                        <li><a href="shop.asp?species=Dresses&shop=Wommen">Dresses</a></li>
                                        <li><a href="shop.asp?species=Jeans&shop=Wommen">Jeans</a></li>
                                        <li><a href="shop.asp?species=Hoodies&shop=Wommen">Hoodies & Sweats</a></li>
                                        <li><a href="shop.asp?species=Leggings&shop=Wommen">Pants & Leggings</a></li>
                                        <li><a href="shop.asp?species=Bras&shop=Wommen">Bras & Panties</a></li>
                                    </ul>
                                    <ul class="single-mega cn-col-4">
                                        <li class="title">Men's Collection</li>
                                        <li><a href="shop.asp?species=Shirts&shop=Men">T-Shirts</a></li>
                                        <li><a href="shop.asp?species=Polo&shop=Men">Polo</a></li>
                                        <li><a href="shop.asp?species=Shirts&shop=Men">Shirts</a></li>
                                        <li><a href="shop.asp?species=Jackets&shop=Men">Jackets & Coats</a></li>
                                        <li><a href="shop.asp?species=Trench&shop=Men">Trench</a></li>
                                    </ul>
                                    <ul class="single-mega cn-col-4">
                                        <li class="title">Shoe's Collection</li>
                                        <li><a href="shop.asp?species=Dresses">Dresses</a></li>
                                        <li><a href="shop.asp?species=Dresses">Shirts</a></li>
                                        <li><a href="shop.asp?species=Dresses">T-shirts</a></li>
                                        <li><a href="shop.asp?species=Dresses">Jackets</a></li>
                                        <li><a href="shop.asp?species=Dresses">Trench</a></li>
                                    </ul>
                                    <div class="single-mega cn-col-4">
                                        <img src="img/bg-img/bg-6.jpg" alt="">
                                    </div>
                                </div>
                            </li>
                            <li><a href="shop_sale.asp">Sale off</a></li>
                            <li><a href="shop_new.asp">New Collection</a></li>
                        </ul>
                    </div>
                    <!-- Nav End -->
                </div>
            </nav>

            <!-- Header Meta Data -->
            <div class="header-meta d-flex clearfix justify-content-end">
                <!-- Search Area -->
                <div class="search-area">
                    <form action="#" method="post">
                        <input type="search" name="search" id="headerSearch" placeholder="Type for search">
                        <button type="submit"><i class="fa fa-search" aria-hidden="true"></i></button>
                    </form>
                </div>
                <!-- Favourite Area -->
                <div class="favourite-area">
                    <a href="#"><img src="img/core-img/heart.svg" alt=""></a>
                </div>
                <!-- User Login Info -->
                <div class="user-login-info">
                    <a href="user.asp"><img src="img/core-img/user.svg" alt=""></a>
                </div>
                <!-- Cart Area -->
                <div class="cart-area">
                    <% if NOT IsEmpty(Session("ID_user")) then 
                    Set RScart=Server.CreateObject("ADODB.Recordset") 
                    sql="select COUNT(cart.ID_cart) as id from cart join users on users.ID_user = cart.ID_user where cart.ID_user = " &Session("ID_user") 
                    RScart.Open sql, conn 
                    %>
                    <a href="#" id="essenceCartBtn"><img src="img/core-img/bag.svg" alt=""> <span id="span-quantity"><%=RScart("id")%></span></a>
                    <% else %>
                        <a href="#" id="essenceCartBtn"><img src="img/core-img/bag.svg" alt=""> <span id="span-quantity">0</span></a>
                    <% end if %>

                </div>
            </div>
        </div>
    </header>

    <div id="search_content" class="search_content" data-pre="VisualSearch">
        <ul id="list_search_id" class="list_search" data-var="VisualSearchResults" data-pre="VisualSearchResults">
            
        </ul>
    </div>
    <div id="blur_document" class="blur_document">

    </div>
    <script src="./js/search.js"></script>