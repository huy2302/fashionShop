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

                <div class="col-12 col-md-6 d-flex action_container">
                    <% if (isEmpty(Session("ID_user"))) then%>
                        <a class="action" href="login.asp">Login account.</a>
                    <% else %>
                        <a class="action" href="profile.asp">Edit profile.</a>
                        <a class="action" href="changePass.asp">Change Password.</a>
                        <a class="action" href="purchase.asp">Purchase History.</a>
                        <a class="action logout">Sign out.</a>
                    <% end if %>
                </div>

            </div>
        </div>
    </div>
    <!-- ##### Checkout Area End ##### -->
    <script>
        var logoutBtn = document.querySelector('.logout');
        function myFunction() {
            let text = "You want to sign out?";
            if (confirm(text) == true) {
                window.location.href = './logout.asp';
            } else {
                alert("You canceled!");
            }
        }
        logoutBtn.addEventListener('click', myFunction)
    </script>
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