<!-- #include file="../connect.asp" --> 
<%
Dim sql

id = Request.QueryString("id")

sql = "UPDATE bill set delivery_day = GETDATE() where ID_bill = "&id
Conn.Execute sql 

Response.ContentType = "text/html"
%>
<script>alert('Update success!')</script>
<script>window.location.href = "/fashionShop/views/admin/pages/revenue/allBill.asp"</script>


