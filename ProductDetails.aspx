<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ProductDetails.aspx.cs" Inherits="ProductDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        $(document).ready(function () {
            $(window).load(function () {
                $('#preloader').fadeOut('slow', function () { $(this).remove(); });
            });
            window.location.hash = '#focusto';

            var rowCount = $('#ulSanPham li').length;
            var msgbox = $('#tenSP');
            var hinhanh = $('#hinhSP');
            var mausp = $("[id*=ddlMau]");
            var gioitinh = $("[id*=ddlSex]");
            var pttt = $("[id*=ddlPTTT]");
            var giasp = $('#giaSPP');
            var idspp;
            var j = 0;
            $('#btnSoSanh').click(function () {

                var $boxes = $('input[name=checkboxsosanh]:checked');
                var i = 0;
                $boxes.each(function () {
                    // Do stuff here with this

                    if ($boxes.is(":checked") == true) {
                        var idsp = $(this).closest('div').attr('id');
                        
                        sessionStorage.setItem("idsp" + i + "", idsp);
                        i = i + 1;
                        
                    }

                    
                });
                if ($boxes.length == 2) {
                    var idsp0 = sessionStorage.getItem("idsp0").toString().split(" ").join("");
                    var idsp1 = sessionStorage.getItem("idsp1").toString().split(" ").join("");

                    window.location.assign("Compair.aspx?idsp0=" + idsp0 + "&&idsp1=" + idsp1 + "");
                }
                else
                    alert("Bạn vui lòng chọn 2 sản phẩm để so sánh !.");
            });
            while (j < rowCount) {

                $('#btnMuaNgay11' + j + '').click(function () {

                    idspp = $(this).closest('div').attr('id');
                    $.ajax({
                        type: "POST",
                        //Gọi trang và truyền hàm của server
                        url: "Default.aspx/tenSP",
                        // truyền các tham số của hàm trong C#.
                        //Bạn có thể dung data{DanhSachCacBien}
                        data: "{idsp:" + idspp + "}",
                        //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            //Lấy phản hồi từ Webserver cho Client
                            msgbox.html(msg.d);
                        }

                    });

                    $.ajax({
                        type: "POST",
                        //Gọi trang và truyền hàm của server
                        url: "Default.aspx/hinhAnh",
                        // truyền các tham số của hàm trong C#.
                        //Bạn có thể dung data{DanhSachCacBien}
                        data: "{idsp:" + idspp + "}",
                        //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            //Lấy phản hồi từ Webserver cho Client
                            hinhanh.attr('src', msg.d);
                        }
                    });
                    $.ajax({
                        type: "POST",
                        //Gọi trang và truyền hàm của server
                        url: "Default.aspx/mauSP",
                        // truyền các tham số của hàm trong C#.
                        //Bạn có thể dung data{DanhSachCacBien}
                        data: "{idsp:" + idspp + "}",
                        //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            //Lấy phản hồi từ Webserver cho Client
                            mausp.empty().append('<option selected="selected" value="0">Chọn Màu</option>');
                            $.each(msg.d, function () {
                                mausp.append($("<option></option>").val(this['Value']).html(this['Text']));
                            });

                        }

                    });

                    $.ajax({
                        type: "POST",
                        //Gọi trang và truyền hàm của server
                        url: "Default.aspx/PTTT",
                        // truyền các tham số của hàm trong C#.
                        //Bạn có thể dung data{DanhSachCacBien}
                        data: "{}",
                        //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            //Lấy phản hồi từ Webserver cho Client
                            pttt.empty();
                            $.each(msg.d, function () {
                                pttt.append($("<option></option>").val(this['Value']).html(this['Text']));
                            });

                        }

                    });

                    $.ajax({
                        type: "POST",
                        //Gọi trang và truyền hàm của server
                        url: "Default.aspx/giaTienSP",
                        // truyền các tham số của hàm trong C#.
                        //Bạn có thể dung data{DanhSachCacBien}
                        data: "{idsp:" + idspp + ",idmau:" + mausp.val() + "}",
                        //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",

                        success: function (msg) {

                            giasp.html(msg.d);

                        }

                    });


                });


                j = j + 1;
            }
            mausp.change(function () {


                $.ajax({
                    type: "POST",
                    //Gọi trang và truyền hàm của server
                    url: "Default.aspx/giaTienSP",
                    // truyền các tham số của hàm trong C#.
                    //Bạn có thể dung data{DanhSachCacBien}
                    data: "{idsp:" + idspp + ",idmau:" + mausp.val() + "}",
                    //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (msg) {

                        giasp.html(msg.d);

                    }

                });

            });
            $('#btnXacNhan').click(function () {
                txt = document.getElementById("txtSoDienThoai").value;
                txt1 = document.getElementById("txtHoTen").value;
                txt2 = document.getElementById("txtEmail").value;
                data1 = txt.match(/^[0-9-]{6,9}$|^[0-9-]{12}$/);
                data2 = txt.match(/^\d{1,4}-\d{4}$|^\d{2,5}-\d{1,4}-\d{4}$/);
                data3 = txt2.match(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
                if (txt1 == "") {
                    alert("Không được để trống họ tên!");
                    return false;
                }
                if (!data1 && !data2) {
                    alert("Số Điện thoại không hợp lệ");
                    return false;
                }
                if (!data3) {
                    alert("Email không hợp lệ !");
                    return false;
                }
                if (mausp.val() == "0") {
                    alert("Vui lòng chọn màu !");
                    return false;
                }

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    url: "Default.aspx/themDatNgayTuVan",
                    data: "{idSP:" + idspp + ", idMau:" + mausp.val() + ", gioiTinh:" + gioitinh.val() + ", hoTenn:'" + txt1 + "', soDT:'" + txt + "', Email:'" + txt2 + "'}",
                    success: function (Record) {

                        if (Record.d == true) {
                            alert("Bạn đã đặt hàng thành công, Bạn vui lòng chờ 1 lát sẽ có người gọi lại tư vấn cho bạn. Cảm ơn bạn đã ghé thăm !");
                            window.location.reload();
                        }
                        else {
                            alert("Sản phẩm bạn vừa chọn đã hết, Bạn có thể kham khảo sản phẩm khác. Cảm ơn bạn !");
                        }
                    }
                });
            });
        });
    </script>
    <%ToolsDT tools = new ToolsDT(); %>
    <div class="span9">
                <div id="muaNgay" class="modal hide fade in" tabindex="-1" role="dialog" aria-labelledby="MuaNgay" aria-hidden="false" >
		  <div class="modal-header" style="background-color:#21e88c;text-align:center">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>			
            <h3 style="color:#ff6a00;text-align:center">Đặt Ngay - Nhận tư vấn miễn phí</h3>
            <small>(Mua là quyền của bạn - Tư vấn miễn phí là trách nhiệm của chúng tôi)</small>
		  </div>
		  <div class="modal-body" style="float:left">
              <strong>Bước 1:</strong>
			<div class="form-horizontal loginFrm">
			  <img src="" alt="" width="80" height="80" style="float:left" id="hinhSP">
               <div style="float:left">
              <p><asp:DropDownList ID="ddlMau" runat="server" Width="100px"></asp:DropDownList></p>
              <a style="color:#ffffff" id="giaSPP" class="btn btn-primary"></a><a style="color:red">đ</a>
              <strong><p style="color:red" id="tenSP"></p></strong>
               </div> 
			</div>		
			<p>Hình thức thanh toán: </p>
			<p><asp:DropDownList ID="ddlPTTT" runat="server" Width="100px"></asp:DropDownList></p>
		  </div>
        <div class="modal-body" style="float:left">
            <strong>Bước 2:</strong>
			<div class="form-horizontal loginFrm">            
			  <div class="control-group">	
                <p><asp:DropDownList ID="ddlSex" runat="server" Width="100px">
                    <asp:ListItem Value="1">Anh</asp:ListItem>
                    <asp:ListItem Value="0">Chị</asp:ListItem>
                    </asp:DropDownList></p>      							
				<input type="text" id="txtHoTen" placeholder="Họ và Tên">
			  </div>
			  <div class="control-group">
				<input type="text" id="txtSoDienThoai" placeholder="Số Điện Thoại">
			  </div>
                <div class="control-group">
				<input type="text" id="txtEmail" placeholder="Email">
			  </div>
			</div>		
			<p><button type="button" class="btn btn-success" style="margin-left:45px;width:151px" id="btnXacNhan">Xác Nhận</button></p>
            <p><i class="fa fa-phone" aria-hidden="true" style="color:#00ff21;font-size:20px"></i>&nbsp;Tư vấn bán hàng <strong><font style="color:red;font-size:20px;"> 070-3368-2312</font></strong>.</p>
            <p><i class="fa fa-car" style="color:#00ff21;font-size:20px"></i>&nbsp;Giao hàng miễn phí.</p>

            </div>
	</div>

        <ul class="breadcrumb" id="focusto">
            <li><a href="index.html">Home</a> <span class="divider">/</span></li>
            <li><a href="Products.aspx?idNSX=<%= tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()%>&&idTT=<%=tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idTinhTrang"].ToString() %>">Sản phẩm</a> <span class="divider">/</span></li>
            <li class="active">Chi tiết sản phẩm</li>
        </ul>
        <div class="row">
            <div id="gallery" class="span3">
                <% int i = 0;%>
                <a href="<%= tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["urlHinh"].ToString() %>" title="<%= tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["TenSP"].ToString()%>">
                    <img src="<%= tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["urlHinh"].ToString() %>" style="width: 100%" alt="Fujifilm FinePix S2950 Digital Camera" />
                </a>
                <div id="differentview" class="moreOptopm carousel slide">
                    <div class="carousel-inner">
                        <div class="item active">
                            <%while (i < tools.getHinhBySanPham(Request.QueryString.Get("Detailspr").ToString()).Rows.Count)
                              {%>
                            <% if (i <= 2)
                               {%>
                            <a href="<%=tools.getHinhBySanPham(Request.QueryString.Get("Detailspr").ToString()).Rows[i]["urlHinh"].ToString() %>">
                                <img style="width: 29%" src="<%=tools.getHinhBySanPham(Request.QueryString.Get("Detailspr").ToString()).Rows[i]["urlHinh"].ToString() %>" alt="<%= tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["TenSP"].ToString() %>" /></a>
                            <%}
                               else
                               {%>
                            <div class="item">
                                <a href="<%=tools.getHinhBySanPham(Request.QueryString.Get("Detailspr").ToString()).Rows[i]["urlHinh"].ToString() %>">
                                    <img style="width: 29%" src="<%=tools.getHinhBySanPham(Request.QueryString.Get("Detailspr").ToString()).Rows[i]["urlHinh"].ToString() %>" alt="<%= tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["TenSP"].ToString() %>" /></a>
                            </div>
                            <%} %>
                            <%i = i + 1;
                              } %>
                        </div>
                        <%-- <div class="item">
                   <a href="themes/images/products/large/f3.jpg" > <img style="width:29%" src="themes/images/products/large/f3.jpg" alt=""/></a>
                   <a href="themes/images/products/large/f1.jpg"> <img style="width:29%" src="themes/images/products/large/f1.jpg" alt=""/></a>
                   <a href="themes/images/products/large/f2.jpg"> <img style="width:29%" src="themes/images/products/large/f2.jpg" alt=""/></a>
                  </div>--%>
                    </div>
                    <!--  
			  <a class="left carousel-control" href="#myCarousel" data-slide="prev">‹</a>
              <a class="right carousel-control" href="#myCarousel" data-slide="next">›</a> 
			  -->
                </div>
<%--                <div class="btn-toolbar">
                    <div class="btn-group">
                        <span class="btn"><i class="icon-envelope"></i></span>
                        <span class="btn"><i class="icon-print"></i></span>
                        <span class="btn"><i class="icon-zoom-in"></i></span>
                        <span class="btn"><i class="icon-star"></i></span>
                        <span class="btn"><i class=" icon-thumbs-up"></i></span>
                        <span class="btn"><i class="icon-thumbs-down"></i></span>
                    </div>
                </div>--%>
            </div>
            <div class="span6">
                <h3><%= tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["TenSP"].ToString() + " " + tools.getTinhTrangSanPhamByidTT(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idTinhTrang"].ToString()).Rows[0]["TinhTrang"].ToString() %> </h3>
                <small>- Dịch vụ đăng ký tư vấn điện thoại -</small>
                <hr class="soft" />
                <div class="form-horizontal qtyFrm">
                    <div class="control-group">
                        <label class="control-label"><span>
                            <%=tools.formatMoney(tools.getSLbyidSP(ddlMauSP.SelectedValue, Request.QueryString.Get("Detailspr").ToString()).Rows[0]["Gia"].ToString(), ".") + " " + "đ" %>
                                                     </span></label>
                        <div class="controls">
                            <input type="number" class="span1" placeholder="0" runat="server" id="txtSoLuong" min="0"/>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Bạn chưa chọn số lượng !" ControlToValidate="txtSoLuong" ForeColor="Red" ValidationGroup="checkThemSL">*</asp:RequiredFieldValidator>
                            <%--<button type="button" class="btn btn-large btn-primary pull-right" id="btnDatHang" runat="server">Thêm vào giỏ hàng <i class=" icon-shopping-cart"></i></button>--%>                         
                            <%--<asp:Button class="btn btn-large btn-primary pull-right" id="btnDatHang" runat="server" Text='<%=<i class=" icon-shopping-cart"></i> %>'/>--%>
                            <asp:LinkButton runat="server" ID="btnDatHang" ToolTip="Click" CssClass="btn btn-large btn-primary pull-right" Text='Thêm vào giỏ hàng<i class=" icon-shopping-cart"></i>' OnClick="btnDatHang_Click" ValidationGroup="checkThemSL" />

                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtSoLuong" ErrorMessage="Số lượng bạn chọn quá lớn. Chắc Shop ko đáp ứng đủ đâu. hì !" ForeColor="Red" ValidationExpression="[0-9]{1,2}" ValidationGroup="checkThemSL">*</asp:RegularExpressionValidator>

                        </div>
                    </div>
                </div>
                
                <hr class="soft" />
                <h4><%= tools.getSLbyidSP(ddlMauSP.SelectedValue, Request.QueryString.Get("Detailspr").ToString()).Rows[0]["SoLuongTonKho"].ToString() + " " + "sản phẩm màu " + " " + ddlMauSP.SelectedItem.Text + " " + " tại của hàng "%></h4>
                <div class="form-horizontal qtyFrm pull-right" >
                    <small>
                        <asp:Label ID="checkSL" runat="server" Text="" style="color:red"></asp:Label>
                    </small>
                    <div class="control-group">

                        <label class="control-label"><span>Màu</span></label>
                        <div class="controls">
                            <%--<select class="span2" id="mauSP" name="mauSP">
                                <%int j = 0; %>
                                <%while (j < tools.getMauByID(Request.QueryString.Get("Detailspr").ToString()).Rows.Count)
                                  { %>
                                <option>
                                    <%= tools.getMauByID(Request.QueryString.Get("Detailspr").ToString()).Rows[j]["TenMau"].ToString() %>
                                </option>
                                <%j = j + 1;
                            } %>
                            </select>--%>
                            <asp:DropDownList ID="ddlMauSP" runat="server" CssClass="span2" AutoPostBack="True" OnSelectedIndexChanged="ddlMauSP_SelectedIndexChanged" ></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <hr class="soft clr" />
                <p>
                    <%= tools.getTTSPByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["tinh_nang_noi_bat"].ToString() %>
                </p>
                <a class="btn btn-small pull-right" href="#detail">Xem Chi Tiết</a>
                <br class="clr" />
                <a href="#" name="detail"></a>
                <hr class="soft" />
            </div>

            <div class="span9">
                <ul id="productDetail" class="nav nav-tabs">
                    <li class="active"><a href="#home" data-toggle="tab">Chi Tiết Sản Phẩm</a></li>
                    <li><a href="#profile" data-toggle="tab">Sản Phẩm Liên Quan</a></li>
                </ul>
                <div id="myTabContent" class="tab-content">
                    <div class="tab-pane fade active in" id="home">
                        <h4>Thông Tin Sản Phẩm</h4>
                        <table class="table table-bordered">
                            <tbody>
                                <tr class="techSpecRow">
                                    <th colspan="2">Chi Tiết Sản Phẩm</th>
                                </tr>
                                <tr class="techSpecRow">
                                    <td class="techSpecTD1">Màn Hình </td>
                                    <td class="techSpecTD2"><%= tools.getTTSPByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["man_hinh"].ToString() %></td>
                                </tr>
                                <tr class="techSpecRow">
                                    <td class="techSpecTD1">Camera Trước</td>
                                    <td class="techSpecTD2"><%= tools.getTTSPByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["may_anh_truoc"].ToString() %></td>
                                </tr>
                                <tr class="techSpecRow">
                                    <td class="techSpecTD1">Đặc Tính</td>
                                    <td class="techSpecTD2"><%= tools.getTTSPByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["dac_tinh_may_anh_truoc"].ToString() %></td>
                                </tr>
                                <tr class="techSpecRow">
                                    <td class="techSpecTD1">Camera Sau</td>
                                    <td class="techSpecTD2"><%= tools.getTTSPByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["may_anh_sau"].ToString() %></td>
                                </tr>
                                <tr class="techSpecRow">
                                    <td class="techSpecTD1">Đặc Tính</td>
                                    <td class="techSpecTD2"><%= tools.getTTSPByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["dac_tinh_may_anh_sau"].ToString() %></td>
                                </tr>
                                <tr class="techSpecRow">
                                    <td class="techSpecTD1">Quay Phim</td>
                                    <td class="techSpecTD2"><%= tools.getTTSPByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["quay_phim"].ToString() %></td>
                                </tr>
                                <tr class="techSpecRow">
                                    <td class="techSpecTD1">Xem Phim</td>
                                    <td class="techSpecTD2"><%= tools.getTTSPByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["xem_phim"].ToString() %></td>
                                </tr>
                                <tr class="techSpecRow">
                                    <td class="techSpecTD1">Nghe Nhạc</td>
                                    <td class="techSpecTD2"><%= tools.getTTSPByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["nghe_nhac"].ToString() %></td>
                                </tr>
                                <tr class="techSpecRow">
                                    <td class="techSpecTD1">Ghi Âm</td>
                                    <td class="techSpecTD2"><%= tools.getTTSPByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["ghi_am"].ToString() %></td>
                                </tr>
                                <tr class="techSpecRow">
                                    <td class="techSpecTD1">Kết Nối</td>
                                    <td class="techSpecTD2"><%= tools.getTTSPByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["ket_noi"].ToString() %></td>
                                </tr>
                                <tr class="techSpecRow">
                                    <td class="techSpecTD1">Bộ Nhớ Ram</td>
                                    <td class="techSpecTD2"><%= tools.getTTSPByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["bonho_ram"].ToString() %></td>
                                </tr>
                                <tr class="techSpecRow">
                                    <td class="techSpecTD1">Tốc Độ CPU</td>
                                    <td class="techSpecTD2"><%= tools.getTTSPByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["toc_do_cpu"].ToString() %></td>
                                </tr>
                                <tr class="techSpecRow">
                                    <td class="techSpecTD1">Thẻ Nhớ Ngoài</td>
                                    <td class="techSpecTD2"><%= tools.getTTSPByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["bonho_the_nho_ngoai"].ToString() %></td>
                                </tr>
                                <tr class="techSpecRow">
                                    <td class="techSpecTD1">Bộ Nhớ Còn Lại (Khả Dụng)</td>
                                    <td class="techSpecTD2"><%= tools.getTTSPByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["bonho_con_lai"].ToString() %></td>
                                </tr>
                            </tbody>
                            
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ShowMessageBox="True" ShowSummary="False" ValidationGroup="checkThemSL" />
                            
                        </table>
                    </div>
                    <div class="tab-pane fade" id="profile" >
                        <div id="myTab" class="pull-right">
                            <a href="#listView" data-toggle="tab"><span class="btn btn-large"><i class="icon-list"></i></span></a>
                            <a href="#blockView" data-toggle="tab"><span class="btn btn-large btn-primary"><i class="icon-th-large"></i></span></a>
                        </div>
                        <br class="clr" />
                        <hr class="soft" />
                        <div class="tab-content">
                            <div class="tab-pane" id="listView">
                                <%for (int l = 0; l < tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows.Count; l++){ %>
                                <div class="row">
                                    <div class="span2">
                                        <img src="<%=tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows[l]["urlHinh"].ToString() %>" alt="" />
                                    </div>
                                    <div class="span4">
                                        <h3><%=tools.getTinhTrangSanPhamByidTT(tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows[l]["idTinhTrang"].ToString()).Rows[0]["TinhTrang"].ToString()  %></h3>
                                        <hr class="soft" />
                                        <h5><%=tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows[l]["TenSP"].ToString() %> </h5>
                                        <p>
                                            <%=tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows[l]["Mota"].ToString() %>
                                        </p>
                                        <a class="btn btn-small pull-right" href="ProductDetails.aspx?Detailspr=<%=tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows[l]["idSP"].ToString() %>">View Details</a>
                                        <br class="clr" />
                                    </div>
                                    <div class="span3 alignR">
                                        <div class="form-horizontal qtyFrm" id=" <%=tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows[l]["idSP"].ToString() %>" >
                                            <h3><%=tools.formatMoney(tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows[l]["GiaHienTai"].ToString(),".") + " " + "đ" %></h3>
                                            <label class="checkbox">
                                                <input type="checkbox" name="checkboxsosanh">
                                                Thêm vào để so sánh
                                            </label>
                                            &nbsp;<br />
                                            <div class="btn-group" id="<%=tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows[l]["idSP"].ToString() %>">
                                                <%--<a href="product_details.html" class="btn btn-large btn-primary">Đặt Ngay <i class=" icon-shopping-cart"></i></a>--%>
                                                <a class="btn btn-large btn-primary" role="button" data-toggle="modal" href="#muaNgay" id="btnMuaNgay11<%=l %>">Đặt Ngay <i class="icon-shopping-cart"></i></a>
                                                <a href="ProductDetails.aspx?Detailspr=<%=tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows[l]["idSP"].ToString() %>" class="btn btn-large"><i class="icon-zoom-in"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <hr class="soft" />
                                <%} %>
                            </div>
                            
                            <div class="tab-pane active" id="blockView">
                                <ul class="thumbnails" id="ulSanPham">
                <%
                  for(int p = 0; p < tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows.Count;p++){ %>
				<li class="span3">
				  <div class="thumbnail">
				  <i class="class"></i>
					<a href="ProductDetails.aspx?Detailspr=<%=tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows[p]["idSP"].ToString() %>"><img src="<%=tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows[p]["urlHinh"].ToString() %>" alt="" width="160" height="200"></a>
                      <h5><%=tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows[p]["TenSP"].ToString() %></h5>
                      <p><a class="btn btn-danger"><%=tools.formatMoney(tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows[p]["GiaHienTai"].ToString(),".") + " " + "đ" %></a></p>
					  <p><a class="btn btn-primary" href="ProductDetails.aspx?Detailspr=<%=tools.getSanPhamByIdNsx(tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["idNSX"].ToString()).Rows[p]["idSP"].ToString() %>">XEM CHI TIẾT</a></p>
				  </div>
				</li>
                <%} %>
                                </ul>
                                <hr class="soft" />
                            </div>
                        </div>
                        <a class="btn btn-large pull-right" id="btnSoSanh">So Sánh Sản Phẩm</a>
                        <br class="clr">
                    </div>
                </div>
            </div>

        </div>
    </div>
    </div> </div>
</div>
    
    <!-- MainBody End ============================= -->
</asp:Content>

