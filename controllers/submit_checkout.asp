<!--#include file="connect.asp"-->
<!-- #include file="connectCMD.asp" --> 
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
        ' kiem tra so luong hang trong kho
        sql = "select * from product_size_color"
        Set ResultQuantity = Conn.execute(sql)
        
        sql = "select * from cart where ID_user = "&Session("ID_user")
        Set ResultCart = Conn.execute(sql)

        Dim quantityStockAfter, allowOrder, overLimitOrder, quantityOverOrder
        ' Biến allowOrder = true thì sẽ cho phép đặt hàng
        allowOrder = false
        ' Biến overLimitOrder = true là số lượng đặt > số lượng kho
        ' sẽ báo là đặt được số lượng còn lại, không thể đặt hơn
        overLimitOrder = false

        Dim ID_productS, ID_sizeS, ID_colorS
        Do while not ResultCart.EOF

            Do while not ResultQuantity.EOF
                if ((ResultCart("ID_product")) = ResultQuantity("ID_product") and ResultCart("ID_product") = ResultQuantity("ID_product") and ResultCart("ID_product") = ResultQuantity("ID_product")) then
                    ID_productS = ResultQuantity("ID_product")
                    ID_sizeS = ResultQuantity("ID_size")
                    ID_colorS = ResultQuantity("ID_color")
                    if (CInt(ResultQuantity("quantity") > 0)) then 
                        if (CInt(ResultCart("quantity")) <= CInt(ResultQuantity("quantity"))) then
                            quantityStockAfter = CInt(ResultQuantity("quantity")) - CInt(ResultCart("quantity"))

                            allowOrder = true
                            statusOrder = "Complete"
                        else 
                            ' nếu số lượng đặt > số lượng có thì không cho đặt và thông báo
                            allowOrder = true 
                            overLimitOrder = true

                            quantityStockAfter = 0

                            quantityOverOrder = CInt(ResultCart("quantity")) - CInt(ResultQuantity("quantity"))
                            statusOrder = "Missing orders" ' còn thiếu hàng
                        end if
                    else 
                        statusOrder = "Failed"
                        allowOrder = false
                        Response.write "This product is currently out of stock, your order will be recorded. When we update the item, we will deliver the order to you. We apologize for this inconvenience."
                    end if
                    ' update số lượng còn lại vào bảng product_size_color
                    if (overLimitOrder = true) then 
                        Response.write "<script>alert(""The quantity you ordered exceeds the amount left in stock, so you can only order "&ResultQuantity("quantity")&" products, the remaining "&quantityOverOrder&" products when the stock is updated, we will automatically place a 2nd order for you. We apologize for this inconvenience."")</script>"
                    end if
                    if (statusOrder <> "Failed") then 
                        sql_quantity = "update product_size_color set quantity = "&quantityStockAfter&"where ID_product = "&ID_productS&"and ID_size = "&ID_sizeS&" and ID_color = "&ID_colorS
                        Conn.Execute sql_quantity
                    end IF

                    Exit Do ' Dừng vòng lặp khi tìm ra sản phẩm
                end if

            ResultQuantity.MoveNext
            loop

        ResultCart.MoveNext
        loop
        ' allowOrder = false

        if (allowOrder = true and statusOrder <> "Failed") then
            ' insert vào bảng bill
            ' nếu chưa có bill thì insert bill đầu tiên, ngược lại insert với ID_bill = select MAX
            if (countBill = "0") then
                sql_bill = "insert into bill values (1, "&Session("ID_user")&", GETDATE(), null, '"&total_price&"', '"&first_name&"', '"&last_name&"', '"&phone_number&"', '"&email&"', '"&statusOrder&"')"
                Conn.Execute sql_bill
            else 
                sql_bill = "insert into bill values ((SELECT MAX(ID_bill) + 1 AS id FROM bill), "&Session("ID_user")&", GETDATE(), null, '"&total_price&"', '"&first_name&"', '"&last_name&"', '"&phone_number&"', '"&email&"', '"&statusOrder&"')"
                Conn.Execute sql_bill
            end if
            
            ' insert vào bảng bill_details
            sql_cart = "select * from cart"
            Set Result_cart = Conn.execute(sql_cart)
            dim sale_percent
            do while not Result_cart.EOF 
            
                sql_details = "insert into billDetails values((SELECT MAX(ID_bill) AS id FROM bill), "&Result_cart("ID_product")&", "&Result_cart("quantity")&", '"&Result_cart("price")&"', (select species from product where ID_product = "&Result_cart("ID_product")&"),(select sale_percent from discount where ID_product = "&Result_cart("ID_product")&" and end_day > GETDATE() - 1), '',"&Result_cart("ID_color")&","&Result_cart("ID_size")&", (select name from product where ID_product = "&Result_cart("ID_product")&"))"

                Conn.Execute sql_details

            Result_cart.MoveNext
            loop

            ' insert vào bảng address
            sql_address = "insert into address values ("&Session("ID_user")&", '"&city&"', '"&province&"', '"&district&"', '"&address&"')"
            Conn.Execute sql_address

            ' tạo 1 tài khoản cho khách hàng nếu khách hàng tick chọn
            ' sql_insert = "insert into "
            Response.write "<script>alert(""Your order is successful, you will be redirected to the product page."")</script>"
            Response.write "<script>window.location.href = '/fashionShop/views/customers/shop.asp'</script>"
        else 
            Response.write "<script>alert(""The product you ordered does not exist or has been deleted. Order failed!"")</script>"
        end if
    else
        Response.write "<script>alert(""Looks like you haven't been on the page for a long time, please login again to continue."")</script>"
        Response.write "<script>window.location.href = '/fashionShop/views/customers/user.asp'</script>"
    end if
End If
%>


