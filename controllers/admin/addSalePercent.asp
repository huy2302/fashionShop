
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

Dim sql

id_product = Request.QueryString("id_product")
startDay = Request.QueryString("start")
endDay = Request.QueryString("end")
sale = Request.QueryString("sale")

Response.write "id="&id&" link1="&link1&" link2="&link2&" link3="&link3&" link4="&link4

sql = "insert into discount values("&id_product&", "&id_product&", '"&startDay&"', '"&endDay&"',"&sale&")"
Conn.Execute sql 

Response.ContentType = "text/html"
%>


