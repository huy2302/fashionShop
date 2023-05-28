
<!--#include file="connect.asp"-->
<%
Dim email, pass
email = Request.Form("email")
pass = Request.Form("pass")

Dim sql
sql = "INSERT INTO account (email, password) VALUES('" & email & "', '" & password & "')"
connDB.Open()
connDB.Execute sql
sql.Close()
connDB.Close()
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/login.css">
    <link rel="icon" href="./img/core-img/favicon.ico">
    <script src="js/checkpass.js"></script>
    <title>Essece-Register</title>

</head>
<body>
    
    <!--Register-->
    <div class="form">
     <div class="form-panel one">
       <div class="form-header">
         <h1>Register Account</h1>
       </div>
       <div class="form-content">
         <form id="form" action="" method="get">
           <!-- email -->
           <div class="form-group">
             <label for="email">Email</label>
             <input id="email" type="email" name="email" placeholder="Your Email" required="required"/>
           </div>

           <!-- password -->
           <div class="form-group">
             <label for="pass">Password</label>
             <input id="pass" type="password" name="pass" required placeholder="Create Password (Min. 8 Characters)" 
             required pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$" 
             title="Please include at least 1 uppercase character, 1 lowercase character, and 1 number."/>
           </div>
           <!-- comfirm pass -->
           <div class="form-group">
             <label for="c_pass">Confirm Password</label>
             <input id="c_pass" type="password" name="c_pass" onchange="confirmPass()" required placeholder="Confirm Password" />
           </div>
           <!-- <span id="error" style="color:#F00;"> </span> -->
           
           <div class="form-group">
             <button type="submit" onclick="confirmPass()">Register</button>
            </div>
          </form>
            <div class="form-group">
            <a href="login.asp" class="form-recovery">Did you have an Account?</a>
            </div>

       </div>
     </div>
    </div>
</body>
</html>