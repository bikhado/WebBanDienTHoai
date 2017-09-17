using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ProductDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
        
            loadDDL();
            //Response.Write(ddlMauSP.SelectedValue);
            ToolsDT tools = new ToolsDT();
            //lblGiaTien.Text = tools.formatMoney(tools.getSLbyidSP(ddlMauSP.SelectedValue, Request.QueryString.Get("Detailspr").ToString()).Rows[0]["Gia"].ToString(), ".") + " " + "đ";
            if (tools.getSLbyidSP(ddlMauSP.SelectedValue, Request.QueryString.Get("Detailspr").ToString()).Rows[0]["SoLuongTonKho"].ToString() == "0")
            {
                checkSL.Text = "hết hàng";
                btnDatHang.Enabled = false;
                btnDatHang.ForeColor = System.Drawing.Color.DarkGray;
            }
            else {
                checkSL.Text = "còn hàng";
                btnDatHang.Enabled = true;
                btnDatHang.ForeColor = System.Drawing.Color.White;
            } 
            
            
        }
    }
    private void loadDDL()    
    {
            ToolsDT tools = new ToolsDT();
            ddlMauSP.DataSource = tools.getMauByID(Request.QueryString.Get("Detailspr").ToString());
            ddlMauSP.DataTextField = "tenmau";
            ddlMauSP.DataValueField = "mamau";
            ddlMauSP.DataBind();
    }
    protected void ddlMauSP_SelectedIndexChanged(object sender, EventArgs e)
    {
        ToolsDT tools = new ToolsDT();
        if (tools.getSLbyidSP(ddlMauSP.SelectedValue, Request.QueryString.Get("Detailspr").ToString()).Rows[0]["SoLuongTonKho"].ToString() == "0")
        { 
            checkSL.Text = "hết hàng";
            btnDatHang.Enabled = false;
            btnDatHang.ForeColor = System.Drawing.Color.DarkGray;
        }
        else {
            checkSL.Text = "còn hàng";
            btnDatHang.Enabled = true;
            btnDatHang.ForeColor = System.Drawing.Color.White;
        }     
        //lblGiaTien.Text = tools.formatMoney(tools.getSLbyidSP(ddlMauSP.SelectedValue, Request.QueryString.Get("Detailspr").ToString()).Rows[0]["Gia"].ToString(),".") + " " + "đ";
        ddlMauSP.Focus();
    }
    protected void btnDatHang_Click(object sender, EventArgs e)
    {
        ToolsDT tools = new ToolsDT();
        string tenSP = tools.getSanPhamByID(Request.QueryString.Get("Detailspr").ToString()).Rows[0]["tenSP"].ToString();
        if (int.Parse(txtSoLuong.Value) <= int.Parse(tools.getSLbyidSP(ddlMauSP.SelectedValue, Request.QueryString.Get("Detailspr").ToString()).Rows[0]["SoLuongTonKho"].ToString()))
        {
            Carts cart = (Carts)Session["cart"];

            if (cart == null)
            {
                cart = new Carts();
            }
            cart.addToGioHang(new Items(Request.QueryString.Get("Detailspr").ToString(), int.Parse(txtSoLuong.Value), ddlMauSP.SelectedValue));
            Session.Add("cart", cart);       
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Bạn đã thêm sản phẩm  " + tenSP + " số lượng " + txtSoLuong.Value + " vào giỏ hàng !');", true);
            Label lblSoLuong = (Label)Master.FindControl("lblSoLuong");
            Label lblTongTien = (Label)Master.FindControl("lblTongTien");
            Label lblSoLuong1 = (Label)Master.FindControl("lblSoLuong1");
            Label lblTongTien1 = (Label)Master.FindControl("lblTongTien1");
            for (int i = 0; i < cart.vebang().Rows.Count; i++)
            {
                if(Session["username"] != null)
                tools.updateGH(Session["username"].ToString(), cart.vebang().Rows.Count.ToString(), cart.tongTien.ToString(), cart.vebang().Rows[i]["soLuong"].ToString(), cart.vebang().Rows[i]["giaTien"].ToString(), cart.vebang().Rows[i]["thanhTien"].ToString(), cart.vebang().Rows[i]["idSP"].ToString(), cart.vebang().Rows[i]["mamau"].ToString());
            }
                lblSoLuong.Text = cart.vebang().Rows.Count.ToString() + " ";
            lblTongTien.Text = tools.formatMoney(cart.tongTien.ToString(), ".") + "VNĐ";
            lblSoLuong1.Text = cart.vebang().Rows.Count.ToString() + " ";
            lblTongTien1.Text = tools.formatMoney(cart.tongTien.ToString(), ".") + "VNĐ";

            txtSoLuong.Focus();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Sản phẩm  " + tenSP + " không đủ với số lượng bạn chọn. Vui lòng giảm số lượng! hì.!');", true);
            txtSoLuong.Focus();
        }


    }
}