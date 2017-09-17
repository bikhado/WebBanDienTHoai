using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod]
    public static List<ListItem> getTinhThanhPho()
    {
        ToolsDT tools = new ToolsDT();
        List<ListItem> items = new List<ListItem>();
        for (int i = 0; i < tools.getTinhThanhPho().Rows.Count; i++)
        {
            items.Add(new ListItem
            {
                Value = tools.getTinhThanhPho().Rows[i]["provinceid"].ToString(),
                Text = tools.getTinhThanhPho().Rows[i]["name"].ToString()
            });
        }
        return items;
    }

    [System.Web.Services.WebMethod]
    public static List<ListItem> getQuanHuyen(string provinceid)
    {
        ToolsDT tools = new ToolsDT();
        List<ListItem> items = new List<ListItem>();
        for (int i = 0; i < tools.getQuanHuyen(provinceid).Rows.Count; i++)
        {
            items.Add(new ListItem
            {
                Value = tools.getQuanHuyen(provinceid).Rows[i]["districtid"].ToString(),
                Text = tools.getQuanHuyen(provinceid).Rows[i]["name"].ToString()
            });
        }
        return items;
    }

    [System.Web.Services.WebMethod]
    public static List<ListItem> getPhuongXa(string districtid)
    {
        ToolsDT tools = new ToolsDT();
        List<ListItem> items = new List<ListItem>();
        for (int i = 0; i < tools.getPhuongXa(districtid).Rows.Count; i++)
        {
            items.Add(new ListItem
            {
                Value = tools.getPhuongXa(districtid).Rows[i]["wardid"].ToString(),
                Text = tools.getPhuongXa(districtid).Rows[i]["name"].ToString()
            });
        }
        return items;
    }
    [System.Web.Services.WebMethod]
    public static bool checkUsername(string username)
    {
        ToolsDT tools = new ToolsDT();
        if (tools.checkUsername(username).Rows.Count > 0)
            return true;
        else return false;
    }

    [System.Web.Services.WebMethod]
    public static bool checkEmail(string email)
    {
        ToolsDT tools = new ToolsDT();
        if (tools.checkEmail(email).Rows.Count > 0)
            return true;
        else return false;
    }
    [System.Web.Services.WebMethod]
    public static bool dangKyThanhVien(string hoten, string username, string password, string diachi, string gioitinh, string dienthoai, string email, string ngaydangky, string tinh, string quan, string huyen)
    {
        ToolsDT tools = new ToolsDT();
        if (tools.dangKyThanhVien(hoten, username, password, diachi, gioitinh, dienthoai, email, ngaydangky, tinh, quan,huyen) > 0){
            HttpContext.Current.Session["username"] = username;
            return true;
        }           
        else return false;
    }
}