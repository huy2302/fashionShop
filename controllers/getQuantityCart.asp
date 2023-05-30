
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

Dim sql
quantity = ""

if (not IsEmpty(Session("ID_user"))) then
    quantity = "123"
    sql = "select COUNT(cart.ID_cart) as id from cart join users on users.ID_user = cart.ID_user where cart.ID_user = "&Session("ID_user")

    Set QuantityResult = Conn.execute(sql)
    If Not QuantityResult.EOF Then
        quantity = QuantityResult("id")
    Else 
        quantity = "0"
    End If
    Response.write(quantity)
    ' Response.ContentType = "application/json"
    ' Response.write "{""quantity"": """&quantity&"""}"
end if

%>
