<!-- #include file="../connect.asp" --> 
<%
Dim sql

id = Request.QueryString("id")

sql = "update discount set end_day = (CURRENT_TIMESTAMP - 1) where discount.ID_product in (select campaign.ID_product from campaign where ID_campaign = "&id&")"
Conn.Execute sql 

sql = "update campaign set status = 'Completed', end_day = (CURRENT_TIMESTAMP - 1) where ID_campaign = "&id
Conn.Execute sql 

Response.ContentType = "text/html"
%>
<script>alert('Update success!')</script>
<script>window.location.href = "/fashionShop/views/admin/pages/product/allCampaign.asp"</script>
