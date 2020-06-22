

function updateClockSave() {
    var note_time = document.getElementById("note_time").value;
    var   clock_time=document.getElementById("add_clock_time").value;
    alert("修改闹钟成功");
    location.href="/updateClock?note_time="+note_time+"&clock_time="+clock_time;
}
function newClockSave() {
    var note_time = document.getElementById("note_time").value;
    var   clock_time=document.getElementById("new_clock_time").value;
    alert("设置闹钟成功");
    location.href="/updateClock?note_time="+note_time+"&clock_time="+clock_time;
}
// 修改公交信息
function updateBusMes(o) {
    var bus_number = document.getElementById("busMes_number_"+o).value;
    var start_time = document.getElementById("busMes_start_time_"+o).value;
    var end_time = document.getElementById("busMes_end_time_"+o).value;
    var price = document.getElementById("busMes_price_"+o).value;
    var length = document.getElementById("busMes_length_"+o).value;
    var bus_time = document.getElementById("busMes_bus_time_"+o).value;
    var direction = document.getElementById("busMes_direction_"+o).value;

    location.href="/updateBusMes.do?bus_number="+bus_number+"&start_time="+start_time+"&end_time="+end_time+"&price="+price+"&length="+length+"&bus_time="+bus_time+"&direction="+direction;
}
// 修改站点
function updateBusStation(i) {
    var bus_number = document.getElementById("bus_number").value;
    var station_name = document.getElementById("station_name_"+i).value;
    var is_brt = document.getElementById("is_brt_"+i).checked;
    var subway = document.getElementById("subway_"+i).value;
    var go_number = document.getElementById("go_number_"+i).value;
    var back_number = document.getElementById("back_number_"+i).value;

    location.href="/updateBus.do?bus_number="+bus_number+"&go_number="+go_number+"&station_name="+station_name+"&back_number="+back_number+"&is_brt="+is_brt+"&subway="+subway;
}


// 增加站点
function checkAddBusStation(i) {
    var bus_number = document.getElementById("bus_number").value;
    var station_name = document.getElementById("add_station_name_"+i).value;
    var go_number = document.getElementById("add_go_number_"+i).value;
    var back_number = document.getElementById("add_back_number_"+i).value;
    var is_brt = document.getElementById("add_is_brt_"+i).checked;
    if(is_brt==true){
        is_brt=true;
    }else {
        is_brt="";
    }
    var subway = document.getElementById("add_subway_"+i).value;
    // alert("--"+bus_number+"--"+go_number+"--"+back_number);
    // document.updateBus.submit();
    location.href="/updateAddBusStation.do?bus_number="+bus_number+"&go_number="+go_number+"&station_name="+station_name+"&back_number="+back_number+"&is_brt="+is_brt+"&subway="+subway;
}
//修改日志


function checkUpdateNote() {
    if(document.updateNote.note.value == "") {
        alert("请输入内容！");
        document.updateNote.note.focus();
        return false;
    }
    document.updateNote.submit();
}
//添加日志
function checkAddNote() {
    if(document.addNote.note.value == "") {
        alert("请输入内容！");
        document.addNote.note.focus();
        return false;
    }
    document.addNote.submit();

}


function checkUpdateBusNumberChange() {
    if(document.updateBusNumber.bus_number.value == "") {
        alert("请输入原公交线路的号码！");
        document.updateBusNumber.bus_number.focus();
        return false;
    }
    if(document.updateBusNumber.new_bus_number.value == "") {
        alert("请输入原公交线路的号码！");
        document.updateBusNumber.bus_number.focus();
        return false;
    }
    document.updateBusNumber.submit();
}

function checkSearchUser() {
    if(document.searchUser.user_id.value == "") {
        alert("请输入用户账号！");
        document.searchUser.user_id.focus();
        return false;
    }
    document.searchUser.submit();
}

function checkUpdateBusNumber() {
    if(document.showUpdateBus.bus_number.value == "") {
        alert("请输入修改公交线路的号码！");
        document.showUpdateBus.bus_number.focus();
        return false;
    }
    document.showUpdateBus.submit();
}

function checkUpdateStationName() {
    if(document.updateStationName.station_name.value == "") {
        alert("请输入修改公交站点！");
        document.updateStationName.station_name.focus();
        return false;
    }
    document.updateStationName.submit();
}
function checkDeleteNumber() {
    if(document.deleteBus.bus_number.value == "") {
        alert("请输入删除公交线路的号码！");
        document.deleteBus.bus_number.focus();
        return false;
    }
    document.deleteBus.submit();
}
function  checkAddNumber() {
    if(document.showAddTable.add_number.value == "") {
        alert("请输入增加行数！");
        document.showAddTable.add_number.focus();
        return false;
    }
    document.showAddTable.submit();

}
function checkStationName() {
    if(document.busStation.station_name.value == "") {
        alert("请输入站点！");
        document.busStation.station_name.focus();
        return false;
    }
    document.busStation.submit();
}

function checkBusChange() {
    if(document.bus.start.value == "") {
        alert("请输入出发站点！");
        document.bus.start.focus();
        return false;
    }
    if(document.bus.end.value == "") {
        alert("请输入目的站点！");
        document.bus.end.focus();
        return false;
    }
    document.bus.submit();
}
function change() {
    var start =document.bus.start.value;
    var end =document.bus.end.value;
    document.bus.start.value=end;
    document.bus.end.value=start;
}
function checkBusNumber() {
    if(document.busNumber.bus_number.value == "") {
        alert("请输入公交车号码！");
        document.busNumber.bus_number.focus();
        return false;
    }
    document.busNumber.submit();
}

function checkRegister() {
    if(document.register.user_id.value == "") {
        alert("请输入您的ID！");
        document.register.user_id.focus();
        return false;
    }

    if(document.register.user_name.value == "") {
        alert("请输入您的姓名！");
        document.register.user_name.focus();
        return false;
    }

    if(document.register.user_password.value == "") {
        alert("请输入您的密码！");
        document.register.user_password.focus();
        return false;
    }

    if(document.register.user_sex.value == "") {
        alert("请输入您的性别！");
        document.register.user_sex.focus();
        return false;
    }
    alert("提交成功！")
    document.register.submit();

}

function  checkLogin() {
    if(document.login.user_id.value == "") {
        alert("请输入您的ID！");
        document.login.user_id.focus();
        return false;
    }

    if(document.login.user_password.value == "") {
        alert("请输入您的密码！");
        document.login.user_password.focus();
        return false;
    }
    document.login.submit();
}