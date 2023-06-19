<!--#include file="connect.asp"-->
<!--#include file="connectCMD.asp"-->

<%    
    'Lay ve IDProduct
    Dim ID_product, ID_size, ID_color
    ID_product = Request.QueryString("id")
    ID_size = Request.QueryString("size")
    ID_color = Request.QueryString("color")
    Response.Write "ID_product: "&ID_product&" ID_size:"&ID_size&" ID_color:"&ID_color
    Response.Write "<br/>"

    ' Do Something...
    If (NOT IsNull(ID_product) and NOT IsEmpty(Session("ID_user"))) Then
        Dim cmdPrep, Result
        Set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.CommandText = "select product.ID_product, product.name, size.ID_size, size, color.ID_color, color, cart.quantity from cart inner join product_size_color p on p.ID_product = cart.ID_product inner join product on product.ID_product = cart.ID_product inner join size on size.ID_size = cart.ID_size inner join color on color.ID_color = cart.ID_color where product.ID_product = "&ID_product&" and size.ID_size = "&ID_size&" and color.ID_color = "&ID_color&" group by product.ID_product, product.name, size.ID_size, size, color.ID_color, color, cart.quantity"
        Set Result = cmdPrep.execute 
        Response.write "<br>"

            If Result.EOF then
                sql = "insert into cart (ID_user, ID_product, ID_size, ID_color, quantity, price) values ("&Session("ID_user")&", "&ID_product&", "&ID_size&", "&ID_color&", 1, (select price from product where ID_product = "&ID_product&"))"
                Conn.Execute sql
            end if

            Do While Not Result.EOF
                IF (CInt(ID_product) = CInt(Result("ID_product")) and CInt(ID_size) = CInt(Result("ID_size")) and CInt(ID_color) = CInt(Result("ID_color")) ) then
                    sql = "update cart set quantity = ((select quantity from cart where cart.ID_product = "&Result("ID_product")&" and cart.ID_size = "&Result("ID_size")&" and cart.ID_color = "&Result("ID_color")&") + 1) where cart.ID_product = "&Result("ID_product")&" and cart.ID_size = "&Result("ID_size")&" and cart.ID_color = "&Result("ID_color")&""
                    Conn.Execute sql
                    Session("Success") = "The Product has bean added to your cart."
                END IF
            Result.MoveNext
            Loop
            Conn.close()
                Response.Write("The Session is exists.")   
                
            Result.Close()
            connDB.Close()

        
    End if   

%>