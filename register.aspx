<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script>
        $(document).ready(function () {

            var dtToday = new Date();

            var month = dtToday.getMonth() + 1;
            var day = dtToday.getDate();
            var year = dtToday.getFullYear();

            if (month < 10)
                month = '0' + month.toString();
            if (day < 10)
                day = '0' + day.toString();

            var maxDate = year + '-' + month + '-' + day;
            $('#inputLnam').attr('max', maxDate);


            var tinhthanhpho = $("[id*=ddlTinhThanhPho]");
            var quanhuyen = $("[id*=ddlQuanHuyen]");
            var phuongxa = $("[id*=ddlPhuongXa]");

            $('#quanhuyen').hide();
            $('#phuongxa').hide();
            $.ajax({
                type: "POST",
                //Gọi trang và truyền hàm của server
                url: "register.aspx/getTinhThanhPho",
                // truyền các tham số của hàm trong C#.
                //Bạn có thể dung data{DanhSachCacBien}
                data: "{}",
                //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    //Lấy phản hồi từ Webserver cho Client
                    tinhthanhpho.empty().append('<option selected="selected" value="0">Tỉnh/Thành Phố</option>');
                    $.each(msg.d, function () {
                        tinhthanhpho.append($("<option></option>").val(this['Value']).html(this['Text']));
                    });

                }

            });
            tinhthanhpho.change(function () {
                $.ajax({
                    type: "POST",
                    //Gọi trang và truyền hàm của server
                    url: "register.aspx/getQuanHuyen",
                    // truyền các tham số của hàm trong C#.
                    //Bạn có thể dung data{DanhSachCacBien}
                    data: "{provinceid:" + tinhthanhpho.val() + "}",
                    //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        $('#quanhuyen').show(1000);
                        //Lấy phản hồi từ Webserver cho Client
                        quanhuyen.empty().append('<option selected="selected" value="0">Quận Huyện</option>');
                        $.each(msg.d, function () {
                            quanhuyen.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });

                    }

                });

            });
            quanhuyen.change(function () {
                $.ajax({
                    type: "POST",
                    //Gọi trang và truyền hàm của server
                    url: "register.aspx/getPhuongXa",
                    // truyền các tham số của hàm trong C#.
                    //Bạn có thể dung data{DanhSachCacBien}
                    data: "{districtid:" + quanhuyen.val() + "}",
                    //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        $('#phuongxa').show(1000);
                        //Lấy phản hồi từ Webserver cho Client
                        phuongxa.empty().append('<option selected="selected" value="0">Phường Xã</option>');
                        $.each(msg.d, function () {
                            phuongxa.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });

                    }

                });
            });
            $('#dkBtnDangKy').click(function () {
                var gioitinh = $('#dkGioiTinh');
                var hoten = $('#dkHoTen');
                var email = $('#dkEmail');
                var sdt = $('#dkSDT');
                var username = $('#dkUserName');
                var matkhau = $('#dkPassword');
                var xnmatkhau = $('#dkPasswordXN');
                var diachi = $('#dkDC');
                var tinhthanhpho = $("[id*=ddlTinhThanhPho]");
                var quanhuyen = $("[id*=ddlQuanHuyen]");
                var phuongxa = $("[id*=ddlPhuongXa]");
                var ngay = $('#inputLnam');
                data = username.val().match(/^[A-Za-z0-9]*$/);
                alert(data);
                if (hoten.val() == "") {
                    alert("Không được để trống họ tên.");
                    hoten.focus();
                    return false;
                }
                if (ngay.val() == "") {
                    alert("Vui lòng chọn ngày.");
                    hoten.focus();
                    return false;
                }
                if (email.val() == "") {
                    alert("Không được để trống email.");
                    email.focus();
                    return false;
                }
                if (sdt.val() == "") {
                    alert("Không được để trống số điện thoại.");
                    sdt.focus();
                    return false;
                }
                if (username.val() == "") {
                    alert("Không được để trống username.");
                    username.focus();
                    return false;
                }
                if (username.val().length > 10) {
                    alert("Độ dài username không phù hợp.");
                    username.focus();
                    return false;
                }
                if (!data) {
                    alert("Tên username không được chứa ký tự tiếng việt hoặc ký tự đặc biệt.");
                    username.focus();
                    return false;
                }
                if (matkhau.val() == "") {
                    alert("Không được để trống mật khẩu.");
                    matkhau.focus();
                    return false;
                }
                if (matkhau.val().length < 8 || matkhau.val().length > 50) {
                    alert("Độ dài mật khẩu không phù hợp.");
                    matkhau.focus();
                    return false;
                }
                if (xnmatkhau.val() == "") {
                    alert("Không được để trống xác nhận mật khẩu.");
                    xnmatkhau.focus();
                    return false;
                }
                if (diachi.val() == "") {
                    alert("Không được để trống địa chỉ nhận hàng.");
                    diachi.focus();
                    return false;
                }
                if (tinhthanhpho.val() == "0" || quanhuyen.val() == "0" || phuongxa.val()== "0") {
                    alert("Vui lòng chọn đầy đủ TP-Quận-Xã.");
                    tinhthanhpho.focus();
                    return false;
                }
                $.ajax({
                    type: "POST",
                    //Gọi trang và truyền hàm của server
                    url: "register.aspx/dangKyThanhVien",
                    // truyền các tham số của hàm trong C#.
                    //Bạn có thể dung data{DanhSachCacBien}
                    data: "{hoten:'" + hoten.val() + "',username:'" + username.val() + "',password:'" + matkhau.val() + "',diachi:'" + diachi.val() + "',gioitinh:'" + gioitinh.val() + "',dienthoai:'" + sdt.val() + "',email:'" + email.val() + "',ngaydangky:'" + ngay.val() + "',tinh:'" + tinhthanhpho.val() + "',quan:'" + quanhuyen.val() + "',huyen:'" + phuongxa.val() + "'}",
                    //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == true) {
                            alert("Đăng ký thành công!");
                            window.location.assign("Default.aspx");
                        } else {
                            alert("Đăng ký thất bại, vui lòng kiểm tra các thông tin đã chính xác chưa!");
                        }

                    }

                });
            })
            $('#dkUserName').keyup(function () {
                var username = $('#dkUserName');
                $.ajax({
                    type: "POST",
                    //Gọi trang và truyền hàm của server
                    url: "register.aspx/checkUsername",
                    // truyền các tham số của hàm trong C#.
                    //Bạn có thể dung data{DanhSachCacBien}
                    data: "{username:'" + username.val() + "'}",
                    //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == true) {
                            $('#checktendangnhap').show();
                        } else {
                            $('#checktendangnhap').hide();
                        }

                    }

                });
            })
            $('#dkEmail').keyup(function () {
                var email = $('#dkEmail');
                $.ajax({
                    type: "POST",
                    //Gọi trang và truyền hàm của server
                    url: "register.aspx/checkEmail",
                    // truyền các tham số của hàm trong C#.
                    //Bạn có thể dung data{DanhSachCacBien}
                    data: "{email:'" + email.val() + "'}",
                    //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == true) {
                            $('#checkemail').show();
                        } else {
                            $('#checkemail').hide();
                        }

                    }

                });
            })

        });
        
    </script>
    <ul class="breadcrumb">
		<li><a href="index.html">Home</a> <span class="divider">/</span></li>
		<li class="active">Đăng ký</li>
    </ul>
	<h3> Đăng ký thành viên</h3>	
	<div class="well">
	<!--
	<div class="alert alert-info fade in">
		<button type="button" class="close" data-dismiss="alert">×</button>
		<strong>Lorem Ipsum is simply dummy</strong> text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
	 </div>
	<div class="alert fade in">
		<button type="button" class="close" data-dismiss="alert">×</button>
		<strong>Lorem Ipsum is simply dummy</strong> text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
	 </div>
	 <div class="alert alert-block alert-error fade in">
		<button type="button" class="close" data-dismiss="alert">×</button>
		<strong>Lorem Ipsum is simply</strong> dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s
	 </div> -->
	<div class="form-horizontal" >
		<h4>Thông tin của bạn</h4>
		<div class="control-group">
		<label class="control-label">Title <sup>*</sup></label>
		<div class="controls">
		<select class="span1" name="days" id="dkGioiTinh">
			<option value="0">Mr.</option>
			<option value="1">Mrs</option>
		</select>
		</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="dkHoTen">Tên <sup>*</sup></label>
			<div class="controls">
			  <input type="text" id="dkHoTen" placeholder="Họ và Tên">
			</div>
		 </div>
		 <div class="control-group">
			<label class="control-label" for="inputLnam" >Ngày tháng năm sinh <sup>*</sup></label>
			<div class="controls">
			  <input type="date" id="inputLnam" max="2014-05-20">
			</div>
		 </div>
		<div class="control-group">
		<label class="control-label" for="dkEmail">Email <sup>*</sup></label>
		<div class="controls">
		  <input type="text" id="dkEmail" placeholder="Email">
		</div>
	  </div>
        <div class="alert alert-danger" id="checkemail" style="display:none">
            <strong>Chú ý !</strong> Email của bạn đã có người sử dụng.
        </div>  
        <div class="control-group">
		<label class="control-label" for="dkSDT">Số điện thoại<sup>*</sup></label>
		<div class="controls">
		  <input type="text" id="dkSDT" placeholder="Số điện thoại">
		</div>
	  </div>
        
        <div class="control-group">
		<label class="control-label" for="dkUserName">Tên đăng nhập <sup>*</sup></label>
		<div class="controls">
		  <input type="text" id="dkUserName" placeholder="Username">
		</div>
	  </div>		
        <div class="alert alert-danger" id="checktendangnhap" style="display:none">
            <strong>Chú ý !</strong> Tên đăng nhập của bạn đã bị trùng.
        </div>  
	<div class="control-group">
		<label class="control-label" for="dkPassword">Mật khẩu <sup>*</sup></label>
		<div class="controls">
		  <input type="password" id="dkPassword" placeholder="Mật Khẩu">
		</div>
	  </div>	  
        <div class="control-group">
		<label class="control-label" for="dkPasswordXN">Xác nhận mật khẩu <sup>*</sup></label>
		<div class="controls">
		  <input type="password" id="dkPasswordXN" placeholder="Mật Khẩu">
		</div>
	  </div>
		<h4>Địa chỉ</h4>
		
		
		<div class="control-group">
			<label class="control-label" for="dkDC">Địa chỉ nhận hàng<sup>*</sup></label>
			<div class="controls">
			  <textarea rows="3" id="dkDC" class="input-xlarge" placeholder="Địa Chỉ Nhận Hàng"></textarea> <span>Vui lòng điền CHÍNH XÁC "tầng, số nhà, đường" để tránh trường hợp đơn hàng bị hủy ngoài ý muốn</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="city">Tỉnh/Thành phố<sup>*</sup></label>
			<div class="controls">
                <asp:DropDownList ID="ddlTinhThanhPho" runat="server"></asp:DropDownList>
			</div>
		</div>
		<div class="control-group" id="quanhuyen">
			<label class="control-label" for="state">Quận/huyện<sup>*</sup></label>
			<div class="controls">
                <asp:DropDownList ID="ddlQuanHuyen" runat="server"></asp:DropDownList>
			</div>
		</div>		
		<div class="control-group" id="phuongxa">
			<label class="control-label" for="postcode">Phường Xã<sup>*</sup></label>
			<div class="controls">
                <asp:DropDownList ID="ddlPhuongXa" runat="server"></asp:DropDownList>
			</div>
		</div>
	
	<div class="control-group">
			<div class="controls">
				<input class="btn btn-large btn-success" type="button" id="dkBtnDangKy" value="Đăng Ký" />
			</div>
		</div>		
	</div>
</div>

</asp:Content>

