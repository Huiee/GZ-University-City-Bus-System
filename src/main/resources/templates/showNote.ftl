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
                <img src="/../images/${user_picture!}" class="img-circle" width="80" height="80">
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
              <li class="active"><a href="/showNoteTitle">查看记事本</a></li>
              <li ><a href="/showAddNote">添加记事本</a></li>
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
            <section >
              <div class="row">
                <!--  DATE PICKERS -->
                <div class="col-lg-12">
                  <div class="form-panel" style="box-shadow: 0px 3px 20px #84c5d4;border-radius: 10px;">

                      <div class="note-form">
                        <label class="col-sm-12  control-label">
                          <div class="darkblue-header">
                            <h4>NOTE</h4>
                          </div>
                        </label>
                      </div>

                      <#if note_title ??>
                      <form action="/updateNote" name="updateNote" class="form-horizontal style-form">

                      <div class="note-form">
                        <label class="col-sm-2 col-sm-2 control-label">标题</label>
                        <div class="col-sm-10">
                          <input type="text" class="form-control" style="width: 400px;" id="note_title" name="note_title" value="${note_title!}">
                        </div>
                      </div>

                      <div class="note-form">
                        <label class="col-sm-5 control-label">内容</label>
                        <label class="col-sm-7 control-label">

                          <#if note_clock??>
<#--                            有闹钟-->

                              <input type="text" id="note_time" name="note_time" value="${note_time!}" disabled style="display: none" class="form-control form-control-inline input-medium default-date-picker" >

                              <input type="date" id="update_clock_time" name="update_clock_time" value="${note_clock!}" disabled style="margin-right: 20px;float: left;width: 150px;" class="form-control form-control-inline input-medium default-date-picker" >
                            <button type="button" id="updateClock"  onclick="return showUpdateColck()"  class="btn btn-round btn-warning" style="margin-right: 15px;float: left;">
                              <i class="fa fa-bell"></i>修改闹钟</button>
                            <button type="button" id="closeOldClock" onclick="CloseColck()" class="btn btn-round btn-warning" style="float: left;margin-right: 10px;">
                              <i class="fa fa-bell"></i>关闭闹钟</button>


<#--                            没有闹钟-->

                              <button type="button" id="addClock" onclick="return showAddClock()" class="btn btn-round btn-warning" style="float: right;display: none">
                              <i class="fa fa-bell"></i>设置闹钟</button>
<#--                            设置闹钟-->
                            <input type="date" id="add_clock_time" name="add_clock_time" style="margin-right: 20px;float: left;display: none;width: 160px" class="form-control form-control-inline input-medium default-date-picker" >
                            <button type="button" id="saveClock" onclick="return updateClockSave()"   class="btn btn-round btn-warning" style="float: left;display: none">
                              <i class="fa fa-bell"></i>保存闹钟</button>

                    <#else >


<#--                            <input type="date" id="clock_time" name="clock_time" style="margin-right: 20px;float: left;display: none;width: 150px" class="form-control form-control-inline input-medium default-date-picker" >-->
                          <button type="button" id="showClock" onclick="return showColckTime()" class="btn btn-round btn-warning" style="float: right;">
                            <i class="fa fa-bell"></i>设置闹钟</button>


                              <input type="date" id="new_clock_time" name="clock_time" style="margin-right: 20px;float: left;display: none;width: 150px" class="form-control form-control-inline input-medium default-date-picker" >
                            <button type="button" id="saveNewClock" onclick="return newClockSave()"   class="btn btn-round btn-warning" style="float: left;display: none">
                              <i class="fa fa-bell"></i>保存闹钟</button>
                          <button type="button" id="closeClock" onclick="return showCloseColckTime()" class="btn btn-round btn-warning" style="float: left;display: none">
                            <i class="fa fa-bell"></i>取消闹钟</button>

                          </#if>

                        </label>
                      </div>

                        <div class="note-form">
                        <div class="">
                         <textarea class="form-control note-form-control" style=" height:480px;" id="note" name="note" disabled>${note!}</textarea>
                        </div>
                      </div>

                      <div class="note-form">
                        <div class="col-lg-9"></div>
                        <div class="col-lg-3">
                            <input type="text" id="note_time" name="note_time" value="${note_time!}" style="display: none">
                          <a class="btn btn-theme" id="showUpdate" style="color: #FFFFFF;" onclick="return showUpdateNote()">修改</a>
                          <a class="btn btn-theme" id="updateNote" style="display:none;color: #FFFFFF;" onclick="return checkUpdateNote()">保存</a>
                         <button type="button" class="btn btn-danger" onclick="location.href='/deleteNote?note_time=${note_time!}'">删除</button>
                        </div>
                      </div>
                    </form>
                  <#else>
                      <form action="/addNote.do" name="addNote" class="form-horizontal style-form">
                          <div class="note-form">
                              <label class="col-sm-2 col-sm-2 control-label">标题</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control" id="note_title" name="note_title" value="">
                              </div>
                          </div>

                          <div class="note-form">
                            <label class="col-sm-7 control-label">内容</label>
                            <label class="col-sm-5 control-label">
                              <input type="date" id="clock_time" name="clock_time" style="margin-right: 20px;float: left;display: none;width: 150px" class="form-control form-control-inline input-medium default-date-picker" >
                              <button type="button" id="showNewClock" onclick="return showNewColckTime()" class="btn btn-round btn-warning" style="float: right;">
                                <i class="fa fa-bell"></i>设置闹钟</button>
                              <button type="button" id="closeNewClock" onclick="return showNewCloseColckTime()" class="btn btn-round btn-warning" style="float: left;display: none">
                                <i class="fa fa-bell"></i>关闭闹钟</button>
                            </label>
                          </div>

                        <div class="note-form">
                              <div class="">
                                  <textarea class="form-control  note-form-control " style=" height:480px;" id="note" name="note"> </textarea>
                              </div>
                          </div>

                          <div class="note-form">
                              <div class="col-lg-9"></div>
                              <div class="col-lg-3">
                                  <input type="text" id="note_time" name="note_time" value="" style="display: none">

                                  <button type="button" class="btn btn-theme"onclick="return checkAddNote()">保存</button>
                              </div>
                          </div>
                      </form>
                      </#if>

                  </div>
                  <!-- /form-panel -->
                </div>
                <!-- /col-lg-12 -->
              </div>
            </section>
          </div>

          <div class="col-sm-3">
            <#--            日历-->
            <section class="panel" style="background: #4ECDC4">
              <div class="panel-body">
                <div id="my-calendar"></div>
              </div>
            </section>
<#--            天气-->
            <section class="panel">
              <div class="panel-body" style="padding:2.5px">
                <div id="weather-view-he"></div>
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

    <section>
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
  <script type="text/javascript" src="https://apip.weatherdt.com/view/static/js/r.js?v=1111"></script>

  <!-- weather-w -->
  <script>
    WIDGET = {ID: 'PCl2tuMCNc'};
  </script>

  <!-- 日历-->
  <script type="application/javascript">
    $(document).ready(function () {
      $("#my-calendar").zabuto_calendar();
    });
  </script>

    <#--   删除 闹钟-->
    <script type="text/javascript">
      function CloseColck() {
        $.ajax({
          type:"POST",
          url:"deleteClock",
          dataType:"json",
          data:{
            "note_time" : "${note_time!}"
            <#--clock_time : "${note_clock!}"-->
          },
          success : function () {
          },
          error : function() {
            $("#updateClock").hide();
            $("#closeOldClock").hide();
            $("#update_clock_time").hide();
            $('#addClock').show();
          },
        })
      }
    </script>

    <#--天气-->

  <!-- weather -->

<#--  <script>-->
<#--    WIDGET = {ID: 'iJxdEm7ZIX'};-->
<#--  </script>-->
</body>

</html>
