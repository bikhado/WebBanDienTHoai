<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.master" AutoEventWireup="true" CodeFile="DefaultAdmin.aspx.cs" Inherits="DefaultAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script>

        $(document).ready(function () {
            var marquee = $('div.marquee');
            marquee.each(function () {
                var mar = $(this), indent = mar.width();
                mar.marquee = function () {
                    indent--;
                    mar.css('text-indent', indent);
                    if (indent < -1 * mar.children('div.marquee-text').width()) {
                        indent = mar.width();
                    }
                };
                mar.data('interval', setInterval(mar.marquee, 1000 / 60));
            });
        })
    </script>
    <style>
        div.marquee {
          
            overflow:hidden;
            }
            div.marquee > div.marquee-text {
                white-space: nowrap;
                display: inline;
            }
    </style>
    <div class='marquee'>
    <div class='marquee-text'>
        <h3 class="marquee">Welcome to Admin Page!</h3>
    </div>
</div>
    
</asp:Content>

