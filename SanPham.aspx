<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.master" AutoEventWireup="true" CodeFile="SanPham.aspx.cs" Inherits="SanPham" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<!-- Modal -->
    <script>

        $(document).ready(function () {
            var chungloai = $("[id*=ddlChungLoai]");
            var loai = $("[id*=ddlLoai]");
            var sapxep = $("[id*=ddlSapXep]");
            loai.hide();
            $.ajax({
                type: "POST",
                //Gọi trang và truyền hàm của server
                url: "SanPham.aspx/chungLoai",
                // truyền các tham số của hàm trong C#.
                //Bạn có thể dung data{DanhSachCacBien}
                data: "{}",
                //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    //Lấy phản hồi từ Webserver cho Client
                    chungloai.empty().append('<option selected="selected" value="0">Chọn</option>');
                    $.each(msg.d, function () {
                        chungloai.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                }

            });
            chungloai.change(function () {
                $.ajax({
                    type: "POST",
                    //Gọi trang và truyền hàm của server
                    url: "SanPham.aspx/loaiSP",
                    // truyền các tham số của hàm trong C#.
                    //Bạn có thể dung data{DanhSachCacBien}
                    data: "{idCL: "+chungloai.val()+"}",
                    //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        //Lấy phản hồi từ Webserver cho Client
                        loai.empty().append('<option selected="selected" value="0">Chọn</option>');
                        $.each(msg.d, function () {
                            loai.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                    }

                });
                loai.show(500);
            });
            sapxep.change(function () {
               
            });
        });
    </script>
<!-- Modal -->
    <%
        ToolsDT tools = new ToolsDT();
        System.Data.DataSet ds = null;
        int i = 0;
        if (Request.QueryString.Get("idSapXep") == null)
            ds = tools.GetPhanTrangAdmin_DataSet("TB_News_PagingByCateIDAdmin0", (Request.QueryString["page"] + "" != "") ? int.Parse("0" + Request.QueryString["page"]) : 1, 6, 3, sapxep);
        else  
        ds = tools.GetPhanTrangAdmin_DataSet("TB_News_PagingByCateIDAdmin0", (Request.QueryString["page"] + "" != "") ? int.Parse("0" + Request.QueryString["page"]) : 1, 6, 3, int.Parse(Request.QueryString.Get("idSapXep").ToString()));
        
         %>
<div id="myModal" class="modal fade bs-example-modal-lg" role="dialog" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-lg" role="document">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header" style="background-color:#21e88c;text-align:center">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" style="text-align:center;color:#ff6a00">CHI TIẾT SẢN PHẨM</h4>
      </div>
      <div class="modal-body">
          <h3>Sản Phẩm</h3>
        <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Id sản phẩm</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00"><input style="border:none" value=".col-sm-9"/></div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Loại</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Nhà sản xuất</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Tên sản phẩm</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Mô tả</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Ngày cập nhật</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Giá mới ra</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Giá hiện tại</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Hình ảnh</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Bài viết</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Số lần xem</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Số lượng tồn kho</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Ghi chú</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Số lần mua</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Ẩn hiện</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Tình trạng</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
        <h3>Thuộc tính</h3>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Tính năng nổi bật</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Màn hình</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Máy ảnh trước</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Đặc tính máy ảnh trước</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Máy ảnh sau</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Đặc tính máy ảnh sau</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
              </div>
              <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Video call</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                 <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Quay phim</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                 <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Xem phim</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                 <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Nghe nhạc</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                 <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Ghi âm</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                 <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Kết nối</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                 <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Bộ nhớ ram</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                 <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Tốc độ CPU</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>

                           <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Bộ nhớ thẻ nhớ ngoài</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                           <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Bộ nhớ còn lại</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
          <h3>Thuộc tính tóm tắt</h3>
                       <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Màn hình</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                         <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Hệ điều hành</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                         <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">CPU</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                         <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">RAM</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                         <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Camera</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                     <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">Pin</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                     <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">ROM</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                     <div class="row">
            <div class="col-sm-3" style="border:1px solid #b6ff00">SIM</div>
            <div class="col-sm-9" style="border:1px solid #ff6a00">.col-sm-9</div>
        </div>
                <div class="row">
            <div class="col-sm-6"  ><a class="btn btn-primary">Update</a></div>
            <div class="col-sm-6" ><a class="btn btn-danger" data-dismiss="modal">Close</a></div>
        </div>
      </div>
     <%-- <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>--%>
    </div>

  </div>
</div>
                <h3>Danh sách sản phẩm</h3>
            <hr />
    <h4>Lọc sản phẩm theo:</h4>
    <div class="form-group">
    <p>Chủng loại:<asp:DropDownList class="form-control" Width="200px" ID="ddlChungLoai" runat="server"></asp:DropDownList> </p>
    <p>Loại: <asp:DropDownList class="form-control" Width="200px" ID="ddlLoai" runat="server"></asp:DropDownList></p>
    <p>Sắp xếp: 
        <asp:DropDownList class="form-control" Width="200px" ID="ddlSapXep" runat="server" OnSelectedIndexChanged="ddlSapXep_SelectedIndexChanged" AutoPostBack="True">
            <asp:ListItem Value="0">--Sắp xếp--</asp:ListItem>
                <asp:ListItem Value="1">Ngày cập nhật giảm dần</asp:ListItem>
                <asp:ListItem Value="2">Số lượng tồn kho giảm dần</asp:ListItem>
        </asp:DropDownList>

    </p>
        </div>
      <table class="table table-bordered">
    <thead>
      <tr>
        <th>Tên SP</th>
        <th>Tình trạng</th>
        <th>Nhà SX</th>
        <th>Giá hiện tại</th>
        <th>Ẩn hiện</th>
          <th>Hình</th>
        <th>&nbsp;</th>
      
      </tr>
    </thead>
    <tbody>
        <%if(ds.Tables.Count > 1){ %>
        <%  if(ds.Tables[0].Rows.Count > 0){ %>
            <%while(i < ds.Tables[0].Rows.Count){ %>
      <tr>
        <td><%=ds.Tables[0].Rows[i]["tenSP"].ToString() %></td>
        <td><%=ds.Tables[0].Rows[i]["tinhtrang"].ToString() %></td>
        <td><%=ds.Tables[0].Rows[i]["nhasanxuat"].ToString() %></td>
        <td><%=ds.Tables[0].Rows[i]["GiaHienTai"].ToString() %></td>
        <td><%=ds.Tables[0].Rows[i]["anhien1"].ToString() %></td>
        <td><img src="<%=ds.Tables[0].Rows[i]["urlHinh"].ToString() %>" width="50" height="50"/></td>
        <td><a class="btn btn-primary" role="button" data-toggle="modal" href="#myModal">chi tiết</a></td>
      </tr>
        <%
                  i = i + 1;
        } %>
        <%} %>
        <%} %>
    </tbody>
  </table>
    			<ul>
			<%if (ds.Tables[1].Rows.Count > 0) {  %>
             <%=ds.Tables[1].Rows[0][0] + " " %> 
        <%} %>
			</ul>
           <p><a class="btn btn-primary">Thêm sản phẩm</a></p> 
</asp:Content>

