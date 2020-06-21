<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategotySale.aspx.cs" Inherits="ZoomLaCMS.Manage.Shop.CategotySale" MasterPageFile="~/Manage/I/Default.master" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>商品类别销售排名</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <table class="table table-striped table-bordered table-hover">
        <tr class="text-center">
            <td style="width:33%;">分类ID</td>
            <td style="width:33%;">产品分类</td>
            <td style="width:33%;">总销量</td>
        </tr>
        <ZL:ExRepeater ID="Order_RPT" runat="server" PageSize="10" PagePre="<tr><td colspan='3' class='text-center'>" PageEnd="</td></tr>">
            <ItemTemplate>
                <tr class=" text-center">
                    <td class="tdbg"><%#Eval("NodeID", "{0}")%></td>
                    <td class="tdbg"><%#Eval("NodeName")%></td>
                    <td class="tdbg"><%#getnum(Eval("NodeID","{0}"))%></td>
                </tr>
            </ItemTemplate>
        </ZL:ExRepeater>
    </table>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent"></asp:Content>
