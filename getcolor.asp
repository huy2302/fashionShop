<!-- #include file="connect.asp" -->

<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"


' size = Request.Form("size")
' Set RS_MauSac = Conn.Execute("SELECT * FROM mau_sac")

' Set RS_Size = Conn.Execute("SELECT DISTINCT quantity FROM Product WHERE masp='" & size & "'")

Dim size, sql, rs
size = Request.QueryString("size")
sql = "SELECT quantity FROM Product WHERE size='" & size & "'"
sql = "select product.ID_product, size, size.ID_size, color, color.ID_color, quantity from product_size_color p join size on size.ID_size = p.ID_size join color on color.ID_color = p.ID_color join product on product.ID_product = p.ID_product where product.ID_product = 1 and size.ID_size = " & size & ""
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn

Response.ContentType = "text/html"
Do While Not rs.EOF
  if rs("quantity") > 0 then
    Response.Write "<option value='" & rs("color") & "'>" & rs("color") & "</option>"
  else 
    Response.Write "<option disabled value='" & rs("color") & "'>" & rs("color") & "</option>"
  end if
  rs.MoveNext
Loop
rs.Close
%>


