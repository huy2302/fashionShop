var searchBtn = document.getElementById("headerSearch");
var ID_product = document.getElementById("ID_product").value;

searchBtn.onchange((searchBtn) => {
    showHint()
})
favoriteBtn.addEventListener('click', function() {
    var xmlhttp = new XMLHttpRequest();
    if (favoriteBtn.classList.contains("active")) {
        const favorite = 0
        xmlhttp.open("GET", "updateFavorite.asp?q=" + favorite +"&id="+ID_product, true);
        console.log(ID_product)
        xmlhttp.send();
    } else {
        const favorite = 1
        xmlhttp.open("GET", "updateFavorite.asp?q=" + favorite +"&id="+ID_product, true);
        console.log(ID_product)
        xmlhttp.send();
    }
})
function showHint(str) {
    if (str.length == 0) { 
      document.getElementById("txtHint").innerHTML = "";
      return;
    }
    const xhttp = new XMLHttpRequest();
    xhttp.onload = function() {
      document.getElementById("productColor").innerHTML = `
        <h4>${this.responseText}</h4>
      `
    }
    xhttp.open("GET", "gethint.asp?q="+str);
    xhttp.send();
  }