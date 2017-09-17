<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SanPhamKhuyenMai.aspx.cs" Inherits="SanPhamKhuyenMai" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script>

        $(document).ready(function () {
            $("[rel='tooltip']").tooltip();

            $('.thumbnail').hover(
                function () {
                    $(this).find('.caption').slideDown(250); //.fadeIn(250)
                },
                function () {
                    $(this).find('.caption').slideUp(0); //.fadeOut(205)
                }
            );
        });
        $(document).ready(function () {
            $(window).load(function () {
                $('#preloader').fadeOut('slow', function () { $(this).remove(); });
            });

            var i = 0;
            var j = 0;
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
                            //$('.loader1').hide();
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

            while (j < rowCount) {

                $('#btnMuaNgay1' + j + '').click(function () {
                    //mausp.SelectedIndex = 1; 
                    //alert(mausp.attr('selectedIndex', 0));
                    $('.loader1').show(1000);
                    //alert($(this).closest('li').attr('id'));
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
                            $('.loader1').hide(1000);
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
                            //$('.loader1').hide();
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
                    window.location.assign("Compair.aspx?idsp0=" + sessionStorage.getItem("idsp0") + "&&idsp1=" + sessionStorage.getItem("idsp1") + "");
                    //alert(sessionStorage.getItem("idsp0"));
                }
                else
                    alert("Bạn vui lòng chọn 2 sản phẩm để so sánh !.");
            });
        });
    </script>
        <%ToolsDT tools = new ToolsDT();
      int i = 0;
      int j = 0;
      System.Data.DataSet ds = null;
      if (Request.QueryString.Get("idSapXep") != null)
      {
          if (int.Parse(Request.QueryString.Get("idSapXep").ToString()) == 2)
              ds = tools.GetPhanTrang_DataSet("TB_News_PagingByCateID98", (Request.QueryString["page"] + "" != "") ? int.Parse("0" + Request.QueryString["page"]) : 1, 6, 3, idsp, int.Parse(Request.QueryString.Get("idSapXep").ToString()), tinhtrang);
      }
      else ds = tools.GetPhanTrang_DataSet("TB_News_PagingByCateID98", (Request.QueryString["page"] + "" != "") ? int.Parse("0" + Request.QueryString["page"]) : 1, 6, 3, idsp, sapxep, tinhtrang);
        
      if((Request.QueryString.Get("idSapXep") != null)){
          if (int.Parse(Request.QueryString.Get("idSapXep").ToString()) == 4)
              ds = tools.GetPhanTrang_DataSet("TB_News_PagingByCateID97", (Request.QueryString["page"] + "" != "") ? int.Parse("0" + Request.QueryString["page"]) : 1, 6, 3, idsp, int.Parse(Request.QueryString.Get("idSapXep").ToString()), tinhtrang);
      }
      else ds = tools.GetPhanTrang_DataSet("TB_News_PagingByCateID97", (Request.QueryString["page"] + "" != "") ? int.Parse("0" + Request.QueryString["page"]) : 1, 6, 3, idsp, sapxep, tinhtrang);
      if (Request.QueryString.Get("idSapXep") != null)
      {
          if (int.Parse(Request.QueryString.Get("idSapXep").ToString()) == 1 || int.Parse(Request.QueryString.Get("idSapXep").ToString()) == 0 || int.Parse(Request.QueryString.Get("idSapXep").ToString()) == 3)
              ds = tools.GetPhanTrang_DataSet("TB_News_PagingByCateID99", (Request.QueryString["page"] + "" != "") ? int.Parse("0" + Request.QueryString["page"]) : 1, 6, 3, idsp, int.Parse(Request.QueryString.Get("idSapXep").ToString()), tinhtrang); 
      }
      else ds = tools.GetPhanTrang_DataSet("TB_News_PagingByCateID99", (Request.QueryString["page"] + "" != "") ? int.Parse("0" + Request.QueryString["page"]) : 1, 6, 3, idsp, sapxep, tinhtrang); 
      %>

        <ul class="breadcrumb">
		<li><a href="index.html">Home</a> <span class="divider">/</span></li>
		<li class="active">Sản phẩm khuyến mãi</li>
    </ul>
	<h4> <%=tools.getCodeByID(Request.QueryString.Get("idMaCode").ToString()).Rows[0]["giamGia"].ToString() + "%" + " " %> khuyến mãi, nhập mã <font style="color:red"><%=tools.getCodeByID(Request.QueryString.Get("idMaCode").ToString()).Rows[0]["maCode"].ToString() + " " %></font> áp dụng từ ngày <%=tools.getCodeByID(Request.QueryString.Get("idMaCode").ToString()).Rows[0]["ngayapdung"].ToString() %> trong vòng <%=tools.getCodeByID(Request.QueryString.Get("idMaCode").ToString()).Rows[0]["apdungmayngay"].ToString() %> ngày <small class="pull-right"> </small></h4>	
	<hr class="soft"/>
	<div class="form-horizontal span6">
		<div class="control-group">
		  <label class="control-label alignL">Sắp Xếp </label>
			<asp:DropDownList ID="ddlSapXep" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSapXep_SelectedIndexChanged">
                <asp:ListItem Value="0">--Sắp xếp--</asp:ListItem>
                <asp:ListItem Value="1">Giá từ cao đến thấp</asp:ListItem>
                <asp:ListItem Value="2">Giá từ thấp đến cao</asp:ListItem>
                <asp:ListItem Value="3">Sản phẩm theo lượt mua giảm dần</asp:ListItem>
                <asp:ListItem Value="4">Các Sản phẩm xem nhiều nhất</asp:ListItem>
            </asp:DropDownList>
		</div>
	  </div>
	<div id="myTab" class="pull-right">
	 <a href="#listView" data-toggle="tab"><span class="btn btn-large"><i class="icon-list"></i></span></a>
	 <a href="#blockView" data-toggle="tab"><span class="btn btn-large btn-primary"><i class="icon-th-large"></i></span></a>
	</div>
<br class="clr"/>
<div class="tab-content">
	<div class="tab-pane" id="listView">
        <%if(ds.Tables.Count > 1){ %>
        <%if(ds.Tables[0].Rows.Count > 0){
                        while (j < ds.Tables[0].Rows.Count) { 
                        %>
		<div class="row">	  
			<div class="span2">
				<img src="<%=ds.Tables[0].Rows[j]["urlHinh"].ToString() %>" alt=""/>
			</div>
			<div class="span4">
				<h3>New | Available</h3>				
				<hr class="soft"/>
				<h5><%=ds.Tables[0].Rows[j]["tenSP"].ToString() %> </h5>
				<p>
				<%=ds.Tables[0].Rows[j]["MoTa"].ToString() %>
				</p>
				<a class="btn btn-small pull-right" href="ProductDetails.aspx?Detailspr=<%=ds.Tables[0].Rows[j]["idSP"].ToString() %>">View Details</a>
				<br class="clr"/>
			</div>
			<div class="span3 alignR">
			<div class="form-horizontal qtyFrm" id="<%=ds.Tables[0].Rows[j]["idSP"].ToString() %>">
			<h3> <%=tools.formatMoney(ds.Tables[0].Rows[j]["GiaHienTai"].ToString(),".") + " " + "đ" %></h3>
			<label class="checkbox">
				<input type="checkbox" name="checkboxsosanh">  Thêm vào để so sánh
			</label><br/>
			<a class="btn btn-large btn-primary" role="button" data-toggle="modal" href="#muaNgay" id="btnMuaNgay1<%=j %>">Đặt Ngay <i class="icon-shopping-cart"></i></a>
			  <%--<a href=#muaNgay" class="btn btn-large btn-primary"> Mua Ngay <i class=" icon-shopping-cart"></i></a>--%>
			  <a href="ProductDetails.aspx?Detailspr=<%=ds.Tables[0].Rows[j]["idSP"].ToString() %>" class="btn btn-large"><i class="icon-zoom-in"></i></a>
			
				</div>
			</div>
		</div>
        <hr class="soft"/>
        <%
                            j = j + 1;
        } %>
        <%} %>
        <%} %>
		
	</div>

	<div class="tab-pane  active" id="blockView">
			<ul class="thumbnails" id="ulSanPham">
            <% 
                if(ds.Tables.Count > 1){%>
			 <%if(ds.Tables[0].Rows.Count > 0){
                        while (i < ds.Tables[0].Rows.Count) { 
                        %>
            <li class="span3" id="<%=ds.Tables[0].Rows[i]["idSP"].ToString() %>" >
               
			  <div class="thumbnail">
                  
				<a href="ProductDetails.aspx?Detailspr=<%= ds.Tables[0].Rows[i]["idSP"].ToString()%>"><img src="<%=ds.Tables[0].Rows[i]["urlHinh"].ToString() %>"  width="160" height="200" alt=""/></a>
				<div class="caption">
				   <h4 style="text-align:center;color:#ff6a00"><%= tools.getSanPham().Rows[i]["TenSP"].ToString() %></h4>
                        <hr style="padding:1px;"/>
                    <p><strong>Màn hình:</strong> <%=tools.getTTSPTTByID(ds.Tables[0].Rows[i]["idSP"].ToString()).Rows[0]["ManHinh"].ToString()%></p>
                    <p><strong>HĐH:</strong> <%=tools.getTTSPTTByID(ds.Tables[0].Rows[i]["idSP"].ToString()).Rows[0]["HDH"].ToString()%></p>
                    <p><strong>CPU:</strong> <%=tools.getTTSPTTByID(ds.Tables[0].Rows[i]["idSP"].ToString()).Rows[0]["CPU"].ToString()%></p>                  
                    <p><strong>Camera:</strong> trước <%=tools.getTTSPTTByID(ds.Tables[0].Rows[i]["idSP"].ToString()).Rows[0]["Camera"].ToString()%>
                    </p>
                    <p><a class="btn" href="ProductDetails.aspx?detailspr=<%=tools.getSanPham().Rows[i]["idSP"].ToString() %>"> <i class="icon-zoom-in"></i></a> <a class="btn" role="button" data-toggle="modal" href="#muaNgay" id="btnMuaNgay<%=i %>">Đặt Ngay <i class="icon-shopping-cart"></i></a></p>
				</div>
                  <%string mausp = " ";
                    for (int l = 0; l < tools.getMauByID1(ds.Tables[0].Rows[i]["idSP"].ToString()).Rows.Count; l++)
                    {
                        mausp = mausp + tools.getMauByID1(ds.Tables[0].Rows[i]["idSP"].ToString()).Rows[l]["tenmau"].ToString() + " ";
                    }%>
                    
                        
                  <p style="color:#fa0606"><img src="<%=tools.getCodeByID(Request.QueryString.Get("idMaCode").ToString()).Rows[0]["urlHinh"].ToString() %>" width="25px" height="25px"/> <%=mausp + " " + "được khuyến mãi"%></p>
                  <p><h5><%=ds.Tables[0].Rows[i]["tenSP"].ToString() %></h5></p>
                  <%if (ds.Tables[0].Rows[i]["GiaMoiRa"].ToString() == ds.Tables[0].Rows[i]["GiaHienTai"].ToString()) {%>
                  <p>&nbsp;</p>
                  <%} %>
                  <%else{ %>
                  <p><a href="#" style="text-decoration:line-through;color:#fa0606"><%=tools.formatMoney(ds.Tables[0].Rows[i]["GiaMoiRa"].ToString(),".") + " " + "đ" %></a></p>
                  <%} %>

                  <p><a class="btn btn-primary" href="#"><%=tools.formatMoney(ds.Tables[0].Rows[i]["GiaHienTai"].ToString(),".") + " " + "đ" %></a></p>
                  
			  </div>
                
			</li>
            <%
                            i = i + 1;
                  } %>
                  <% } %>
		  </ul>


	<hr class="soft"/>
	</div>
</div>
<a id="btnSoSanh" class="btn btn-large pull-right">So Sánh Sản Phẩm</a>
	<div class="pagination">
			<ul>
			<%if (ds.Tables[1].Rows.Count > 0) {  %>
             <%=ds.Tables[1].Rows[0][0] + " " %> 
        <%} %>
			</ul>
        
			</div>
    <%}else{
          ScriptManager.RegisterStartupScript(this, GetType(),"showalert", "Chưa có sản phẩm nào.!", true);
                } %>
<br class="clr"/>
</asp:Content>

