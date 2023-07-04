<!-- #include file="connect.asp"-->
<%
Session("dummy") = ""
Dim email, password
email = Request.Form("email")
password = Request.Form("password")
If (NOT isnull(email) AND NOT isnull(password) AND TRIM(email)<>"" AND TRIM(password)<>"" ) Then
    ' true
    Dim sql
    ' sql = "select * from account where email= ? and password= ?"
    sql = "select ID_user, role, email, password from account acc join users u on u.ID_account = acc.ID_account where acc.email = ? and acc.password = ? and acc.role = 1"
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
End if

'Lay ve thong tin dang nhap gom email va password

'Validate thong tin dang nhap

'Kiem tra thong tin xem co ton tai trong bang taikhoan hay khong

'Neu ton tai thi dang nhap thanh cong, tao Session, redirect toi trang quan tri

'Neu dang nhap ko thanh cong, thi thong bao loi.
%>
<div class="ERROR-fail">
    <%  
        If (NOT IsEmpty(Session("Error")) AND NOT isnull(Session("Error"))) AND (TRIM(Session("Error"))<>"") Then
    %>
            <div class="notify-error alert alert-danger mt-2" role="alert">
                <%=Session("Error")%>
            </div>
    <%
            Session.Contents.Remove("Error")
        End If
    %>   
</div>
    
<!DOCTYPE html>
<html lang="en">  

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>Essence - Login</title>

    <!-- Favicon  -->
    <link rel="shortcut icon" href="./img/core-img/favicon.ico">
    <link rel="stylesheet" href="./css/add.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <link rel="stylesheet" href="css/login.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        window.setTimeout(function() {
            $(".alert").fadeTo(500, 0).slideUp(500, function(){
                $(this).remove(); 
            });
        }, 1000);
    </script>
</head>


<body>
    
    <div class="form">
        <div class="form-panel one">
            <div class="form-header">
                <h1>Account Login</h1>
            </div>
            <div class="form-content">
                <form method="post" action="login.asp"> 
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input id="username" type="text" name="email" required="required"/>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input id="password" type="password" name="password" required="required"/>
                    </div>
                    <div class="form-group">
                        <label class="form-remember">
                            <input type="checkbox"/>Remember Me
            
                        </label>
                        <a href="register.asp" class="form-recovery">Create Account</a>
                        <a class="form-recovery" href="#">Forgot Password?</a>
                    </div>
                    <div class="form-group">
                        <button type="submit">Log In</button>
                    </div>
                </form>
            </div>
        </div>
    </div>  
        
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>         
    
    </html>

    
    