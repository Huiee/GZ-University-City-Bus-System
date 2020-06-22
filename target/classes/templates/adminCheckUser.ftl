<!DOCTYPE html>
<html lang="en">
<#--<html lang="en" xmlns:th="http://www.thymeleaf.org">-->
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
<#--  <link th:href="@{/static/css/style.css}" rel="stylesheet">-->
  <link href="/css/style-responsive.css" rel="stylesheet">
  <link href="/css/common.css" rel="stylesheet">

  <link href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.css"  rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css" rel="stylesheet">
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
<#--      <div class="nav notify-row" id="top_menu">-->
        <!--  notification start -->
<#--        <ul class="nav top-menu">-->

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
        <div class="row mt">
<#--         搜索-->
          <div class="mb" style="color: #d2cece;width: 530px;margin:0px 15px 0px 20px">
            <div class="darkblue-panel pn">
              <div class="darkblue-header servicetitle">
                <h5>SEARCH USER</h5>
                <hr>
              </div>
              <form action="/searchUser.do" name="searchUser" method="post" style="margin-top:40px">
                <table>
                  <tr>
                    <td style="width: 150px; padding: 2px 5px 2px 15px;">用户账号</td>
                    <td style="width: 850px; padding: 2px 10px;">
                      <input class="form-control form-control-inline input-medium default-date-picker" name="user_id" size="16" type="text" value="" placeholder="请输入用户账号">
                    </td>
                    <td style="padding: 20px 20px;"> <button type="button" class="btn btn-theme"onclick="return checkSearchUser()">查询</button></td>
                  </tr>
                  <tr>
                    <td style="padding: 20px 20px;" colspan="3">
                    <a class="btn btn-theme" href="/showAllUserMes" style="width:200px">查看所有用户</a>
                    </td>
                  </tr>
                </table>
                <br>
              </form>
              <#--                          <canvas id="serverstatus02" height="180" width="180" style="width: 120px; height: 120px;"></canvas>-->
            </div>
          </div>

          <div class="col-md-4 col-sm-4 mb" style="max-width: 23.333333%;">
          <div class="darkblue-panel pn">
            <div class="darkblue-header">
              <h5>USER SEX</h5>
            </div>
            <canvas id="myChart" width="30" height="30" style="padding: 15px;"></canvas>
            <p>May 16, 2020</p>

          </div>
          </div>


          <div class="col-md-4 col-sm-4 mb" style="max-width: 23.333333%;">
            <div class="darkblue-panel pn">
              <div class="darkblue-header">
                <h5>USER AGE</h5>
              </div>
              <canvas id="myChartAge" width="30" height="30" style="padding: 15px;"></canvas>
              <p>May 16, 2020</p>
              <#--                          <canvas id="serverstatus02" height="180" width="180" style="width: 120px; height: 120px;"></canvas>-->
            </div>
          </div>

<#--显示用户-->
          <#if users ??>
          <div class="col-md-12">
            <div class="content-panel-table">
              <h4><i class="fa fa-angle-right" style="margin-left:30px"></i> 用户信息</h4><hr><table class="table table-striped table-advance table-hover">
                <form  method="post">
                <thead>
                <tr>
                  <th><i class="fa fa-users"></i> 账号</th>
                  <th class="hidden-phone"><i class="fa fa-tasks"></i> 昵称</th>
                  <th><i class="fa fa-bookmark"></i> 性别</th>
                  <th><i class=" fa fa-edit"></i> 账号状态</th>
                  <th></th>
                </tr>
                </thead>
                <tbody>
                <#assign i=0>
                <#list users as user>
                  <#assign i=i+1>
                <tr>
                  <td>
                    <a href="basic_table.html#">${user.user_id!}</a>
                  </td>
                  <td class="hidden-phone">${user.user_name!}</td>
                  <td>${user.user_sex!}</td>
                  <td>
                    <#if user.user_state=true>
                      <span class="label label-info label-mini">正常</span>
                      <#else >
                        <span class="label label-warning label-mini">封禁中</span>
                    </#if>
                    </td>
                  <td>
                    <input type="date" id="update_clock_time_${i}" name="block_time" value=""  style="margin-right: 20px;float: left;width: 150px;display: none" class="form-control form-control-inline input-medium default-date-picker" >
                    <button type="button" id="saveUserState_${i}" onclick="return saveUserState('${i}','${user.user_id!}')" class="btn btn-success btn-xs" style="display: none"><i class="fa fa-check"></i></button>
                    <#if user.user_state=true>
                    <button type="button" id="updateStateBtn_${i}" class="btn btn-danger btn-xs" onclick="return showUpdateState('${i}')"><i class="fa fa-pencil"></i></button>
                    <#else>
                      <a  class="btn btn-primary btn-xs" onclick="location.href='UserStateFree?user_id=${user.user_id!}'"><i class="fa fa-pencil"></i></a>
                    </#if>
<#--                    <button class="btn btn-danger btn-xs"><i class="fa fa-trash-o "></i></button>-->
                  </td>
                </tr>
                </#list>

                </tbody>
              </table>
              </form>
            </div>
            <!-- /content-panel -->
          </div>
          </#if>
<#-- 搜索 -- end -->

<#--  结果 --- s --->
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
          &copy; <strong>H_Yi_Lee</strong>. 2020.5
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
  <!--script for this page-->
  <script  type="text/javascript" src="/js/morris-conf.js" rel="stylesheet"></script>
  <script  type="text/javascript" src="/js/morris.min.js" rel="stylesheet"></script>
  <script  type="text/javascript" src="/js/jquery.min.js" rel="stylesheet"></script>
  <script  type="text/javascript" src="/js/show.js" rel="stylesheet"></script>
  <script  type="text/javascript" src="/js/check.js" rel="stylesheet"></script>

  <script   type="text/javascript" src="/js/bootstrap.min.js" rel="stylesheet"></script>
  <script  type="text/javascript" src="/../jquery-ui-1.9.2.custom.min.js" rel="stylesheet"></script>
  <script  type="text/javascript" src="/../jquery.ui.touch-punch.min.js" rel="stylesheet"></script>
  <script class="include" type="text/javascript" src="/js/jquery.dcjqaccordion.2.7.js" rel="stylesheet"></script>
  <script  type="text/javascript" src="/js/jquery.scrollTo.min.js" rel="stylesheet"></script>
  <script  type="text/javascript" src="/js/jquery.nicescroll.js" rel="stylesheet"></script>
  <!--common script for all pages-->
  <script type="text/javascript" src="/js/common-scripts.js" rel="stylesheet"></script>


<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
  <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
  <script>
    var ctx = document.getElementById("myChart").getContext('2d');
    var myChart = new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: ["男", "女"],
        datasets: [{
          label: '# of Votes',
          data: ["${boy!}", "${girl!}"],
          backgroundColor: [
            // 'rgba(255, 99, 132, 0.2)',
            // 'rgba(54, 162, 235, 0.2)',
            'rgb(80,123,163)',
            'rgba(255,99,132,1)',

          ],
          borderColor: [
            // 'rgba(255,99,132,1)',
            // 'rgba(54, 162, 235, 1)',
                '#ffffff',
            '#ffffff',
          ],
          borderWidth: 1,
        }]
      },
      options: {
        cutoutPercentage:70,
      }


    });
  </script>

  <script>
    var ctx = document.getElementById("myChartAge").getContext('2d');
    var myChartAge = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ["80","85","90","95","00"],
        datasets: [{
          label: '# 年龄层',
          data: ["${age_80!}","${age_85!}","${age_90!}","${age_95!}","${age_00!}"],
          backgroundColor: [
            '#1c9ca7',
            '#9876aa',
            '#54c98d',
            '#f68275',
            '#ffdf46',
            // 'rgba(255, 99, 132, 0.2)',
            // 'rgba(54, 162, 235, 0.2)',

          ],
          borderColor: [
            // 'rgba(255,99,132,1)',
            // 'rgba(54, 162, 235, 1)',
            '#ffffff',
            '#ffffff',
            '#ffffff',
            '#ffffff',
            '#ffffff',
          ],
          borderWidth: 1,
          barPercentage: 0.7,
        }]
      },
      options: {
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero:true
            }
          }]
        }
      }
    });
  </script>

<#--  <script>-->
<#--    var doughnutData = [{-->
<#--      value: 60,-->
<#--      color: "#1c9ca7"-->
<#--    },-->
<#--      {-->
<#--        value: 40,-->
<#--        color: "#f68275"-->
<#--      }-->
<#--    ];-->
<#--    var myDoughnut = new Chart(document.getElementById("serverstatus02").getContext("2d")).Doughnut(doughnutData);-->
<#--  </script>-->
</body>

</html>
