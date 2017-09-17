using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SanPhamKhuyenMai : System.Web.UI.Page
{
    public int sapxep;
    public int tinhtrang;
    public int idsp;
    protected void Page_Load(object sender, EventArgs e)
    {
        idsp = int.Parse(Request.QueryString.Get("idMaCode").ToString());
        tinhtrang = int.Parse(Request.QueryString.Get("idTT").ToString());
    }
    protected void ddlSapXep_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Request.QueryString.Get("idSapXep") == null && Request.QueryString.Get("page") == null)
            sapxep = int.Parse(ddlSapXep.SelectedValue);
        else if (Request.QueryString.Get("page") != null)
        {
            string idpage = Request.QueryString.Get("page").ToString();
            Response.Redirect("SanPhamKhuyenMai.aspx?idSapXep=" + int.Parse(ddlSapXep.SelectedValue) + "&&idMaCode=" + Request.QueryString.Get("idMaCode").ToString() + "&&idTT=" + Request.QueryString.Get("idTT") + "&&page=" + idpage + "");
        }
    }
}