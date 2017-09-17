<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ProductSummary.aspx.cs" Inherits="ProductSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%ToolsDT tools = new ToolsDT();  %>
   <SCRIPT language = Javascript>
           function isNumberKey(evt) {
               var charCode = (evt.which) ? evt.which : evt.keyCode;
               if (charCode > 31 && (charCode < 48 || charCode > 57))
                   return false;
               return true;
           }
           //Stop Form Submission of Enter Key Press
           function stopRKey(evt) {
               var evt = (evt) ? evt : ((event) ? event : null);
               var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
               if ((evt.keyCode == 13) && (node.type == "text")) { return false; }
               if ((evt.keyCode == 13) && (node.type == "password")) { return false; }
           }
           document.onkeypress = stopRKey;
   </SCRIPT>
    <script>
        $(document).ready(function (e) {
            $(window).load(function () {
                $('#preloader').fadeOut('slow', function () { $(this).remove(); });
            });
            $('#inputUsername').focus();
            $('#canhbaosoluong').hide();
            $('#dangnhapThanhCong').hide();
            $('#phivanchuyen').hide();
            $('#nhapmathanhcong').hide();
            $('#nhapmathatbai').hide();
            var user = $('#<%=Master.FindControl("welcomeUser").ClientID %>');
            if (user.text() == "") {
                $('#dangnhapThanhCong').hide();
                $('#tableLogin').show();
            } else {
                $('#dangnhapThanhCong').show(1000);
                $('#tableLogin').hide();
            }
            var i = 0;
            var rowCount = $('#tbProductSummary tr').length;
            while (i < rowCount) {
                $('#btnPlus' + i + '').click(function () {
                    $('#canhbaosoluong').hide();
                    var id1 = $(this).closest('tr').attr('id');
                    
                    var temp = id1.indexOf(" ");
                    var id = id1.substr(0, temp);
                    var mamautemp = id1.substr(temp,id1.length);
                    var mamau = mamautemp.replace(" ", "");
                    var soLuong = parseInt($('#soLuong' + id + mamau + '').val()) + 1;
                    // cập nhật thành tiền
                    var giatien = $(this).closest('tr').children('td.giaTien').text();
                    var thanhTien = $(this).closest('tr').children('td.thanhTien').text();
                    var sub = giatien.replace("đ", "");
                    var res = sub.split(".").join("");
                    var okthanhTien = Number(res) * soLuong;
                    
                    //tách lấy tổng tiền
                    var tongtien = $('#tbProductSummary tr').children('td.tongTien').text();
                    var sub1 = tongtien.replace("đ", "");
                    var res1 = sub1.split(".").join("");
                    var oktongTien = Number(res1) + Number(res);
                    var tdthanhtien = $(this).closest('tr').children('td.thanhTien');
                    var tongtienMasterpage = $('#<%=Master.FindControl("lblTongTien").ClientID %>');
                    var tongtien1Masterpage = $('#<%=Master.FindControl("lblTongTien1").ClientID %>');
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        url: "ProductSummary.aspx/soLuong",
                        data: "{idsp:" +id+ ", idmau: "+mamau+", soluong:" +soLuong+ "}",
                        success: function (Record) {

                            if (Record.d == true) {
                                $('#soLuong' + id + mamau + '').val(soLuong);
                               
                                // cập nhật lại thành tiền va tổng tiền
                                tdthanhtien.text(okthanhTien.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "đ");
                                $('#tbProductSummary tr').children('td.tongTien').text(oktongTien.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "đ");
                                //$('#aaaaaaaaa').text(okthanhTien.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "đ");
                                tongtienMasterpage.text(oktongTien.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "VNĐ");
                                tongtien1Masterpage.text(oktongTien.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "VNĐ");
                            }
                            else {
                                //alert("Số lượng đã vượt quá trong kho. !");
                                $('#canhbaosoluong').show();
                                $('#canhbaosoluongtext').text("Không thể cộng thêm, vì số lượng đã vừa đủ trong kho nhé .");
                            }
                        }
                    });
                });

                $('#btnMinus99' + i + '').click(function () {
                    $('#canhbaosoluong').hide();
                    var id1 = $(this).closest('tr').attr('id');
                    var temp = id1.indexOf(" ");
                    var id = id1.substr(0, temp);
                    var mamautemp = id1.substr(temp, id1.length);
                    var mamau = mamautemp.replace(" ", "");
                    var soLuong = parseInt($('#soLuong' + id + mamau + '').val()) - 1;

                    // cập nhật thành tiền
                    var giatien = $(this).closest('tr').children('td.giaTien').text();
                    var thanhTien = $(this).closest('tr').children('td.thanhTien').text();
                    var sub = giatien.replace("đ", "");
                    var res = sub.split(".").join("");
                    var okthanhTien = Number(res) * soLuong;

                    //tách lấy tổng tiền
                    var tongtien = $('#tbProductSummary tr').children('td.tongTien').text();
                    var sub1 = tongtien.replace("đ", "");
                    var res1 = sub1.split(".").join("");
                    var oktongTien = Number(res1) - Number(res);
                    var tdthanhtien = $(this).closest('tr').children('td.thanhTien');
                    var tongtienMasterpage = $('#<%=Master.FindControl("lblTongTien").ClientID %>');
                    var tongtien1Masterpage = $('#<%=Master.FindControl("lblTongTien1").ClientID %>');
                    if (soLuong > 0) {

                        $.ajax({
                            type: "POST",
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            url: "ProductSummary.aspx/soLuong",
                            data: "{idsp:" + id + ", idmau: " + mamau + ", soluong:" + soLuong + "}",
                            success: function (Record) {

                                if (Record.d == true) {
                                    $('#soLuong' + id + mamau + '').val(soLuong);

                                    // cập nhật lại thành tiền va tổng tiền
                                    tdthanhtien.text(okthanhTien.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "đ");
                                    $('#tbProductSummary tr').children('td.tongTien').text(oktongTien.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "đ");
                                    tongtienMasterpage.text(oktongTien.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "VNĐ");
                                    tongtien1Masterpage.text(oktongTien.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "VNĐ");
                                }
                                else {
                                    //alert("Số lượng đã vượt quá trong kho. !");
                                    $('#soLuong' + id + mamau + '').val(soLuong);
                                    $('#canhbaosoluong .canhbaosoluongtext').text("Số lượng đã vượt quá trong kho !");
                                }
                            }
                        });

                    }
                });
                $('#btnDelete' + i + '').click(function () {
                    var id1 = $(this).closest('tr').attr('id');

                    //lấy mã và màu sản phẩm
                    var temp = id1.indexOf(" ");
                    var id = id1.substr(0, temp);
                    var mamautemp = id1.substr(temp, id1.length);
                    var mamau = mamautemp.replace(" ", "");

                    // lấy tổng tiền
                    var tongtien = $('#tbProductSummary tr').children('td.tongTien').text();
                    var sub1 = tongtien.replace("đ", "");
                    var res1 = sub1.split(".").join("");

                    //lấy ra thành tiền
                    var soLuong = parseInt($('#soLuong' + id + mamau + '').val());
                    var giatien = $(this).closest('tr').children('td.giaTien').text();
                    var sub = giatien.replace("đ", "");
                    var res = sub.split(".").join("");
                    var okthanhTien = Number(res) * soLuong;

                    // tính tổng tiền còn lại
                    var tongtienconlai = Number(res1) - Number(okthanhTien);
                    //$('#tbProductSummary tr').children('td.tongTien').text(tongtienconlai.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "đ");
                    var soluongMasterpage = $('#<%=Master.FindControl("lblSoluong").ClientID %>');
                    var soluong1Masterpage = $('#<%=Master.FindControl("lblSoluong1").ClientID %>');
                    var tongtienMasterpage = $('#<%=Master.FindControl("lblTongTien").ClientID %>');
                    var tongtien1Masterpage = $('#<%=Master.FindControl("lblTongTien1").ClientID %>');
                    var soluongtemp = parseInt(soluongMasterpage.text());
                    var soluong1temp = parseInt(soluong1Masterpage.text());
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        url: "ProductSummary.aspx/deleteSPofGH",
                        data: "{idsp:" + id + ", idmau: " + mamau + ", userName:''}",
                        success: function (Record) {
                            if (Record.d == true) {
                                alert("Sản phẩm đã được xóa");
                            }
                            else {
                                alert("Không được xóa sản phẩm");
                            }
                        }
                    });
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        url: "ProductSummary.aspx/xoaSanPham",
                        data: "{idsp:" + id + ", idmau: " + mamau + ", soluong:0}",
                        success: function (Record) {

                            if (Record.d == true) {
                                // cập nhật lại thành tiền va tổng tiền                              
                                $('#tbProductSummary tr').children('td.tongTien').text(tongtienconlai.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "đ");
                                tongtienMasterpage.text(tongtienconlai.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "VNĐ");
                                tongtien1Masterpage.text(tongtienconlai.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "VNĐ");
                                soluongMasterpage.text(soluongtemp - 1);
                                soluong1Masterpage.text(soluong1temp - 1);

                                if (($('#tbProductSummary tr').length - 2) == 0) {
                                    alert("Không còn sản phẩm nào trong giỏ hàng.");                                 
                                    window.location.assign("Default.aspx");
                                 
                                }
                            }
                            else {
                                //alert("Số lượng đã vượt quá trong kho. !");
                                $('#canhbaosoluong .canhbaosoluongtext').text("Số lượng đã vượt quá trong kho !");
                            }
                        }
                    });
                    //xóa đi 1 dòng
                    $(this).closest('tr').remove();
                });
                i = i + 1;
            }
            $('#btnSignin').click(function () {
                var user = document.getElementById("inputUsername").value;
                var pass = document.getElementById("inputPassword1").value
                
                //$.ajax({
                //    type: "POST",
                //    dataType: "json",
                //    contentType: "application/json; charset=utf-8",
                //    url: "ProductSummary.aspx/kiemtraDangNhap",
                //    data: "{user:'" + user + "', pass: '" + pass + "'}",
                //    success: function (Record) {

                //        if (Record.d == true) {
                //            $('#dangnhapThanhCong').show(1000);
                //            $('#tableLogin').hide();
                //        }
                //        else {
                //            alert("NOT OK");
                //        }
                //    }
                //});
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    url: "Default.aspx/kiemTraDangNhap",
                    data: "{username: '" + user + "',password: '" + pass + "',checkremember:'false'}",
                    success: function (Record) {

                        if (Record.d == true) {
                                        $('#dangnhapThanhCong').show(1000);
                                        $('#tableLogin').hide();
                        }
                        else {
                            alert("Sai tên tài khoản hoặc mật khẩu!");
                        }
                    }
                });
            });

            var tinhthanhpho = $("[id*=ddlTinhThanhPho]");
            var quanhuyen = $("[id*=ddlQuanHuyen]");
            var phuongxa = $("[id*=ddlPhuongXa]");
            var ptgh = $("[id*=ddlPTGH]");
            var pttt = $("[id*=ddlPTTT]");
            $('#quanhuyen').hide();
            $('#phuongxa').hide();
            $('#ptgh').hide();
            $('#pttt').hide();
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
                        $('#quanhuyen').show(500);
                        //Lấy phản hồi từ Webserver cho Client
                        quanhuyen.empty().append('<option selected="selected" value="0">Quận Huyện</option>');
                        $.each(msg.d, function () {
                            quanhuyen.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        $('#phivanchuyen').hide();
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
                        $('#phuongxa').show(500);
                        //Lấy phản hồi từ Webserver cho Client
                        phuongxa.empty().append('<option selected="selected" value="0">Phường Xã</option>');
                        $.each(msg.d, function () {
                            phuongxa.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        $('#phivanchuyen').hide();
                    }

                });
            });
            
            phuongxa.change(function () {
                
                
                $.ajax({
                    type: "POST",
                    //Gọi trang và truyền hàm của server
                    url: "ProductSummary.aspx/getPTTT",
                    // truyền các tham số của hàm trong C#.
                    //Bạn có thể dung data{DanhSachCacBien}
                    data: "{}",
                    //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        $('#ptgh').show(500);
                        //Lấy phản hồi từ Webserver cho Client
                        ptgh.empty().append('<option selected="selected" value="0">Chọn</option>');
                        $.each(msg.d, function () {
                            ptgh.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                        $('#phivanchuyen').hide();
                    }

                });
                    
            });
            phivanchuyen = $("#tinhphivanchuyen");
            ptgh.change(function () {
                $('#pttt').show(500);
                if (tinhthanhpho.val() == '79' && quanhuyen.val() == '765')
                {
                    if (ptgh.val() == 1) {
                        phivanchuyen.text("20K")
                    }
                    else if(ptgh.val() == 2){
                        phivanchuyen.text("25K")
                    } else {
                        phivanchuyen.text("30K")
                    }
                    $('#phivanchuyen').show(500);
                }
                else {
                    if (ptgh.val() == 1) {
                        phivanchuyen.text("30K")
                    }
                    else if (ptgh.val() == 2) {
                        phivanchuyen.text("35K")
                    } else {
                        phivanchuyen.text("40K")
                    }
                    $('#phivanchuyen').show(500);
                }
            });
            var addmacode = $('#addmacode');
            
            addmacode.click(function () {
                var sotiengiam = 0;
                
                $('#tbProductSummary > tbody  > tr').each(function () {
                    check = 0;
                    var id1 = $(this).closest('tr').attr('id');
                    var tensp = $(this).closest('tr').children('td.tenspham').text();
                    var mauspham = $(this).closest('tr').children('td.mauspham').text();
                    //lấy mã và màu sản phẩm
                    var temp = id1.indexOf(" ");
                    var id = id1.substr(0, temp);
                    var mamautemp = id1.substr(temp, id1.length);
                    var mamau = mamautemp.replace(" ", "");
                    
                    //lấy ra thành tiền
                    var soLuong = parseInt($('#soLuong' + id + mamau + '').val());
                    var giatien = $(this).closest('tr').children('td.giaTien').text();
                    var sub = giatien.replace("đ", "");
                    var res = sub.split(".").join("");
                    var okthanhTien = Number(res) * soLuong;

                    var macode = document.getElementById("macode").value;

                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        url: "ProductSummary.aspx/getMaCode",
                        data: "{macode:'" + macode + "',idsp:"+id+",idmau:"+mamau+"}",
                        success: function (Record) {
                            
                            if (Record.d == true) {
                                $.ajax({
                                    type: "POST",
                                    dataType: "json",
                                    contentType: "application/json; charset=utf-8",
                                    url: "ProductSummary.aspx/tinhSoTienGiam",
                                    data: "{macode:'" + macode + "',tongtien:" + okthanhTien + ",idsp:" + id + ",idmau:" + mamau + "}",
                                    success: function (Record) {
                                        sotiengiam = sotiengiam + Record.d;
                                        $('#nhapmathanhcongtext').text(sotiengiam.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "VNĐ");
                                        $('#nhapmathanhcong').show();
                                        $('#nhapmathatbai').hide();
                                        check = check + 1;
                                    }
                                });                                                                  
                            }
                            else if (Record.d == false && check == 0)
                            {
                                $('#nhapmathatbai').show();
                                $('#nhapmathanhcong').hide();
                            }
                        }
                    });                    
                });
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
            $('#btnXacNhan56').click(function () {
                if (phuongxa.val() == 0 || tinhthanhpho.val() == 0 || quanhuyen.val()==0  || ptgh.val() == 0) {
                    alert("Vui lòng chọn thông tin đầy đủ để tính Ship cho bạn.");
                }
                else {
                    var user1 = $('#<%=Master.FindControl("welcomeUser").ClientID %>');
                    if (user1.text() == "" && $('#tableLogin').is(":visible") == true) {
                        window.location.assign("Login.aspx");
                    } else {
                        //alert("Bạn đã đặt hàng");

                        //alert($('#tableLogin').is(":visible"));
                        //alert(user1.text());
                        //$.ajax({
                        //    type: "POST",
                        //    //Gọi trang và truyền hàm của server
                        //    url: "ProductSummary.aspx/tinhPhiCode",
                        //    // truyền các tham số của hàm trong C#.
                        //    //Bạn có thể dung data{DanhSachCacBien}
                        //    data: "{macode:'" + macode + "',tongTien:" + id + ",ship:" + mamau + ",idsp:" + mamau + ",idmau:" + mamau + "}",
                        //    //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                        //    contentType: "application/json; charset=utf-8",
                        //    dataType: "json",
                        //    success: function (msg) {
                        //        //Lấy phản hồi từ Webserver cho Client
                        //        pttt.empty();
                        //        $.each(msg.d, function () {
                        //            pttt.append($("<option></option>").val(this['Value']).html(this['Text']));
                        //        });

                        //    }

                        //});
                        //lấy ra tổng tiền
                        var tongtien = $('#tbProductSummary tr').children('td.tongTien').text();
                        var sub1 = tongtien.replace("đ", "");
                        var res1 = sub1.split(".").join("");

                        //lấy ra số tiền giảm
                        var sotiengiam = $('#nhapmathanhcongtext').text();
                        var sub2 = sotiengiam.replace("VNĐ", "");
                        var res2 = sub2.split(".").join("");

                        //lấy ra tiền ship
                        var tienship = phivanchuyen.text().replace("K", "");

                        // tổng tiền phải trả 
                        var tongtienphaitra = Number(res1) - Number(res2) + Number(tienship);

                        //lấy ra username
                        //var username = document.getElementById("inputUsername").value;
                        var username = $('#<%=Master.FindControl("welcomelogin").ClientID %>').text();

                        // pttt
                        var ptthanhtoan = pttt.val();
                        var ptgiaohang = ptgh.val();

                        var loinhangui = $('#loinhangui').val();
                        // mã code
                        var macode = document.getElementById("macode").value;
                        // đã trả tiền
                        var datratien;
                        if (pttt.val() == 1) datratien = 0;
                        else {
                            alert("Đang cập nhật thanh toán qua ngân hàng!");
                            datratien = 0;
                        };
                        $.ajax({
                            type: "POST",
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            url: "ProductSummary.aspx/datHang",
                            data: "{username:'" + username + "',email:'" + username + "',tongtien:" + tongtienphaitra + ",idpttt:" + ptthanhtoan + ",idptgh:" + ptgiaohang + ",loikhachdan:'" + loinhangui + "',shipping:" + tienship + ",macode:'" + macode + "',datratien:" + datratien + "}",
                            success: function (Record) {

                                if (Record.d == true) {
                                    if (sotiengiam == "") {
                                        $('#thongBaoTongTien').modal('show');
                                        $('#thanhtoan').modal('hide');
                                        $('#fontThongBaoTongTien').text("Tổng số tiền bạn phải trả là: " + tongtien + "+" + phivanchuyen.text() + "=" + tongtienphaitra.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "VNĐ");
                                    }

                                    else {
                                        $('#thanhtoan').modal('hide');
                                        $('#thongBaoTongTien').modal('show');
                                        $('#fontThongBaoTongTien').text("Tổng số tiền bạn phải trả là: " + tongtien + "-" + sotiengiam + "+" + phivanchuyen.text() + "=" + tongtienphaitra.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " " + "VNĐ");
                                    }
                                }
                                else {
                                    //alert("Đặt hàng thất bại.!");

                                    $.ajax({
                                        type: "POST",
                                        //Gọi trang và truyền hàm của server
                                        url: "ProductSummary.aspx/kiemTraSoLuong",
                                        // truyền các tham số của hàm trong C#.
                                        //Bạn có thể dung data{DanhSachCacBien}
                                        data: "{}",
                                        //Nếu không có tham số truyền vào trong hàm bạn có thể dung data: "{}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (msg) {
                                            //Lấy phản hồi từ Webserver cho Client
                                            $('#fontThongBaoSL').text(msg.d);

                                        }

                                    });
                                    $('#thanhtoan').modal('hide');
                                    $('#thongBaoThatBai').modal('show');
                                }
                            }
                        });
                        //alert(macode);
                    }
                }
            });
            $('#btncontinueshopping').click(function () {
                window.history.back();
            });

            $('#loinhangui').keyup(function (e) {
                if (e.keyCode == 13) {
                    $("#btnXacNhan").click();
                }
            });
            $('#inputUsername').keyup(function (e) {
                if (e.keyCode == 13) {
                    $("#btnSignin").click();
                }
            });
            $('#inputPassword1').keyup(function (e) {
                if (e.keyCode == 13) {
                    $("#btnSignin").click();
                }
            });
            $('#tbTT').click(function () {
                window.location.assign("Default.aspx");
            })
            $('#ttttClose').click(function () {
                window.location.reload();
            })
        });
    </script>
        	<div id="thongBaoTongTien" class="modal hide fade in" tabindex="-1" role="dialog" aria-labelledby="login" aria-hidden="false" >
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="ttttClose">×</button>
			<h3>Thông Báo</h3>
		  </div>
		  <div class="modal-body">
                <div class="alert alert-success">
                    <strong>Success!</strong> Bạn đã đặt hàng thành công.
                </div>
              <div class="alert alert-info">
                <strong>Info!</strong> <font id="fontThongBaoTongTien" style="font-size:12px"></font>
            </div>
              <a class="btn btn-danger" id="tbTT"> Tiếp tục mua hàng.</a>
		  </div>
	</div>    

            	<div id="thongBaoThatBai" class="modal hide fade in" tabindex="-1" role="dialog" aria-labelledby="login" aria-hidden="false" >
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3>Thông Báo</h3>
		  </div>
		  <div class="modal-body">
              <div class="alert alert-error">
                <strong>Info!</strong> <font id="fontThongBaoSL" style="font-size:12px"></font>
            </div>
              <a class="btn btn-danger" data-dismiss="modal" aria-hidden="true"> Close.</a>
		  </div>
	</div>  
    <%Carts cart = new Carts();
      cart = (Carts)Session["cart"];%>
    <ul class="breadcrumb">
		<li><a href="Defaults.aspx">Home</a> <span class="divider">/</span></li>
		<li class="active"> Giỏ Hàng </li>
    </ul>
    <%if (Session["cart"] != null) {%>
	<h3>  GIỎ HÀNG [ <small><%= cart.vebang().Rows.Count %> sản phẩm </small>]<a id="btncontinueshopping" class="btn btn-large pull-right"><i class="icon-arrow-left"></i> Tiếp tục mua hàng </a></h3>	
	<%} %>
    <hr class="soft"/>
	<table class="table table-bordered" id="tableLogin">
		<tr><th> BẠN ĐÃ CÓ TÀI KHOẢN  </th></tr>
		 <tr> 
		 <td>
			<div class="form-horizontal">
				<div class="control-group">
				  <label class="control-label" for="inputUsername">Username</label>
				  <div class="controls">
					<input type="text" id="inputUsername" placeholder="Username">
          
				  </div>
				</div>
				<div class="control-group">
				  <label class="control-label" for="inputPassword1">Password</label>
				  <div class="controls">
					<input type="password" id="inputPassword1" placeholder="Password">
				  </div>
				</div>
				<div class="control-group">
				  <div class="controls">
					<button type="button" class="btn" id="btnSignin">Sign in</button> OR <a href="register.aspx" class="btn">Register Now!</a>
				  </div>
				</div>
				<div class="control-group">
					<div class="controls">
					  <a href="QuenMatKhau.aspx" style="text-decoration:underline">Quên mật khẩu ?</a>
					</div>
				</div>
                
			</div>
		  </td>
		  </tr>
	</table>	
    <div class="alert alert-success" id="dangnhapThanhCong">
        <button type="button" class="close" data-dismiss="alert">×</button>
                    <strong>Success!</strong> Đăng nhập thành công!.
                </div>	
	<div class="alert alert-danger" id="canhbaosoluong">
  <strong>Chú ý !</strong> <font id="canhbaosoluongtext" style="font-size:12"></font>
    </div>		
	<table class="table table-bordered" id="tbProductSummary">
              <thead>
                <tr>
                  <th>Sản Phẩm</th>
                  <th>Tên</th>
                  <th>Màu</th>
                  <th>Số Lượng</th>
                  <th>Ngày Order</th>
				  <th>Giá Tiền</th>                                 
                  <th>Thành Tiền</th>
				</tr>
              </thead>
              <tbody>
                  <%                   
                     int i = 0;
                     if (Session["cart"] == null && Session["username"] == null)
                     {
                         ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Chưa có sản phẩm nào trong giỏ hàng !!');", true);
                     }
                     else
                     {
                         if (Session["username"] == null)
                         {
                             while (i < cart.vebang().Rows.Count)
                             { %>
                <tr id="<%= cart.vebang().Rows[i]["idSP"].ToString() + " " + cart.vebang().Rows[i]["mamau"].ToString()%>">
                  <td> <img width="60" src="<% = cart.vebang().Rows[i]["urlHinh"].ToString()%>" alt=""/></td>
                  <td class="tenspham"><%= cart.vebang().Rows[i]["tenSP"].ToString()%></td>
                  <td class="mauspham"><%= cart.vebang().Rows[i]["mau"].ToString()%></td>
				  <td>
					<div class="input-append"><input class="span1" style="max-width:34px;" readonly placeholder="1" size="16" type="number" value="<%= cart.vebang().Rows[i]["soLuong"].ToString()%>" id="soLuong<%=(cart.vebang().Rows[i]["idSP"].ToString() + cart.vebang().Rows[i]["mamau"].ToString()).Trim()%>" min="0"><button class="btn" type="button" id="btnMinus99<%=i%>"><i class="icon-minus"></i></button><button class="btn" id="btnPlus<%=i%>" type="button"><i class="icon-plus"></i></button><button class="btn btn-danger" type="button" id="btnDelete<%=i%>"><i class="icon-remove icon-white"></i></button>				
                      </div>
				  </td>
                  <td><%= cart.vebang().Rows[i]["ngayDat"].ToString()%></td>
                  <td class="giaTien"><%= tools.formatMoney(cart.vebang().Rows[i]["giaTien"].ToString(), ".") + " " + "đ"%></td>                              
                  <td class="thanhTien"><%= tools.formatMoney(cart.vebang().Rows[i]["thanhTien"].ToString(), ".") + " " + "đ"%></td>
                </tr>
                  <%
                                 i = i + 1;
                             }
                         }
                         else
                         {
                             int ij = 0; %>
                  <%if (tools.getGioHang(Session["username"].ToString()).Rows.Count > 0) %>
                    <%while (ij < tools.getChiTietGH(tools.getGioHang(Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows.Count)
                      { %>
                  
                  <tr id="<%= tools.getChiTietGH(tools.getGioHang(Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ij]["idSP"].ToString() + " " + tools.getChiTietGH(tools.getGioHang(Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ij]["idMau"].ToString()%>">
                  <td> <img width="60" src="<% = tools.getSanPhamByID(tools.getChiTietGH(tools.getGioHang(Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ij]["idSP"].ToString()).Rows[0]["urlHinh"].ToString()%>" alt=""/></td>
                  <td class="tenspham"><%= tools.getSanPhamByID(tools.getChiTietGH(tools.getGioHang(Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ij]["idSP"].ToString()).Rows[0]["tenSP"].ToString()%></td>
                  <td class="mauspham"><%= tools.getMauByIdMau(tools.getChiTietGH(tools.getGioHang(Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ij]["idMau"].ToString()).Rows[0]["TenMau"].ToString()%></td>
				  <td>
					<div class="input-append"><input class="span1" style="max-width:34px;" readonly placeholder="1" size="16" type="number" value="<%= tools.getChiTietGH(tools.getGioHang(Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ij]["SoLuongSP"].ToString()%>" id="soLuong<%= tools.getChiTietGH(tools.getGioHang(Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ij]["idSP"].ToString() + tools.getChiTietGH(tools.getGioHang(Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ij]["idMau"].ToString()%>" min="0"><button class="btn" type="button" id="btnMinus99<%=ij%>"><i class="icon-minus"></i></button><button class="btn" id="btnPlus<%=ij%>" type="button"><i class="icon-plus"></i></button><button class="btn btn-danger" type="button" id="btnDelete<%=ij%>"><i class="icon-remove icon-white"></i></button>				
                      </div>
				  </td>
                  <td><%= tools.getGioHang(Session["username"].ToString()).Rows[0]["NgayOrder"].ToString()%></td>
                  <td class="giaTien"><%= tools.formatMoney(tools.getChiTietGH(tools.getGioHang(Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ij]["GiaTien"].ToString(), ".") + " " + "đ"%></td>                              
                  <td class="thanhTien"><%= tools.formatMoney(tools.getChiTietGH(tools.getGioHang(Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ij]["ThanhTien"].ToString(), ".") + " " + "đ"%></td>
                </tr>
                  <%                   
                          ij = ij + 1;
                      } %>
                  <%} %>
				
                <tr>
                    <%if (Session["username"] == null)
                      { %>
                  <td colspan="6" style="text-align:right">Tổng tiền:	</td>
                  <td class="tongTien"><%= tools.formatMoney(cart.tongTien.ToString(), ".") + " " + "đ"%></td>
                <%}
                      else
                      { %>
                    <td colspan="6" style="text-align:right">Tổng tiền:	</td>
                    <%if (tools.getGioHang(Session["username"].ToString()).Rows.Count > 0) {%>
                  <td class="tongTien"><%= tools.formatMoney(tools.getGioHang(Session["username"].ToString()).Rows[0]["TongTien"].ToString(), ".") + " " + "đ"%></td>
                    <%}else
                          ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Chưa có sản phẩm nào trong giỏ hàng !!');", true); %>
                    <%} %>
                </tr>

                 <%} %>
				</tbody>
            </table>
		
		<div id="thanhtoan" class="modal hide fade in" tabindex="-1" role="dialog" aria-labelledby="login" aria-hidden="false">
		  <div class="modal-header" style="background-color:#21e88c;text-align:center">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>			
            <h3 style="color:#ff6a00;text-align:center">Hoàn Tất - Quá Trình Thanh Toán</h3>
            <small>(Cảm ơn quý khách đã luôn tin tưởng chúng tôi)</small>
		  </div>
		  <div class="modal-body">
              <table class="table table-bordered">
			<tbody>
				 <tr>
                  <td> 
				<div class="form-horizontal">
				<div class="control-group">
				<label class="control-label"><strong> VOUCHERS CODE<small>(nếu có)</small>: </strong> </label>
				<div class="controls">
				<input type="text" class="input-medium" placeholder="CODE" id="macode">
				<button type="button" class="btn" id="addmacode"> ADD </button>
				</div>
				</div>
				</div>
				</td>
                </tr>
				<div class="alert alert-success" id="nhapmathanhcong">
                    <strong>Success!</strong>Bạn đã được giảm <font id="nhapmathanhcongtext" style="font-size:12px"></font>
                </div>
                <div class="alert alert-danger" id="nhapmathatbai">
                    <strong>Danger!</strong> Nhập mã thất bại.
                </div>
			</tbody>
			</table>
			
			<table class="table table-bordered">
			 <tr><th>ƯỚC TÍNH PHÍ VẬN CHUYỂN </th></tr>
			 <tr> 
			 <td>
				<div class="form-horizontal">
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
        <div class="control-group" id="ptgh">
			<label class="control-label" for="postcode">Phương Thức Giao Hàng<sup>*</sup></label>
			<div class="controls">
                <asp:DropDownList ID="ddlPTGH" runat="server"></asp:DropDownList>
			</div>
		</div>
        <div class="control-group" id="pttt">
			<label class="control-label" for="postcode">Phương Thức Thanh Toán<sup>*</sup></label>
			<div class="controls">
                <asp:DropDownList ID="ddlPTTT" runat="server"></asp:DropDownList>
			</div>
		</div>
        <div class="control-group">
			<label class="control-label" for="address">Bạn Có Muốn Nhắn Gửi Gì Không<sup></sup></label>
			<div class="controls">
			  <textarea rows="3" id="loinhangui" class="input-xlarge" placeholder="Nhập văn bản"></textarea>
			</div>
		</div>
              <div class="alert alert-info" id="phivanchuyen">
                  <strong>Info!</strong>Phí vận chuyển của bạn là <font id="tinhphivanchuyen" style="font-size:12px"></font>
              </div>
				</div>				  
			  </td>
			  </tr>
            </table>	
             <p><button type="button" class="btn btn-success" style="margin-left:34%;width:151px" id="btnXacNhan56">Xác Nhận</button></p>
		  </div>
	</div>   
            	
	<a href="Default.aspx" class="btn btn-large"><i class="icon-arrow-left"></i> Tiếp tục mua hàng </a>
    <%
        if (Session["cart"] != null || (Session["username"] != null && tools.getGioHang(Session["username"].ToString()).Rows.Count > 0 &&  tools.getChiTietGH(tools.getGioHang(Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows.Count > 0))
        {
    %>
	<a class="btn btn-large pull-right" id="datHangfinish" role="button" data-toggle="modal" href="#thanhtoan">Thanh Toán <i class="icon-arrow-right" ></i></a>
    <%}%>
</asp:Content>

