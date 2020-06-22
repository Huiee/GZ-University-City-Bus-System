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
  <link href="/css/font-awesome.css"  type="text/css" rel="stylesheet" />
  <!-- Custom styles for this template -->
  <link href="/css/style.css"  type="text/css" rel="stylesheet">
  <link href="/css/style-responsive.css"  type="text/css" rel="stylesheet">
  
  
</head>

<body>
  <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
  <div id="login-page">
    <div class="container">
      <form class="form-login" action="/showAdminCover"   method="post" name="login" accept-charset="UTF-8">
        <h2 class="form-login-heading">登 陆</h2>
        <div class="login-wrap">
          <input type="text" name="user_id" class="form-control" placeholder="账 号" autofocus>
          <br>
          <input type="password" name="user_password" class="form-control" placeholder="Password">
<br>
          <button class="btn btn-theme btn-block"  type="button" onclick="return checkLogin()"><i class="fa fa-lock"></i> 登陆</button>
          <hr>
          <div class="login-social-link centered">
            <p>没有账号？</p>
            <button class="btn btn-facebook" type="button" onclick="location.href='/register.do'"><i class="fa fa-facebook"></i> 注册</button>
       </div>
          <div class="registration">
            Don't have an account yet?<br/>
            <a class="" href="/register.do">
              Create an account
              </a>
          </div>
        </div>

      </form>
    </div>
  </div>
  <!-- js placed at the end of the document so the pages load faster -->
  <script  src="/js/jquery.min.js"></script>
  <script  src="/js/bootstrap.min.js"></script>
  <!--BACKSTRETCH-->
  <!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
  <script type="text/javascript" src="/js/jquery.backstretch.min.js"></script>
  <script  src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
  <script type="text/javascript" src="/js/check.js"></script>
  <script>
    // $.backstretch("/../images/login-bg.jpg", {
    //   speed: 500
    // });
    // $.backstretch("/../resources/static/images/login_bg.png", {
    //   speed: 500
    // });
  </script>
</body>

</html>
