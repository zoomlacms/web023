<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExpPrint.aspx.cs" Inherits="ZoomLaCMS.Manage.Shop.Addon.ExpPrint" ClientIDMode="Static"%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>快递单在线打印</title>
</head>
<body>
<form id="form1" runat="server">
<img src="/App_Themes/Admin/ShopIco/exp_sf.jpg" style="width: 23cm;z-index:-1;left:0cm;top:0cm;position:absolute;height:12.7cm;transform:scale(1,0.91);margin-top:-0.57cm;" class="noprint" />
<div class="nomargin">
    <div style="margin-left:1.4cm;margin-top:3.0cm;position:absolute;">上海逐一软件公司</div>
    <div style="margin-left:7cm;margin-top:3.0cm;position:absolute;">徐林之</div>
    <div style="margin-left:1.4cm;margin-top:3.6cm;position:absolute;">上海XXXXX新区XXX 501</div>
    <div style="margin-left:1.4cm;margin-top:4.2cm;position:absolute;">18897905543</div>
    <div style="margin-left:1.4cm;margin-top:5.0cm;position:absolute;">江西省聚合实业有限公司</div>
    <div style="margin-left:7cm;margin-top:5.0cm;position:absolute;" id="Receiver">收件人</div>
    <div style="margin-left:1.5cm;margin-top:5.5cm;position:absolute;" id="Shengfen"></div>
    <div style="margin-left:3.5cm;margin-top:5.5cm;position:absolute;" id="Chengshi"></div>
    <div style="margin-left:5.8cm;margin-top:5.5cm;position:absolute;" id="Diqu"></div>
    <div style="margin-left:1.4cm;margin-top:6.2cm;position:absolute;" id="Jiedao"></div>
    <div style="margin-left:1.4cm;margin-top:6.8cm;position:absolute;" id="MobileNum"></div><!--18897905543-->
    <div style="margin-left:10cm;margin-top:7.8cm;position:absolute;" id="Ordermessage">此处填入订单备注,如无的话可以为空</div>
</div>
<div style="position:absolute;top:500px;width:100%;padding-left:380px;">
    <input type="button" value="打印单据" onclick="express.print();" class="noprint" style="width:100px;height:50px;" />
</div>
<asp:HiddenField runat="server" ID="Order_Hid" /> 
<style type="text/css">
body{margin:0cm;}
.nomargin{position:relative;margin-left:2.8cm;font-size:10pt;}
</style>
<style media="print" type="text/css">
.noprint{display:none;}
.nomargin {margin-left:0cm;margin-top:0cm; font-size:12pt;}
/*@page {
    size: 230mm 127mm;   or size: 794px 1123px;  3.78 
    size: 297mm 420mm;   or size: 1123px 1588px;  
}*/
</style>
<script src="/JS/jquery-1.11.1.min.js"></script>
<script>
    var express = { model: null };
    express.init = function () {
        var ref = this;
        ref.model = JSON.parse($("#Order_Hid").val());
        for(var key in ref.model)
        {
            $("#" + key).text(ref.model[key]);
        }
    }
    //单打快递单,连打请配置好WCF
    express.print = function () { window.print(); }
    //获取当前屏幕的dpi
    express.getdpi = function () {
        var arrDPI = new Array;
        if (window.screen.deviceXDPI) {
            arrDPI[0] = window.screen.deviceXDPI;
            arrDPI[1] = window.screen.deviceYDPI;
        }
        else {
            var tmpNode = document.createElement("DIV");
            tmpNode.style.cssText = "width:1in;height:1in;position:absolute;left:0px;top:0px;z-index:99;visibility:hidden";
            document.body.appendChild(tmpNode);
            arrDPI[0] = parseInt(tmpNode.offsetWidth);
            arrDPI[1] = parseInt(tmpNode.offsetHeight);
            tmpNode.parentNode.removeChild(tmpNode);
        }
        return arrDPI;//[96, 96]
    }
    express.init();
</script>
</form>
</body>
</html>
