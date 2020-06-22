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
</head>

<body>
<meta name="viewport" content="width=device-width, initial-scale=1" />
  <section id="container">
    <!-- **********************************************************************************************************************************************************
        TOP
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
    <!--顶部菜单栏 end-->
    <!-- **********************************************************************************************************************************************************
        MAIN SIDEBAR MENU
        *********************************************************************************************************************************************************** -->
    <!--左侧菜单栏 start-->
    <aside>
  <div id="sidebar" class="nav-collapse ">
    <!-- 左侧菜单栏内容 start-->
    <ul class="sidebar-menu" id="nav-accordion">
        <#--      头像-->
      <p class="centered">
          <#if user_id??><a href="/showUserMessage"></#if>
          <#if user_picture ??>
            <img src="/../images/${user_picture!}" class="img-circle" width="80" height="80">
          <#else >
            <img src="/../images/p1.jpg" class="img-circle" width="80" height="80">
          </#if>
        </a>
      </p>
<#--            登录名字显示-->
      <h5 class="centered">
        <#if user_name ??>
        ${user_name!}
          <#else >
        <a href="/showLogin" style="color: white"> 未登录</a>
        </#if>
        </h5>
<#--            线路查询-->
      <li class="mt">
        <a class="active" href="/showCover">
          <i class="fa fa-location-arrow"></i>
          <span>线路查询</span>
          </a>
      </li>
<#--            站点查询-->
      <li class="sub-menu">
        <a href="/station">
          <i class="fa fa-map-marker"></i>
          <span>站点查询</span>
          </a>
        <ul class="sub" style="display: block">
          <li><a href="/station">公交站点名称</a></li>
          <li><a href="/showBusNumber">公交线路号码</a></li>
        </ul>
      </li>
      <#if admin_id??>
<#--            公交线路管理-->
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
<#--            用户管理-->
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
<#--              历史记录-->
      <li class="sub-menu">
        <a href="javascript:;">
          <i class="fa fa-calendar-o"></i>
          <span>历史记录</span>
          </a>
        <ul class="sub">
          <li><a href="/showHistory">查看历史记录</a></li>
        </ul>
      </li>
<#--              行程记事-->
      <li class="sub-menu">
        <a href="javascript:;">
          <i class="fa fa-book"></i>
          <span>行程记事本</span>
          </a>
        <ul class="sub">
          <li><a href="/showNoteTitle">查看记事本</a></li>
          <li ><a href="/showAddNote">添加记事本</a></li>
        </ul>
      </li>
<#--              个人信息-->
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
        <!-- 左侧菜单栏内容  end-->
      </div>
    </aside>
    <!--左侧菜单栏 end-->
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper site-min-height">
        <div class="row mt">
<#--  搜索-->
<div class="col-lg-12">
   <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
      <div class="custom-box">
         <div class="servicetitle"><h4>换乘查询</h4><hr></div>
          <p>广州大学城公交线路查询</p>
<#--          输入出发站点目的站点  start-->
   <form action="/checkBusStationName" method="post" name="bus">
      <table>
         <tr>
           <td style="width: 500px; padding: 2px 20px;">
             <input class="form-control form-control-inline input-medium default-date-picker" name="start" size="16" type="text" value="${start!}" placeholder="请输入出发站点">
           </td>
           <td style="padding: 2px 20px;"> <span class="icn-container" onclick="return change()">⇿</span></td>
           <td style="width: 500px;padding: 2px 20px;">
             <input class="form-control form-control-inline input-medium default-date-picker" name="end" size="16" type="text" value="${end!}" placeholder="请输入目的站点">
            </td>
           </tr>
         </table><br>
         <button type="button" class="btn btn-theme"onclick="return checkBusChange()">查询</button>
   </form>
<#--          输入出发站点目的站点  end-->
      </div>
   </div>
</div>
<#-- 搜索 -- end -->

<#--  结果 --- s --->
<#--  直达 ----  start --->
<#if busMes_Change ??>
<div class="col-lg-12">
<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
  <div class="custom-box">
    <div class="servicetitle"><h4>推荐方案</h4><hr></div>
    <p>${start!}——>${end!}</p>
    <form>
      <table>
        <tr>
<#--                图标表格：车+星-->
          <td style="padding:20px ">
                <span class="glyphicon glyphicon-bed" aria-hidden="true"></span>&nbsp;&nbsp;
<#--                  收藏显示-->
              <#if user_id??>
<#--                 flag 收藏标志0未尚未收藏，1为已收藏-->
                <#assign flag=0>
                <#if notes??>
<#--                    记事本不会空，遍历查看是否存在-->
                  <#list notes as n>
                    <#assign title =start +"->"+end>
<#--                      已收藏-->
                      <#if n.note_title == title>
                        <#assign flag=1>
                        <span class="fa fa-star" style="color: #ffdf46" aria-hidden="true" id="star"  ></span>
                      </#if>
                    <#break>
                  </#list>
                  <#if flag=0>
                    <a href="/collectResult?start=${start!}&&end=${end!}">
                  <span class="fa fa-star-o" aria-hidden="true" id="no-star"></span></a>
                  </#if>
<#--                    记事本为空情况-->
                  <#else>
                    <a href="/collectResult?start=${start!}&&end=${end!}">
                    <span class="fa fa-star-o" aria-hidden="true" id="no-star"></span></a>
                </#if>
              </#if>
              </td>
<#--                结果表格-->
          <td style="width: 800px;text-align: left; " >
          从${start!}上车乘坐
<#--  go方向不为空-->
          <#if buses ??>
            <#list buses as bus>
<#--                获取始发站点和目的站点序号-->
              <#if bus.station_name==start><#assign num =bus.go_number></#if>
              <#if bus.station_name==end><#assign num_end =bus.go_number>
              <a href="/showBusMes?bus_number=${bus.bus_number!}&&start_num=${num!}&&end_num=${num_end!}">${bus.bus_number!}</a>
              (坐${(num_end-num+1)!}站)、
              </#if>
            </#list>
          </#if>
<#--go方向--end-->
<#-- back方向-->
    <#if buses_back ??>
      <#list buses_back as bus>
         <#if bus.station_name==start><#assign num =bus.back_number></#if>
         <#if bus.station_name==end><#assign num_end =bus.back_number>
             <a href="/showBusMesBack?bus_number=${bus.bus_number!}&&start_num=${num!}&&end_num=${num_end!}">
                 ${bus.bus_number!}</a>
             (坐${(num_end-num+1)!}站)、
         </#if>
      </#list>
    </#if>
<#--back方向 -- end -->
    到${end!}下车
      </td>
    </tr>
  <tr><td style="padding:20px;text-align: left ">  <span class="glyphicon glyphicon-scale" aria-hidden="true"></span></td>
      <td colspan="2" style="text-align: left">
          <#if buses ??>
              <#list buses as bus>
                  <#if bus_last??>
                      <#if bus_last ==bus.bus_number>
                      <#else>
                          <a href="/searchBusByNumber?bus_number=${bus.bus_number!}">
                              <span class="badge-subway btn-primary" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus.bus_number!}</span></a>
<#--                <span class="badge-subway bg-theme" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus.bus_number!}</span>-->
                       </#if>
                      <#else>
                      <a href="/searchBusByNumber?bus_number=${bus.bus_number!}">
                          <span class="badge-subway btn-primary" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus.bus_number!}</span>
                              </a>

<#--                          <span class="badge-subway bg-theme" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus.bus_number!}</span>-->
                  </#if>
              <#assign bus_last =bus.bus_number>
              </#list>
          </#if>
          <#if buses_back ??>
              <#list buses_back as bus>
                  <#if bus_last??>
                      <#if bus_last ==bus.bus_number>
                      <#else>
                              <a href="/searchBusByNumber?bus_number=${bus.bus_number!}">
                                  <span class="badge-subway btn-primary" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus.bus_number!}</span>
                              </a>
                      </#if>
                  <#else>
                          <a href="/searchBusByNumber?bus_number=${bus.bus_number!}">
                              <span class="badge-subway btn-primary" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus.bus_number!}</span>
                          </a>
                  </#if>
                  <#assign bus_last =bus.bus_number>
              </#list>
          </#if>
      </td></tr>
<#--    </#if>-->
   </table>
</form>
<#-- 直达--详细站点 -->
<table style="text-align: center; font-size: 14px;">
   <tr>
<#-- go方向--详细站点-->
    <#if bus_mes ??>
      <#list bus_mes as bus>
        <#if (bus.go_number gte start_num ) && (bus.go_number lte end_num) >
          <#if bus.go_number == start_num>
            <td style="width: 10px; padding: 2px 20px;">
                <i class="fa fa-male"></i>  <span class="badge-subway bg-theme">${bus.bus_number!}</span>
            </td>
            <td style="width: 10px; padding: 2px 20px;">
              <i class="fa fa-arrow-right"></i>
            </td>
          </#if>
            <td style="width: 10px; padding: 2px 20px;">
              ${bus.go_number-start_num+1!} ${bus.station_name!}
          <#if bus.subway ??>
            <span class="badge-subway bg-theme">${bus.subway?substring(0,1)}号线</span>
              <#if bus.subway?length gt 2>
                <span class="badge-subway bg-theme">${bus.subway?substring(2)}号线</span>
              </#if>
          </#if>
            </td>
          <#if (bus.go_number-start_num+1)% 8 ==0></tr><tr></#if>
            <td style="width: 10px; padding: 2px 20px;">
              <i class="fa fa-arrow-right"></i>
            </td>
          <#if bus.go_number == end_num>
            <td style="width: 10px; padding: 2px 20px;">
              <i class="fa fa-home"></i>
            </td>
          </#if>
        </#if>
      </#list>
    </#if>
<#--back方向 -- 详细站点-->
    <#if bus_mes_back ??>
      <#list bus_mes_back as bus>
        <#if (bus.back_number gte start_num ) && (bus.back_number lte end_num ) >
          <#if bus.back_number == start_num>
             <td style="width: 10px; padding: 2px 20px;">
               <i class="fa fa-male"></i><span class="badge-subway bg-theme">${bus.bus_number!}</span>
             </td>
             <td style="width: 10px; padding: 2px 20px;">
               <i class="fa fa-arrow-right"></i>
             </td>
          </#if>

              <td style="width: 10px; padding: 2px 20px;">
                ${bus.back_number-start_num+1!} ${bus.station_name!}
          <#if bus.subway ??>
            <span class="badge-subway bg-theme">${bus.subway?substring(0,1)}号线</span>
              <#if bus.subway?length gt 2 >
                <span class="badge-subway bg-theme">${bus.subway?substring(2)}号线</span>
              </#if>
          </#if>
              </td>
          <#if (bus.back_number-start_num+1)% 8 ==0></tr><tr></#if>
            <td style="width: 10px; padding: 2px 20px;">
              <i class="fa fa-arrow-right"></i>
            </td>
          <#if bus.back_number == end_num>
            <td style="width: 10px; padding: 2px 20px;">
              <i class="fa fa-home"></i>
            </td>
          </#if>
        </#if>
    </#list>
    </#if>
    </tr>
</table>
          <br>
<#--详细站点 end-->

                </div>
              </div>
            </div>
</#if>
<#--直达 -- end -->
<#--一次换乘 start-->
<#if changeOneResult??>
<div class="col-lg-12">
  <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
    <div class="custom-box">
      <div class="servicetitle">
           <h4>换乘方案</h4> <hr>
         </div>
         <p>${start!}——>${end!}</p>
          <p>   <div class="btn-group">
            <a data-toggle="dropdown" href="#" class="btn mini all">
              查询类型
              <i class="fa fa-angle-down "></i>
            </a>
            <ul class="dropdown-menu">
              <li><a href="/searchBusChange.do?start=${start!}&&end=${end!}&&search_type=站点优先"><i class="fa fa-location-arrow"></i>&nbsp;&nbsp;站点优先</a></li>
              <li class="divider"></li>
              <li><a href="/searchBusChange.do?start=${start!}&&end=${end!}&&search_type=价格优先"><i class="fa fa-map-marker"></i>&nbsp;&nbsp;价格优先</a></li>

            </ul>
          </div></p>
           <form>
<table>
  <tr>
          <#assign i =0>
            <#assign times = 0>
<#--            ${changeOneResult?size!}-->
          <#list changeOneResult as bus>
            <#assign times = times+1>
<#--            第一次遍历-->
      <#if i=0>
    <td style="padding:20px ">
     <span class="glyphicon glyphicon-bed" aria-hidden="true"></span>&nbsp;&nbsp;
        <#if  user_id??>
     <a onclick="return collectChange('${i}','${bus.station_A!}','${bus.station_B}','${bus.bus_number_A}','${bus.bus_number_B}')">
       <#assign f=0>
       <#if notes??>
       <#list notes as n>
         <#assign title =start +"->"+end>
         <#if n.note_title == title>
           <#if n.note?contains(bus.bus_number_B)>
             <#if n.note?contains(bus.bus_number_A+"到"+bus.change_station_C+"(共"+bus.num?c)>
               <#assign f=1>
                 <span class="fa fa-star" style="color: #ffdf46" aria-hidden="true" id="star"  ></span>
             </#if>
           </#if>
         </#if>
       </#list>
       <#if f=0>
       <a onclick="return collectChange('${i}','${bus.station_A!}','${bus.station_B}','${bus.bus_number_A}','${bus.bus_number_B}')">
       <span class="fa fa-star-o" aria-hidden="true" id="no-star"></span></a>
      </#if>
      <#else >
       <a onclick="return collectChange('${i}','${bus.station_A!}','${bus.station_B}','${bus.bus_number_A}','${bus.bus_number_B}')">
        <span class="fa fa-star-o" aria-hidden="true" id="no-star"></span></a>
      </#if>

         </#if>
    </td>

    <td style="width: 800px;text-align: left; " >
      </#if>
      <#assign i=i+1>
      <#if bus_A ??>
      <#if bus_A=bus.bus_number_A && bus_B = bus.bus_number_B>
           /<a href="/showBusMesAll?bus_number_A=${bus.bus_number_A}&&bus_number_B=${bus.bus_number_B}&&num_A=${bus.num_A}&&num_A_C=${bus.num_A_C}&&num_C_B=${bus.num_C_B}&&num_B=${bus.num_B}&&start=${start}&&change=${bus.change_station_C}&&end=${end}">${bus.change_station_C}</a> (${(bus.num)!}站)
        <#if changeOneResult?size == times>
            换乘 <a href="/searchBusByNumber?bus_number=${bus_B!}">${bus_B}</a>(价格：${bus.price!}元)
            <tr><td style="padding:20px;text-align: left ">  <span class="glyphicon glyphicon-scale" aria-hidden="true"></span></td>
                <td colspan="2" style="text-align: left">
                    <a href="/searchBusByNumber?bus_number=${bus_A!}"> <span class="badge-subway btn-primary" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus_A!}</span></a>
                    <span style="margin: 5px" class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <a href="/searchBusByNumber?bus_number=${bus_B!}"><span class="badge-subway btn-primary" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus_B!}</span></a>
                </td></tr>
        </#if>
      <#else>
      换乘  <a href="/searchBusByNumber?bus_number=${bus_B!}">${bus_B}</a>(价格：${bus.price!}元)
        <tr>
        <tr><td style="padding:20px ;text-align: left">   <span class="glyphicon glyphicon-scale" aria-hidden="true"></span></td>
            <td colspan="2" style="text-align: left">
                <a href="/searchBusByNumber?bus_number=${bus_A!}"><span class="badge-subway btn-primary" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus_A!}</span></a>
                <span style="margin: 5px"  class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <a href="/searchBusByNumber?bus_number=${bus_B!}"><span class="badge-subway btn-primary" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus_B!}</span></a>
            </td></tr>
    </td>
  </tr>
</table>
           </form>
    </div>
  </div>
</div>

<div class="col-lg-12">
  <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
    <div class="custom-box">
       <form>
         <table>
           <tr>
             <td style="padding:20px ">
               <span class="glyphicon glyphicon-bed" aria-hidden="true"></span>&nbsp;&nbsp;
                 <#--                   收藏-->
              <#if user_id??>
               <#assign f2=0>
               <#if notes??>
                 <#list notes as n>
                   <#assign title =start +"->"+end>
                   <#if n.note_title == title>
                     <#if n.note?contains(bus.bus_number_B)>
                         <#if n.note?contains(bus.bus_number_A+"到"+bus.change_station_C+"(共"+bus.num?c)>
                         <#assign f2=1>
                         <span class="fa fa-star" style="color: #ffdf46" aria-hidden="true" id="star"  ></span>
                       </#if>
                     </#if>
                   </#if>
                 </#list>
                 <#if f2=0>
                    <a onclick="return collectChange('${i}','${bus.station_A!}','${bus.station_B}','${bus.bus_number_A}','${bus.bus_number_B}')">
                     <span class="fa fa-star-o" aria-hidden="true" id="no-star"></span></a>
                 </#if>
               <#else >
                    <a onclick="return collectChange('${i}','${bus.station_A!}','${bus.station_B}','${bus.bus_number_A}','${bus.bus_number_B}')">
                   <span class="fa fa-star-o" aria-hidden="true" id="no-star"></span></a>
               </#if>
              </#if>
             </td>
               <#--收藏-->
             <td style="width: 800px;text-align: left; " >
              从${start!}上车乘坐
              <a href="/searchBusByNumber?bus_number=${bus.bus_number_A!}">${bus.bus_number_A!}</a>
              到 <a href="/showBusMesAll?bus_number_A=${bus.bus_number_A}&&bus_number_B=${bus.bus_number_B}&&num_A=${bus.num_A}&&num_A_C=${bus.num_A_C}&&num_C_B=${bus.num_C_B}&&num_B=${bus.num_B}&&start=${start}&&change=${bus.change_station_C}&&end=${end}">${bus.change_station_C}</a>
                 (${(bus.num)!}站)
<#--             识别最后一个-->
              <#if changeOneResult?size == times>
              换乘 <a href="/searchBusByNumber?bus_number=${bus.bus_number_B!}">${bus.bus_number_B}</a> (价格:${bus.price!}元)
             <tr><td style="padding:20px ;text-align: left">
                     <span class="glyphicon glyphicon-scale" aria-hidden="true"></span>
                 </td>
                 <td colspan="2" style="text-align: left">
                     <a href="/searchBusByNumber?bus_number=${bus.bus_number_A!}"><span class="badge-subway btn-primary" style="margin-top: 0px;min-width: 60px;border-radius: 13px;">${bus.bus_number_A!}</span></a>
                     <span style="margin: 5px"  class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                     <a href="/searchBusByNumber?bus_number=${bus.bus_number_B!}"><span class="badge-subway btn-primary" style="margin-top: 0px;min-width: 60px;border-radius: 13px;">${bus.bus_number_B!}</span></a>
                 </td></tr>
              </#if>
               </#if>
               <#else>
                 从${start!}上车乘坐
                   <a href="/searchBusByNumber?bus_number=${bus.bus_number_A!}">${bus.bus_number_A!}</a>
                 到 <a href="/showBusMesAll?bus_number_A=${bus.bus_number_A}&&bus_number_B=${bus.bus_number_B}&&num_A=${bus.num_A}&&num_A_C=${bus.num_A_C}&&num_C_B=${bus.num_C_B}&&num_B=${bus.num_B}&&start=${start}&&change=${bus.change_station_C}&&end=${end}">${bus.change_station_C}</a>(${(bus.num)!}站)
               </#if>
               <#assign bus_A = bus.bus_number_A>
               <#assign bus_B = bus.bus_number_B>
               </#list>
               </#if>
<#--                 (价格:${last_price!}元)-->
             </td>
           </tr>
         </table>
       </form>
    </div>
  </div>
</div>
<#--一次换乘 end-->
<#----一次换乘具体站点    start      -->
  <#if showBusChangeStation??>
          <div class="col-lg-12">
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
              <div class="custom-box">
                <div class="servicetitle">
                  <h4>换乘方案</h4> <hr>
                </div>
                <p>${start!}——>${end!}</p>

          <table style="text-align: center; font-size: 14px;">

            <tr>
              <td colspan="13" style="text-align: right">
                <#if user_id??><a><span class="fa fa-star-o" aria-hidden="true"></span>收藏</a></#if>
              </td>
              <td></td>
              <td colspan="1" style="text-align: right">
                <button type="submit" class="btn btn-theme" onclick="javascript:history.back(-1);">返回</button>
              </td>
            </tr>
            <tr>
              <#-- 一次换乘--详细站点-->
              <#assign i = 0>

              <#list bus_A as bus>
                <#if direction_A == "go">
                    <#assign bus_num =bus.go_number>
                    <#else><#assign bus_num =bus.back_number>
                </#if>
              <#if (bus_num gte num_A ) && (bus_num lte num_A_C) >
              <#assign a =(bus_num-num_A+1)>
              <#if bus_num == num_A>
                <td style="width: 10px; padding: 2px 20px;">
                  <i class="fa fa-male"></i>
                  <span class="badge-subway bg-theme" style="background-color:#4e69cd;">${bus.bus_number}</span>
                  <#assign i =i+1>
                </td>    <#if i%15==0></tr><tr></#if>
                <td style="width: 10px; padding: 2px 20px;">
                  <i class="fa fa-arrow-right"></i> <#assign i =i+1>
                </td>    <#if i%15==0></tr><tr></#if>
              </#if>
              <td style="width: 10px; padding: 2px 20px;"><#assign i =i+1>
                ${bus_num-num_A+1!} ${bus.station_name!}
                <#if bus.subway ??>
                  <span class="badge-subway bg-theme">${bus.subway?substring(0,1)}号线</span>
                  <#if bus.subway?length gt 2>
                    <span class="badge-subway bg-theme">${bus.subway?substring(2)}号线</span>
                  </#if>
                </#if>
              </td>
              <#if i%15==0></tr><tr></#if>
              <td style="width: 10px; padding: 2px 20px;">
                <i class="fa fa-arrow-right"></i><#assign i =i+1>
              </td><#if i%15==0></tr><tr></#if>
              </#if>
              </#list>

              <#list bus_B as bus>
                  <#if direction_B == "go">
                      <#assign bus_num =bus.go_number>
                  <#else><#assign bus_num =bus.back_number>
                  </#if>
              <#if (bus_num gte num_C_B ) && (bus_num lte num_B) >
              <#if bus_num == num_C_B>
                <td style="width: 10px; padding: 2px 20px;">
                  <i class="fa fa-male"></i>
                  <span class="badge-subway bg-theme" style="background-color:#fb9b61;">${bus.bus_number}</span>
                  <#assign i =i+1>
                </td>    <#if i%15==0></tr><tr></#if>
                <td style="width: 10px; padding: 2px 20px;">
                  <i class="fa fa-arrow-right"></i><#assign i =i+1>
                </td>    <#if i%15==0></tr><tr></#if>
              </#if>
              <td style="width: 10px; padding: 2px 20px;"><#assign i =i+1>
                ${bus_num-num_C_B+1+a-1!} ${bus.station_name!}
                <#if bus.subway ??>
                  <span class="badge-subway bg-theme">${bus.subway?substring(0,1)}号线</span>
                  <#if bus.subway?length gt 2>
                    <span class="badge-subway bg-theme">${bus.subway?substring(2)}号线</span>
                  </#if>
                </#if>
              </td>
              <#if i%15==0></tr><tr></#if>
              <td style="width: 10px; padding: 2px 20px;">
                <i class="fa fa-arrow-right"></i><#assign i =i+1>
              </td> <#if i%15==0></tr><tr></#if>
              <#if bus_num == num_B>
                <td style="width: 10px; padding: 2px 20px;">
                  <i class="fa fa-home"></i><#assign i =i+1>
                </td>
              </#if>
              </#if>
              </#list>

            </tr>
          </table><br>
        </div>
        </div>
        </div>
          </#if>
<#----一次换乘具体站点    end      -->


 <#--二次换乘 start-->
<#if changeTwoResult  ??>
  <div class="col-lg-12">
    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
      <div class="custom-box">
        <div class="servicetitle"><h4>换乘方案</h4> <hr></div>
          <p>${start!}——>${end!}</p>
          <#if bus_null??><p>${bus_null}</p></#if>
  <form>
    <table>
      <tr>
        <#assign i =0>
        <#assign times = 0> <#--识别最后一个站点-->
        <#list changeTwoResult as bus>
          <#assign times = times+1>
            <#-- 第一次遍历-->
          <#if i=0>
            <td style="padding:20px ">
              <span class="glyphicon glyphicon-bed" aria-hidden="true"></span>&nbsp;&nbsp;
    <#if  user_id??><#--收藏处理-->
      <a onclick="return collectChange('${i}','${bus.station_A!}','${bus.station_B}','${bus.bus_number_A}','${bus.bus_number_B}')">
        <#assign f=0>
          <#if notes??>
            <#list notes as n>
              <#assign title =start +"->"+end>
                <#if n.note_title == title>
                  <#if n.note?contains(bus.bus_number_B) &&  n.note?contains(bus.bus_number_A)  &&n.note?contains(bus.bus_number_D)>
                      <#assign f=1>
                        <span class="fa fa-star" style="color: #ffdf46" aria-hidden="true" id="star"  ></span>
                  </#if>
                </#if>
            </#list>
              <#if f=0>
                <a onclick="return collectChangeTwo('${i}','${bus.station_A!}','${bus.station_B}','${bus.bus_number_A}','${bus.bus_number_D}','${bus.bus_number_B}')">
                <span class="fa fa-star-o" aria-hidden="true" id="no-star"></span></a>
              </#if>
          <#else >
              <a onclick="return collectChangeTwo('${i}','${bus.station_A!}','${bus.station_B}','${bus.bus_number_A}','${bus.bus_number_D}','${bus.bus_number_B}')">
              <span class="fa fa-star-o" aria-hidden="true" id="no-star"></span></a>
          </#if>
          </#if>
            </td>
            <td style="width: 800px;text-align: left; " >
          </#if>
<#--以上是第一次遍历的图标-->
<#--    第一次遍历过后，从第二次开始会进入这里-->

            <#assign i=i+1>
            <#if bus_A ??>
            <#if bus_A=bus.bus_number_A && bus_B = bus.bus_number_B && bus_D = bus.bus_number_D>
            <#else>
        </table>
        </form>
        </div>
        </div>
        </div>
    <div class="col-lg-12">
        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
            <div class="custom-box">
                <form>
            <table>
                <tr>
                    <td style="padding:20px ">
                        <span class="glyphicon glyphicon-bed" aria-hidden="true"></span>&nbsp;&nbsp;
                        <#--                   收藏-->
                        <#if user_id??>
                            <#assign f2=0>
                            <#if notes??>
                                <#list notes as n>
                                    <#assign title =start +"->"+end>
                                    <#if n.note_title == title>
                                        <#if n.note?contains(bus.bus_number_B)&&  n.note?contains(bus.bus_number_A)&&n.note?contains(bus.bus_number_D)>
<#--                                            <#if n.note?contains(bus.bus_number_A+"到"+bus.change_station_C+"(共"+bus.num?c)>-->
                                                <#assign f2=1>
                                                <span class="fa fa-star" style="color: #ffdf46" aria-hidden="true" id="star"  ></span>
<#--                                            </#if>-->
                                        </#if>
                                    </#if>
                                </#list>
                                <#if f2=0>
                                    <a onclick="return collectChangeTwo('${i}','${bus.station_A!}','${bus.station_B}','${bus.bus_number_A}','${bus.bus_number_D}','${bus.bus_number_B}')">
                                        <span class="fa fa-star-o" aria-hidden="true" id="no-star"></span></a>
                                </#if>
                            <#else >
                                <a onclick="return collectChangeTwo('${i}','${bus.station_A!}','${bus.station_B}','${bus.bus_number_A}','${bus.bus_number_D}','${bus.bus_number_B}')">
                                    <span class="fa fa-star-o" aria-hidden="true" id="no-star"></span></a>
                            </#if>
                        </#if>
                    </td>
                <#--收藏-->
                <td style="width: 800px;text-align: left; " >
                    从${start!}上车乘坐
                    <a href="/searchBusByNumber?bus_number=${bus.bus_number_A}">${bus.bus_number_A!}</a>
                    到<#assign q=0><#list changeStationC1 as C1>
                        <#if C1.bus_number_A==bus.bus_number_A &&C1.bus_number_B ==bus.bus_number_B && C1.bus_number_D == bus.bus_number_D>
                    <#if q==0>
                   <a  href="/showBusMes">${C1.change_station_C!}</a>(${(C1.num_A_C-C1.num_A)!}站)
                    <#else>
                    /<a  href="/showBusMes">${C1.change_station_C!}</a> (${(C1.num_A_C-C1.num_A)!}站)
                    </#if><#assign q=q+1>
                    </#if>
                    </#list>
                    换乘<a href="/searchBusByNumber?bus_number=${bus.bus_number_D!}">${bus.bus_number_D!}</a>
                    到<#assign p=0><#list changeStationC2 as C2>
                    <#if C2.bus_number_A==bus.bus_number_A &&C2.bus_number_B ==bus.bus_number_B && C2.bus_number_D == bus.bus_number_D>
                         <#if p==0>
                             <a  href="/showBusMes">${C2.change_station_C2!}</a>(${(C2.num_B-C2.num_C_B)!}站)
                    <#else>/<a  href="/showBusMes">${C2.change_station_C2!}</a>(${(C2.num_B-C2.num_C_B)!}站)
                        </#if><#assign p=p+1>
                        </#if>
                    </#list>
                    换乘 <a href="/searchBusByNumber?bus_number=${bus_B}">${bus_B}</a>(价格：${bus.price!}元)
                <tr><td style="padding:20px;text-align: left ">  <span class="glyphicon glyphicon-scale" aria-hidden="true"></span></td>
                    <td colspan="2" style="text-align: left">
                        <a href="/searchBusByNumber?bus_number=${bus.bus_number_A!}"><span class="badge-subway btn-primary" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus.bus_number_A!}</span></a>
                        <span style="margin: 5px" class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        <a href="/searchBusByNumber?bus_number=${bus.bus_number_D!}"><span class="badge-subway btn-primary" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus.bus_number_D!}</span></a>
                        <span style="margin: 5px" class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        <a href="/searchBusByNumber?bus_number=${bus.bus_number_B!}"><span class="badge-subway btn-primary" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus.bus_number_B!}</span></a>
                    </td></tr>

            </#if>
            <#else>
                从${start!}上车乘坐
                <a href="/searchBusByNumber?bus_number=${bus.bus_number_A!}">${bus.bus_number_A!}</a>
                到<#assign p=0><#list changeStationC1 as C1>
                <#if C1.bus_number_A==bus.bus_number_A &&C1.bus_number_B ==bus.bus_number_B && C1.bus_number_D == bus.bus_number_D>
                   <#if p==0>
                       <a  href="/showBusMes">${C1.change_station_C!}</a>(${(C1.num_A_C-C1.num_A)!}站)
                   <#else>/ <a  href="/showBusMes">${C1.change_station_C!}</a>(${(C1.num_A_C-C1.num_A)!}站)
                   </#if><#assign p=p+1></#if>
            </#list>
                换乘<a href="/searchBusByNumber?bus_number=${bus.bus_number_D!}">${bus.bus_number_D!}</a>
                到<#assign q=0><#list changeStationC2 as C2>
                <#if C2.bus_number_A==bus.bus_number_A &&C2.bus_number_B ==bus.bus_number_B && C2.bus_number_D == bus.bus_number_D>
                 <#if q==0>
                     <a  href="/showBusMes">${C2.change_station_C2!}</a>(${(C2.num_B-C2.num_C_B)!}站)
                     <#else>/<a  href="/showBusMes">${C2.change_station_C2!}</a>(${(C2.num_B-C2.num_C_B)!}站)
                 </#if>
                    <#assign q=q+1>
                  </#if>
            </#list>
                换乘<a href="/searchBusByNumber?bus_number=${bus.bus_number_B!}">${bus.bus_number_B}</a>(价格：${bus.price!}元)
                <tr><td style="padding:20px;text-align: left ">  <span class="glyphicon glyphicon-scale" aria-hidden="true"></span></td>
                    <td colspan="2" style="text-align: left">
                        <a href="/searchBusByNumber?bus_number=${bus.bus_number_A!}"><span class="badge-subway btn-primary" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus.bus_number_A!}</span></a>
                        <span style="margin: 5px" class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        <a href="/searchBusByNumber?bus_number=${bus.bus_number_D!}"><span class="badge-subway btn-primary" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus.bus_number_D!}</span></a>
                        <span style="margin: 5px" class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        <a href="/searchBusByNumber?bus_number=${bus.bus_number_B!}"><span class="badge-subway btn-primary" style="min-width: 60px;border-radius: 13px;margin-top: 0px;">${bus.bus_number_B!}</span></a>
                    </td></tr>
            </#if>
            <#assign bus_B = bus.bus_number_B>
            <#assign bus_D = bus.bus_number_D>
            <#assign bus_A = bus.bus_number_A>
            <#assign bus_C1 =bus.change_station_C>
            </#list>
                </td>
            </tr>
        </table>
    </form>
                </#if>

</div>
</div>
</div>

<#--二次换乘 end-->
</div>

      </section>
      <!-- /wrapper -->
    </section>
<#--    <div id="gritter-notice-wrapper" class="bottom-right">-->
<#--      <div id="gritter-item-1" class="gritter-item-wrapper my-sticky-class" style="">-->
<#--        <div class="gritter-top"></div>-->
<#--        <div class="gritter-item">-->
<#--          <div class="gritter-close" style="display: none;"></div>-->
<#--          <img src="/../images/${user_picture!}" class="gritter-image">-->
<#--          <div class="gritter-with-image">-->
<#--            <span class="gritter-title">Welcome to Dashio!</span>-->
<#--            <p>Hover me to enable the Close Button. You can hide the left sidebar clicking on the button next to the logo.</p></div>-->
<#--          <div style="clear:both"></div></div>-->
<#--        <div class="gritter-bottom"></div></div></div>-->
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
 <script type="text/javascript" src="https://webapi.amap.com/maps?v=1.4.15&key=57f9132b3af695d3abf110e6b883ca72"></script>
<#--  <script type="application/javascript">-->
<#--    $(document).ready(function() {-->
<#--      $("#date-popover").popover({-->
<#--        html: true,-->
<#--        trigger: "manual"-->
<#--      });-->
<#--      $("#date-popover").hide();-->
<#--      $("#date-popover").click(function(e) {-->
<#--        $(this).hide();-->
<#--      });-->

<#--      $("#my-calendar").zabuto_calendar({-->
<#--        action: function() {-->
<#--          return myDateFunction(this.id, false);-->
<#--        },-->
<#--        action_nav: function() {-->
<#--          return myNavFunction(this.id);-->
<#--        },-->
<#--        ajax: {-->
<#--          url: "show_data.php?action=1",-->
<#--          modal: true-->
<#--        },-->
<#--        legend: [{-->
<#--          type: "text",-->
<#--          label: "Special event",-->
<#--          badge: "00"-->
<#--        },-->
<#--          {-->
<#--            type: "block",-->
<#--            label: "Regular event",-->
<#--          }-->
<#--        ]-->
<#--      });-->
<#--    });-->

<#--    function myNavFunction(id) {-->
<#--      $("#date-popover").hide();-->
<#--      var nav = $("#" + id).data("navigation");-->
<#--      var to = $("#" + id).data("to");-->
<#--      console.log('nav ' + nav + ' to: ' + to.month + '/' + to.year);-->
<#--    }-->
<#--  </script>-->
</body>

</html>
