<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="TinhTrangDonHang.aspx.cs" Inherits="TinhTrangDonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script>

        $(document).ready(function () {
            $('#btnLogout').click(function () {
                window.location.assign("Default.aspx");
            });

        })
    </script>
    <%ToolsDT tools = new ToolsDT();
      int i = 0;
      
      %>
    <%while (i < tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows.Count)
      {
          int je = 0;%>
              <%= tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["ThoiDiemDatHang"].ToString()%> <%= tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["TinhTrang"].ToString()%>
	<table class="table table-bordered">
              <thead>
                <tr>
                  <th>Hình SP</th>
                  <th>Tên SP</th>
                <th>Màu SP</th>
                    <th>Tình Trang</th>
                    <th>Giá Tiền</th>
                    <th>Số Lượng</th>
                  <th>Thành Tiền</th>
				</tr>
              </thead>
              <tbody>
                  <%while (je < tools.getChiTietDH(tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["idDH"].ToString()).Rows.Count)
                    { %>
				<tr>
                    <% %>
                  <td> <img width="60" height="60" src="<%=tools.getSanPhamByID(tools.getChiTietDH(tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["idDH"].ToString()).Rows[je]["idSP"].ToString()).Rows[0]["urlHinh"].ToString() %>" alt=""/></td>
                  <td><%=tools.getSanPhamByID(tools.getChiTietDH(tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["idDH"].ToString()).Rows[je]["idSP"].ToString()).Rows[0]["TenSP"].ToString() %></td>
                  <td><%=tools.getMauByIdMau(tools.getChiTietDH(tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["idDH"].ToString()).Rows[je]["idMau"].ToString()).Rows[0]["TenMau"].ToString() %></td>
                    <td><%=tools.getTinhTrangSanPhamByidTT(tools.getSanPhamByID(tools.getChiTietDH(tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["idDH"].ToString()).Rows[je]["idSP"].ToString()).Rows[0]["idTinhTrang"].ToString()).Rows[0]["TinhTrang"].ToString() %></td>
                  <td><%=tools.formatMoney(tools.getSLbyidSP(tools.getChiTietDH(tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["idDH"].ToString()).Rows[je]["idMau"].ToString(),tools.getChiTietDH(tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["idDH"].ToString()).Rows[je]["idSP"].ToString()).Rows[0]["Gia"].ToString(),".") + " " + "VNĐ" %></td>
                    <td><%=tools.getSlChiTietDonHang(tools.getChiTietDH(tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["idDH"].ToString()).Rows[je]["idSP"].ToString(),tools.getChiTietDH(tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["idDH"].ToString()).Rows[je]["idMau"].ToString(),tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["idDH"].ToString()).Rows[0]["SoLuong"].ToString() %></td>
                    <td><%=tools.formatMoney((int.Parse(tools.getSlChiTietDonHang(tools.getChiTietDH(tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["idDH"].ToString()).Rows[je]["idSP"].ToString(),tools.getChiTietDH(tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["idDH"].ToString()).Rows[je]["idMau"].ToString(),tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["idDH"].ToString()).Rows[0]["SoLuong"].ToString())*int.Parse(tools.getSLbyidSP(tools.getChiTietDH(tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["idDH"].ToString()).Rows[je]["idMau"].ToString(),tools.getChiTietDH(tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["idDH"].ToString()).Rows[je]["idSP"].ToString()).Rows[0]["Gia"].ToString())).ToString(),".") + " " + "VNĐ" %></td>
                </tr>
				<%je = je + 1;
                    } %>
                <tr>
                  <td colspan="6" style="text-align:right">Total Price:	</td>
                  <td> <%= tools.formatMoney(tools.getDH(Request.QueryString.Get("idUser").ToString()).Rows[i]["TongTien"].ToString(), ".") + " " + "VNĐ"%></td>
                </tr>
				</tbody>
            </table>
    <% i = i + 1;
      } %>
</asp:Content>

