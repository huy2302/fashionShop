<!-- #include file="../connect.asp" --> 
<%
Dim orderDay
orderDay = Request.QueryString("day")

sql = "SELECT COUNT(CASE WHEN joindate > DATEADD(DAY, -30, GETDATE()) THEN ID_user END) AS users_last_30_days, COUNT(CASE WHEN joindate < DATEADD(DAY, -30, GETDATE()) THEN ID_user END) AS users_last_60_days, COUNT(joindate) AS users_all_days FROM [shop].[dbo].[users] join account on account.ID_account = users.ID_account where joindate > GETDATE() - 60 and joindate < GETDATE() and account.role = 1"

Set result = Conn.execute(sql)

sqlTotal = "SELECT COUNT(joindate) AS users_all_days FROM [shop].[dbo].[users] join account on account.ID_account = users.ID_account where joindate < GETDATE() and account.role = 1"

Set resultTotal = Conn.execute(sqlTotal)
dim id
id = 1
Response.ContentType = "application/json"
Response.Write "["
do while not result.EOF

    Response.Write "{ ""id"": """&id&""", ""users_last_30_days"": """&result("users_last_30_days")&""",""users_last_60_days"": """&result("users_last_60_days")&""",""users_all_days"": """&resultTotal("users_all_days")&"""},"
    
result.MoveNext
loop
Response.Write    "{ ""id"": ""-1"", ""name"": ""6"" }"
Response.Write "]"
' end if
%>