function confirmPass() {
    var pass = document.getElementById("pass").value
    var confPass = document.getElementById("c_pass").value
    if(pass != confPass) {
        document.getElementById("c_pass").style.borderColor = "thick solid red";
        alert("right")
    }
    else
    {
        
        document.getElementById('error').innerHTML='';
    }
}
