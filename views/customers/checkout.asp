<!-- #include file="connect.asp" -->
<%
connDB.Open()
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

    <!-- ##### Breadcumb Area Start ##### -->
    <div class="breadcumb_area bg-img" style="background-image: url(img/bg-img/breadcumb.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="page-title text-center">
                        <h2>Checkout</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ##### Checkout Area Start ##### -->
    <div class="checkout_area section-padding-80">
        <div class="container">
            <form>
                <div class="row">

                <div class="col-12 col-md-6">
                    <div class="checkout_details_area mt-50 clearfix">

                        <div class="cart-page-heading mb-30">
                            <h5>Billing Address</h5>
                        </div>

                        <form action="#" method="post">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="first_name">First Name <span>*</span></label>
                                    <input type="text" class="form-control" id="first_name" value="" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="last_name">Last Name <span>*</span></label>
                                    <input type="text" class="form-control" id="last_name" value="" required>
                                </div>
                                <div class="col-12 mb-3">
                                    <label for="company">City <span>*</span></label>
                                    <input type="text" class="form-control" id="company" value="" required>
                                </div>
                                
                                <div class="col-12 mb-3">
                                    <label for="company">Province <span>*</span></label>
                                    <input type="text" class="form-control" id="company" value="" required>
                                </div>
                                
                                <div class="col-12 mb-3">
                                    <label for="company">District <span>*</span></label>
                                    <input type="text" class="form-control" id="company" value="" required>
                                </div>
                                
                                <div class="col-12 mb-3">
                                    <label for="company">Address details <span>*</span></label>
                                    <input type="text" class="form-control" id="company" value="" required>
                                </div>
                                
                                <div class="col-12 mb-3">
                                    <label for="phone_number">Phone No <span>*</span></label>
                                    <input type="number" class="form-control" id="phone_number" min="0" value="" required>
                                </div>
                                <div class="col-12 mb-4">
                                    <label for="email_address">Email Address <span>*</span></label>
                                    <input type="email" class="form-control" id="email_address" value="" required>
                                </div>

                                <div class="col-12">
                                    <div class="custom-control custom-checkbox d-block mb-2">
                                        <input type="checkbox" class="custom-control-input" id="customCheck1" required>
                                        <label class="custom-control-label" for="customCheck1">Terms and conitions <span>*</span></label>
                                    </div>
                                    <div class="custom-control custom-checkbox d-block mb-2">
                                        <input type="checkbox" class="custom-control-input" id="customCheck2">
                                        <label class="custom-control-label" for="customCheck2">Create an account</label>
                                    </div>
                                    <div class="custom-control custom-checkbox d-block">
                                        <input type="checkbox" class="custom-control-input" id="customCheck3">
                                        <label class="custom-control-label" for="customCheck3">Subscribe to our newsletter</label>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="col-12 col-md-6">
                    <div class="order-details-confirmation">

                        <div class="cart-page-heading">
                            <h5>Your Order</h5>
                            <p>The Details</p>
                        </div>

                        <ul class="order-details-form mb-4">
                            <li><span>Product</span> <div style="display: flex; width: 12em; justify-content: space-between;"><span>Quantity</span> <span>Total</span></div></li>
                        <%
                        Set cmdPrep = Server.CreateObject("ADODB.Command")
                        cmdPrep.ActiveConnection = connDB
                        cmdPrep.CommandType = 1
                        cmdPrep.Prepared = True

                        cmdPrep.CommandText = "select cart.*, product.name, discount.sale_percent, discount.end_day from cart inner join product on product.ID_product = cart.ID_product inner join discount on discount.ID_product = cart.ID_product where cart.ID_user = "&Session("ID_user")
                        Set Result = cmdPrep.execute
                        Dim total
                        total_sale = 0
                        total = 0
                        do while not Result.EOF
                            ' lấy ra giá, số lượng, phần trăm sale
                            price = CInt(Result("price"))
                            quantity = CInt(Result("quantity"))
                            percent = CInt(Result("sale_percent"))

                            ' tạo biến currentDate lấy ra ngày hiện tại
                            ' so sánh với ngày hết hạn sale để tính giá tiền
                            Dim currentDate
                            currentDate = Date()

                            Dim datee
                            datee = FormatDateTime(Result("end_day"),2)

                            if (CStr(datee) < CStr(currentDate)) then
                                percent = 0
                            end if

                            ' tính giá tổng đơn hàng
                            subtotal_sale = (price * (100 - percent))/100 * quantity
                            subtotal = price * quantity
                            total = total + subtotal
                            total_sale = total_sale + subtotal_sale
                        %>
                            <li><span><%=Result("name")%></span> <div style="display: flex; width: 10em; justify-content: space-between;"><span><%=Result("quantity")%></span> <span>$<%=subtotal%>.00</span></div></li>
                        <%
                        Result.MoveNext
                        loop
                        %>
                            <!--<li><span>Subtotal</span> <span>$59.90</span></li>-->
                            <li><span>Shipping</span> <span>Free</span></li>
                            <li><span>Subtotal</span> <span>$<%=total%>.00</span></li>
                            <li><span>Sale off</span> <span>$<%=total - total_sale%>.00</span></li>
                            <li><span>Total</span> <span>$<%=total_sale%>.00</span></li>
                        </ul>

                        <div id="accordion" role="tablist" class="mb-4">
                            <div class="card">
                                <div class="card-header" role="tab" id="headingOne">
                                    <h6 class="mb-0">
                                        <a data-toggle="collapse" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne"><i class="fa fa-circle-o mr-3"></i>Paypal</a>
                                    </h6>
                                </div>

                                <div id="collapseOne" class="collapse" role="tabpanel" aria-labelledby="headingOne" data-parent="#accordion">
                                    <div class="card-body">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pharetra tempor so dales. Phasellus sagittis auctor gravida. Integ er bibendum sodales arcu id te mpus. Ut consectetur lacus.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header" role="tab" id="headingTwo">
                                    <h6 class="mb-0">
                                        <a class="collapsed" data-toggle="collapse" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"><i class="fa fa-circle-o mr-3"></i>cash on delievery</a>
                                    </h6>
                                </div>
                                <div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo" data-parent="#accordion">
                                    <div class="card-body">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo quis in veritatis officia inventore, tempore provident dignissimos.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header" role="tab" id="headingThree">
                                    <h6 class="mb-0">
                                        <a class="collapsed" data-toggle="collapse" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree"><i class="fa fa-circle-o mr-3"></i>credit card</a>
                                    </h6>
                                </div>
                                <div id="collapseThree" class="collapse" role="tabpanel" aria-labelledby="headingThree" data-parent="#accordion">
                                    <div class="card-body">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Esse quo sint repudiandae suscipit ab soluta delectus voluptate, vero vitae</p>
                                    </div>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header" role="tab" id="headingFour">
                                    <h6 class="mb-0">
                                        <a class="collapsed" data-toggle="collapse" href="#collapseFour" aria-expanded="true" aria-controls="collapseFour"><i class="fa fa-circle-o mr-3"></i>direct bank transfer</a>
                                    </h6>
                                </div>
                                <div id="collapseFour" class="collapse show" role="tabpanel" aria-labelledby="headingThree" data-parent="#accordion">
                                    <div class="card-body">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est cum autem eveniet saepe fugit, impedit magni.</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn essence-btn">Place Order</button>
                    </div>
                </div>
            </div>
            </form>
        </div>
    </div>
    <!-- ##### Checkout Area End ##### -->
    <!-- ##### Breadcumb Area End ##### -->

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
    <script>
        const postSalePercent = (id, start, end, sale) => {
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.open("GET", "/fashionShop/controllers/admin/addSalePercent.asp?id_product=" + id + "&start=" + start + "&end=" + end + "&sale=" + sale, true);
            // console.log(ID_product)
            xmlhttp.send();
        }

        postSalePercent();
    </script>

</body> 

</html>