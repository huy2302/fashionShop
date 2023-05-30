<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div class="container">
        <div id="content">

        </div>
        
        <div id="messenger">

        </div>

        <button id="submit" onclick="LoadData()">submit</button>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    <%
    ID_productDetail = 2
    %>
    <script>
        function LoadData(){
            // var data = {ID_productDetail: <%=ID_productDetail%>};
            // console.log(data);
            $.ajax({
                url: 'addCart.asp?id=<%=ID_productDetail%>',
                // data: data,
                dataType: 'json',
                success: function (response) {
                    console.log(response.length)
                    // var jsonArray = JSON.parse(response);
                    response.forEach(function(item) {

                        // Xử lý thông tin từng phần tử trong mảng
                        console.log("id: " + item.id + ", name: " + item.name);
                        console.log("size: " + item.size + ", brand: " + item.brand);
                        console.log("price: " + item.price + ", quantity: " + item.quantity);
                    });
                    for (var i = 0; i < response.length; i++) {
                        
                    }
                    // $('#content').html(response.id)
                    // $('#messenger').html(response.value)
                },
                error: function (response){
                    alert('Lỗi AJAX');
                }
            });
        }

        function CloseConfirm(){
            document.getElementById('confirm-delete').style.display = "none";

        }
    </script>
</body>
</html>