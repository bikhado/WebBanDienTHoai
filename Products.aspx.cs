using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Products : System.Web.UI.Page
{
    public int idsp;
    public int sapxep;
    public int tinhtrang;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ToolsDT tools = new ToolsDT();
            lblTenSanPham.Text = tools.getTenNSX(Request.QueryString.Get("idNSX").ToString()) + " " + tools.getTinhTrangSanPhamByidTT(Request.QueryString.Get("idTT").ToString()).Rows[0]["TinhTrang"].ToString();                         
        }  
        idsp = int.Parse(Request.QueryString.Get("idNSX").ToString());
        tinhtrang = int.Parse(Request.QueryString.Get("idTT").ToString());
        
    }
    protected void ddlSapXep_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Request.QueryString.Get("idSapXep") == null && Request.QueryString.Get("page") == null)
            sapxep = int.Parse(ddlSapXep.SelectedValue);
        else if (Request.QueryString.Get("page") != null)
        {
            string idpage = Request.QueryString.Get("page").ToString();
            Response.Redirect("Products.aspx?idSapXep=" + int.Parse(ddlSapXep.SelectedValue) + "&&idNSX=" + Request.QueryString.Get("idNSX").ToString() + "&&idTT=" + Request.QueryString.Get("idTT") + "&&page=" + idpage + "");
        }
        
    }
}