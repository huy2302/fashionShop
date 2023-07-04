<!-- #include file="connect.asp"-->

<%


Dim email, pass, confirmPass
email = Request.Form("email")
pass = Request.Form("password")
confirmPass = Request.Form("c_password")

If pass <> confirmPass  Then
   Session("Error") = "Passwords do not match"

Else 

    ' Lưu email + pass khách hàng vào bảng "Accounts"
    Dim cmd
    Set cmd = Server.CreateObject("ADODB.Command")
    connDB.open()
    cmd.ActiveConnection = connDB
    If (NOT isnull(email) AND NOT isnull(pass) AND TRIM(email)<>"" AND TRIM(pass)<>"" ) Then
      cmd.CommandText = "INSERT INTO account (ID_account, email, password, role) VALUES ((select MAX(ID_account) + 1 as id from account), '"&email&"', '"&pass&"', '1')"

      cmd.Execute

      ' Lưu ID người dùng vào bảng "Users"
      cmd.CommandText = "INSERT INTO users (ID_user, ID_account) VALUES ((select MAX(ID_account) as id from account), (select MAX(ID_account) as id from account))"

      cmd.Execute
    connDB.close()
    Response.write "<script>alert(""Successful account registration, you will be redirected to the login page."")</script>"
    Response.write "<script>window.location.href = './login.asp'</script>"

    End If
End if
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
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/login.css">
    <link rel="icon" href="./img/core-img/favicon.ico">
    <title>Essece-Register</title>
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
    
    <!--Register-->
    <div class="form">
     <div class="form-panel one">
       <div class="form-header">
         <h1>Register Account</h1>
       </div>
       <div class="form-content">
         <form action="register.asp" method="POST" onsubmit="return checkPassword()">
           <!-- email -->
            <div class="form-group">
              <label for="email">Email</label>
              <input id="email" type="email" name="email" placeholder="Your Email" required="required"/>
            </div>

           <!-- password -->
            <div class="form-group">
             <label for="pass">Password</label>
             <input id="pass" type="password" name="password" required placeholder="Create Password (Min. 8 Characters)" 
             required pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$" 
             title="Please include at least 1 uppercase character, 1 lowercase character, and 1 number."/>
            </div>
           <!-- comfirm pass -->
            <div class="form-group">
              <label for="c_pass">Confirm Password</label>
              <input id="c_pass" type="password" name="c_password" required placeholder="Confirm Password" />

            </div>
            
            <div class="form-group">
              <button type="submit"  >Register</button>
            </div>
          </form>
      
        </div>
            <div class="form-group">
            <a href="login.asp" class="form-recovery">Did you have an Account?</a>
            </div>

       </div>
     </div>
    
</body>
</html>
