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
  <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

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

<#--  日历-->
  <link href="https://cdn.bootcss.com/zabuto_calendar/1.6.4/zabuto_calendar.css" rel="stylesheet">
  <link href="https://cdn.bootcss.com/zabuto_calendar/1.6.4/zabuto_calendar.min.css" rel="stylesheet">
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
      <div class="nav notify-row" id="top_menu">
        <!--  notification start -->
        <ul class="nav top-menu">
          <!-- inbox dropdown start-->
          <li id="header_inbox_bar" class="dropdown">
            <a data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
              <i  class="glyphicon glyphicon-map-marker"></i>
              <#if user_show_hisotry??>
                <span class="badge bg-theme">${user_show_hisotry?size!}</span>
              </#if>
            </a>
            <ul class="dropdown-menu extended inbox">
              <div class="notify-arrow notify-arrow-green"></div>
              <li>
                <p class="green">最近常去地点</p>
              </li>
              <#if user_show_hisotry??>
                <#assign show_his=0>
                <#list user_show_hisotry as his>
                  <#assign show_his=show_his+1>
                  <#if show_his lt 5>
                    <li>
                      <a href="/searchBusByStationName?station_name=${his.station_name!}">
                        <span class="glyphicon glyphicon-map-marker" style="float: left;color: #17a9a9" aria-hidden="true"></span>
                        <span class="subject">
                  <span class="from" style="float: left;" >&nbsp;&nbsp;${his.station_name!}</span>
                  </span>
                      </a>
                    </li>
                  </#if>
                </#list>
              <#else>
                <li>
                  <a href="">暂无</a>
                </li>
              </#if>
            </ul>

            <!-- inbox dropdown end -->
            <!-- notification dropdown start-->
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
                <li>
                  <a href="/showNoteTitle">See all collect</a>
                </li>
              <#else>
                <li>
                  <a href="/showNoteTitle">暂无</a>
                </li>
              </#if>
            </ul>
          </li>
          <!-- notification dropdown end -->
          <#if notes_clock ??>
          <!-- notification dropdown start-->
          <#assign num=0>
          <#list notes_clock as clock>
          <#assign num=num+1>
          <#if num=1>
          <li id="header_notification_bar" class="dropdown">
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
              <div style="border-color: transparent transparent #bb1717;border-bottom-color: #bb1717 !important;border-top-color: #bb1717 !important;" "></div>
      <li>
        <p style="background-color: #bb1717;color: white;">今日提醒</p>
      </li>
      </#if>
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
        <!--  notification end -->
      </div>
      <div class="top-menu">
        <ul class="nav pull-right top-menu">
          <li><a class="logout" href="/exit">退出</a></li>
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
                <img src="/../images/${user_picture!}" class="img-circle"  width="80" height="80">
              <#else >
                <img src="/../images/p1.jpg" class="img-circle"  width="80" height="80">
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
            <a href="javascript:;" class="active">
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
<#--      start-->
        <div class="row mt">

          <div class="col-sm-9">
            <section class="panel">
              <header class="panel-heading wht-bg">
                <h4 class="gen-case">
                  History
                  <form action="" class="pull-right mail-src-position">
                    <div class="input-append">
                      <input type="text" class="form-control " placeholder="Search History">
                    </div>
                  </form>
                </h4>
              </header>
              <div class="panel-body minimal">
                <div class="mail-option">
                  <div class="chk-all">

                    <div class="btn-group">
                      <a data-toggle="dropdown" href="#" class="btn mini all">
                        查询类型
                        <i class="fa fa-angle-down "></i>
                      </a>
                      <ul class="dropdown-menu">
                        <li><a href="/searchHistoryByType?history_type=线路查询"><i class="fa fa-location-arrow"></i>&nbsp;&nbsp;线路查询</a></li>
                        <li class="divider"></li>
                        <li><a href="/searchHistoryByType?history_type=站点查询"><i class="fa fa-map-marker"></i>&nbsp;&nbsp;站点查询</a></li>
                        <li class="divider"></li>
                        <li><a href="/searchHistoryByType?history_type=公交查询"><i class="fa fa-car"></i>&nbsp;&nbsp;公交查询</a></li>
                        <li class="divider"></li>
                        <li><a href="/showHistory"><i class="fa fa-bars"></i>&nbsp;&nbsp;全部</a></li>
                      </ul>
                    </div>

                  </div>
                  <div class="btn-group">
                    <a data-original-title="Refresh" data-placement="top" data-toggle="dropdown" href="#" class="btn mini tooltips">
                      <i class=" fa fa-refresh"></i>
                    </a>
                  </div>
                </div>
                <div class="table-inbox-wrap ">
                  <table class="table table-inbox table-hover">
                    <tbody>
                    <#if history??>
                    <#list history as his>
                    <tr class="">
                      <td class="inbox-small-cells">
                        <input type="checkbox" class="mail-checkbox">
                      </td>
                      <#if his.history_type=="线路查询">
                      <td class="inbox-small-cells">
                        <i class="fa fa-star"></i>
                          <span class="label label-info label-mini">线路查询</span>
                       </td>
                        <td class="view-message  dont-show"><a onclick="location.href='/searchBusChange.do?start=${his.start!}&&end=${his.destination!}'">${his.start!}->${his.destination!}</a></td>

                      </#if>
                      <#if his.history_type=="站点查询">
                      <td class="inbox-small-cells">
                        <i class="fa fa-star"></i>
                        <span class="label label-warning label-mini">站点查询</span>
                      </td>
                        <td class="view-message  dont-show"><a onclick="location.href='/searchBusByStationName?station_name=${his.station_name!}'">${his.station_name}</a></td>

                      </#if>
                      <#if his.history_type=="公交查询">
                      <td class="inbox-small-cells">
                        <i class="fa fa-star"></i>
                        <span class="label label-success label-mini">公交查询</span>
                      </td>
                        <td class="view-message  dont-show"><a onclick="location.href='/searchBusByNumber?bus_number=${his.bus_number}'">${his.bus_number}</a></td>
                      </#if>
                      <td class="inbox-small-cells"><a onclick="location.href='/deleteHistory?history_time=${his.history_time}'"><i class="fa fa-trash-o "></i></a></td>
                      <td class="view-message "></td>
                      <td class="view-message  inbox-small-cells"><i class="fa fa-paperclip"></i></td>
                      <td class="view-message  text-right">${his.history_time!}</td>
                    </tr>
                    </#list>
                      <#else >
                    <tr class="unread">
                       <td class="view-message dont-show">
                        <a >还没有历史记录~ 快去查询吧</a></td>
                    </tr>
                    </#if>
                    </tbody>
                  </table>
                </div>
              </div>
            </section>
          </div>

          <div class="col-sm-3">
            <#--            天气-->
            <section class="panel">
              <div class="panel-body" style="padding:2.5px">
                <div id="weather-view-he"></div>
              </div>
            </section>
<#--            日历-->
            <section class="panel" style="background: #4ECDC4">
              <div class="panel-body">
                <div id="my-calendar"></div>
              </div>
            </section>

          </div>
        </div>
<#--       end-->
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
   <script src="/js/zabuto_calendar.js" type="text/javascript" ></script>
  <script src="https://cdn.bootcss.com/zabuto_calendar/1.6.4/zabuto_calendar.js"></script>
  <script src="https://cdn.bootcss.com/zabuto_calendar/1.6.4/zabuto_calendar.min.js"></script>
  <!-- 日历-->
  <script type="application/javascript">
    $(document).ready(function () {
      $("#my-calendar").zabuto_calendar();
    });
  </script>
<#--天气-->
  <!-- weather-w -->
  <script>
    WIDGET = {ID: 'PCl2tuMCNc'};
  </script>
</body>

</html>
