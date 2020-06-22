// function checkRegister() {
//     if(document.register.user_id.value == "") {
//         alert("请输入您的ID！");
//         document.register.user_id.focus();
//         return false;
//     }
//
//     if(document.register.user_name.value == "") {
//         alert("请输入您的姓名！");
//         document.register.user_name.focus();
//         return false;
//     }
//
//     if(document.register.user_password.value == "") {
//         alert("请输入您的密码！");
//         document.register.user_password.focus();
//         return false;
//     }
//
//     if(document.register.user_phone.value == "") {
//         alert("请输入您的手机！");
//         document.register.user_phone.focus();
//         return false;
//     }
//     if(document.register.user_sex.value == "") {
//         alert("请输入您的性别！");
//         document.register.user_sex.focus();
//         return false;
//     }
//     alert("提交成功！")
//     document.register.submit();
// }

//登陆
// function checkLogin() {
//     if(document.login.user_id.value == "") {
//         alert("请输入您的姓名！");
//         document.login.user_id.focus();
//         return false;
//     }
//     if(document.login.user_password.value == "") {
//         alert("请输入您的密码！");
//         document.login.user_password.focus();
//         return false;
//     }
//     document.login.submit();
// }

function showText(){
    var showAddText= document.getElementById("user_tag");
    showAddText.style.display="block";
    var showAddBtn= document.getElementById("addTagBtn");
    showAddBtn.style.display="block";
}

function checkTag() {
    if(document.addTag.user_tag.value == "") {
        alert("请输入标签！");
        document.addTag.user_tag.focus();
        return false;
    }

    document.addTag.submit();
}

function checkMessage() {
    if(document.sendMessage.mes_content.value == ""){
        alert("不能发送空消息");
        document.sendMessage.mes_content.focus();
        return false;
    }

    document.sendMessage.submit();
}

function checkMoney() {
    var money = document.addMoney.user_money.value;
    if( money == null || money ==''){
        alert("请输入充值金额"+money);
        return false;
    }
        alert("充值成功!充值金额为："+money);
        document.addMoeny.submit();
}

function checkAcceptMoney() {
    var user_money=0.00;

    var money = 0.00;
    if(document.acceptJob.user_money.value!=""){
        user_money =document.acceptJob.user_money.value;
    }
    if(document.acceptJob.user_money.value!=""){
        money =document.acceptJob.user_money.value;
    }
    if(parseFloat(user_money) < parseFloat(money)){
        alert("需要交保证金，余额不足请充值");
        return false;
    }
    document.acceptJob.submit();


}

// 修改个人资料
function updateName(){
    var showAddText= document.getElementById("new_user_name");
    showAddText.style.display="block";
    var showAddBtn= document.getElementById("newUserNameBtn");
    showAddBtn.style.display="none";
}

function updatePhone(){
    var showAddText= document.getElementById("new_user_phone");
    showAddText.style.display="block";
    var showAddBtn= document.getElementById("newUserPhoneBtn");
    showAddBtn.style.display="none";
}

function showNewPassword(){
    var showAddText= document.getElementById("new_user_password");
    showAddText.style.display="block";
    var showAddText2= document.getElementById("user_password");
    showAddText2.style.display="block";
    var showAddBtn= document.getElementById("newUserPasswordBtn");
    showAddBtn.style.display="none";
}

// var select = document.getElementById('selectOrder');
// select.onchange = function(){
//     var val = this.value;
//     document.searchList.submit();
// }

function func(){
    //获取被选中的option标签
    var selectOrder = $('select  option:selected').val();
    document.coverOrder.submit();
}