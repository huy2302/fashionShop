<nav class="sidebar sidebar-offcanvas" id="sidebar">
  <ul class="nav">
    <li class="nav-item">
      <a class="nav-link" href="../../index.asp">
        <i class="mdi mdi-grid-large menu-icon"></i>
        <span class="menu-title">Dashboard</span>
      </a>
    </li>
    <li class="nav-item nav-category">User Manager</li>
    <li class="nav-item">
      <a class="nav-link" data-bs-toggle="collapse" href="#admin" aria-expanded="false" aria-controls="ui-basic">
        <i class="menu-icon mdi mdi-account-box"></i>
        <span class="menu-title">Admin</span>
        <i class="menu-arrow"></i> 
      </a>
      <div class="collapse" id="admin">
        <ul class="nav flex-column sub-menu">
          <li class="nav-item"> <a class="nav-link" href="/fashionshop/views/admin/pages/user/allemployee.asp">All employee</a></li>
          <li class="nav-item"> <a class="nav-link" href="/fashionshop/views/admin/pages/user/addemployee.asp">Add employee</a></li>
        </ul>
      </div>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-bs-toggle="collapse" href="#user" aria-expanded="false" aria-controls="ui-basic">
        <i class="menu-icon mdi mdi-account-box"></i>
        <span class="menu-title">User</span>
        <i class="menu-arrow"></i> 
      </a>
      <div class="collapse" id="user">
        <ul class="nav flex-column sub-menu">
          <li class="nav-item"> <a class="nav-link" href="/fashionshop/views/admin/pages/user/alluser.asp">All user</a></li>
          <li class="nav-item"> <a class="nav-link" href="/fashionshop/views/admin/pages/user/adduser.asp">Add user</a></li>
        </ul>
      </div>
    </li>
    <li class="nav-item nav-category">Product</li>
    <li class="nav-item">
      <a class="nav-link" data-bs-toggle="collapse" href="#product" aria-expanded="false" aria-controls="ui-basic">
        <i class="menu-icon mdi mdi-briefcase-check"></i>
        <span class="menu-title">Products</span>
        <i class="menu-arrow"></i> 
      </a>
      <div class="collapse" id="product">
        <ul class="nav flex-column sub-menu">
          <li class="nav-item"> <a class="nav-link" href="/fashionshop/views/admin/pages/product/allproduct.asp">All products</a></li>
          <li class="nav-item"> <a class="nav-link" href="/fashionshop/views/admin/pages/product/addproduct.asp">Add product</a></li>
          <li class="nav-item"> <a class="nav-link" href="/fashionshop/views/admin/pages/product/saleProduct.asp">Sale product</a></li>
          <li class="nav-item"> <a class="nav-link" href="/fashionshop/views/admin/pages/product/addSaleCampaign.asp">Create a discount campaign</a></li>
          <li class="nav-item"> <a class="nav-link" href="/fashionshop/views/admin/pages/product/allCampaign.asp">All Campaign</a></li>
        </ul>
      </div>
    </li>
    <li class="nav-item nav-category">Sales</li>
    <li class="nav-item">
      <a class="nav-link" data-bs-toggle="collapse" href="#sales" aria-expanded="false" aria-controls="ui-basic">
        <i class="menu-icon mdi mdi-chart-areaspline"></i>
        <span class="menu-title">Revenue</span>
        <i class="menu-arrow"></i> 
      </a>
      <div class="collapse" id="sales">
        <ul class="nav flex-column sub-menu">
          <li class="nav-item"> <a class="nav-link" href="/fashionshop/views/admin/pages/revenue/all_revenue.asp">Sales Chart</a></li>
          <li class="nav-item"> <a class="nav-link" href="/fashionshop/views/admin/pages/revenue/allBill.asp">Order List</a></li>
        </ul>
      </div>
    </li>
    
  </ul>
</nav>