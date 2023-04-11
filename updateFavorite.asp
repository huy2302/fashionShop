<!-- #include file="connect.asp" -->

<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

Dim sql
' favorite_note = 1 => favorite checked
' favorite_note = 0 => favorite unchecked

favorite_note = Request.QueryString("q")
id_product = Request.QueryString("id")

if (CInt(favorite_note) = 1) then 
    sql = "update favorite set favorite_note = 'true' where favorite.ID_product = "&id_product&" and favorite.ID_user = 1"
    response.write("favorite "&favorite_note)
    Conn.Execute sql
elseif (CInt(favorite_note) = 0) then 
    sql = "update favorite set favorite_note = 'false' where favorite.ID_product = "&id_product&" and favorite.ID_user = 1"
    response.write("favorite "&favorite_note)
    Conn.Execute sql
end if

%>
