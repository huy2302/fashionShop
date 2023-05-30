
<%
Dim orderDay
orderDay = Request.QueryString("day")

' if (not IsEmpty(Session("ID_user"))) then
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"

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