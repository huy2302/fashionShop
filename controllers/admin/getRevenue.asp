<!-- #include file="../connect.asp" --> 
<%
Dim orderDay
orderDay = Request.QueryString("day")

sql = "select count(ID_bill) as quantity, oder_day from bill where oder_day = '"&orderDay&"' group by oder_day"

Set result = Conn.execute(sql)
dim id
id = 1
Response.ContentType = "application/json"
Response.Write "["
do while not result.EOF

    Response.Write "{ ""id"": """&id&""", ""quantity"": """&result("quantity")&""",""oder_day"": """&result("oder_day")&"""},"
    id = id + 1
result.MoveNext
loop
Response.Write    "{ ""id"": ""-1"", ""name"": ""6"" }"
Response.Write "]"
' end if
%>