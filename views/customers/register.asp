
<!--#include file="connect.asp"-->


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
         <form>
           <!-- name -->
           <div class="form-group">
             <label for="name">Name</label>
             <input id="name" type="text" name="name" placeholder="Your Full Name" required="required" required minlength="3" required maxlength="100"/>
           </div>
           <!-- email -->
           <div class="form-group">
             <label for="email">Email</label>
             <input id="email" type="email" name="email" placeholder="Your Email" required="required"/>
           </div>
           <!-- password -->
           <div class="form-group">
             <label for="password1">Password</label>
             <input id="password1" type="password" required="required" placeholder="Create Password (Min. 8 Characters)" 
             required pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$" 
             title="Please include at least 1 uppercase character, 1 lowercase character, and 1 number."/>
           </div>
           <!-- comfirm pass -->
           <div class="form-group">
             <label for="password2">Confirm Password</label>
             <input id="password2" type="password" name="password" required="required" placeholder="Confirm Password"
             required pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$" />
           </div>

           <div class="form-group">
             <button type="submit">Register</button>
            </div>
            <div class="form-group">
            <a href="login.asp" class="form-recovery">Did you have an Account?</a>
            </div>
         </form>
       </div>
     </div>
    </div>
</body>
</html>