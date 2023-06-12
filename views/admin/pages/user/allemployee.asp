<% 'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=huydevtr\SQLASP;Database=shop;User Id=sa;Password=123"
connDB.ConnectionString = strConnection
connDB.Open()
%>

<!DOCTYPE html>
<html lang="en">

<head>
  <!-- <link rel="stylesheet" href="./css/modal.css"> -->
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Star Admin2 </title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="../../vendors/feather/feather.css">
  <link rel="stylesheet" href="../../vendors/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="../../vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="../../vendors/typicons/typicons.css">
  <link rel="stylesheet" href="../../vendors/simple-line-icons/css/simple-line-icons.css">
  <link rel="stylesheet" href="../../vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="../../css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="../../images/favicon.png" />
</head>
<style>
  .swal2-confirm.swal2-styled {
    background-color: rgb(48, 133, 214) !important;
    color: #fff !important;
    font-weight: 400 !important;
  }
</style>
<body>
  <div class="container-scroller"> 

      <!-- #include file="../../partials/_header.asp" --> 

      <!-- partial -->
      <div class="container-fluid page-body-wrapper">

        <!-- #include file="../../partials/_settings-panel.asp" -->


        <!-- #include file="../../partials/_sidebar.asp" -->

      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
          <div class="row">
            <div class="col-lg-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title">List Employees</h4>
                  <div class="table-responsive">
                    <table class="table table-striped">
                      <thead>
                        <tr>
                          <th>
                            User
                          </th>
                          <th>
                            ID 
                          </th>
                          <th>
                            Full name
                          </th>
                          <th>
                            Identity Card
                          </th>
                          <th>
                            Birthday
                          </th>
                          <th>
                            Join on
                          </th>
                          <th>
                            Phone Number
                          </th>
                          <th>
                            Action
                          </th>
                        </tr>
                      </thead>
                      <tbody>
                        <%
                        Set cmdPrep = Server.CreateObject("ADODB.Command")
                        cmdPrep.ActiveConnection = connDB
                        cmdPrep.CommandType = 1
                        cmdPrep.Prepared = True
                        cmdPrep.CommandText = "select CONCAT(users.firstName, ' ', users.lastName) as fullName, birthday, ID_user, joindate, phone_number, cmnd from users"

                        Set Result = cmdPrep.execute
                        do while not Result.EOF
                        %>
                        <tr>
                          <td class="py-1">
                            <img src="../../images/faces/face1.jpg" alt="image"/>
                          </td>
                          <td>
                            <%=Result("ID_user")%>
                          </td>
                          <td>
                            <%=Result("fullName")%>
                          </td>
                          <td>
                            <%=Result("cmnd")%>
                          </td>
                          <td>
                            <!--<div class="progress">
                              <div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>-->
                            <%=Result("birthday")%>
                          </td>
                          <td>
                            <%=Result("joindate")%>
                          </td>
                          <td>
                            <%=Result("phone_number")%>
                          </td>
                          <td>
                            <a href="editEmployee.asp?id=<%=Result("ID_user")%>" class="btn btn-secondary">Edit</a>
                            <a id='<%=Result("ID_user")%>' class="btn btn-danger btn-delete">Delete</a>
                          </td>
                        </tr>
                        <%
                            Result.MoveNext
                            loop
                        %>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
        <footer class="footer">
          <div class="d-sm-flex justify-content-center justify-content-sm-between">
            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Premium <a href="https://www.bootstrapdash.com/" target="_blank">Bootstrap admin template</a> from BootstrapDash.</span>
            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Copyright © 2021. All rights reserved.</span>
          </div>
        </footer>
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
    </div>
    <!-- container-scroller -->
    <!-- #include file="../../js/mainJs.asp" -->

</body>

</html>