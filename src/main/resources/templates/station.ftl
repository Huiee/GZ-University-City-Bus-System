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
  <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

  <!--external css-->
  <link href="/css/font-awesome.css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="/css/style.css" rel="stylesheet">
  <link href="/css/style-responsive.css" rel="stylesheet">

  
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
      <#if user_id??>
        <div class="nav notify-row" id="top_menu">
          <!--  顶部中间 start -->
          <ul class="nav top-menu">
            <!-- 最近站点 start-->
            <li id="header_inbox_bar" class="dropdown">
              <a data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
                <i  class="glyphicon glyphicon-map-marker"></i>
                <#if user_show_hisotry??>
                  <span class="badge bg-theme">${user_show_hisotry?size!}</span>
                </#if>
              </a>
              <ul class="dropdown-menu extended inbox">
                <div class="notify-arrow notify-arrow-green"></div>
                <li><p class="green">最近常去地点</p></li>
                <#--                  站点详情-->
                <#if user_show_hisotry??>
                  <#assign show_his=0>
                  <#list user_show_hisotry as his>
                    <#assign show_his=show_his+1>
                    <#if show_his lt 5>
                      <li><a href="/searchBusByStationName?station_name=${his.station_name!}">
                          <span class="glyphicon glyphicon-map-marker" style="float: left;color: #17a9a9" aria-hidden="true"></span>
                          <span class="subject">
                  <span class="from" style="float: left;" >&nbsp;&nbsp;${his.station_name!}</span>
                  </span>
                        </a></li>
                    </#if>
                  </#list>
                <#else>
                  <li><a href="">暂无</a></li>
                </#if>
              </ul>
            </li>
            <!-- 最近站点 end -->
            <!-- 收藏 start-->
            <li id="header_notification_bar" class="dropdown">
              <a data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
                <i class="fa fa-tasks"></i>
                <#if user_note_collect ??>
                  <span class="badge bg-warning">${user_note_collect?size!}</span>
                </#if>
              </a>
              <ul class="dropdown-menu extended notification">
                <div class="notify-arrow notify-arrow-yellow"></div>
                <li>
                  <p class="yellow">我的收藏</p>
                </li>
                <#if user_note_collect ??>
                  <#list user_note_collect as collect>
                    <li>
                      <a href="/checkNote?note_time=${collect.note_time!}">
                        <span class="label label-danger"><i class="fa fa-bolt"></i></span>
                        ${collect.note_title!}
                        <span class="small italic">${collect.note_time?substring(5,11)}</span>
                      </a>
                    </li>
                  </#list>
                  <li><a href="/showNoteTitle">See all collect</a></li>
                <#else>
                  <li><a href="/showNoteTitle">暂无</a></li>
                </#if>
              </ul>
            </li>
            <!-- 收藏 end -->

            <!-- 行程提醒 start-->
            <#if notes_clock ??>
              <#assign num=0>
              <#list notes_clock as clock>
                <#assign num=num+1>
                <#if num=1>
                  <li id="header_notification_bar" class="dropdown">
                <#--                显示提醒内容-->
                  <a data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
                    <i class="fa fa-bell-o"></i>
                    <span class="small">
                    <#if clock.note?length  gt 40>
                      ${clock.note?substring(0,40)!}...
                    <#else>
                      ${clock.note!}
                    </#if>
                </span>
                    <span class="badge" style="background-color: #ff3737;">${notes_clock?size!}</span>
                  </a>
                  <ul class="dropdown-menu extended notification">
                  <div style="border-color: transparent transparent #bb1717;border-bottom-color: #bb1717 !important;border-top-color: #bb1717 !important;" ></div>
                  <li><p style="background-color: #bb1717;color: white;">今日提醒</p></li>
                </#if>
              <#--                提醒详情-->
                <li>
                  <a href="/checkNote?note_time=${clock.note_time!}" style="white-space: normal;">
                    <span class="label label-danger"><i class="fa fa-bolt"></i></span>
                    <span style="width: 200px">
            <#if clock.note?length  gt 40>
              ${clock.note?substring(0,40)!}...
            <#else>
              ${clock.note!}
            </#if>
            </span>
                  </a>
                </li>
              </#list>
              </ul>
              </li>
            </#if>
          </ul>
          <!--  行程提醒 end -->
        </div>
      </#if>
      <div class="top-menu">
        <#--          右侧登录退出返回-->
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
          <p class="centered"><#if user_id??><a href="/showUserMessage"></#if>
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
              <a href="/showLogin"> 未登录</a>
            </#if>
            </h5>
          <li class="mt">
            <a href="/showCover">
              <i class="fa fa-dashboard"></i>
              <span>线路查询</span>
              </a>
          </li>
          <li class="sub-menu">
            <a class="active"  >
              <i class="fa fa-desktop"></i>
              <span>站点查询</span>
              </a>
            <ul class="sub" style="display: block">
              <li><a href="/station">公交站点名称</a></li>
              <li><a href="/showBusNumber">公交线路号码</a></li>

            </ul>
          </li>
          <#if admin_id??>
            <li class="sub-menu">
              <a href="javascript:;">
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
                <li ><a href="/showAllUserMes">查看用户</a></li>
              </ul>
            </li>
          </#if>
          <#if user_id??>
          <li class="sub-menu">
            <a href="javascript:;">
              <i class="fa fa-calendar-o"></i>
              <span>历史记录</span>
            </a>
            <ul class="sub">
              <li><a href="/showHistory">查看历史记录</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="javascript:;">
              <i class="fa fa-book"></i>
              <span>行程记事本</span>
            </a>
            <ul class="sub">
              <li><a href="/showNoteTitle">查看记事本</a></li>
              <li class="active"><a href="/showAddNote">添加记事本</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="javascript:;">
              <i class="fa fa-tasks"></i>
              <span>个人信息</span>
            </a>
            <ul class="sub">
              <li><a href="/showUserMessage">查看个人信息</a></li>
            </ul>
          </li>
          </#if>

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
<#--            <p>Place your content here.</p>-->
<#--          </div>-->
<#--          搜索-->
          <div class="col-lg-12">
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
              <div class="custom-box">
                <div class="servicetitle">
                  <h4>站点查询</h4>
                  <hr>
                </div>
                <p>广州大学城公交线路查询——公交站点</p>
                <form action="/searchBusByStationName" method="post" name="busStation">
                  <table>
                    <tr>
                      <td style="width: 850px; padding: 2px 20px;">
                        <input class="form-control form-control-inline input-medium default-date-picker" name="station_name" size="16" type="text" value="" placeholder="请输入公交车站">
                      </td>
                      <td style="padding: 20px 20px;"> <button type="button" class="btn btn-theme"onclick="return checkStationName()">查询</button></td>

                    </tr>
                  </table>
                  <br>

                </form>
              </div>
              <!-- end custombox -->
            </div>

          </div>
<#--          搜索  end-->
<#--          结果-- start-->
<#if busStation ??>
 <div class="col-lg-12">
   <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
     <#assign num =0>
     <#list busStation as bus>
     <#list busMes as busMes>
     <#assign num=num+1>
     <#if num=1>
     <div class="custom-box">
       <div class="servicetitle">
         <h4>${bus.station_name!}</h4> <hr>
       </div>
       <p>途经线路公交信息——公交站点</p>
       <form>
         <table>
           <#else>
           <#if bus_name != bus.station_name>
         </table>
         <br>
       </form>
     </div>
     <div class="custom-box">
       <div class="servicetitle">
         <h4>${bus.station_name!}</h4> <hr>
       </div>
       <p>途经线路公交信息——公交站点</p>
       <form>
         <table>
           </#if>
           </#if>

         <#if bus.go_number??>
            <#if (bus.bus_number==busMes.bus_number) && busMes.direction=="go">
         <tr>
           <td style="width: 180px; padding: 20px 20px;">
           <a href="/searchBusByNumber?bus_number=${bus.bus_number}"> ${bus.bus_number!}路</a>
           </td>
           <td style="width: 850px; padding: 20px 20px; text-align: left;">
             开往${busMes.end_station!}方向 |全程${busMes.length!}|票价${busMes.price!}元
           </td>
         </tr>
            </#if>
</#if>
           <#if bus.back_number??>
            <#if (bus.bus_number==busMes.bus_number)&& busMes.direction=="back">
         <tr>
           <td style="width:180px; padding: 20px 20px;">
             <a href="/searchBusByNumber?bus_number=${bus.bus_number}"> ${bus.bus_number!}路</a>
           </td>
           <td style="width: 850px; padding: 20px 20px;text-align: left;">
             开往${busMes.end_station!}方向 |全程${busMes.length!}|票价${busMes.price!}元
           </td>
         </tr>
            </#if>
         </#if>
         <#assign bus_name = bus.station_name>
         </#list>
        </#list>
                  </table>
                  <br>
                </form>
              </div>
              <!-- end custombox -->
            </div>
          </div>
</#if>
<#--          结果 -- end-->
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
          &copy; H_Yi_Lee<strong>Dashio</strong>. All Rights Reserved
        </p>
        <div class="credits">
          Guangzhou University City public transport query system <a target="_blank" title="广州大学城公交查询系统">广州大学城公交查询系统</a> - Collect from <a title="网页模板" target="_blank">网页模板</a>
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

</body>

</html>
