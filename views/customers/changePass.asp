<!-- #include file="connect.asp" -->
<%
if (isEmpty(Session("ID_user"))) then 
    Response.redirect("./user.asp")
end if
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
    <link rel="icon" href="img/core-img/favicon.ico">

    <!-- Core Style CSS -->
    <link rel="stylesheet" href="css/core-style.css">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="./css/add.css">
    

</head>
<style>
    .pass-error span, .pass-new-error span {
        font-size: 14px;
    }
    .pass-error .pass-suc, .pass-new-error .pass-suc {
        color: #00cc1f;
    }
    .pass-error .pass-err, .pass-new-error .pass-err {
        color: #ff0700;
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
                        <h2>Change Password</h2>
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
                                    <label for="first_name">Enter Password</label>
                                    <input name="password" onkeyup="checkNewPass()" type="text" class="form-control" id="first_name" value="" required>
                                </div>
                                <div class="col-12 mb-3">
                                    <label for="last_name">Enter New Password</label>
                                    <input name="new_password" onkeyup="checkNewPass()" type="text" class="form-control" id="last_name" value="" required>
                                    <div class="pass-new-error"></div>
                                </div>
                                <div class="col-12 mb-3">
                                    <label for="last_name">Enter Again New Password</label>
                                    <input name="again_new_password" onkeyup="checkPass()" type="text" class="form-control" id="last_name" value="" required>
                                    <div class="pass-error"></div>
                                </div>
                                
                            </div>

                            <button class="submit-btn" type="submit">Update</button>
                            <button class="cancel-btn" onclick="funcCancel()">Cancel</button>
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
                    // xác thực nhập lại mật khẩu
                    <%
                    Set Conn = Server.CreateObject("ADODB.Connection")
                    Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

                    sql = "select * from account where ID_account = "&Session("ID_user")

                    Set result = Conn.execute(sql)
                    dim oldPass
                    if not result.EOF then
                        response.write result("password")
                        oldPass = result("password")
                    end if
                    %>

                    var successPass = false;
                    var successNewPass = false;
                    var oldPassDatabase = false;
                    const checkPass = () => {
                        var pass = document.querySelector('input[name="new_password"]').value;
                        var againPass = document.querySelector('input[name="again_new_password"]').value;
                        var errorPassBlock = document.querySelector('.pass-error');

                        if (pass == againPass) {
                            successPass = true;
                            errorPassBlock.innerHTML = `
                                <span class='pass-suc'><i class="fa-solid fa-check"></i> Re-entered password is correct</span>
                            `
                        } else {
                            successPass = false;
                            errorPassBlock.innerHTML = `
                                <span class='pass-err'><i class="fa-solid fa-xmark"></i> Re-entered password is incorrect</span>
                            `
                        }
                    }
                    const checkNewPass = () => {
                        var pass = document.querySelector('input[name="password"]').value;
                        var newPass = document.querySelector('input[name="new_password"]').value;
                        var errorNewPassBlock = document.querySelector('.pass-new-error');

                        if (pass == <%=oldPass%>) {
                            oldPassDatabase = true;
                        } else {
                            oldPassDatabase = false;
                        }
                        if (pass != '') {
                            if (newPass != '') {
                                if (pass != newPass) {
                                    successNewPass = true;
                                    errorNewPassBlock.innerHTML = `
                                        <span class='pass-suc'><i class="fa-solid fa-check"></i> Valid Password</span>
                                    `
                                } else {
                                    successNewPass = false;
                                    errorNewPassBlock.innerHTML = `
                                        <span class='pass-err'><i class="fa-solid fa-xmark"></i> The new password cannot be the same as the old password</span>
                                    `
                                }
                            }
                        } else if (pass == '' && newPass !='') {
                            successNewPass = false;
                            errorNewPassBlock.innerHTML = `
                                    <span class='pass-err'><i class="fa-solid fa-xmark"></i> Old password field cannot be empty</span>
                                `
                        }
                    }

                    const submitBtn = document.querySelector('.submit-btn');
                    submitBtn.addEventListener('click', (e) => {
                        e.preventDefault();
                        if (successNewPass) {
                            if (successPass) {
                                if (oldPassDatabase) {
                                    var newPass = document.querySelector('input[name="new_password"]').value;

                                    var xmlhttp = new XMLHttpRequest();
                                    xmlhttp.open("GET", "/fashionShop/controllers/changePassword.asp?id=" + <%=Session("ID_user")%> + "&password="+newPass, true);
                                    // console.log(ID_product)
                                    xmlhttp.send();

                                    alert('Change password successfully!');
                                    window.location.href = "./user.asp";
                                } else {
                                    alert('Incorrect Password');
                                    document.querySelector('input[name="password"]').focus()
                                }
                            } else {
                                alert('Re-entered password is incorrect!');
                                document.querySelector('input[name="again_new_password"]').focus()
                            }
                        } else {
                            alert('The new password cannot be the same as the old password');
                            document.querySelector('input[name="new_password"]').focus()
                        }

                    })
                </script>
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