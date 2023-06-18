<!-- #include file="../connect.asp" --> 
<%
Dim sql

' id_product = Request.QueryString("id_product")
startDay = Request.QueryString("start")
endDay = Request.QueryString("end")
sale = Request.QueryString("sale")

sql = "insert into discount values((select max(ID_product) as id from product), (select max(ID_product) as id from product), '"&startDay&"', '"&endDay&"',"&sale&")"
Conn.Execute sql 


Response.ContentType = "text/html"
%>


