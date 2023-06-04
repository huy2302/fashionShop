
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

Dim sql

' id_product = Request.QueryString("id_product")
startDay = Request.QueryString("start")
endDay = Request.QueryString("end")
sale = Request.QueryString("sale")

sql = "insert into discount values((select max(ID_product) as id from product), (select max(ID_product) as id from product), '"&startDay&"', '"&endDay&"',"&sale&")"
Conn.Execute sql 


Response.ContentType = "text/html"
%>


