<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderList.aspx.cs" Inherits="ZoomLaCMS.Manage.Shop.OrderList" MasterPageFile="~/Common/Master/Empty.master" %>
<%@ Import Namespace="ZoomLa.Model" %>
<%@ Import Namespace="ZoomLa.BLL" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>订单列表</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div id="BreadDiv" class="container-fluid mysite">
        <div class="row">
            <ol id="BreadNav" class="breadcrumb navbar-fixed-top">
                <li><a href="ProductManage.aspx">商城管理</a></li>
                <li><a href="OrderList.aspx">订单管理</a></li>
                <li class="active"><a href="OrderList.aspx">订单列表</a> [<a href="AddOrder.aspx?">添加订单</a>]</li>
                <div id="help" class="pull-right text-center"><a href="javascript:;" class="help_btn active" onclick="selbox.toggle(cfg);"><i class="fa fa-search"></i></a></div>
                <div id="sel_box" style="height:90px;border-top:1px solid #ddd;">
                    <div class="input-group" style="width:1039px;">
                        <asp:TextBox runat="server" ID="ProName_T" class="form-control text_md" placeholder="商品名称" />
                        <asp:TextBox runat="server" ID="OrderNo_T" class="form-control text_md" placeholder="订单号" />
                        <ZL:TextBox runat="server" ID="ReUser_T" class="form-control text_md" placeholder="收货人"/>
                        <asp:TextBox runat="server" ID="Mobile_T" class="form-control text_md" placeholder="手机号" ValidType="MobileNumber"  />
                        <asp:TextBox runat="server" ID="UserID_T" class="form-control text_md" placeholder="用户ID 多个用户用,号分隔" />
                        <span class="input-group-addon" title="支持多条件查询"><i class="fa fa-leaf"></i></span>
                        <%--        <asp:TextBox runat="server" ID="TextBox5" class="form-control" placeholder="销售人ID" />--%>
                        <%--  <span class="input-group-btn">
            <asp:LinkButton runat="server" ID="Export_Btn" class="btn btn-info" OnClick="Export_Btn_Click"><i class="fa fa-download"></i> 导出</asp:LinkButton>
            <button type="button" class="btn btn-info"><i class="fa fa-print"></i> 打印电子面单</button>
            <button type="button" class="btn btn-info"><i class="fa fa-print"></i> 打印普通快递单</button>
            <button type="button" class="btn btn-info"><i class="fa fa-list"></i> 表格批量发货</button>
        </span>--%>
                    </div>
                    <div class="input-group margin_t5" style="display: inline-block;">
                        <asp:DropDownList runat="server" ID="SkeyType_DP" class="form-control text_md">
                            <asp:ListItem Value="exp" Selected="True">快递单号</asp:ListItem>
                            <asp:ListItem Value="oid">订单ID</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox runat="server" ID="Skey_T" class="form-control text_md" placeholder="请输入关键词" />
                        <asp:TextBox runat="server" ID="Remind_T" class="form-control text_md" placeholder="订单备注"></asp:TextBox>
                        <asp:TextBox runat="server" ID="STime_T" class="form-control text_md" placeholder="订单创建起始时间" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'ETime_T\')}'});" />
                        <asp:TextBox runat="server" ID="ETime_T" class="form-control text_md" placeholder="订单创建结束时间" onclick="WdatePicker({minDate:'#F{$dp.$D(\'STime_T\')}'});" />
                        <span class="input-group-btn">
                            <asp:LinkButton runat="server" ID="Skey_Btn" class="btn btn-primary" OnClick="Skey_Btn_Click"><i class="fa fa-search"></i> 查询</asp:LinkButton>
                            <button type="button" class="btn btn-primary" onclick="cleartxt();"><i class="fa fa-recycle"></i>清除查询</button>
                        </span>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </ol>
        </div>
    </div>
<div style="height:40px;"></div>
<div id="maindiv">
    <ul id="ordernav" class="nav nav-tabs margin_t5">
       <li data-type="all"><a href="OrderList.aspx"><asp:Label runat="server" ID="order_all_l" Text="全部订单"></asp:Label></a></li>
       <li data-type="unexp"><a href="OrderList.aspx?filter=unexp"><asp:Label runat="server" ID="order_unexp_l" Text="待发货"></asp:Label></a></li>
       <li data-type="unpaid"><a href="OrderList.aspx?filter=unpaid"><asp:Label runat="server" ID="order_unpaid_l" Text="待付款"></asp:Label></a></li>
       <li data-type="exped"><a href="OrderList.aspx?filter=exped"><asp:Label runat="server" ID="order_exped_l" Text="已发货"></asp:Label></a></li>
       <li data-type="finished"><a href="OrderList.aspx?filter=finished"><asp:Label runat="server" ID="order_finished_l" Text="交易完成"></asp:Label></a></li>
       <li data-type="unrefund"><a href="OrderList.aspx?filter=unrefund"><asp:Label runat="server" ID="order_unrefund_l" Text="待退款"></asp:Label></a></li>
       <li data-type="refunded"><a href="OrderList.aspx?filter=refunded"><asp:Label runat="server" ID="order_refunded_l" Text="退款完成"></asp:Label></a></li>
       <li data-type="recycle"><a href="OrderList.aspx?filter=recycle"><asp:Label runat="server" ID="order_recycle_l" Text="回收站"></asp:Label></a></li>
    </ul>
    <div class="orderlist" id="orderlist">
            <div runat="server" id="empty_div" visible="false" class="alert alert-info margin_t5">没有匹配的订单信息</div>
            <ZL:ExRepeater ID="Order_RPT" runat="server" OnPreRender="Order_RPT_PreRender" PagePre="<div class='clearfix'></div><div class='text-center foot_page'><label class='pull-left'><input type='checkbox' id='chkAll'/>全选</label>" PageEnd="</div>"
                 OnItemDataBound="Order_RPT_ItemDataBound" OnItemCommand="Order_RPT_ItemCommand" PageSize="10">
                <ItemTemplate>
                    <div class="order-item">
                        <table class="table prolist">
                            <thead>
                            <tr class="tips_div">
                                <th class="orderinfo" colspan="8">
                                    <div style="display: inline-block; width: 1030px;">
                                        <span><strong><label><input type="checkbox" name="idchk" value="<%#Eval("ID") %>" />编号：</strong><%#Eval("ID") %></label></span>
                                        <span><strong>订单号：</strong><a href="OrderListInfo.aspx?ID=<%#Eval("ID") %>" title="订单详情"><%#Eval("OrderNo") %></a></span>
                                        <span><strong>下单时间：</strong><%#Eval("AddTime") %></span>
                                        <span><strong>付款单号：</strong><%#GetPayInfo() %></span>
                                        <span><strong>推荐人：</strong><%#GetPUserInfo() %></span>
                                    </div>
                                    <asp:Label ID="Store_L" runat="server" style="font-size:16px;" />
                                    <a href="javascript:;" title="收缩/展开" onclick="order.slideup(this);"><i class="fa fa-chevron-circle-down" style="font-size:20px;"></i></a>
                                    <asp:LinkButton runat="server" CommandArgument='<%#Eval("ID") %>' CommandName="del2" Visible='<%#Filter.Equals("recycle")?false:true %>'
                                         class="pull-right" OnClientClick="return confirm('确定要移入回收站吗');"><i class="fa fa-trash"></i> 删除订单</asp:LinkButton>
                                </th>
                            </tr></thead>
                            <tbody class="prowrap">
                                <asp:Repeater ID="Pro_RPT" runat="server" EnableViewState="false" OnItemDataBound="Pro_RPT_ItemDataBound">
                                    <ItemTemplate>
                                        <tr>
                                            <td style="text-align: left; border-right: none; border-left: none;">
                                                <span>
                                                    <a href="<%#GetShopUrl() %>" target="_blank">
                                                        <img src="<%#GetImgUrl() %>" onerror="shownopic(this);" class="img50" /></a>
                                                    <span><%#Eval("Proname") %></span>
                                                </span>
                                            </td>
                                            <td class="td_md goodservice" style="border-left: none;"><%#GetRepair() %></td>
                                            <td class="td_md"><%#Eval("Shijia","{0:f2}") %></td>
                                            <td class="td_md gray9">x<%#Eval("Pronum") %></td>
                                            <asp:Literal runat="server" ID="Order_Lit" EnableViewState="false"></asp:Literal>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <%#GetMessage() %>
                            </tbody>
                        </table>
                    </div>
                </ItemTemplate>
                <FooterTemplate></FooterTemplate>
            </ZL:ExRepeater>
        <div class="margin_t5">
           <%-- <button type="button" class="btn btn-primary" onclick="OutToExcel();">下载概览</button>--%>
            <asp:Button ID="DownDetails_B" runat="server" CssClass="btn btn-primary" OnClick="DownDetails_B_Click" Text="下载详单" />
            <div id="op_normal" runat="server" visible="false" style="display:inline-block;">
                <asp:Button ID="Sure_Btn" class="btn btn-primary" Text="确认订单" runat="server" OnClick="Sure_Btn_Click" OnClientClick="return confirm('要确认订单吗?');" />
                <asp:Button ID="Recycle_Btn" class="btn btn-primary" Text="移除订单" runat="server" OnClick="Recycle_Btn_Click" OnClientClick="return confirm('确认要移入回收站吗?');" />
            </div>
            <div id="op_recycle" runat="server" visible="false" style="display:inline-block;">
                <asp:Button runat="server" ID="BatRecover_Btn" class="btn btn-primary" Text="批量还原" OnClick="BatRecover_Btn_Click" />
                <asp:Button runat="server" ID="BatDel_Btn" class="btn btn-danger" Text="批量删除" OnClick="BatDel_Btn_Click" OnClientClick="return confirm('不可恢复性删除,确定要移除订单吗?');"/>
                <asp:Button runat="server" ID="Clear_Btn" class="btn btn-danger" Text="清空回收站" OnClick="Clear_Btn_Click" OnClientClick="return confirm('不可恢复性删除,确定要移除订单吗?');"/>
            </div>
            <div class="pull-right"><span>金额合计:</span><span class="rd_red_l"><%=TotalSum_Hid.Value %></span></div>
        </div>
     </div>
</div>
<asp:HiddenField runat="server" ID="TotalSum_Hid" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<style>
#ordernav li.active{font-weight:bolder;}
.table {margin-bottom:0px;}
.rd_red_l{color:red;font-size:1.5em;}
.orderlist td,.orderlist th{font-size:14px;font-family:'Microsoft YaHei';}
.orderlist .order-item{border:1px solid #ddd;border-top:none;font-size:14px;font-family:'Microsoft YaHei';}
.orderlist .gray9{color:#999;}
.orderlist .orderinfo { line-height:20px;}
/*.orderlist .shopinfo{line-height:20px;}*/
.orderlist .opinfo {line-height:20px;text-align:right;padding-right:15px;color:gray;}
.orderlist .tips_div{background-color:#f5f5f5;font-weight:normal;}
.orderlist .tips_div span{margin-right:5px;font-weight:normal;}
.orderlist .top_div{line-height:30px; background-color:#f5f5f5;margin-top:10px;}
.orderlist .prolist td{ line-height:70px; border-left:1px solid #ddd;height:70px;text-align:center;}
.orderlist .prolist td:last-child{border-right:none;}
.orderlist .proname div{padding:5px;}
.orderlist .goodservice {text-align:right;padding-right:20px;}
.orderlist .prolist .rowtd {line-height:20px;padding-top:30px}
.orderlist .order_navs{position:relative;}
.orderlist .search_div{position:absolute;right:0px;top:3px;}
.orderlist .ordertime{color:#999;}
.orderlist .order_bspan { font-size:1em;}
.orderlist .idcmessage{color:#999;line-height:normal;margin:0;}
.orderlist .idm_tr td{line-height:normal;height:auto;text-align:left;}
.foot_page{border:1px solid #ddd;padding:5px;border-top:none;}
#sel_box{ display:none; position:absolute; top:36px; left:0; padding-top:5px; padding-left:40px; padding-right:40px; width:100%; height:44px; background:#f1f1f1; box-shadow:0 6px 12px rgba(0,0,0,.175); z-index:99; }
#sel_box .input-group{ border-radius:0;}
#sel_box input.form-control{ border-radius:0; border-color:#ccc;} 
</style>
<script src="/JS/Label/ZLHelper.js"></script>
<script src="/JS/SelectCheckBox.js"></script>
<script src="/JS/Controls/ZL_Dialog.js"></script>
<script src="/JS/DatePicker/WdatePicker.js"></script>
<script src="/JS/ZL_Regex.js"></script>
<script>
    var siteconf = { path: "<%=customPath2%>" };
    var cfg = { show: function () { $("#maindiv").css("margin-top", "90px"); console.log("1"); }, hide: function () { $("#maindiv").css("margin-top", "0px"); console.log("2"); } }
    $(function () {
        var filter = "<%:Filter%>";
    if (filter == "") { filter = "all"; }
    $("#ordernav li[data-type=" + filter + "]").addClass("active");
    $("#chkAll").click(function () { selectAllByName(this, "idchk"); });
     //有非空的搜索条件,则不隐藏搜索框
    $("#sel_box input[type='text']").each(function () {
        if (!ZL_Regex.isEmpty(this.value)) { console.log("test",this.value); selbox.toggle(cfg); return false; }
    });

})
function cleartxt() { $("input[type='text']").val(""); }
<%--function OutToExcel() {
    var $html = $(document.getElementById("orderlist").outerHTML);
    $html.find("td").css("border", "1px solid #666");
    $html.find("tr").find("td:first").remove();
    $html.find("#page_tr").remove();
    $html.find("tr:last").remove();
    ZLHelper.OutToExcel($html.html(), '<%=DateTime.Now.ToString("yyyyMMdd")%>订单概览');
}--%>
    var order = {
        slideup: function (obj) {
            var $btn = $(obj).find("i");
            var $wrap = $(obj).closest(".prolist").find('.prowrap');
            if ($wrap.is(":visible")) { $wrap.hide(); $btn.removeClass("fa-chevron-circle-down").addClass("fa-chevron-circle-right"); }
            else { $wrap.show(); $btn.removeClass("fa-chevron-circle-right").addClass("fa-chevron-circle-down"); }
        }
    };
</script>
</asp:Content>

