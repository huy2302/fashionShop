
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

Dim size, sql, rs

id = Request.QueryString("id")
size = Request.QueryString("size")
color = Request.QueryString("color")

Response.write "id: "&id&", size: "&size&", color: "&color
sql = "delete cart where cart.ID_product = "&id&" and cart.ID_size = "&size&" and cart.ID_color = "&color&""
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn
' Response.write "<br>"
' Response.write rs.Open sql, conn

Response.ContentType = "text/html"

' rs.Close
%>


