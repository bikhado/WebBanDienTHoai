<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style>

    </style>
    <%ToolsDT tools = new ToolsDT(); %>
        <script>
            $(document).ready(function () {
                //$("[rel='tooltip']").tooltip();

                $('.thumbnail').hover(
                    function () {
                        $(this).find('.caption').slideDown(250); //.fadeIn(250)
                    },
                    function () {
                        $(this).find('.caption').slideUp(0); //.fadeOut(205)
                    }
                );
            });

            $(document).ready(function (e) {
                $(window).load(function () {
                    $('#preloader').fadeOut('slow', function () { $(this).remove(); });
                });
                var i = 0;
                var rowCount = $('#ulSanPham li').length;
                var msgbox = $('#tenSP');
                var hinhanh = $('#hinhSP');
                var mausp = $("[id*=ddlMau]");
                var gioitinh = $("[id*=ddlSex]");
                var pttt = $("[id*=ddlPTTT]");
                var giasp = $('#giaSPP');
                var idspp;
                while (i < rowCount) {
                    
                    $('#btnMuaNgay' + i + '').click(function () {
                        $('.loader1').show(1000);
                        //mausp.SelectedIndex = 1; 
                        //alert(mausp.attr('selectedIndex', 0));

                        //alert($(this).closest('li').attr('id'));
                        idspp = $(this).closest('li').attr('id');
                        
                        $.ajax({
                            type: "POST",
                            //Gọi trang và truyền hàm của server
                            url: "Default.aspx/tenSP",
                            // truyền các tham số của hàm trong C#.
                            //Bạn có thể dung data{DanhSachCacBien}
                            data: "{idsp:"+idspp+"}",
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
                                //$('.loader1').hide();
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
                                $('.loader1').hide(1000);
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
                                //$('.loader1').hide();
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
                                //$('.loader1').hide();
                            }

                        });
                        

                    });


                    i = i + 1;
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
                    data1 = txt.match(/^[0]{1}[19]{1}[0-9]{8,9}$/);
                    data2 = txt.match(/^\d{1,4}-\d{4}$|^\d{2,5}-\d{1,4}-\d{4}$/);
                    data3 = txt2.match(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
                    alert(data3);
                    if (txt1 == "") {
                        alert("Không được để trống họ tên!");
                        return false;
                    }
                    if (!data1) {
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
                                $('#muaNgay').modal('hide');
                                $('#thongBaoDatNgay').modal('show');
                            }
                            else {
                                alert("Sản phẩm bạn vừa chọn đã hết, Bạn có thể kham khảo sản phẩm khác. Cảm ơn bạn !");
                            }
                        }
                    });
                });
                $('#txtHoTen').keyup(function (e) {
                    if (e.keyCode == 13) {
                        $("#btnXacNhan").click();
                    }
                });
                $('#txtSoDienThoai').keyup(function (e) {
                    if (e.keyCode == 13) {
                        $("#btnXacNhan").click();
                    }
                });
                $('#txtEmail').keyup(function (e) {
                    if (e.keyCode == 13) {
                        $("#btnXacNhan").click();
                    }
                });

                $('#tbTT').click(function () {
                    window.location.reload();
                })
                $('#ttttClose').click(function () {
                    window.location.reload();
                })

            });
    </script>
   
   <div id="thongBaoDatNgay" class="modal hide fade in" tabindex="-1" role="dialog" aria-labelledby="login" aria-hidden="false" >
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="ttttClose">×</button>
			<h3>Thông Báo</h3>
		  </div>
		  <div class="modal-body">
                <div class="alert alert-success">
                    <strong>Success!</strong> Bạn đã đặt hàng thành công, Bạn vui lòng chờ 1 lát sẽ có người gọi lại tư vấn cho bạn. Cảm ơn bạn đã ghé thăm !
                </div>
              <a class="btn btn-danger" id="tbTT"> Tiếp tục mua hàng.</a>
		  </div>
	</div> 
    <%
           int i;
           int f = 0;
           int k = 0;
           %>
                <div class="well well-small">
			<h4>Sản Phẩm Nổi Bật</h4>
			<div class="row-fluid">
			<div id="featured" class="carousel slide">
			<div class="carousel-inner">
			  <div class="item active">
			  <ul class="thumbnails">
                  <%while(f < tools.getSanPhamXemNhieu().Rows.Count){ %>
				<li class="span3">
				  <div class="thumbnail">
				  <i class="class"></i>
					<a href="ProductDetails.aspx?Detailspr=<%=tools.getSanPhamXemNhieu().Rows[f]["idSP"].ToString() %>"><img src="<%=tools.getSanPhamXemNhieu().Rows[f]["urlHinh"].ToString() %>" alt=""></a>
                      <i class="tag"></i>
                      <h5><%=tools.getSanPhamXemNhieu().Rows[f]["TenSP"].ToString() %><small>(<%=tools.getTinhTrangSanPhamByidTT(tools.getSanPhamXemNhieu().Rows[f]["idTinhTrang"].ToString()).Rows[0]["tinhTrang"].ToString() %>)</small></h5>
                      <p><a class="btn btn-danger"><%=tools.formatMoney(tools.getSanPhamXemNhieu().Rows[f]["GiaHienTai"].ToString(),".") + " " + "đ" %></a></p>
					  <p><a class="btn btn-primary" href="ProductDetails.aspx?Detailspr=<%=tools.getSanPhamXemNhieu().Rows[f]["idSP"].ToString() %>">XEM CHI TIẾT</a></p>
				  </div>
				</li>
                  <%
                  f= f + 1;
                  } %>
			  </ul>
			  </div>
			   <div class="item">
			  <ul class="thumbnails">
                  <%while(k < tools.getSanPhamXemNhieuMuaNhieu().Rows.Count){ %>
				<li class="span3">
				  <div class="thumbnail">
					<a href="ProductDetails.aspx?Detailspr=<%=tools.getSanPhamXemNhieuMuaNhieu().Rows[k]["idSP"].ToString() %>"><img src="<%=tools.getSanPhamXemNhieuMuaNhieu().Rows[k]["urlHinh"].ToString() %>" alt=""></a>
                      <h5><%=tools.getSanPhamXemNhieuMuaNhieu().Rows[k]["TenSP"].ToString() %><small>(<%=tools.getTinhTrangSanPhamByidTT(tools.getSanPhamXemNhieuMuaNhieu().Rows[k]["idTinhTrang"].ToString()).Rows[0]["tinhTrang"].ToString() %>)</small></h5>
					  <p><a class="btn btn-danger"><%=tools.formatMoney(tools.getSanPhamXemNhieuMuaNhieu().Rows[k]["GiaHienTai"].ToString(),".") + " " + "đ" %></a></p>
					  <p><a class="btn btn-primary" href="ProductDetails.aspx?Detailspr=<%=tools.getSanPhamXemNhieuMuaNhieu().Rows[k]["idSP"].ToString() %>">XEM CHI TIẾT</a></p>
				  </div>
				</li>
                  <%
                        k = k + 1;
                  } %>
			  </ul>
			  </div>
			  </div>
			  <a class="left carousel-control" href="#featured" data-slide="prev">‹</a>
			  <a class="right carousel-control" href="#featured" data-slide="next">›</a>
			  </div>
			  </div>
		</div>
		<h4>Sản Phẩm Mới Nhất </h4>
			  <ul class="thumbnails" id="ulSanPham">
                  <%
                     i = 0;
                     while (i < tools.getSanPham().Rows.Count)
                     {  
                       %>
				<li class="span3" id="<%=tools.getSanPham().Rows[i]["idSP"].ToString() %>">
				  <div class="thumbnail">
					<a  href="ProductDetails.aspx?detailspr=<%=tools.getSanPham().Rows[i]["idSP"].ToString() %>"><img src="<%= tools.getSanPham().Rows[i]["urlHinh"].ToString() %>" alt="" width="160" height="200"/></a>
					<div class="caption">
					  <h4 style="text-align:center;color:#ff6a00"><%= tools.getSanPham().Rows[i]["TenSP"].ToString() %><small>(<%=tools.getTinhTrangSanPhamByidTT(tools.getSanPham().Rows[i]["idTinhTrang"].ToString()).Rows[0]["tinhTrang"].ToString() %>)</small></h4>
                        <hr style="padding:1px;"/>
                    <p><strong>Màn hình:</strong> <%=tools.getTTSPTTByID(tools.getSanPham().Rows[i]["idSP"].ToString()).Rows[0]["ManHinh"].ToString()%></p>
                    <p><strong>HĐH:</strong> <%=tools.getTTSPTTByID(tools.getSanPham().Rows[i]["idSP"].ToString()).Rows[0]["HDH"].ToString()%></p>
                    <p><strong>CPU:</strong> <%=tools.getTTSPTTByID(tools.getSanPham().Rows[i]["idSP"].ToString()).Rows[0]["CPU"].ToString()%></p>                  
                    <p><strong>Camera:</strong> trước <%=tools.getTTSPTTByID(tools.getSanPham().Rows[i]["idSP"].ToString()).Rows[0]["Camera"].ToString()%>
                    </p>
                    <p><a class="btn" href="ProductDetails.aspx?detailspr=<%=tools.getSanPham().Rows[i]["idSP"].ToString() %>"> <i class="icon-zoom-in"></i></a> <a class="btn" role="button" data-toggle="modal" href="#muaNgay" id="btnMuaNgay<%=i %>">Đặt Ngay <i class="icon-shopping-cart"></i></a></p>
				  </div>
                      <h5><%= tools.getSanPham().Rows[i]["tenSP"].ToString() %><small>(<%=tools.getTinhTrangSanPhamByidTT(tools.getSanPham().Rows[i]["idTinhTrang"].ToString()).Rows[0]["tinhTrang"].ToString() %>)</small></h5>
                        <% if (tools.getSanPham().Rows[i]["GiaMoiRa"].ToString() == tools.getSanPham().Rows[i]["GiaHienTai"].ToString()){ %>
                        <p>&nbsp;</p>
                        <%} %>
                        <% else %>                     
                         <% if (tools.getSanPham().Rows[i]["GiaMoiRa"].ToString() != tools.getSanPham().Rows[i]["GiaHienTai"].ToString()){ %>
                        <p style="color:red;text-decoration:line-through"><%=tools.formatMoney(tools.getSanPham().Rows[i]["GiaMoiRa"].ToString(),".") + " " + "đ" %></p>
                        <%} %>
                     <p><a class="btn btn-primary" href="#"><%= tools.formatMoney(tools.getSanPham().Rows[i]["GiaHienTai"].ToString(),".") + " " + "đ" %></a></p>
					  <%--<h4 style="text-align:center"><a class="btn" href="product_details.html"> <i class="icon-zoom-in"></i></a> <a class="btn" href="Default.aspx?detailspr=<%=tools.getSanPham().Rows[i]["idSP"].ToString() %>">Thêm vào <i class="icon-shopping-cart"></i></a></h4>--%>
                        <%--<h4 style="text-align:center"><asp:LinkButton ID="btnDatHang" ToolTip="Click" CssClass="btn" Text='Thêm vào<i class="icon-shopping-cart"></i>' OnClick="btnDatHang_Click1" runat="server"  /></h4>--%>
					</div>
				</li>
                  <%
                         i++;
                  } 
                    %>
			  </ul>	
    </label>
</asp:Content>