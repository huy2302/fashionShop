<!-- #include file="connect.asp" -->

<%
' ham lam tron so nguyen
function Ceil(Number)
    Ceil = Int(Number)
    if Ceil<>Number Then
        Ceil = Ceil + 1
    end if
end function

connDB.Open()
Dim ID_product
Set ID_product = Request.QueryString("product")
Set cmdPrep = Server.CreateObject("ADODB.Command")
cmdPrep.ActiveConnection = connDB
cmdPrep.CommandType = 1
cmdPrep.Prepared = True
if (NOT IsEmpty(Session("ID_user"))) then
    cmdPrep.CommandText = "select users.ID_user, product.ID_product, product.name, description, brand, sale_percent, size, color, price, imageProduct.* from product_size_color psc join product on product.ID_product = psc.ID_product inner join discount on product.ID_product = discount.ID_product join size on size.ID_size = psc.ID_size join color on color.ID_color = psc.ID_color join imageProduct on imageProduct.ID_product = psc.ID_product inner join brand on product.ID_product = brand.ID_product join users on users.ID_user = "&Session("ID_user")&" where psc.ID_product = "&ID_product
    else 
    cmdPrep.CommandText = "select product.ID_product, product.name, description, brand, sale_percent, size, color, price, imageProduct.* from product_size_color psc join product on product.ID_product = psc.ID_product inner join discount on product.ID_product = discount.ID_product join size on size.ID_size = psc.ID_size join color on color.ID_color = psc.ID_color join imageProduct on imageProduct.ID_product = psc.ID_product inner join brand on product.ID_product = brand.ID_product where psc.ID_product = "&ID_product
end if

Set Result = cmdPrep.execute

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

    <link rel="icon" href="img/core-img/favicon.ico">
    <link rel="stylesheet" href="./css/add.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- Core Style CSS -->
    <link rel="stylesheet" href="css/core-style.css">
    <link rel="stylesheet" href="style.css">
    <style>
        .nice-select {
            display: none !important;
        }
        select {
            display: block !important;
        }
        #quantity_color {
            margin: 0;
            
            margin-top: -1em;
            padding: 10px 50px;
            font-weight: 500;
            font-size: 1.1em;
            margin-bottom: 1em;
            display: inline-table;
            border-bottom: 2px solid;
            border-top: 2px solid;
            /* border: 2px solid; */
        }
        .inStock {
            color: #5BA21D;
        }
        .outOfStock {
            color: #CF2425;
        }
        .owl-carousel .owl-item img {
            object-fit: cover;
            display: block;
            width: 100%;
            height: 74em;
            -webkit-transform-style: preserve-3d;
        }
    </style>
</head>

<body>
    <!-- ##### Header Area Start ##### -->

    <!-- #include file="header.asp" -->

    <!-- ##### Header Area End ##### -->
    <input id="ID_user" type="hidden" name="" value="<%=Session("ID_user")%>">
    <input id="ID_product" type="text" value="<%=ID_product%>" style="display: none;">

    <!-- #include file="cart.asp" -->
    
    <!-- ##### Single Product Details Area Start ##### -->
    <section class="single_product_details_area d-flex align-items-center">

        <!-- Single Product Thumb -->
        <div class="single_product_thumb clearfix">
            <div class="product_thumbnail_slides owl-carousel">
                <img src="/fashionShop/resources/imgProduct/<%=Result("link1")%>" alt="">
                <img src="/fashionShop/resources/imgProduct/<%=Result("link2")%>" alt="">
                <img src="/fashionShop/resources/imgProduct/<%=Result("link3")%>" alt="">
                <img src="/fashionShop/resources/imgProduct/<%=Result("link4")%>" alt="">
            </div>
        </div>

        <!-- Single Product Description -->
        <div class="single_product_desc clearfix">
            <span><%=Result("brand")%></span>
            <a href="cart.html">
                <h2><%=Result("name")%></h2>
            </a>
            <%
            dim priceSale
            if (CInt(Result("sale_percent")) > 0) then 
                priceSale = CInt(Result("price")) - CInt(Result("price")) * CInt(Result("sale_percent")) / 100
            %>

            <p class="product-price"><span class="old-price">$<%=Result("price")%>.00</span> $<%=Ceil(priceSale)%>.00</p>
            <% else %>
            <p class="product-price">$<%=Result("price")%>.00</p>
            <% end if%>
            <p class="product-desc"><%=Result("description")%></p>

            <!-- Form -->
            <form class="cart-form clearfix" method="">
                <!-- Select Box -->
                <div class="select-box d-flex mt-50 mb-30">
                    <select id="size" name="size" class="selectColor mr-5" onchange="getColors()">
                    <%
                        sql = "select product.ID_product, size, size.ID_size from product_size_color p inner join product on product.ID_product = p.ID_product inner join size on size.ID_size = p.ID_size where product.ID_product = "&ID_product&" group by product.ID_product, size, size.ID_size"
                        Set RS_Size = connDB.Execute(sql)
                        do while not RS_Size.EOF
                    %>
                        <!--<option value="<%=RS_Size("ID_size")%>">Size: <%=RS_Size("size")%></option>-->
                        <option value="<%=RS_Size("ID_size")%>">Size: <%=RS_Size("size")%></option>
                    <%
                        RS_Size.MoveNext
                        loop
                    %>
                    </select>
                    <select id="color" name="color" class="selectColor" onchange="showQuantity()">

                    </select>
                </div>
                <p id="quantity_color">con hang</p>
                <!-- Cart & Favourite Box -->
                <div class="cart-fav-box d-flex align-items-center">
                    <!-- Cart -->
                    <button id="add_btn" type="submit" name="addtocart" value="5" class="btn essence-btn">Add to cart</button>

                    <!-- Favourite -->
                    <% if (NOT IsEmpty(Session("ID_user"))) then %>
                    <div class="product-favourite ml-4">
                    <%
                        Set Conn = Server.CreateObject("ADODB.Connection")
                        Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"
                        
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
                    <div class="product-favourite ml-4">
                        <a id="favorite_btn" href="#" class="favorite_btn favme fa fa-heart"></a>
                    </div>
                    <% end if %>

                </div>
            </form>
        </div>
    </section>
    <!-- ##### Single Product Details Area End ##### -->

    <!-- #include file="footer.asp" -->

    <!-- jQuery (Necessary for All JavaScript Plugins) -->
    <script src="js/jquery/jquery-2.2.4.min.js"></script>

    <!-- call AJAX to get the color and quantity corresponding to the size -->
    <script>
        var ListColor = []
        var getColors = function (){
            var size = document.getElementById("size").value;
            var ID_product = document.getElementById("ID_product").value;
            $.ajax({
                url: `/fashionShop/controllers/getProductDetails/getcolor.asp?id=${ID_product}&size=${size}`,
                // data: data,
                dataType: 'json',
                success: function (response) {
                    // console.log(response)
                    ListColor = response
                    document.getElementById('color').innerHTML = "";
                    response.forEach(element => {
                        if (element.id == "-1") {
                            return;
                        }
                        // console.log(element.id)
                        document.getElementById('color').innerHTML += `
                        <option value='${element.id_color}'>${element.color}</option>
                        `;
                    });
                    if (response[0].quantity == "0") {
                        document.getElementById('quantity_color').innerText = "Out of stock";
                        document.getElementById('quantity_color').classList.add('outOfStock')
                    } else {
                        document.getElementById('quantity_color').innerText = `In stock: ${response[0].quantity}`;
                        document.getElementById('quantity_color').classList.add('inStock')
                    }
                },
                error: function (response){
                    alert('Lỗi AJAX');
                }
            });
        }
        var ID_product = document.getElementById("ID_product").value;
        var showQuantity = () => {
            var color = document.getElementById("color").value;

            if (ListColor[color - 1].quantity == "0") {
                document.getElementById('quantity_color').innerText = "Out of stock";
                document.getElementById('quantity_color').classList.remove('inStock')
                document.getElementById('quantity_color').classList.add('outOfStock')
            } else {
                document.getElementById('quantity_color').innerText = `In stock: ${ListColor[color - 1].quantity}`;
                document.getElementById('quantity_color').classList.remove('outOfStock')
                document.getElementById('quantity_color').classList.add('inStock')
            }
            // console.log(color)
            // console.log(ListColor[color - 1])
        }
        // auto load size đầu tiên
        window.addEventListener('load', getColors);
        // update favorite
        var favoriteBtn = document.querySelector(".favorite_btn");
        favoriteBtn.addEventListener('click', function() {
            // alert("hehe")
            var stringID = favoriteBtn.id    
            var id = stringID.charAt(stringID.length - 1)
            console.log(id)
            var xmlhttp = new XMLHttpRequest();
            if (favoriteBtn.classList.contains("active")) {
                const favorite = 0
                xmlhttp.open("GET", "/fashionShop/controllers/updateFavorite.asp?q=" + favorite +"&id="+id, true);
                console.log(id)
                xmlhttp.send();
            } else {
                const favorite = 1
                xmlhttp.open("GET", "/fashionShop/controllers/updateFavorite.asp?q=" + favorite +"&id="+id, true);
                console.log(ID_product)
                xmlhttp.send();
            }
        })

        // add to cart
        var addCartBtn = document.querySelector("#add_btn");
        var sizeProduct = document.querySelector("#size");
        var colorProduct = document.querySelector("#color");
        var user = document.getElementById('ID_user')
        // var quantity_number = 0;
        const addToCart = function(e) {
            e.preventDefault();
            if (user.value != '') {
                if (document.getElementById('quantity_color').classList.contains('inStock')) {
                    console.log("addCart.asp?id=" + ID_product +"&size="+sizeProduct.value+"&color="+colorProduct.value)
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.open("GET", "/fashionShop/controllers/addCart.asp?id=" + ID_product +"&size="+sizeProduct.value+"&color="+colorProduct.value, true);
                    // console.log(ID_product)
                    xmlhttp.send();
        
                    setTimeout(() => {
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
                    }, 300);
                } else {
                    alert("This product is out of stock, please choose another product.");
                }
            } else {
                let text = "Please login to continue shopping.";
                if (confirm(text) == true) {
                    window.location.href="./login.asp"
                }
            }
        }
        addCartBtn.addEventListener("click", addToCart)

    </script>
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