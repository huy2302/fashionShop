
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

Dim sql

id_product = Request.QueryString("id_product")
startDay = Request.QueryString("start")
endDay = Request.QueryString("end")
sale = Request.QueryString("sale")

sql = "update discount set start_day = '"&startDay&"', end_day = '"&endDay&"', sale_percent = "&sale&" where ID_product = "&id_product
Conn.Execute sql 

Response.ContentType = "text/html"
%>


