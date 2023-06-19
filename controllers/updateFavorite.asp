<!--#include file="connect.asp"-->
<% 
Dim sql
' favorite_note = 1 => favorite checked
' favorite_note = 0 => favorite unchecked

favorite_note = Request.QueryString("q")
id_product = Request.QueryString("id")

Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

sql = "select * from favorite where ID_user = "&Session("ID_user")&" and ID_product = "&id_product
set rs = Conn.Execute(sql)

if not rs.EOF then
    Response.Write rs("ID_user")&" - "&rs("ID_product")&" - "&rs("favorite_note")&"<br>"
    del_sql = "DELETE FROM favorite WHERE ID_user = "&Session("ID_user")&" and ID_product = "&id_product
    Conn.Execute del_sql
else 
    Response.write "insert"
    ins_sql = "INSERT INTO favorite values ("&Session("ID_user")&", "&id_product&", '1')"
    Conn.Execute ins_sql
end if



' if (CInt(favorite_note) = 1) then 
'     sql = "update favorite set favorite_note = 'true' where favorite.ID_product = "&id_product&" and favorite.ID_user = "&Session("ID_user")
'     response.write("favorite "&favorite_note)
'     Conn.Execute sql
' elseif (CInt(favorite_note) = 0) then 
'     sql = "update favorite set favorite_note = 'false' where favorite.ID_product = "&id_product&" and favorite.ID_user = "&Session("ID_user")
'     response.write("favorite "&favorite_note)
'     Conn.Execute sql
' end if

%>
