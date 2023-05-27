<!--#include file="connect.asp"-->

<%
' Check if the form has been submitted
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    ' Retrieve form data
    Dim terms, create_acc, subs
    first_name = Request.Form("first_name")
    last_name = Request.Form("last_name")
    city = Request.Form("city")
    province = Request.Form("province")
    district = Request.Form("district")
    address = Request.Form("address")
    phone_number = Request.Form("phone_number")
    email = Request.Form("email")
    terms = Request.Form("terms") = "on"
    create_acc = Request.Form("create_acc") = "on"
    subs = Request.Form("subs") = "on"
    total_price = Request.Form("total_price")
    ' response.write "terms "&terms&" subs "&subs&" create_acc "&create_acc
    ' response.write "<br>"
    

    IF (NOT IsEmpty(Session("ID_user"))) Then
        Set Conn = Server.CreateObject("ADODB.Connection")
        Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"
        ' kiểm tra số lượng bill
        sql = "SELECT COUNT(ID_bill) AS id FROM bill"
        Set Result = Conn.execute(sql)
        dim countBill
        if not Result.EOF then
        ' nếu chưa có bill nào thì countBill = 0
            if (Result("id") = "0") then
                countBill = "0"
            else 
                countBill = "1"
            end if
        end if
        ' insert vào bảng bill
        ' nếu chưa có bill thì insert bill đầu tiên, ngược lại insert với ID_bill = select MAX
        if (countBill = "0") then
            sql_bill = "insert into bill values (1, "&Session("ID_user")&", GETDATE(), null, '"&total_price&"', '"&first_name&"', '"&last_name&"', '"&phone_number&"', '"&phone_number&"')"
            Conn.Execute sql_bill
        else 
            sql_bill = "insert into bill values ((SELECT MAX(ID_bill) + 1 AS id FROM bill), "&Session("ID_user")&", GETDATE(), null, '"&total_price&"', '"&first_name&"', '"&last_name&"', '"&phone_number&"', '"&phone_number&"')"
            Conn.Execute sql_bill
        end if

        ' insert vào bảng bill_details
        sql_cart = "select * from cart"
        Set Result_cart = Conn.execute(sql_cart)
        do while not Result_cart.EOF 

            sql_details = "insert into billDetails values((SELECT MAX(ID_bill) AS id FROM bill), "&Result_cart("ID_product")&", "&Result_cart("quantity")&", '"&Result_cart("price")&"', '','','',"&Result_cart("ID_color")&","&Result_cart("ID_size")&")"

            Conn.Execute sql_details

        Result_cart.MoveNext
        loop

        ' insert vào bảng address
        sql_address = "insert into address values ("&Session("ID_user")&", '"&city&"', '"&province&"', '"&district&"', '"&address&"')"
        Conn.Execute sql_address

        ' nếu khách tích vào tạo acc thì insert vào bảng account và user với id mới
        if create_acc = True then 
            response.write "create_acc true"
        else 
            response.write "create_acc false"
        end if
    END IF
    ' Response.write "<script>alert(""Your order is successful, you will be redirected to the product page"")</script>"
    ' Response.write "<script>window.location.href = '/fashionShop/views/customers/shop.asp'</script>"
    ' Response.Redirect "/fashionShop/views/customers/shop.asp"
End If
%>


