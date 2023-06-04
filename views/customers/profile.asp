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

    <!-- Core Style CSS -->
    <link rel="stylesheet" href="css/core-style.css">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="./css/add.css">
    

</head>

<body>
    <!-- ##### Header Area Start ##### -->
   
    <!-- #include file="header.asp" -->

    <!-- ##### Header Area End ##### -->

    <!-- ##### Right Side Cart Area ##### -->
    <div class="cart-bg-overlay"></div>

    <!-- #include file="cart.asp" -->
    
    <!-- ##### Right Side Cart End ##### -->
    <!-- ##### Breadcumb Area Start ##### -->
    <div class="breadcumb_area bg-img" style="background-image: url(img/bg-img/breadcumb.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="page-title text-center">
                        <h2>Profile</h2>
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

                <div class="col-12 col-md-6">
                    <div class="checkout_details_area mt-50 clearfix">

                        <div class="cart-page-heading mb-30">
                            <h5>Manage profile information for account security</h5>
                        </div>

                        <form action="#" method="post">
                            <div class="row">
                                <div class="col-12 mb-3">
                                    <label for="first_name">User Name</label>
                                    <input type="text" class="form-control" id="first_name" value="" required>
                                </div>
                                <div class="col-12 mb-3">
                                    <label for="last_name">Full Name</label>
                                    <input type="text" class="form-control" id="last_name" value="" required>
                                </div>
                                <div class="col-12 mb-3">
                                    <label for="country">Gender</label>
                                    <select class="w-100" id="country">
                                        <option value="usa">Male</option>
                                        <option value="uk">Female</option>
                                        <option value="ger">Orther...</option>
                                    </select>
                                </div>
                                <div class="col-12 mb-3">
                                    <label for="postcode">Birthdays</label>
                                    <input type="date" class="form-control" id="postcode" value="">
                                </div>
                                <div class="col-12 mb-3">
                                    <label for="company">Email ADDRESS</label>
                                    <input type="email" class="form-control" id="company" value="">
                                </div>
                                <div class="col-12 mb-3">
                                    <label for="company">Phone No</label>
                                    <input type="number" class="form-control" id="company" value="">
                                </div>
                                
                            </div>

                            <button class="submit-btn" type="submit">Update</button>
                            <button class="submit-btn" onclick="funcCancel()">Cancel</button>
                        </form>
                    </div>
                </div>
                <script>
                    function funcCancel() {
                        let text = "You want to go back to the previous page?";
                        if (confirm(text) == true) {
                            window.location.href = './user.asp';
                        } else {
                            
                        }
                    }
                </script>
                <div class="col-12 col-md-6 col-lg-5 ml-lg-auto">
                    <div class="order-details-confirmation">

                        <div class="cart-page-heading">
                            <img src="./img/325238682_554022089814546_3800225607054645913_n.jpg" alt="">
                        </div>


                        <div id="accordion" role="tablist" class="mb-4">
                            
                            <div class="card">
                                <div id="collapseFour" class="collapse show" role="tabpanel" aria-labelledby="headingThree" data-parent="#accordion">
                                    <div class="card-body">
                                        <p>Maximum file size 1 MB<br>Format: .JPEG, .PNG</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <a href="#" class="btn essence-btn">Select Avatar</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
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