
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

Dim sql

id = Request.QueryString("id")

sql = "update discount set end_day = CURRENT_TIMESTAMP - 1 where ID_product = "&id
Conn.Execute sql 

Response.ContentType = "text/html"
%>
<script>alert('Update success!')</script>
<script>window.location.href = "/fashionShop/views/admin/pages/product/saleProduct.asp"</script>


