<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductSale.aspx.cs" Inherits="ZoomLaCMS.Manage.Shop.ProductSale" MasterPageFile="~/Manage/I/Default.master" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>总体销售统计</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <table class="table table-striped table-bordered table-hover">
        <tr class="text-center">
            <td>产品ID</td>
            <td>产品名称</td>
            <td>总销量</td>
        </tr>
        <ZL:ExRepeater ID="Repeater1" PageSize="10" runat="server" PagePre="<tr><td colspan='3' class='text-center'>" PageEnd="</td></tr>">
            <ItemTemplate>
                <tr class="text-center">
                    <td class="tdbg">
                        <%#Eval("proid","{0}") %></td>
                    <td class="tdbg"><%#Eval("proname") %></td>
                    <td class="tdbg"><%#Eval("cc") %></td>
                </tr>
            </ItemTemplate>
        </ZL:ExRepeater>
    </table>
</asp:Content>
