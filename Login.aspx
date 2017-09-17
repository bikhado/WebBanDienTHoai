<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script>
        $(document).ready(function () {
            $('#inputEmail0').focus();
            $('#btnRegiter').click(function () {
                window.location.assign("register.aspx");
            });

            $('#btnsignin1').click(function () {
                var user = $('#inputEmail1').val().trim();
                var pass = $('#inputPassword1').val().trim();
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    url: "Default.aspx/kiemTraDangNhap",
                    data: "{username: '" + user + "',password: '" + pass + "',checkremember:'false'}",
                    success: function (Record) {

                        if (Record.d == true) {
                            window.location.assign("ProductSummary.aspx");
                        }
                        else {
                            alert("Sai tên tài khoản hoặc mật khẩu!");
                        }
                    }
                });
            });
        })
        
    </script>
    <ul class="breadcrumb">
		<li><a href="Default.aspx">Home</a> <span class="divider">/</span></li>
		<li class="active">Login</li>
    </ul>
	<h3> Login</h3>	
	<hr class="soft"/>
	
	<div class="row" >
		<div class="span4">
			<div class="well">
			<h5>CREATE YOUR ACCOUNT</h5><br/>
			Enter your e-mail address to create an account.<br/><br/><br/>
			<div >
			  <div class="control-group">
				<label class="control-label" for="inputEmail0">E-mail address</label>
				<div class="controls">
				  <input class="span3"  type="text" id="inputEmail0" placeholder="Email">
				</div>
			  </div>
			  <div class="controls">
			  <button type="button" class="btn block" id="btnRegiter">Create Your Account</button>
			  </div>
			</div>
		</div>
		</div>
		<div class="span1"> &nbsp;</div>
		<div class="span4">
			<div class="well">
			<h5>ALREADY REGISTERED ?</h5>
			<form>
			  <div class="control-group">
				<label class="control-label" for="inputEmail1">Email</label>
				<div class="controls">
				  <input class="span3"  type="text" id="inputEmail1" placeholder="Email">
				</div>
			  </div>
			  <div class="control-group">
				<label class="control-label" for="inputPassword1">Password</label>
				<div class="controls">
				  <input type="password" class="span3"  id="inputPassword1" placeholder="Password">
				</div>
			  </div>
			  <div class="control-group">
				<div class="controls">
				  <button type="button" class="btn" id="btnsignin1">Sign in</button> <a href="forgetpass.html">Forget password?</a>
				</div>
			  </div>
			</form>
		</div>
		</div></div>
</asp:Content>

