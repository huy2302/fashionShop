
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

Dim size, sql, rs

id = Request.QueryString("id")

Response.write "id: "&id
Set rs = Server.CreateObject("ADODB.Recordset")

sql = "delete discount where discount.ID_product = "&id
Conn.Execute sql

sql = "delete product_size_color where product_size_color.ID_product = "&id
Conn.Execute sql

sql = "delete brand where brand.ID_product = "&id
Conn.Execute sql

sql = "delete imageProduct where imageProduct.ID_product = "&id
Conn.Execute sql

sql = "delete product where product.ID_product = "&id
Conn.Execute sql

Response.ContentType = "text/html"
%>
<script>alert('Delete successfully!')</script>
<script>window.location.href = "/fashionShop/views/admin/pages/product/allProduct.asp"</script>


