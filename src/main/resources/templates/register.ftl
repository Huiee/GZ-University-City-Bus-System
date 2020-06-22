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


</head>

<body>
<!-- **********************************************************************************************************************************************************
    MAIN CONTENT
    *********************************************************************************************************************************************************** -->
<div id="login-page">
    <div class="container">
        <form class="form-login" action="/addUser.do"  method="post" name="register" accept-charset="UTF-8">
            <h2 class="form-login-heading">注 册</h2>
            <div class="login-wrap">
                <input name="user_id" class="form-control" type="text" placeholder="账 号" value="${register_id!}" autofocus>
                <div class="id-exist">${exist_id!}</div>
                <br>
                <input name="user_name"class="form-control" type="text" placeholder="昵 称" value="${register_name!}"><br>

                <input name="user_password" class="form-control" type="password" placeholder="Password"><br>

                <input name="user_birthday"class="form-control" max="${today!}" type="date" placeholder="出生日期" value="${register_birthday!}"><br>

                <span class="user-sex">
                    <input type="radio" name="user_sex" value="男" >男</span>
                <span class="user-sex">
                    <input type="radio" name="user_sex" value="女" >女
                </span><br>

                <button class="btn btn-theme btn-block" href="index.html" type="button"  onclick= " return checkRegister()"><i class="fa fa-lock"></i> 注册</button>
                <hr>
                <div class="login-social-link centered">
                    <button class="btn btn-facebook" type="button"  onclick="location.href='/showLogin'"><i class="fa fa-facebook"></i> 返回</button>
                </div>
                <div class="registration">
                    广州大学城公交查询系统
                </div>
            </div>

        </form>
    </div>
</div>
<!-- js placed at the end of the document so the pages load faster -->
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script type="text/javascript" src="/js/bootstrap.min.js"></script>

<!--BACKSTRETCH-->
<!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
<script type="text/javascript" src="/js/jquery.backstretch.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script type="text/javascript" src="/js/check.js"></script>
<script>
    $.backstretch("/../images/login-bg.jpg", {
        speed: 500
    });
    // $.backstretch("/../resources/static/images/login_bg.png", {
    //   speed: 500
    // });
</script>
</body>

</html>
