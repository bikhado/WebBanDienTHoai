<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LienHe.aspx.cs" Inherits="LienHe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script>
        $(document).ready(function () {
            $(window).load(function () {
                $('#preloader').fadeOut('slow', function () { $(this).remove(); });
            });

            window.location.hash = '#lienhe';

            $('#lhSend').click(function () {
                //var email = $('#lhEmail').val();
                email = document.getElementById("lhEmail").value;
                var name = $('#lhName').val();
                var tieude = $('#lhTieuDe').val();
                var ykien = $('#lhYkien').val();
                tempem = email.match(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
                if (email == "") {
                    alert("Không được để trống Email.");
                    return false;
                }

                if (name == "") {
                    alert("Không được để trống Name.");
                    return false;
                }

                if (tieude == "") {
                    alert("Không được để trống tiêu đề.");
                    return false;
                }

                if (ykien == "") {
                    alert("Không được để trống ý kiến.");
                    return false;
                }
                if (!tempem) {
                    alert("Email không hợp lệ.");
                    return false;
                }
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    url: "LienHe.aspx/khLienHe",
                    data: "{hoten:'" + name + "',email:'" + email + "',tieude:'" + tieude + "',ykien:'" + ykien + "'}",
                    success: function (Record) {
                        if (Record.d == true) {
                            //alert("Bạn đã liên hệ thành công.Vui lòng chờ vài phút sẽ có người trả lời.");
                            $('#thongBao').modal('show');
                            $('#lhName').val('');
                            $('#lhTieuDe').val('');
                            $('#lhYkien').val('');
                            $('#lhEmail').val('');
                        }
                        else {
                            alert("Liên hệ thất bại.");
                        }
                    }
                });

                $('#tbTT').click(function () {

                    window.history.back();
                })
            });
        });
    </script>
    	<div id="thongBao" class="modal hide fade in" tabindex="-1" role="dialog" aria-labelledby="login" aria-hidden="false" >
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3>Thông Báo</h3>
		  </div>
		  <div class="modal-body">
                <div class="alert alert-success">
                    <strong>Success!</strong> Bạn đã liên hệ thành công.
                </div>
              <a class="btn btn-danger" id="tbTT"> Tiếp tục mua hàng.</a>
		  </div>
	</div>    
    <div id="lienhe">
    	<hr class="soften">
	<h1>Ghé thăm chúng tôi</h1>
	<hr class="soften"/>	
	<div class="row">
		<div class="span4">
		<h4>Chi tiết liên hệ</h4>
		<p>	459 Lê Văn Việt,<br/> Quận 9, VN
			<br/><br/>
			duckha9d@gmail.com<br/>
			﻿Tel 123-456-6780<br/>
			web:bikhashop.somee.com
		</p>		
		</div>
			
		<div class="span4">
		<h4>Giờ mở cửa</h4>
			<h5> Thứ 2 - Thứ 6</h5>
			<p>09:00am - 09:00pm<br/><br/></p>
			<h5>Thứ 7</h5>
			<p>09:00am - 07:00pm<br/><br/></p>
			<h5>Chủ nhật</h5>
			<p>12:30pm - 06:00pm<br/><br/></p>
		</div>
		<div class="span4">
		<h4>Liên hệ</h4>
		<form class="form-horizontal">
        <fieldset>
          <div class="control-group">
           
              <input type="text" placeholder="name" class="input-xlarge" id="lhName"/>
           
          </div>
		   <div class="control-group">
           
              <input type="text" placeholder="email" class="input-xlarge" id="lhEmail"/>
           
          </div>
		   <div class="control-group">
           
              <input type="text" placeholder="Tiêu đề" class="input-xlarge" id="lhTieuDe" />
          
          </div>
          <div class="control-group">
              <textarea rows="3" id="lhYkien" class="input-xlarge" placeholder="Ý kiến"></textarea>
           
          </div>

            <button class="btn btn-large" type="button" id="lhSend">Gởi</button>

        </fieldset>
      </form>
		</div>
	</div>
	<div class="row">
	<div class="span12">
	<iframe style="width:100%; height:300; border: 0px" scrolling="no" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d125399.75131878094!2d106.74874776465569!3d10.831028010039159!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3175275b3a69ce75%3A0xfc7063168fc12eaf!2sDistrict+9%2C+Ho+Chi+Minh%2C+Vietnam!5e0!3m2!1sen!2sus!4v1496902852939"></iframe><br />
	<small><a href="https://www.google.co.uk/maps/place/18+California,+Fresno,+CA+93710,+USA/@36.732762,-119.695787,14z/data=!4m5!3m4!1s0x80946800ca7c0703:0xca417adeb42bfe3f!8m2!3d36.8340149!4d-119.79453?hl=en" style="color:#0000FF;text-align:left">View Larger Map</a></small>
	</div>
	</div>
        </div>
</asp:Content>

