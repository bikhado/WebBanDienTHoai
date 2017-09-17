<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="GiaoHang.aspx.cs" Inherits="GiaoHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script>
        $(document).ready(function () {
            $(window).load(function () {
                $('#preloader').fadeOut('slow', function () { $(this).remove(); });
            });
            window.location.hash = '#giaohang';
        });
    </script>
    <div id="giaohang">
    <ul class="breadcrumb" >
		<li><a href="index.html">Home</a> <span class="divider">/</span></li>
		<li class="active">Giao hàng</li>
    </ul>
	<h3> Hình thức giao hàng</h3>	
	<hr class="soft"/>
	<h5>Giao Hàng Tiết Kiệm</h5><br/>
	<p>
	Vận chuyển từ 4 đến 5 ngày.
</p>
<h5>Giao Hàng Tiêu Chuẩn</h5><br/>
<p>
    Vận chuyển từ 3 đến 4 ngày.
</p>
<h5>Giao Hàng Hỏa Tốc</h5><br/>
<p>
    Vận chuyển từ 1 đến 2 ngày.
	</p>
        </div>
</asp:Content>

