<!-- #include file="../connect.asp" --> 
<%
Dim sql

' id = Request.QueryString("id")
link1 = Request.QueryString("link1")
link2 = Request.QueryString("link2")
link3 = Request.QueryString("link3")
link4 = Request.QueryString("link4")

Response.write "id="&id&" link1="&link1&" link2="&link2&" link3="&link3&" link4="&link4

sql = "insert into imageProduct values((select max(ID_product) as id from product), (select max(ID_product) as id from product), '"&link1&"', '"&link2&"', '"&link3&"', '"&link4&"')"
Conn.Execute sql 

Response.ContentType = "text/html"
%>


