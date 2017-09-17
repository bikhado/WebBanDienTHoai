using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SanPham : System.Web.UI.Page
{
    public int sapxep;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod]
    public static List<ListItem> chungLoai()
    {
        ToolsDT tools = new ToolsDT();
        List<ListItem> items = new List<ListItem>();
        for (int i = 0; i < tools.getChungLoai().Rows.Count; i++)
        {
            items.Add(new ListItem
            {
                Value = tools.getChungLoai().Rows[i]["idCL"].ToString(),
                Text = tools.getChungLoai().Rows[i]["TenCL"].ToString()
            });
        }
        return items;
    }
    [System.Web.Services.WebMethod]
    public static List<ListItem> loaiSP(string idCL)
    {
        ToolsDT tools = new ToolsDT();
        List<ListItem> items = new List<ListItem>();
        for (int i = 0; i < tools.getLoai(idCL).Rows.Count; i++)
        {
            items.Add(new ListItem
            {
                Value = tools.getLoai(idCL).Rows[i]["idLoai"].ToString(),
                Text = tools.getLoai(idCL).Rows[i]["TenLoai"].ToString()
            });
        }
        return items;
    }

    //[System.Web.Services.WebMethod]
    //public static int sapXep(string idSapXep)
    //{
    //    SanPham.sapxep = int.Parse(idSapXep);
    //    return sapxep;
    //}

    protected void ddlSapXep_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        if (Request.QueryString.Get("idSapXep")== null && Request.QueryString.Get("page") == null)
            sapxep = int.Parse(ddlSapXep.SelectedValue);
        else if (Request.QueryString.Get("page") != null)
        {
            string idpage = Request.QueryString.Get("page").ToString();
                Response.Redirect("SanPham.aspx?idSapXep="+int.Parse(ddlSapXep.SelectedValue)+"&&page=" +idpage+ "");
        }
            
    }
}