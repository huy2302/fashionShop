<!-- #include file="connect.asp" -->

<%
  if (IsEmpty(session("ID_employee"))) then
    Response.redirect("./pages/samples/login.asp")
  end if
%>

<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Star Admin2 </title>
  <!-- <link rel="stylesheet" href="./css/modal.css"> -->
  <!-- plugins:css -->
  <link rel="stylesheet" href="vendors/feather/feather.css">
  <link rel="stylesheet" href="vendors/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="vendors/typicons/typicons.css">
  <link rel="stylesheet" href="vendors/simple-line-icons/css/simple-line-icons.css">
  <link rel="stylesheet" href="vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <link rel="stylesheet" href="vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="js/select.dataTables.min.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="images/favicon.png" />
</head>
<style>
  .swal2-confirm.swal2-styled {
    background-color: rgb(48, 133, 214) !important;
    color: #fff !important;
    font-weight: 400 !important;
  }
  .rate-percentage {
    text-align: center;
  }
  .w-20 {
    width: 17%;
    /* padding: 0 1em; */
    text-align: left;
    /* border-right: 0.5px solid #ccc; */
    /* margin: 0 1em; */
  }
  .home-tab .statistics-details .rate-percentage {
    display: unset;
  }

</style>
<body>
  <div class="container-scroller"> 
    <!-- partial:partials/_navbar.html -->
    
    <!-- #include file="./partials/_header.asp" -->


    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
      <!-- #include file="./partials/_settings-panel.asp" -->
      <!-- #include file="./partials/_sidebar.asp" -->

      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
          <div class="row">
            <div class="col-sm-12">
              <div class="home-tab">
                <div class="d-sm-flex align-items-center justify-content-between border-bottom">
                  <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item">
                      <a class="nav-link active ps-0" id="home-tab" data-bs-toggle="tab" href="#overview" role="tab" aria-controls="overview" aria-selected="true">Overview</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#audiences" role="tab" aria-selected="false">Audiences</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" id="contact-tab" data-bs-toggle="tab" href="#demographics" role="tab" aria-selected="false">Demographics</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link border-0" id="more-tab" data-bs-toggle="tab" href="#more" role="tab" aria-selected="false">More</a>
                    </li>
                  </ul>
                  <div>
                    <div class="btn-wrapper">
                      <a href="#" class="btn btn-otline-dark align-items-center"><i class="icon-share"></i> Share</a>
                      <a href="#" class="btn btn-otline-dark"><i class="icon-printer"></i> Print</a>
                      <a href="#" class="btn btn-primary text-white me-0"><i class="icon-download"></i> Export</a>
                    </div>
                  </div>
                </div>
                <div class="tab-content tab-content-basic">
                  <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview"> 
                    <div class="row">
                      <div class="col-sm-12">
                        <div class="statistics-details d-flex align-items-flex-start ">
                          <div class="w-20">
                            <%
                            sql = "select count(product.ID_product) as count from product"
                            resultCount = Conn.execute(sql)
                            %>
                            <p class="statistics-title">Total Products</p>
                            <h3 class="rate-percentage"><%=resultCount("count")%></h3>
                            
                          </div>
                          <div class="w-20">
                            <%
                            sql = "select count(product.ID_product) as count from product inner join discount on product.ID_product = discount.ID_product where discount.sale_percent > 0 and discount.end_day > getdate() - 1"
                            resultSale = Conn.execute(sql)
                            %>
                            <p class="statistics-title">Products on Sale</p>
                            <h3 class="rate-percentage"><%=resultSale("count")%></h3>
                            
                          </div>
                          <div class="w-20">
                            <%
                            sql = "select SUM(quantity) as quantity from billDetails"
                            resultSale = Conn.execute(sql)
                            %>
                            <p class="statistics-title">Products Sold</p>
                            <h3 class="rate-percentage"><%=resultSale("quantity")%></h3>
                            
                          </div>
                          <div class="w-20">
                            <%
                            sql = "select COUNT(ID_account) as quantity from account where role = 0"
                            resultSale = Conn.execute(sql)
                            %>
                            <p class="statistics-title">Employees</p>
                            <h3 class="rate-percentage"><%=resultSale("quantity")%></h3>
                            
                          </div>
                          <div class="w-20">
                            <%
                            sql = "select COUNT(ID_account) as quantity from account where role = 1"
                            resultSale = Conn.execute(sql)
                            %>
                            <p class="statistics-title">Users</p>
                            <h3 class="rate-percentage"><%=resultSale("quantity")%></h3>
                            
                          </div>
                          <div class="w-20">
                            <%
                            sql = "SELECT COUNT(CASE WHEN joindate > DATEADD(DAY, -30, GETDATE()) THEN ID_user END) AS users_last_30_days, COUNT(CASE WHEN joindate < DATEADD(DAY, -30, GETDATE()) THEN ID_user END) AS users_last_60_days,	COUNT(joindate) AS users_all_days FROM [shop].[dbo].[users] join account on account.ID_account = users.ID_account where joindate > GETDATE() - 60 and joindate < GETDATE() and account.role = 1"
                            rsUserNumber = Conn.execute(sql)

                            Dim thisMonth, lastMonth, percentNumber, roundedPercent

                            thisMonth = CInt(rsUserNumber("users_last_30_days"))
                            lastMonth = CInt(rsUserNumber("users_last_60_days"))

                            if (lastMonth = 0) then 
                              percentNumber = 0
                            else 
                              percentNumber = thisMonth / lastMonth * 100
                            end if
                            roundedPercent = round(percentNumber, 1)
                            %>
                            <p  class="statistics-title">New Users of The Month</p>
                            <h3 class="rate-percentage"><%=thisMonth%></h3>
                            <%
                            if (thisMonth >= lastMonth) then 
                            %>
                            <p  class="text-success d-flex"><i class="mdi mdi-menu-up"></i><span>+<%=roundedPercent%>%</span></p>
                            <% end if %>
                            <%
                            if (thisMonth < lastMonth) then 
                            %>
                            <p  class="text-danger d-flex"><i class="mdi mdi-menu-down"></i><span>-<%=roundedPercent%>%</span></p>
                            <% end if %>
                          </div>
                        </div>
                      </div>
                    </div> 
                    <div class="row">
                      <div class="col-sm-12">
                        <div class="statistics-details d-flex align-items-flex-start ">
                          <div class="w-20">
                            <%
                            sql = "SELECT COUNT(CASE WHEN oder_day > DATEADD(DAY, -7, GETDATE()) THEN ID_user END) AS order_last_7_days, COUNT(CASE WHEN oder_day < DATEADD(DAY, -7, GETDATE()) THEN ID_user END) AS order_last_14_days, COUNT(oder_day) AS order_all_days FROM bill where oder_day > GETDATE() - 14 and oder_day < GETDATE()"
                            resultBillWeek = Conn.execute(sql)

                            thisMonth = CInt(resultBillWeek("order_last_7_days"))
                            lastMonth = CInt(resultBillWeek("order_last_14_days"))

                            if (lastMonth = 0) then 
                              percentNumber = 0
                            else 
                              percentNumber = thisMonth / lastMonth * 100
                            end if
                            roundedPercent = round(percentNumber, 1)
                            %>
                            <p  class="statistics-title">Orders for The Week</p>
                            <h3 class="rate-percentage"><%=thisMonth%></h3>
                            <%
                            if (thisMonth >= lastMonth) then 
                            %>
                            <p  class="text-success d-flex"><i class="mdi mdi-menu-up"></i><span>+<%=roundedPercent%>%</span></p>
                            <% end if %>
                            <%
                            if (thisMonth < lastMonth) then 
                            %>
                            <p  class="text-danger d-flex"><i class="mdi mdi-menu-down"></i><span>-<%=roundedPercent%>%</span></p>
                            <% end if %>
                          </div>

                          <div class="w-20">
                            <%
                            sql = "SELECT SUM(CASE WHEN oder_day > DATEADD(DAY, -7, GETDATE()) THEN CAST(quantity AS decimal) END) AS order_last_7_days, SUM(CASE WHEN oder_day < DATEADD(DAY, -7, GETDATE()) THEN CAST(quantity AS decimal) END) AS order_last_14_days FROM bill join billDetails on bill.ID_bill = billDetails.ID_bill where oder_day > GETDATE() - 14 and oder_day < GETDATE()"
                            resultQuantityWeek = Conn.execute(sql)

                            thisMonth = CInt(resultQuantityWeek("order_last_7_days"))
                            lastMonth = CInt(resultQuantityWeek("order_last_14_days"))

                            if (lastMonth = 0) then 
                              percentNumber = 0
                            else 
                              percentNumber = thisMonth / lastMonth * 100
                            end if
                            roundedPercent = round(percentNumber, 1)
                            %>
                            <p  class="statistics-title">Week Sold Products</p>
                            <h3 class="rate-percentage"><%=thisMonth%></h3>
                            <%
                            if (thisMonth >= lastMonth) then 
                            %>
                            <p  class="text-success d-flex"><i class="mdi mdi-menu-up"></i><span>+<%=roundedPercent%>%</span></p>
                            <% end if %>
                            <%
                            if (thisMonth < lastMonth) then 
                            %>
                            <p  class="text-danger d-flex"><i class="mdi mdi-menu-down"></i><span>-<%=roundedPercent%>%</span></p>
                            <% end if %>
                          </div>

                          <div class="w-20">
                            <%
                            sql = "SELECT SUM(CASE WHEN oder_day > DATEADD(DAY, -7, GETDATE()) THEN CAST(price AS decimal) else 0 end) as order_last_7_days, SUM(CASE WHEN oder_day < DATEADD(DAY, -7, GETDATE()) THEN CAST(price AS decimal) end) as order_last_14_days FROM bill WHERE oder_day > GETDATE() - 14 and oder_day < GETDATE()"
                            resultPriceWeek = Conn.execute(sql)
                            thisMonth = CInt(resultPriceWeek("order_last_7_days"))
                            lastMonth = CInt(resultPriceWeek("order_last_14_days"))

                            if (lastMonth = 0) then 
                              percentNumber = 0
                            else 
                              percentNumber = thisMonth / lastMonth * 100
                            end if
                            roundedPercent = round(percentNumber, 1)
                            %>
                            <p  class="statistics-title">Amount of The Week</p>
                            <h3 class="rate-percentage">$<%=thisMonth%>.00</h3>
                            <%
                            if (thisMonth >= lastMonth) then 
                            %>
                            <p  class="text-success d-flex"><i class="mdi mdi-menu-up"></i><span>+<%=roundedPercent%>%</span></p>
                            <% end if %>
                            <%
                            if (thisMonth < lastMonth) then 
                            %>
                            <p  class="text-danger d-flex"><i class="mdi mdi-menu-down"></i><span>-<%=roundedPercent%>%</span></p>
                            <% end if %>
                          </div>
                          <div class="d-none d-md-block w-20">
                            <%
                            sql = "SELECT COUNT(CASE WHEN oder_day > DATEADD(DAY, -30, GETDATE()) THEN ID_user END) AS order_last_30_days, COUNT(CASE WHEN oder_day < DATEADD(DAY, -30, GETDATE()) THEN ID_user END) AS order_last_60_days, COUNT(oder_day) AS order_all_days FROM bill where oder_day > GETDATE() - 60 and oder_day < GETDATE()"
                            resultBillMonth = Conn.execute(sql)

                            thisMonth = CInt(resultBillMonth("order_last_30_days"))
                            lastMonth = CInt(resultBillMonth("order_last_60_days"))

                            if (lastMonth = 0) then 
                              percentNumber = 0
                            else 
                              percentNumber = thisMonth / lastMonth * 100
                            end if
                            roundedPercent = round(percentNumber, 1)
                            %>
                            <p  class="statistics-title">Orders for The Month</p>
                            <h3 class="rate-percentage"><%=thisMonth%></h3>
                            <%
                            if (thisMonth >= lastMonth) then 
                            %>
                            <p  class="text-success d-flex"><i class="mdi mdi-menu-up"></i><span>+<%=roundedPercent%>%</span></p>
                            <% end if %>
                            <%
                            if (thisMonth < lastMonth) then 
                            %>
                            <p  class="text-danger d-flex"><i class="mdi mdi-menu-down"></i><span>-<%=roundedPercent%>%</span></p>
                            <% end if %>
                          </div>

                          <div class="w-20">
                            <%
                            sql = "SELECT SUM(CASE WHEN oder_day > DATEADD(DAY, -30, GETDATE()) THEN CAST(quantity AS decimal) END) AS order_last_30_days, SUM(CASE WHEN oder_day < DATEADD(DAY, -30, GETDATE()) THEN CAST(quantity AS decimal) END) AS order_last_60_days FROM bill join billDetails on bill.ID_bill = billDetails.ID_bill where oder_day > GETDATE() - 60 and oder_day < GETDATE()"
                            resultQuantityMonth = Conn.execute(sql)

                            thisMonth = CInt(resultQuantityMonth("order_last_30_days"))
                            lastMonth = CInt(resultQuantityMonth("order_last_60_days"))

                            if (lastMonth = 0) then 
                              percentNumber = 0
                            else 
                              percentNumber = thisMonth / lastMonth * 100
                            end if
                            roundedPercent = round(percentNumber, 1)
                            %>
                            <p  class="statistics-title">Month Sold Products</p>
                            <h3 class="rate-percentage"><%=thisMonth%></h3>
                            <%
                            if (thisMonth >= lastMonth) then 
                            %>
                            <p  class="text-success d-flex"><i class="mdi mdi-menu-up"></i><span>+<%=roundedPercent%>%</span></p>
                            <% end if %>
                            <%
                            if (thisMonth < lastMonth) then 
                            %>
                            <p  class="text-danger d-flex"><i class="mdi mdi-menu-down"></i><span>-<%=roundedPercent%>%</span></p>
                            <% end if %>
                          </div>

                          <div class="d-none d-md-block w-20">
                            <%
                            sql = "SELECT SUM(CASE WHEN oder_day > DATEADD(DAY, -30, GETDATE()) THEN CAST(price AS decimal) end) as order_last_30_days, SUM(CASE WHEN oder_day < DATEADD(DAY, -30, GETDATE()) THEN CAST(price AS decimal) end) as order_last_60_days FROM bill WHERE oder_day >= DATEADD(day, -60, GETDATE()) or oder_day <= GETDATE()"
                            resultPriceMonth = Conn.execute(sql)

                            thisMonth = CInt(resultPriceMonth("order_last_30_days"))
                            lastMonth = CInt(resultPriceMonth("order_last_60_days"))

                            if (lastMonth = 0) then 
                              percentNumber = 0
                            else 
                              percentNumber = thisMonth / lastMonth * 100
                            end if
                            roundedPercent = round(percentNumber, 1)
                            %>
                            <p  class="statistics-title">Amount of The Month</p>
                            <h3 class="rate-percentage">$<%=thisMonth%>.00</h3>
                            <%
                            if (thisMonth >= lastMonth) then 
                            %>
                            <p  class="text-success d-flex"><i class="mdi mdi-menu-up"></i><span>+<%=roundedPercent%>%</span></p>
                            <% end if %>
                            <%
                            if (thisMonth < lastMonth) then 
                            %>
                            <p  class="text-danger d-flex"><i class="mdi mdi-menu-down"></i><span>-<%=roundedPercent%>%</span></p>
                            <% end if %>
                          </div>
                        </div>
                      </div>
                    </div>

                    <div class="row">
                      <div class="col-lg-8 d-flex flex-column">
                        <div class="row flex-grow">
                          <div class="col-12 grid-margin stretch-card">
                            <div class="card card-rounded">
                              <div class="card-body">
                                <div class="d-sm-flex justify-content-between align-items-start">
                                  <div>
                                   <h4 class="card-title card-title-dash">Performance Line Chart</h4>
                                   <h5 class="card-subtitle card-subtitle-dash">Lorem Ipsum is simply dummy text of the printing</h5>
                                  </div>
                                  <div id="performance-line-legend"><div class="chartjs-legend"><ul><li><span style="background-color:#1F3BB3"></span>This week</li><li><span style="background-color:#52CDFF"></span>Last week</li></ul></div></div>
                                </div>
                                <div class="chartjs-wrapper mt-5"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                                  <div>
                                    <canvas id="myChart"></canvas>
                                  </div>

                                  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                                  
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                        
                        
                        <div class="row flex-grow">
                          <div class="col-md-6 col-lg-6 grid-margin stretch-card">
                            <div class="card card-rounded">
                              <div class="card-body card-rounded">
                                <h4 class="card-title  card-title-dash">Recent Events</h4>
                                <div class="list align-items-center border-bottom py-2">
                                  <div class="wrapper w-100">
                                    <p class="mb-2 font-weight-medium">
                                      Change in Directors
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center">
                                      <div class="d-flex align-items-center">
                                        <i class="mdi mdi-calendar text-muted me-1"></i>
                                        <p class="mb-0 text-small text-muted">Mar 14, 2019</p>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <div class="list align-items-center border-bottom py-2">
                                  <div class="wrapper w-100">
                                    <p class="mb-2 font-weight-medium">
                                      Other Events
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center">
                                      <div class="d-flex align-items-center">
                                        <i class="mdi mdi-calendar text-muted me-1"></i>
                                        <p class="mb-0 text-small text-muted">Mar 14, 2019</p>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <div class="list align-items-center border-bottom py-2">
                                  <div class="wrapper w-100">
                                    <p class="mb-2 font-weight-medium">
                                      Quarterly Report
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center">
                                      <div class="d-flex align-items-center">
                                        <i class="mdi mdi-calendar text-muted me-1"></i>
                                        <p class="mb-0 text-small text-muted">Mar 14, 2019</p>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <div class="list align-items-center border-bottom py-2">
                                  <div class="wrapper w-100">
                                    <p class="mb-2 font-weight-medium">
                                      Change in Directors
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center">
                                      <div class="d-flex align-items-center">
                                        <i class="mdi mdi-calendar text-muted me-1"></i>
                                        <p class="mb-0 text-small text-muted">Mar 14, 2019</p>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                
                                <div class="list align-items-center pt-3">
                                  <div class="wrapper w-100">
                                    <p class="mb-0">
                                      <a href="#" class="fw-bold text-primary">Show all <i class="mdi mdi-arrow-right ms-2"></i></a>
                                    </p>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                          <div class="col-md-6 col-lg-6 grid-margin stretch-card">
                            <div class="card card-rounded">
                              <div class="card-body">
                                <div class="d-flex align-items-center justify-content-between mb-3">
                                  <h4 class="card-title card-title-dash">Activities</h4>
                                  <p class="mb-0">20 finished, 5 remaining</p>
                                </div>
                                <ul class="bullet-line-list">
                                  <li>
                                    <div class="d-flex justify-content-between">
                                      <div><span class="text-light-green">Ben Tossell</span> assign you a task</div>
                                      <p>Just now</p>
                                    </div>
                                  </li>
                                  <li>
                                    <div class="d-flex justify-content-between">
                                      <div><span class="text-light-green">Oliver Noah</span> assign you a task</div>
                                      <p>1h</p>
                                    </div>
                                  </li>
                                  <li>
                                    <div class="d-flex justify-content-between">
                                      <div><span class="text-light-green">Jack William</span> assign you a task</div>
                                      <p>1h</p>
                                    </div>
                                  </li>
                                  <li>
                                    <div class="d-flex justify-content-between">
                                      <div><span class="text-light-green">Leo Lucas</span> assign you a task</div>
                                      <p>1h</p>
                                    </div>
                                  </li>
                                  <li>
                                    <div class="d-flex justify-content-between">
                                      <div><span class="text-light-green">Thomas Henry</span> assign you a task</div>
                                      <p>1h</p>
                                    </div>
                                  </li>
                                  <li>
                                    <div class="d-flex justify-content-between">
                                      <div><span class="text-light-green">Ben Tossell</span> assign you a task</div>
                                      <p>1h</p>
                                    </div>
                                  </li>
                                  <li>
                                    <div class="d-flex justify-content-between">
                                      <div><span class="text-light-green">Ben Tossell</span> assign you a task</div>
                                      <p>1h</p>
                                    </div>
                                  </li>
                                </ul>
                                <div class="list align-items-center pt-3">
                                  <div class="wrapper w-100">
                                    <p class="mb-0">
                                      <a href="#" class="fw-bold text-primary">Show all <i class="mdi mdi-arrow-right ms-2"></i></a>
                                    </p>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="col-lg-4 d-flex flex-column">
                        
                        <div class="row flex-grow">
                          <div class="col-12 grid-margin stretch-card">
                            <div class="card card-rounded">
                              <div class="card-body">
                                <div class="row">
                                  <div class="col-lg-12">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                      <h4 class="card-title card-title-dash">Total number of new users</h4>
                                    </div>
                                    <canvas class="my-auto" id="doughnutChart" height="200"></canvas>
                                    <div id="doughnut-chart-legend" class="mt-5 text-center"></div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="row flex-grow">
                          <div class="col-12 grid-margin stretch-card">
                            <div class="card card-rounded">
                              <div class="card-body">
                                <div class="row">
                                  <div class="col-lg-12">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                      <div>
                                        <h4 class="card-title card-title-dash">Leave Report</h4>
                                      </div>
                                      <div>
                                        <div class="dropdown">
                                          <button class="btn btn-secondary dropdown-toggle toggle-dark btn-lg mb-0 me-0" type="button" id="dropdownMenuButton3" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Month Wise </button>
                                          <div class="dropdown-menu" aria-labelledby="dropdownMenuButton3">
                                            <h6 class="dropdown-header">week Wise</h6>
                                            <a class="dropdown-item" href="#">Year Wise</a>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                    <div class="mt-3">
                                      <canvas id="leaveReport"></canvas>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="row flex-grow">
                          <div class="col-12 grid-margin stretch-card">
                            <div class="card card-rounded">
                              <div class="card-body">
                                <div class="row">
                                  <div class="col-lg-12">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                      <div>
                                        <h4 class="card-title card-title-dash">Top Performer</h4>
                                      </div>
                                    </div>
                                    <div class="mt-3">
                                      <div class="wrapper d-flex align-items-center justify-content-between py-2 border-bottom">
                                        <div class="d-flex">
                                          <img class="img-sm rounded-10" src="images/faces/face1.jpg" alt="profile">
                                          <div class="wrapper ms-3">
                                            <p class="ms-1 mb-1 fw-bold">Brandon Washington</p>
                                            <small class="text-muted mb-0">162543</small>
                                          </div>
                                        </div>
                                        <div class="text-muted text-small">
                                          1h ago
                                        </div>
                                      </div>
                                      <div class="wrapper d-flex align-items-center justify-content-between py-2 border-bottom">
                                        <div class="d-flex">
                                          <img class="img-sm rounded-10" src="images/faces/face2.jpg" alt="profile">
                                          <div class="wrapper ms-3">
                                            <p class="ms-1 mb-1 fw-bold">Wayne Murphy</p>
                                            <small class="text-muted mb-0">162543</small>
                                          </div>
                                        </div>
                                        <div class="text-muted text-small">
                                          1h ago
                                        </div>
                                      </div>
                                      <div class="wrapper d-flex align-items-center justify-content-between py-2 border-bottom">
                                        <div class="d-flex">
                                          <img class="img-sm rounded-10" src="images/faces/face3.jpg" alt="profile">
                                          <div class="wrapper ms-3">
                                            <p class="ms-1 mb-1 fw-bold">Katherine Butler</p>
                                            <small class="text-muted mb-0">162543</small>
                                          </div>
                                        </div>
                                        <div class="text-muted text-small">
                                          1h ago
                                        </div>
                                      </div>
                                      <div class="wrapper d-flex align-items-center justify-content-between py-2 border-bottom">
                                        <div class="d-flex">
                                          <img class="img-sm rounded-10" src="images/faces/face4.jpg" alt="profile">
                                          <div class="wrapper ms-3">
                                            <p class="ms-1 mb-1 fw-bold">Matthew Bailey</p>
                                            <small class="text-muted mb-0">162543</small>
                                          </div>
                                        </div>
                                        <div class="text-muted text-small">
                                          1h ago
                                        </div>
                                      </div>
                                      <div class="wrapper d-flex align-items-center justify-content-between pt-2">
                                        <div class="d-flex">
                                          <img class="img-sm rounded-10" src="images/faces/face5.jpg" alt="profile">
                                          <div class="wrapper ms-3">
                                            <p class="ms-1 mb-1 fw-bold">Rafell John</p>
                                            <small class="text-muted mb-0">Alaska, USA</small>
                                          </div>
                                        </div>
                                        <div class="text-muted text-small">
                                          1h ago
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
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

  <!-- jQuery -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <!-- SweetAlert2 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.all.min.js"></script>
  <script src="./js/alertModal.js"></script>

  <!-- plugins:js -->
  <script src="vendors/js/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page -->
  <script src="vendors/chart.js/Chart.min.js"></script>
  <script src="vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
  <script src="vendors/progressbar.js/progressbar.min.js"></script>

  <!-- End plugin js for this page -->
  <!-- inject:js -->
  <script src="js/off-canvas.js"></script>
  <script src="js/hoverable-collapse.js"></script>
  <script src="js/template.js"></script>
  <script src="js/settings.js"></script>
  <script src="js/todolist.js"></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src="js/dashboard.js"></script>
  <script src="js/Chart.roundedBarCharts.js"></script>
  <script src="./js/aGetTotalWeek.js"></script>

  <!-- End custom js for this page-->
</body>

</html>

