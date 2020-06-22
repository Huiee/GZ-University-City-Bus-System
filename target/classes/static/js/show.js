function saveUserState(i,user_id) {
    var block_time = document.getElementById("update_clock_time_"+i).value;
    location.href="/updateUserState?user_id="+user_id+"&block_time="+block_time;
}
function showUpdateState(i) {
    document.getElementById("update_clock_time_"+i).style.display="";
    document.getElementById("saveUserState_"+i).style.display="";
    document.getElementById("updateStateBtn_"+i).style.display="none";
    // document.getElementById("update_clock_time").style.display="none";
}

//一次换乘收藏
function collectChange(i,station_A,station_B,bus_number_A,bus_number_B) {
    location.href="/collectResultChange?start="+station_A+"&end="+station_B+"&bus_number_A="+bus_number_A+"&bus_number_B="+bus_number_B;
}
//二次换乘收藏
function collectChangeTwo(i,station_A,station_B,bus_number_A,bus_number_D,bus_number_B) {
    location.href="/collectResultChangeTwo?start="+station_A+"&end="+station_B+"&bus_number_A="+bus_number_A+"&bus_number_D="+bus_number_D+"&bus_number_B="+bus_number_B;
}
function showUpdateColck() {
    document.getElementById("add_clock_time").style.display="";
    document.getElementById("closeOldClock").style.display="none";
    document.getElementById("updateClock").style.display="none";
    document.getElementById("update_clock_time").style.display="none";
    document.getElementById("saveClock").style.display="";
}
function showAddClock() {
    document.getElementById("add_clock_time").style.display="";
    document.getElementById("addClock").style.display="none";
    document.getElementById("saveClock").style.display="";
}
function showColckTime() {
    document.getElementById("new_clock_time").style.display="";
    document.getElementById("showClock").style.display="none";
    document.getElementById("saveNewClock").style.display="";
    document.getElementById("closeClock").style.display="";
}
function showNewColckTime() {
    document.getElementById("clock_time").style.display="";
    document.getElementById("showNewClock").style.display="none";
    document.getElementById("closeNewClock").style.display="";

}
function showNewCloseColckTime() {
    document.getElementById("clock_time").value=null;
    document.getElementById("clock_time").style.display="none";
    document.getElementById("showNewClock").style.display="";
    document.getElementById("closeNewClock").style.display="none";
}
function showCloseColckTime() {
    document.getElementById("saveNewClock").style.display="none";
    document.getElementById("new_clock_time").style.display="none";
    document.getElementById("showClock").style.display="";
    document.getElementById("closeClock").style.display="none";
}
function showUpdateNote() {
    document.updateNote.note.disabled=false;
    document.getElementById("showUpdate").style.display="none";
    document.getElementById("updateNote").style.display="";

}
function showUpadteName() {
    document.getElementById('new_user_name').style.display="";
    document.getElementById('updateName').style.display="";
}
function showUpdateAdd(i) {
    document.getElementById('add_tr_'+i).style.display="";
    document.getElementById('add_go_number_'+i).style.display="";
    document.getElementById('add_back_number_'+i).style.display="";
    document.getElementById('add_station_name_'+i).style.display="";
    document.getElementById('add_is_brt_'+i).style.display="";
    document.getElementById('add_subway_'+i).style.display="";
    document.getElementById("add_unlock_"+i).style.display="";
}
function showUpdateBusMesInput(o) {
    // document.getElementById('busMes_number_'+o).disabled=false;
    // document.getElementById('busMes_start_station_'+o).disabled=false;
    // document.getElementById('busMes_end_station_'+o).disabled=false;
    document.getElementById('busMes_start_time_'+o).disabled=false;
    document.getElementById('busMes_end_time_'+o).disabled=false;
    // document.getElementById('busMes_price_'+o).disabled=false;
    document.getElementById('show_busMes_price_'+o).style.display="none";
    document.getElementById('busMes_price_'+o).style.display="";

    document.getElementById('busMes_length_'+o).disabled=false;
    document.getElementById('show_busMes_bus_time_'+o).style.display="none";
    document.getElementById('busMes_bus_time_'+o).style.display="";

    document.getElementById("busMes_lock_"+o).style.display="none";
    document.getElementById("busMes_unlock_"+o).style.display="";
}
function showStation() {
    document.getElementsByClassName('sub').style.display='';
}

function showUpdateInput(i) {

    // document.getElementById('go_number_'+i).disabled=false;
    document.getElementById('station_name_'+i).disabled=false;
    // document.getElementById('back_number_'+i).disabled=false;
    document.getElementById('is_brt_'+i).disabled=false;
    document.getElementById('show_subway_'+i).style.display="none";
    document.getElementById('subway_'+i).style.display="";
    document.getElementById("lock_"+i).style.display="none";
    document.getElementById("unlock_"+i).style.display="";
}