<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="H_Yi_Lee">
  <meta name="keyword" content="H_Yi_Lee, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
  <title>广州大学城公交查询系统</title>

  <!-- Favicons -->
  <link href="/../images/favicon.png" rel="icon">
  <link href="/../images/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Bootstrap core CSS -->
  <link href="/../css/bootstrap.min.css" rel="stylesheet">
  <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

  <!--external css-->
  <link href="/css/font-awesome.css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="/css/style.css" rel="stylesheet">
  <link href="/css/style-responsive.css" rel="stylesheet">
  <link href="/css/common.css" rel="stylesheet">

  
</head>

<body>
  <section id="container">
    <!-- **********************************************************************************************************************************************************
        TOP BAR CONTENT & NOTIFICATIONS
        *********************************************************************************************************************************************************** -->
    <!--header start-->
    <header class="header black-bg">
      <div class="sidebar-toggle-box">
        <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
      </div>
      <!--logo start-->
      <a class="logo"><b>广州大学城<span>公交查询系统</span></b></a>
      <!--logo end-->
      <div class="top-menu">
        <ul class="nav pull-right top-menu">
          <#if user_id?? >
            <li><a class="logout" href="javascript:history.back(-1)">返回</a></li>
            <li><a class="logout" href="/exit">退出</a></li>
          <#else>
            <#if admin_id??><#else>
              <li><a class="logout" href="/showLogin">登录</a></li>
            </#if>
          </#if>
          <#if admin_id??>
            <li><a class="logout" href="javascript:history.back(-1)">返回</a></li>
            <li><a class="logout" href="/exitAdmin">退出</a></li>
          </#if>
        </ul>
      </div>
    </header>
    <!--header end-->
    <!-- **********************************************************************************************************************************************************
        MAIN SIDEBAR MENU
        *********************************************************************************************************************************************************** -->
    <!--sidebar start-->
    <aside>
      <div id="sidebar" class="nav-collapse ">
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">
          <p class="centered"><a href="profile.html">
              <#if user_picture ??>
                <img src="/../images/${user_picture!}" class="img-circle" width="80"  height="80">
              <#else >
                <img src="/../images/p1.jpg" class="img-circle" width="80"  height="80">
              </#if>
            </a>
          </p>
          <h5 class="centered">
            <#if user_name ??>
            ${user_name!}
              <#else >
            <a href="/showLogin" style="color: white"> 未登录</a>
            </#if>
            </h5>
          <li class="mt">
            <a  href="/showCover">
              <i class="fa fa-dashboard"></i>
              <span>线路查询</span>
              </a>
          </li>
          <li class="sub-menu">
            <a href="/station">
              <i class="fa fa-desktop"></i>
              <span>站点查询</span>
              </a>
            <ul class="sub" style="display: block">
              <li><a href="/station">公交站点名称</a></li>
              <li><a href="/showBusNumber">公交线路号码</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a class="active" href="javascript:;">
              <i class="fa fa-cogs"></i>
              <span>公交线路管理</span>
              </a>
            <ul class="sub">
              <li><a href="/showAddBus">增加公交线路</a></li>
              <li><a href="/showUpdateBus">修改公交线路</a></li>
              <li><a href="/showDeleteBus">删除公交线路</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="javascript:;">
              <i class="fa fa-book"></i>
              <span>用户管理</span>
              </a>
            <ul class="sub">
              <li class="active"><a href="/showAllUserMes">查看用户</a></li>
            </ul>
          </li>



        <!-- sidebar menu end-->
      </div>
    </aside>
    <!--sidebar end-->
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper site-min-height">
<#--        <h3><i class="fa fa-angle-right"></i> Blank Page</h3>-->
        <div class="row mt">
<#--          <div class="col-lg-12">-->
<#--         搜索-->
            <div class="col-lg-12">
              <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                <div class="custom-box">
                  <div class="servicetitle">
                    <h4>公交线路管理</h4>
                    <hr>
                  </div>
                  <p>广州大学城公交线路增加</p>
              <form action="/showAddTable.do " method="post" name="showAddTable">
                 <table>
                   <tr>
                     <td style="width: 850px; padding: 2px 20px;">
                       <input class="form-control form-control-inline input-medium default-date-picker" name="add_number" size="16" type="text" value="${addNumber!}" placeholder="请输入增加行数">
                     </td>
                     <td>
                       <button type="button" class="btn btn-theme"onclick="return checkAddNumber()">确定</button>
                     </td>
                   </tr>
                 </table>
              </form>

                </div>
                <!-- end custombox -->
              </div>
              </div>
<#-- 搜索 -- end -->

<#--  结果 --- s --->
<#--  显示输入 ----  start --->
          <#if addNumber ??>
            <div class="col-lg-12">
              <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                <div class="custom-box">
                  <div class="servicetitle">
                    <h4>增加线路</h4>
                    <hr>
                  </div>
                  <form action="/addBus.do" method="post">
                    <p>
                      <input class="form-control form-control-inline input-medium default-date-picker" name="bus_number" size="16" type="text" value="" placeholder="请输入公交线路号码">
                    </p>
                    <table style="text-align: left;">
                      <tr>
                        <td style=" padding: 20px 20px;text-align: center" colspan="2">
                          <input type="radio" name="time" value="白天">白天</td>
                        <td style=" padding: 20px 20px; text-align: center" colspan="2">
                          <input type="radio" name="time" value="夜班" >夜班
                        </td>
                      </tr>
                      <tr style="text-align: center ;padding: 20px 20px; width: 350px">
                        <td width="5px">方向1</td>
                        <td style=" padding: 20px 36px;     width: 40%">
                          <input name="go_end_station" size="2" type="text" value="" placeholder="请输入方向1终点站"  class="form-control form-control-inline input-medium default-date-picker">
                        </td>
                        <td  width="5px">方向2</td>
                        <td style=" padding: 20px 36px;     width: 40%">
                          <input name="back_end_station" size="2" type="text" value=""  placeholder="请输入方向2终点站" class="form-control form-control-inline input-medium default-date-picker">
                        </td>
                      </tr>

                      <tr>
                        <td style="padding: 20px 35px; width: 450px" colspan="2">
                          <input  name="go_start_time" size="2" type="text" value="" placeholder="首班车时间" class="form-control form-control-inline input-medium default-date-picker">
                        </td>
                        <td style="padding: 20px 35px; width: 450px" colspan="2">
                          <input  name="back_start_time" size="2" type="text" value="" placeholder="首班车时间" class="form-control form-control-inline input-medium default-date-picker">
                        </td>
                      </tr>
                      <tr>
                        <td style="padding: 20px 35px; width: 450px" colspan="2">
                          <input  name="go_end_time" size="2" type="text" value="" placeholder="末班车时间" class="form-control form-control-inline input-medium default-date-picker">
                        </td>
                        <td style="padding: 20px 35px; width: 450px" colspan="2">
                          <input  name="back_end_time" size="2" type="text" value="" placeholder="末班车时间" class="form-control form-control-inline input-medium default-date-picker">
                        </td>
                      </tr>
                      <tr>
                        <td style="padding: 20px 35px; width: 450px" colspan="2">
                          <input  name="go_length" size="2" type="text" value="" placeholder="全程总长(单位：公里)" class="form-control form-control-inline input-medium default-date-picker">
                        </td>
                        <td style="padding: 20px 35px; width: 450px" colspan="2">
                          <input  name="back_length" size="2" type="text" value="" placeholder="全程总长(单位：公里)" class="form-control form-control-inline input-medium default-date-picker">
                        </td>
                      </tr>
                      <tr>
                        <td style="padding: 20px 35px; width: 450px" colspan="2">
                          <input  name="go_price" size="2" type="text" value="" placeholder="票价(单位：元)" class="form-control form-control-inline input-medium default-date-picker">
                        </td>
                        <td style="padding: 20px 35px; width: 450px" colspan="2">
                          <input  name="back_price" size="2" type="text" value="" placeholder="票价(单位：元)" class="form-control form-control-inline input-medium default-date-picker">
                        </td>
                      </tr>
                    </table>

                    <table style="text-align: center">
                      <tr>
                        <th style=" padding: 20px 20px;     width: 75px">方向1</th>
                        <th style=" padding: 20px 20px;">站点名</th>
                        <th style=" padding: 20px 20px;    width: 75px">方向2</th>
                        <th style=" padding: 20px 20px;">是否有BRT</th>
                        <th style=" padding: 20px 20px;">途经地铁线路</th>
                      </tr>
                      <#list 1..addNumber?number as i>
                        <tr>
                          <td style=" padding: 20px 16px;     width: 75px">
                            <input name="go_number_${i}" size="2" type="text" value="${i!}"  class="form-control form-control-inline input-medium default-date-picker">
                          </td>
                          <td style=" padding: 20px 20px;     width: 250px">
                            <input  name="station_name_${i}" size="2" type="text" value="" placeholder="请输入公交站点" class="form-control form-control-inline input-medium default-date-picker">
                          </td>
                          <td style=" padding: 20px 16px;     width: 75px">
                            <input  name="back_number_${i}" size="2" type="text" value="" class="form-control form-control-inline input-medium default-date-picker">
                          </td>
                          <td style=" padding: 20px 20px;">
                            <input type="checkbox" value="true" name="is_brt_${i}" >有
                          </td>
                          <td style=" padding: 20px 20px;width: 250px" >
                            <input name="subway_${i}" size="2" type="text" value="" placeholder="如有输入线路号码"  class="form-control form-control-inline input-medium default-date-picker">
                          </td>

                        </tr>
                      </#list>
                      <tr>
                        <td colspan="5" style="text-align: right;">
                          <button type="submit" class="btn btn-theme">增加</button>
                        </td>
                      </tr>
                    </table>
                  </form>

                </div>
              </div>
            </div>
</#if>
<#--显示输入 -- end -->
          </div>
        </div>
      </section>
      <!-- /wrapper -->
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
    <!--footer start-->
    <footer class="site-footer">
      <div class="text-center">
        <p>
          &copy; <strong>H_Yi_Lee</strong>. All Rights Reserved
        </p>
        <div class="credits">
          Guangzhou University City public transport query system <a target="_blank" title="广州大学城公交查询系统">广州大学城公交查询系统</a> - Collect from <a  target="_blank">毕业设计</a>
        </div>
        <a href="blank.html#" class="go-top">
          <i class="fa fa-angle-up"></i>
          </a>
      </div>
    </footer>
    <!--footer end-->
  </section>
  <!-- js placed at the end of the document so the pages load faster -->
  <script src="/js/jquery.min.js"></script>
  <script src="/js/show.js"></script>
  <script src="/js/check.js"></script>

  <script src="/js/bootstrap.min.js"></script>
  <script src="/../jquery-ui-1.9.2.custom.min.js"></script>
  <script src="/../jquery.ui.touch-punch.min.js"></script>
  <script class="include" type="text/javascript" src="/js/jquery.dcjqaccordion.2.7.js"></script>
  <script src="/js/jquery.scrollTo.min.js"></script>
  <script src="/js/jquery.nicescroll.js" type="text/javascript"></script>
  <!--common script for all pages-->
  <script src="/js/common-scripts.js"></script>
  <!--script for this page-->
  <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

</body>

</html>
