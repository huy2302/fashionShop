<!-- #include file="connect.asp" -->
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

%>
<%
if IsEmpty(Session("ID_user")) then
    response.write "<script>alert('Please login to continue')</script>"
    response.write "<script>window.location.href = 'user.asp'</script>"
end if

ID_bill = request.QueryString("ID_bill")

if NOT IsEmpty(ID_bill) then 'nếu tồn tại Session ID_bill
    sql = "select bill.*, CONCAT(firstName, ' ', lastName) as name, city, province, district, address, CONCAT(city, '-', province, '-', district, '-', address) as addressDetails from bill join address on address.ID_bill = bill.ID_bill where bill.ID_bill = "&ID_bill
    Set Result_bill = Conn.execute(sql)

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
    <link rel="icon" href="./img/core-img/favicon.ico">
    <link rel="stylesheet" href="./css/add.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- Core Style CSS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.3/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.3.2/html2canvas.min.js"></script>

    <link rel="stylesheet" href="css/core-style.css">
    <link rel="stylesheet" href="style.css">

</head>
<style>
    .cart-page-heading {
        /* flex-direction: row-reverse; */
        font-size: 1em;
        padding-bottom: 3em;
        justify-content: space-between;
    }
    .cart-page-heading h6{
        font-weight: 400;
    }
    .h5-we {
        width: 26%;
        text-align: center;
        text-transform: uppercase;
        font-weight: 400;
        font-size: 1.2em;
        margin: 0 auto;
    }
</style>
<body>
    <!-- ##### Header Area Start ##### -->
    <!-- #include file="header.asp" -->
    
    <!-- ##### Header Area End ##### -->

    <!-- #include file="cart.asp" -->

    <!-- ##### Breadcumb Area Start ##### -->
    <div class="breadcumb_area bg-img" style="background-image: url(img/bg-img/breadcumb.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="page-title text-center">
                        <h2>Invoice & Packing List</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ##### Checkout Area Start ##### -->
    <div class="checkout_area section-padding-80">
        <div class="container">
            <form action="../../controllers/submit_checkout.asp" method="POST">
                <div class="row">


                    <div id="invoice-save" class="col-12 col-md-12">
                        <div class="order-details-confirmation">
                            <div class="col-12">
                                <div class="page-title text-center">
                                    <h2 style="font-weight: 100;">Invoice & Packing List</h2>
                                </div>
                            </div>
                            <div class="cart-page-heading d-flex" >
                                <div>
                                    <h6>Invoice Date: <%=Result_bill("oder_day")%></h6>
                                    <h6>Invoice Number: <%=Result_bill("ID_bill")%></h6>
                                    <h6>Page: 1</h6>
                                </div>
                                <div>
                                    <h6>ESSENCE Shop</h6>
                                    <h6>Phone: 089 89 89 99</h6>
                                </div>
                            </div>
                            <div class="cart-page-heading d-flex" >
                                <div>
                                    <h6>Name: <%=Result_bill("name")%></h6>
                                    <h6>Phone: <%=Result_bill("phone_no")%></h6>
                                    <h6>Address: <%=Result_bill("addressDetails")%></h6>
                                </div>
                                <div>
                                </div>
                            </div>

                            <ul class="order-details-form mb-4">
                                <li>
                                    <span>No.</span> 
                                    <span>Product</span> 
                                    <div style="display: flex; width: 45em; justify-content: space-between;">
                                        <span>Size</span> 
                                        <span>Color</span> 
                                        <span>Price</span> 
                                        <span>Quantity</span> 
                                        <span>Total</span>
                                    </div>
                                </li>
                            <%
                            sql_billDetails = "select billDetails.*,color, size, discount.sale_percent, discount.end_day from billDetails inner join bill on bill.ID_bill = billDetails.ID_bill inner join product on product.ID_product = billDetails.ID_product inner join discount on discount.ID_product = billDetails.ID_product  inner join size on size.ID_size = billDetails.ID_size inner join color on color.ID_color = billDetails.ID_color where bill.ID_bill = "&ID_bill
                            Set Result = Conn.execute(sql_billDetails)
                            Dim index
                            index = 1
                            Dim total
                            total_sale = 0
                            total = 0
                            do while not Result.EOF
                                ' lấy ra giá, số lượng, phần trăm sale
                                price = CInt(Result("price"))
                                quantity = CInt(Result("quantity"))
                                percent = CInt(Result("sale_percent"))

                                ' tạo biến currentDate lấy ra ngày hiện tại
                                ' so sánh với ngày hết hạn sale để tính giá tiền
                                Dim currentDate
                                currentDate = Date()

                                Dim datee
                                datee = FormatDateTime(Result("end_day"),2)

                                if (CStr(datee) < CStr(currentDate)) then
                                    percent = 0
                                end if

                                ' tính giá tổng đơn hàng
                                subtotal_sale = (price * (100 - percent))/100 * quantity
                                subtotal = price * quantity
                                total = total + subtotal
                                total_sale = total_sale + subtotal_sale
                            %>
                                <li>
                                    <span><%=index%></span> 
                                    <span><%=Result("name")%></span> 
                                    <div style="display: flex; width: 45em; justify-content: space-between;">
                                        <span><%=Result("size")%></span> 
                                        <span><%=Result("color")%></span> 
                                        <span><%=Result("price")%></span> 
                                        <span><%=Result("quantity")%></span> 
                                        <span>$<%=subtotal%>.00</span>
                                    </div>
                                </li>
                            <%
                            index = index + 1
                            Result.MoveNext
                            loop
                            
                            %>
                                <!--<li><span>Subtotal</span> <span>$59.90</span></li>-->
                                <li><span>Shipping</span> <span>Free</span></li>
                                <li><span>Subtotal</span> <span>$<%=total%>.00</span></li>
                                <li><span>Sale off</span> <span>$<%=total - total_sale%>.00</span></li>
                                <li><span>Total</span> <span>$<%=total_sale%>.00</span></li>
                                <input type="hidden" id="custId" name="total_price" value="<%=total_sale%>">
                            </ul>
                        <h5 class="h5-we">we have moved pls take note of the about new address with effect from <%=oder_day%></h5>
                        <h5 style="margin-top: 2em;" class="h5-we">We sincerely thank you!</h5>
                        </div>
                    </div>
                </div>
                <button type="button" style="margin-top: 3em;" onclick="back()" class="btn essence-btn">Back</button>
                <button type="button" style="margin-top: 3em;" onclick="saveAsPNG()" class="btn essence-btn">Save Invoice</button>
            </form>
        </div>
    </div>
    <!-- ##### Checkout Area End ##### -->
    <!-- ##### Breadcumb Area End ##### -->

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
    
    <script>
        function back () {
            window.location.href = '/fashionShop/views/customers/shop.asp'
        }
         // Hàm chuyển đổi và lưu thành PNG
        function saveAsPNG() {
            html2canvas(document.getElementById('invoice-save')).then(function(canvas) {
                var imgData = canvas.toDataURL('image/png');
                var link = document.createElement('a');
                link.href = imgData;
                link.download = 'file.png';
                link.click();
            });
        }
    </script>
</body> 

</html>