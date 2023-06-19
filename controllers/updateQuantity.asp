<!--#include file="connect.asp"-->
<% 
Dim sql

id = Request.QueryString("id")
size = Request.QueryString("size")
color = Request.QueryString("color")
quantity = Request.QueryString("quantity")

Response.write "id: "&id&", size: "&size&", color: "&color&", quantity: "&quantity

sql = "update cart set cart.quantity = "&quantity&" where cart.ID_user = "&Session("ID_user")&" and cart.ID_product = "&id&" and cart.ID_size = "&size&" and cart.ID_color = "&color
Response.Write "<br>"
Response.Write sql

Conn.Execute sql 

Response.ContentType = "text/html"
%>


