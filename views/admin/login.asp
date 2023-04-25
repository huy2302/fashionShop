<!DOCTYPE html>
<html lang="en">
<%
    Dim email, password
email = Request.Form("email")
password = Request.Form("password")
If (NOT isnull(email) AND NOT isnull(password) AND TRIM(email)<>"" AND TRIM(password)<>"" ) Then
    ' true
    Dim sql
    ' sql = "select * from account where email= ? and password= ?"
    sql = "select ID_user, name, role, email, password from account acc join users u on u.ID_account = acc.ID_account where acc.email = ? and acc.password = ? and acc.role = 0"
    Dim cmdPrep
    set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType=1
    cmdPrep.Prepared=true
    cmdPrep.CommandText = sql
    cmdPrep.Parameters(0)=email
    cmdPrep.Parameters(1)=password
    Dim result
    set result = cmdPrep.execute()
    'kiem tra ket qua result o day
    If not result.EOF Then
        ' dang nhap thanh cong
        Session("ID_user")=result("ID_user")
        Session("Success")="Login Successfully"
        Response.redirect("./index.asp")
    Else
        ' dang nhap ko thanh cong
        Session("Error") = "Wrong email or password"
    End if
    result.Close()
    connDB.Close()
Else
    ' false
    Session("Error")="Please input email and password."
End if
%>
<head>
    <!-- Title -->
    <title>Login | Graindashboard UI Kit</title>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <!-- Favicon -->
    <link rel="shortcut icon" href="public/img/favicon.ico">

    <!-- Template -->
    <link rel="stylesheet" href="public/graindashboard/css/graindashboard.css">
</head>

<body class="">

    <main class="main">

        <div class="content">

            <div class="container-fluid pb-5">

                <div class="row justify-content-md-center">
                    <div class="card-wrapper col-12 col-md-4 mt-5">
                        <div class="brand text-center mb-3">
                            <a href="/"><img src="public/img/logo.png"></a>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Login</h4>
                                <form>
                                    <div class="form-group">
                                        <label for="email">E-Mail Address</label>
                                        <input id="email" type="email" class="form-control" name="email" required="" autofocus="">
                                    </div>

                                    <div class="form-group">
                                        <label for="password">Password
                                        </label>
                                        <input id="password" type="password" class="form-control" name="password" required="">
                                        <div class="text-right">
                                            <a href="./password-reset.asp" class="small">
                                                Forgot Your Password?
                                            </a>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="form-check position-relative mb-2">
                                            <input type="checkbox" class="form-check-input d-none" id="remember" name="remember">
                                            <label class="checkbox checkbox-xxs form-check-label ml-1" for="remember" data-icon="&#xe936">Remember Me</label>
                                        </div>
                                    </div>

                                    <div class="form-group no-margin">
                                        <a href="./index.asp" class="btn btn-primary btn-block">
                                            Sign In
                                        </a>
                                    </div>
                                    <div class="text-center mt-3 small">
                                        Don't have an account? <a href="./register.asp">Sign Up</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <footer class="footer mt-3">
                            <div class="container-fluid">
                                <div class="footer-content text-center small">
                                    <span class="text-muted">&copy; 2019 Graindashboard. All Rights Reserved.</span>
                                </div>
                            </div>
                        </footer>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="public/graindashboard/js/graindashboard.js"></script>
    <script src="public/graindashboard/js/graindashboard.vendor.js"></script>
</body>

</html>