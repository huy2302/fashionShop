
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

Dim sql

id_product = Request.QueryString("id_product")
id_size = Request.QueryString("id_size")
id_color = Request.QueryString("id_color")
quantity = Request.QueryString("quantity")

Response.write "id_product="&id_product&" id_size="&id_size&" id_color="&id_color&" quantity="&quantity

sql = "insert into product_size_color values("&id_product&", "&id_size&", "&id_color&", "&quantity&")"
Conn.Execute sql 


Response.ContentType = "text/html"
%>