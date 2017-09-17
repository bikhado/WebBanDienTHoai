<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Compair.aspx.cs" Inherits="Compair" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%ToolsDT tools = new ToolsDT(); %>
    <script>
        $(document).ready(function () {
            $(window).load(function () {
                $('#preloader').fadeOut('slow', function () { $(this).remove(); });
            });
            $('#goback').click(function () {

                window.history.back();
            })
        });
    </script>
<ul class="breadcrumb">
		<li><a href="Default.aspx">Home</a> <span class="divider">/</span></li>
		<li class="active">So Sánh Sản Phầm</li>
    </ul>
	<h3> So Sánh Sản Phầm <small class="pull-right"> 2 sản phẩm được so sánh </small></h3>	
	<hr class="soft"/>

	<table id="compairTbl" class="table table-bordered">
              <thead>
                <tr>
                  <th>Features</th>
                  <th><%=tools.getSanPhamByID(Request.QueryString.Get("idsp0")).Rows[0]["TenSP"].ToString() %> </th>
                  <th><%=tools.getSanPhamByID(Request.QueryString.Get("idsp1")).Rows[0]["TenSP"].ToString() %></th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>&nbsp;</td>
                    
                  <td style="width:45%">
					<p class="justify">
						<%=tools.getSanPhamByID(Request.QueryString.Get("idsp0")).Rows[0]["MoTa"].ToString().Trim() %>
					</p>
                      <div style="margin-bottom:0px">				
                          </div>
				</td>                    
                  <td style="width:45%">
				  <p class="justify">
					<%=tools.getSanPhamByID(Request.QueryString.Get("idsp1")).Rows[0]["MoTa"].ToString() %>
				</p>				

				  </td>
                </tr>
                  <tr>
                  <td>Hình Ảnh</td>
                  <td>
                      <img src="<%=tools.getSanPhamByID(Request.QueryString.Get("idsp0")).Rows[0]["urlHinh"].ToString() %>" alt=""/>
                      				<form class="form-horizontal qtyFrm">
				<h3> <%=tools.formatMoney(tools.getSanPhamByID(Request.QueryString.Get("idsp0")).Rows[0]["GiaHienTai"].ToString(),".") + " " + "VNĐ" %></h3><br/>
				 <a href="ProductDetails.aspx?Detailspr=<%=tools.getSanPhamByID(Request.QueryString.Get("idsp0")).Rows[0]["idSP"].ToString() %>" class="btn btn-large btn-primary">Chi tiết <i class="icon-zoom-in"></i></a>
				</form>
                  </td>
                  <td><img src="<%=tools.getSanPhamByID(Request.QueryString.Get("idsp1")).Rows[0]["urlHinh"].ToString() %>" alt=""/>
                      				<form class="form-horizontal qtyFrm">
				<h3> <%=tools.formatMoney(tools.getSanPhamByID(Request.QueryString.Get("idsp1")).Rows[0]["GiaHienTai"].ToString(),".") + " " + "VNĐ" %></h3>
				<br/>
				 <a href="ProductDetails.aspx?Detailspr=<%=tools.getSanPhamByID(Request.QueryString.Get("idsp1")).Rows[0]["idSP"].ToString() %>" class="btn btn-large btn-primary">Chi tiết <i class="icon-zoom-in"></i></a>
                    
				</form>

                  </td>
                </tr>
                <tr>
                  <td>Màn Hình</td>
                  <td><%=tools.getTTSPTTByID(Request.QueryString.Get("idsp0")).Rows[0]["ManHinh"].ToString() %></td>
                  <td><%=tools.getTTSPTTByID(Request.QueryString.Get("idsp1")).Rows[0]["ManHinh"].ToString() %></td>
                </tr>
                <tr>
                  <td>HĐH</td>
                  <td><%=tools.getTTSPTTByID(Request.QueryString.Get("idsp0")).Rows[0]["HDH"].ToString() %></td>
                  <td><%=tools.getTTSPTTByID(Request.QueryString.Get("idsp1")).Rows[0]["HDH"].ToString() %></td>
                </tr>
				<tr>
                  <td>CPU</td>
                  <td><%=tools.getTTSPTTByID(Request.QueryString.Get("idsp0")).Rows[0]["CPU"].ToString() %></td>
                  <td><%=tools.getTTSPTTByID(Request.QueryString.Get("idsp1")).Rows[0]["CPU"].ToString() %></td>
                </tr>
				<tr>
                  <td>RAM</td>
                  <td><%=tools.getTTSPTTByID(Request.QueryString.Get("idsp0")).Rows[0]["RAM"].ToString() %></td>
                  <td><%=tools.getTTSPTTByID(Request.QueryString.Get("idsp1")).Rows[0]["RAM"].ToString() %></td>
                </tr>
				<tr>
                  <td>Camera</td>
                  <td><%=tools.getTTSPTTByID(Request.QueryString.Get("idsp0")).Rows[0]["Camera"].ToString() %></td>
                  <td><%=tools.getTTSPTTByID(Request.QueryString.Get("idsp1")).Rows[0]["Camera"].ToString() %></td>
                </tr>
                  <tr>
                  <td>Pin</td>
                  <td><%=tools.getTTSPTTByID(Request.QueryString.Get("idsp0")).Rows[0]["PIN"].ToString() %></td>
                  <td><%=tools.getTTSPTTByID(Request.QueryString.Get("idsp1")).Rows[0]["PIN"].ToString() %></td>
                </tr>
              </tbody>
            </table>		
	<a id="goback" class="btn btn-large pull-right">Quay Trở Lại</a>
	
</asp:Content>

