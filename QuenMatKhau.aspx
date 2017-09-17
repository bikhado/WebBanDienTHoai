<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="QuenMatKhau.aspx.cs" Inherits="QuenMatKhau" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script>
        $(document).ready(function () {
            
            $('#goimatkhau').click(function () {

                var email = $('#inputEmail111');
                data3 = email.val().match(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
                if (!data3) {
                    alert("Email không hợp lệ!");
                    return false;
                }
                alert("Bạn vui lòng chờ trong giây lát........!!");
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    url: "QuenMatKhau.aspx/goiLaiMatKhau",
                    data: "{Email:'" + email.val() + "'}",
                    success: function (Record) {
                        if (Record.d == true) {
                            alert("Mật khẩu mới đã được gởi về mail của bạn. !");
                            window.location.assign("Default.aspx");
                        }
                        else {
                            alert("Email không hợp lệ !");
                        }
                    }
                });
            })
        })
    </script>
        <ul class="breadcrumb">
		<li><a href="index.html">Home</a> <span class="divider">/</span></li>
		<li class="active">Forget password?</li>
    </ul>
	<h3> BẠN ĐÃ QUÊN MẬT KHẨU?</h3>	
	<hr class="soft"/>
	
	<div class="row">
		<div class="span9" style="min-height:900px">
			<div class="well">
			<h5>Thay đổi password của bạn</h5><br/>
			Điền Email của bạn vào đây, chúng tối sẽ gởi mật khẩu mới đến mail của bạn.<br/><br/><br/>
			<div>
			  <div class="control-group">
				<label class="control-label" for="inputEmail1">E-mail address</label>
				<div class="controls">
				  <input class="span3"  type="text" id="inputEmail111" placeholder="Email">
				</div>
			  </div>
			  <div class="controls">
			  <button type="button" class="btn block" id="goimatkhau">Gởi</button>
			  </div>
			</div>
		</div>
		</div>
	</div>	
	
</asp:Content>

