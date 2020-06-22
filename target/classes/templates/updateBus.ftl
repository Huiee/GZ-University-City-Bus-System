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
<style type="text/css" >
  tr {
    text-align: center;
  }

  </style>
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
                <img src="/../images/${user_picture!}" class="img-circle" width="80" height="80">
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
                  <p>广州大学城公交线路修改</p><br>
                  <form action="/updateBusNumber.do " method="post" name="updateBusNumber">
                    <table>
                      <tr>
                        <td style="width: 150px; padding: 2px 20px;">线路号码更改</td>
                        <td style="width: 350px; padding: 2px 20px;">
                          <input class="form-control form-control-inline input-medium default-date-picker" name="bus_number" size="16" type="text" value="" placeholder="旧·线路号码">
                        </td>
                        <td style="width: 350px; padding: 2px 20px;">
                          <input class="form-control form-control-inline input-medium default-date-picker" name="new_bus_number" size="16" type="text" value="" placeholder="新·线路号码">
                        </td>
                        <td>
                          <button type="button" class="btn btn-theme"onclick="return checkUpdateBusNumberChange()">更新</button>
                        </td>
                      </tr>
                    </table>
                  </form><br>
              <form action="/UpdateBusStationName.do " method="post" name="updateStationName">
                 <table>
                   <tr>
                     <td style="width: 150px; padding: 2px 20px;">站点名更改</td>
                     <td style="width: 350px; padding: 2px 20px;">
                       <input class="form-control form-control-inline input-medium default-date-picker" name="station_name" size="16" type="text" value="" placeholder="旧·站点名称">
                     </td>
                     <td style="width: 350px; padding: 2px 20px;">
                       <input class="form-control form-control-inline input-medium default-date-picker" name="new_station_name" size="16" type="text" value="" placeholder="新·站点名称">
                     </td>
                     <td>
                       <button type="button" class="btn btn-theme"onclick="return checkUpdateStationName()">更新</button>
                     </td>
                   </tr>
                 </table>
              </form>
                  <br>

                  <form action="/ShowUpdateBus.do" method="post" name="showUpdateBus">
                    <table>
                      <tr>
                        <td style="width: 150px; padding: 2px 20px;">线路更改</td>
                        <td style="width: 700px; padding: 2px 20px;">
                          <input class="form-control form-control-inline input-medium default-date-picker" name="bus_number" size="16" type="text" value="" placeholder="请输入需更改线路号码">
                        </td>
                        <td>
                          <button type="button" class="btn btn-theme"onclick="return checkUpdateBusNumber()">查看</button>
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
          <#if updateBusMes  ??>
            <div class="col-lg-12">
              <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                <div class="custom-box">
                  <div class="servicetitle">
                    <h4>${bus_number!}路</h4>
                    <hr>
                  </div>

                  <form  method="post">

                    <table style="text-align: center">
                      <tr style="">
                        <th style=" padding: 20px 10px; width: 60px;text-align: center;">线路号码</th>
                        <th style=" padding: 20px 10px;text-align: center;width: 75px">始发站</th>
                        <th style=" padding: 20px 10px;text-align: center;width: 75px;">终点站</th>
                        <th style=" padding: 20px 10px;text-align: center;width: 60px;">首班车</th>
                        <th style=" padding: 20px 10px;text-align: center;width: 60px; ">末班车</th>
                        <th style=" padding: 20px 10px;text-align: center;width: 60px;">价格</th>
                        <th style=" padding: 20px 10px;text-align: center;width: 60px;">全程</th>
                        <th style=" padding: 20px 10px;text-align: center;width: 60px;">时间</th>
                        <th style=" padding: 20px 10px;text-align: center;width: 60px;">修改</th>
                      </tr>
                      <#assign o=0>
                      <#list  updateBusMes  as bus>
                        <#assign o=o+1>
                        <tr style="text-align: center">
                          <td style=" padding: 20px 10px; ">
                            <input id="busMes_number_${o}" type="text" value="${bus.bus_number!}"  style="width: 80px;" class="form-control form-control-inline input-medium default-date-picker" disabled>
                          </td>
                          <td style=" padding: 20px 10px;width: 160px;">
                            <input id="busMes_start_station_${o}" type="text" value="${bus.start_station!}" class="form-control form-control-inline input-medium default-date-picker" disabled>
                          </td>
                          <td style=" padding: 20px 10px;width: 160px;">
                            <input id="busMes_end_station_${o}" type="text" value="${bus.end_station!}" class="form-control form-control-inline input-medium default-date-picker" disabled>
                          </td>
                          <td style=" padding: 20px 10px;">
                            <input id="busMes_start_time_${o}" type="text" value="${bus.start_time!}" class="form-control form-control-inline input-medium default-date-picker" disabled>
                          </td>
                          <td style=" padding: 20px 10px;">
                            <input id="busMes_end_time_${o}" type="text" value="${bus.end_time!}" class="form-control form-control-inline input-medium default-date-picker" disabled>
                          </td>
                          <td style=" padding: 20px 10px; ">

                            <input id="show_busMes_price_${o}" type="text" value="${bus.price!}元" style="width: 60px;" class="form-control form-control-inline input-medium default-date-picker" disabled>
                            <input id="busMes_price_${o}" type="text" value="${bus.price!}" style="width: 60px;display: none;" class="form-control form-control-inline input-medium default-date-picker" >

                          </td>
                          <td style=" padding: 20px 10px;width: 90px">
                            <input id="busMes_length_${o}" type="text" value="${bus.length!}" class="form-control form-control-inline input-medium default-date-picker" disabled>
                          </td>
                          <td style="padding: 20px 10px;">
                            <input id="show_busMes_bus_time_${o}" style="width: 60px;" type="text" value=" ${bus.bus_time!}" class="form-control form-control-inline input-medium default-date-picker" disabled>
<#--                            <input type="radio" name="time" value="白天">白天-->
<#--                          <input type="radio" name="time" value="夜班" >夜班-->
                            <select id="busMes_bus_time_${o}" style="display:none;" class="btn btn-default dropdown-toggle">
                              <option value="白天" class="btn" <#if bus.bus_time="白天" >selected</#if>>白天</option>
                              <option value="夜班" class="btn" <#if bus.bus_time="夜班">selected</#if> >夜班</option>
                            </select>
<#--                            <input id="busMes_bus_time_${o}" style="width: 60px;" type="text" value=" ${bus.bus_time!}" class="form-control form-control-inline input-medium default-date-picker" disabled>-->
                          </td>
                          <td style=" padding: 20px 10px;">
                            <input style="display:none;" id="busMes_direction_${o}" value="${bus.direction}">
                            <a id="busMes_lock_${o}" onclick="return showUpdateBusMesInput('${o}')" style="width: 60px;"><i class="fa fa-lock"></i></a>
                            <a id="busMes_unlock_${o}" onclick="return updateBusMes('${o}')" style="display: none" style="width: 60px;"><i class="fa fa-unlock"></i></a>
                          </td>
                        </tr>
                      </#list>
                    </table>
                  </form><br><hr style="width="800px"><br>

<#--                  bus信息-->
                  <form  method="post"  name="updateBus" >
                    <div class="servicetitle">
                      <h4>修改线路</h4>
                      <hr>
                    </div>
                    <input id="bus_number" type="text" value="${bus_number!}" style="display: none">
                    <table style="margin-left: 65px;">
                      <tr style="text-align: center">
                        <th style=" padding: 20px 10px; text-align: center;width: 80px;">
                          <a href="/ShowUpdateBus.do?direction=go&&bus_number=${bus_number!}">方向一</a></th>
                        <th style=" padding: 20px 10px;width: 75px;text-align: center;">站点名称</th>
                        <th style=" padding: 20px 10px;text-align: center;width: 80px;">
                          <a href="/ShowUpdateBus.do?direction=back&&bus_number=${bus_number!}">方向二</a></th>
                        <th style=" padding: 20px 10px;text-align: center;">BRT</th>
                        <th style=" padding: 20px 10px;text-align: center;">地铁站</th>
                        <th style=" padding: 20px 10px; text-align: center;width: 80px;"></th>
                        <th style=" padding: 20px 10px; text-align: center;width: 80px;">

                          <a  href="/refreshUpdate" ><i class="fa fa-refresh"></i></a>
                        </th>
                        <th style=" padding: 20px 10px; text-align: center;width: 80px;"></th>

                      </tr>
                      <#assign i=0>
                      <#list  updateBus  as bus>
                        <#assign i=i+1>
                        <tr style="text-align: center" >
                          <td style=" padding: 20px 16px;  width: 75px;text-align: center">
                            <input id="go_number_${i}" type="text" value="${bus.go_number!}" class="form-control form-control-inline input-medium default-date-picker" disabled>
                          </td>
                          <td style=" padding: 20px 16px; width: 275px">
                            <input id="station_name_${i}" type="text" value="${bus.station_name!}" class="form-control form-control-inline input-medium default-date-picker" disabled>
                          </td>
                          <td style=" padding: 20px 16px;  width: 75px;text-align: center">
                            <input id="back_number_${i}" type="text" value="${bus.back_number!}" class="form-control form-control-inline input-medium default-date-picker" disabled>
                          </td>
                          <td style=" padding: 20px 16px;     width: 75px">
                              <input type="checkbox" value="true" id="is_brt_${i}" disabled  <#if bus.is_brt??> checked="checked"<#else ></#if>>有
                          </td>
                          <td style=" padding: 20px 16px; width: 175px">
                            <input id="show_subway_${i}" type="text" value="<#if bus.subway ??><#if bus.subway !="">${bus.subway?substring(0,1)}号线<#if bus.subway?length gt 2 >, ${bus.subway?substring(2)}号线</#if></#if><#else ></#if>" class="form-control form-control-inline input-medium default-date-picker" disabled>
                            <input id="subway_${i}" type="text" value="<#if bus.subway ??><#if bus.subway !="">${bus.subway!}</#if></#if>" class="form-control form-control-inline input-medium default-date-picker" style="display: none">
                          </td>

                          <td style=" padding: 20px 16px;width: 75px">
                            <a id="lock_${i}" onclick="return showUpdateInput('${i}')"><i class="fa fa-lock"></i></a>
                            <a id="unlock_${i}" onclick="return updateBusStation('${i}')" style="display: none"><i class="fa fa-unlock"></i></a>
                          </td>
                          <td style=" padding: 20px 16px;width: 75px">
                            <a id="add_${i}" onclick="return showUpdateAdd('${i}')"><i class="fa fa-plus"></i></a>
                          </td>
                          <td style=" padding: 20px 16px;     width: 75px">
                            <a id="delete_${i}" href="/deleteBusStation.do?bus_number=${bus_number!}&&station_name=${bus.station_name!}" ><i class="fa fa-times"></i></a>
                          </td>
                        </tr>
<#--                        增加-->
                        <tr id="add_tr_${i}" style="display: none">
                          <td style=" padding: 20px 16px;  width: 75px;">
                            <input id="add_go_number_${i}" type="text" value="" style="display: none" class="form-control form-control-inline input-medium default-date-picker" >
                          </td>
                          <td style=" padding: 20px 16px; width: 275px">
                            <input id="add_station_name_${i}" type="text" value="" style="display: none"  class="form-control form-control-inline input-medium default-date-picker" >
                          </td>
                          <td style=" padding: 20px 16px;  width: 75px;">
                            <input id="add_back_number_${i}" type="text" value="" style="display: none"  class="form-control form-control-inline input-medium default-date-picker">
                          </td>
                          <td style=" padding: 20px 16px;width: 75px">
                              <input type="checkbox" value="true" id="add_is_brt_${i}" style="display: none" >有
                          </td>
                          <td style=" padding: 20px 16px; width: 75px">
                            <input id="add_subway_${i}" type="text" value="" style="display: none"  class="form-control form-control-inline input-medium default-date-picker" >
                          </td>

                          <td style=" padding: 20px 16px;     width: 75px">
                            <a id="add_unlock_${i}" onclick="return checkAddBusStation('${i}') " style="display: none"><i class="fa fa-unlock"></i></a>
                          </td>
                        </tr>

                      </#list>
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
<#--  <script type="text/javascript">-->
<#--    $(document).ready(function(){-->
<#--      //点击链接的时候调用-->
<#--      $("#add_unlock_"+${i}).click(function(){-->

<#--        //得到input的值-->
<#--        var go_number = null;-->
<#--        var bus_number =  $("#bus_number").val();-->
<#--        var station_name =  $("#add_station_name_"+${i}).val();-->
<#--        var back_number =  = null;-->
<#--        var is_brt =  = null;-->
<#--        var subway =  = null;-->
<#--        if($("#add_go_number_"+${i}).val()!=""){-->
<#--          go_number = $("#add_go_number_"+${i}).val();-->
<#--        }-->
<#--        if($("#add_back_number"+${i}).val()!=""){-->
<#--          back_number =  $("#add_back_number"+${i}).val();-->
<#--        }-->
<#--        if($("#add_is_brt"+${i}).val().is(':checked'); ){-->
<#--          is_brt =  $("#add_is_brt"+${i}).val();-->
<#--        }-->
<#--        if( $("#add_subway"+${i}).val()!=""){-->
<#--          subway =  $("#add_subway"+${i}).val();-->
<#--        }-->

<#--        //得到id的值-->
<#--        // var id = <%=p.getId() %>;-->
<#--        &lt;#&ndash;alert("go"+go_number+${i});&ndash;&gt;-->
<#--        //设置linkToCart的href的值-->
<#--        $("#add_unlock_${i}").attr("href","updateAddBusStation.do?go_number="+go_number+"&bus_number"+bus_number+"&station_name="+station_name+"&is_brt="+is_brt+"&subway="+subway);-->
<#--      });-->
<#--    });-->
<#--  </script>-->
</body>

</html>
