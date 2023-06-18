<!-- #include file="../connect.asp" --> 
<%

' size = Request.Form("size")
' Set RS_MauSac = Conn.Execute("SELECT * FROM mau_sac")

' Set RS_Size = Conn.Execute("SELECT DISTINCT quantity FROM Product WHERE masp='" & size & "'")

Dim size, sql, rs
size = Request.QueryString("size")
sql = "SELECT quantity FROM Product WHERE size='" & size & "'"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn

Response.ContentType = "text/html"
Do While Not rs.EOF
  Response.Write "<option value='" & rs("quantity") & "'>" & rs("quantity") & "</option>"
  rs.MoveNext
Loop
rs.Close
%>


