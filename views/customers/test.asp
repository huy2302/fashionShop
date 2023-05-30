<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

Dim sql

sql = "select * from favorite where ID_user = 1 and ID_product = 2"

set rs = Conn.Execute(sql)

if not rs.EOF then 
    Response.Write rs("ID_user")&" - "&rs("ID_product")&" - "&rs("favorite_note")&"<br>"
else    
    Response.Write "None"
end if
%>
