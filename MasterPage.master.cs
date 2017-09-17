using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ToolsDT tools = new ToolsDT();
        Carts cart = (Carts)Session["cart"];
        if (cart == null)
        {
            if (Session["username"] == null)
            {
                lblSoLuong.Text = "0";
                lblTongTien.Text = "0 VNĐ";
                lblSoLuong1.Text = "0";
                lblTongTien1.Text = "0 VNĐ";
            }
            else
            {
                if (tools.getGioHang(Session["username"].ToString()).Rows.Count > 0)
                {
                lblSoLuong.Text = tools.getGioHang(Session["username"].ToString()).Rows[0]["SoLuong"].ToString();
                lblTongTien.Text =tools.formatMoney(tools.getGioHang(Session["username"].ToString()).Rows[0]["TongTien"].ToString(),".") + " " + "VNĐ";
                lblSoLuong1.Text = tools.getGioHang(Session["username"].ToString()).Rows[0]["SoLuong"].ToString();
                lblTongTien1.Text = tools.formatMoney(tools.getGioHang(Session["username"].ToString()).Rows[0]["TongTien"].ToString(), ".") + " " + "VNĐ";
                }
            }
        }
        else if (cart != null)
        {
            if (Session["username"] == null)
            {
                string tp = cart.vebang().Rows.Count.ToString();
                lblSoLuong.Text = tp + " ";
                string tpc = cart.tongTien.ToString();
                lblTongTien.Text = tools.formatMoney(tpc, ".") + "VNĐ";
                lblSoLuong1.Text = tp + " ";
                lblTongTien1.Text = tools.formatMoney(tpc, ".") + "VNĐ";
            }
            else
            {
                if (tools.getGioHang(Session["username"].ToString()).Rows.Count > 0)
                {
                    lblSoLuong.Text = tools.getGioHang(Session["username"].ToString()).Rows[0]["SoLuong"].ToString();
                    lblTongTien.Text =tools.formatMoney(tools.getGioHang(Session["username"].ToString()).Rows[0]["TongTien"].ToString(),".") + " " + "VNĐ";
                    lblSoLuong1.Text = tools.getGioHang(Session["username"].ToString()).Rows[0]["SoLuong"].ToString();
                    lblTongTien1.Text = tools.formatMoney(tools.getGioHang(Session["username"].ToString()).Rows[0]["TongTien"].ToString(), ".") + " " + "VNĐ";
                }
            }
            
        }

        if (Request.Cookies["authcoolie"] != null)
        {
            if (tools.checkLogin(Request.Cookies["authcoolie"]["UserName"], Request.Cookies["authcoolie"]["Password"]).Rows.Count > 0)
            {
                welcomeUser.Text = Request.Cookies["authcoolie"]["UserName"];
            }
        }
        if (Session["username"] != null)
        {
            welcomeUser.Text = Session["username"].ToString();
            welcomelogin.Text = Session["username"].ToString();
        }
        
    }

    
    //protected void btnLogin_Click(object sender, EventArgs e)
    //{
    //     ToolsDT tools = new ToolsDT();
    //     if (tools.checkLogin(inputEmail.Text, inputPassword.Text).Rows.Count > 0)
    //     {
    //         if (checkRemember.Checked)
    //         {
    //             Response.Cookies["authcoolie"]["UserName"] = inputEmail.Text;
    //             Response.Cookies["authcoolie"]["Password"] = inputPassword.Text;
    //             Response.Cookies["authcoolie"].Expires = DateTime.Now.AddDays(+30);
    //         }
    //         else
    //         {
    //             Response.Cookies["authcoolie"].Expires = DateTime.Now.AddDays(-1);
    //         }
    //         welcomeUser.Text = inputEmail.Text;
    //     }
    //     else
    //     {
    //         ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Sai tên tài khoản hoặc mật khẩu!');", true);
    //     }
    //}
    //protected void btnLogout_Click(object sender, EventArgs e)
    //{
    //    if (Request.Cookies["authcoolie"] != null)
    //    {
    //        Response.Cookies["authcoolie"].Expires = DateTime.Now.AddDays(-1);
    //    }
    //    Session["username"] = null;
    //    Response.Redirect("Default.aspx");
    //}

}
