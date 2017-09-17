using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnDatHang_Click1(object sender, EventArgs e)
    {
        ToolsDT tools = new ToolsDT();
        //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Sản phẩm  " + + "');", true);

    }
    [System.Web.Services.WebMethod]
    public static string tenSP(string idsp)
    {
        string tenSP;
        ToolsDT tools = new ToolsDT();
        tenSP = tools.getSanPhamByID(idsp).Rows[0]["tenSP"].ToString();
        return tenSP;
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static bool checkAdmin()
    {
        bool check = false;
        ToolsDT tools = new ToolsDT();
        if (HttpContext.Current.Session["username"] != null)
        {
            if (int.Parse(tools.checkUsername(HttpContext.Current.Session["username"].ToString()).Rows[0]["idGroup"].ToString()) == 0 || int.Parse(tools.checkUsername(HttpContext.Current.Session["username"].ToString()).Rows[0]["idGroup"].ToString()) == 1)
                check = true;
            else check = false;
        }
        return check;
    }

    /// <summary>
    /// cập nhật giỏ hàng
    /// </summary>
    /// <param name="idsp"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static bool capNhatGH()
    {
        bool check;
        ToolsDT tools = new ToolsDT();
        Carts cart = (Carts)HttpContext.Current.Session["cart"];
        if (cart != null) { 
        for (int i = 0; i < cart.vebang().Rows.Count; i++)
        {
            if (HttpContext.Current.Session["username"] != null)
                tools.updateGH(HttpContext.Current.Session["username"].ToString(), cart.vebang().Rows.Count.ToString(), cart.tongTien.ToString(), cart.vebang().Rows[i]["soLuong"].ToString(), cart.vebang().Rows[i]["giaTien"].ToString(), cart.vebang().Rows[i]["thanhTien"].ToString(), cart.vebang().Rows[i]["idSP"].ToString(), cart.vebang().Rows[i]["mamau"].ToString());
            //if (HttpContext.Current.Session["username"] != null)
            //    tools.updateSLGH(idsp, idmau, soluong, HttpContext.Current.Session["username"].ToString());
        }

        }

        check = true;
        return check;

    }
    [System.Web.Services.WebMethod]
    public static string hinhAnh(string idsp)
    {
        string urlHinh;
        ToolsDT tools = new ToolsDT();
        urlHinh = tools.getSanPhamByID(idsp).Rows[0]["urlHinh"].ToString();
        return urlHinh;
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string userName()
    {

        ToolsDT tools = new ToolsDT();
        string tenuser = "";
        if (HttpContext.Current.Session["username"] != null)
            tenuser = tools.layThongTinUser(HttpContext.Current.Session["username"].ToString()).Rows[0]["UserName"].ToString();
        else tenuser = "";

        return tenuser;
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string passWord()
    {

        ToolsDT tools = new ToolsDT();
        string password = "";
        if (HttpContext.Current.Session["username"] != null)
            password = tools.layThongTinUser(HttpContext.Current.Session["username"].ToString()).Rows[0]["Password"].ToString();
        else password = "";

        return password;
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string email()
    {

        ToolsDT tools = new ToolsDT();
        string email = "";
        if (HttpContext.Current.Session["username"] != null)
            email = tools.layThongTinUser(HttpContext.Current.Session["username"].ToString()).Rows[0]["Email"].ToString();
        else email = "";

        return email;
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string diaChiGiaoHang()
    {
        
        ToolsDT tools = new ToolsDT();
        string diaChiGiaoHang = "";
        if (HttpContext.Current.Session["username"] != null)
            diaChiGiaoHang = tools.layThongTinUser(HttpContext.Current.Session["username"].ToString()).Rows[0]["DiaChiGiaoHang"].ToString();
        else diaChiGiaoHang = "";

        return diaChiGiaoHang;
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static bool updateMatKhau(string pass, string passcu)
    {
        
        ToolsDT tools = new ToolsDT();
        int result = 0;
        bool check = false;
        if (HttpContext.Current.Session["username"] != null)
        {
            result = tools.updatePassword(HttpContext.Current.Session["username"].ToString(), pass, tools.EnCrypt(passcu,"bikha"));
        }        
        if (result > 0) 
            return check = true;
        else check = false;

        return check;
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static bool updateEmail(string email)
    {

        ToolsDT tools = new ToolsDT();
        int result = 0;
        bool check = false;
        if (HttpContext.Current.Session["username"] != null)
        {
            result = tools.updatEmail(HttpContext.Current.Session["username"].ToString(), email);
        }
        if (result > 0)
            return check = true;
        else check = false;

        return check;
    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string SoDienThoai()
    {
        ToolsDT tools = new ToolsDT();
        string SoDienThoai = "";
        if (HttpContext.Current.Session["username"] != null)
            SoDienThoai = tools.layThongTinUser(HttpContext.Current.Session["username"].ToString()).Rows[0]["DienThoai"].ToString();
        else SoDienThoai = "";

        return SoDienThoai;
    }
    [System.Web.Services.WebMethod]
    public static List<ListItem> mauSP(string idsp)
    {
        ToolsDT tools = new ToolsDT();
        List<ListItem> items = new List<ListItem>();
        for (int i = 0; i < tools.getMauByID(idsp).Rows.Count; i++)
        {
            items.Add(new ListItem
            {
                Value = tools.getMauByID(idsp).Rows[i]["mamau"].ToString(),
                Text = tools.getMauByID(idsp).Rows[i]["tenmau"].ToString()
            });
        }
        return items;
    }

    [System.Web.Services.WebMethod]
    public static List<ListItem> PTTT()
    {
        ToolsDT tools = new ToolsDT();
        List<ListItem> items = new List<ListItem>();
        for (int i = 0; i < tools.getPTTTT().Rows.Count; i++)
        {
            items.Add(new ListItem
            {
                Value = tools.getPTTTT().Rows[i]["idPTTT"].ToString(),
                Text = tools.getPTTTT().Rows[i]["TenPhuongThucTT"].ToString()
            });
        }
        return items;
    }
    [System.Web.Services.WebMethod]
    public static string giaTienSP(string idsp, string idmau)
    {
        string giaTien = "";
        ToolsDT tools = new ToolsDT();
        if(tools.getSLbyidSP(idmau,idsp).Rows.Count > 0)
            giaTien = tools.formatMoney(tools.getSLbyidSP(idmau, idsp).Rows[0]["Gia"].ToString(),".");
        
        return giaTien;
    }
    [System.Web.Services.WebMethod]
    public static bool themDatNgayTuVan(string idSP, string idMau, string gioiTinh, string hoTenn, string soDT, string Email)
    {
        bool InsertData;
        ToolsDT tools = new ToolsDT();
        String sDate = DateTime.Now.ToString("dd-MM-yyyy hh:mm");
        int result = 0;
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "insert into TuVan_DatNgay(idSP,idMau,Sex,HoTen,SDT,Email,Ngay) values('" + int.Parse(idSP) + "','" + int.Parse(idMau) + "','" + int.Parse(gioiTinh) + "', '" + hoTenn + "', '" + soDT + "', '" + Email + "', '" + sDate + "')";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();

        try
        {
            if ((int.Parse(tools.getSLbyidSP(idMau, idSP).Rows[0]["SoLuongTonKho"].ToString()) - 1) > 0)
            {
                conn.Open();
                cmd.CommandText = sql;
                cmd.Connection = conn;              
                result = cmd.ExecuteNonQuery();
            }          
        }
        finally
        {
            conn.Close();
        }

        if (result > 0){
            tools.updateSLTonKho(idSP, idMau, 1);
            tools.updateSLMua(idSP);
            InsertData = true;
        }          
        else InsertData = false;

        return InsertData;

    }

    /// <summary>
    /// check login
    /// </summary>
    /// <param name="idsp"></param>
    /// <param name="idmau"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static bool kiemTraDangNhap(string username, string password, string checkremember)
    {
        bool check = false;
        ToolsDT tools = new ToolsDT();
        if (HttpContext.Current != null)
        {

            if (tools.checkLogin(username, tools.EnCrypt(password, "bikha")).Rows.Count > 0)
            {
                if (checkremember == "true")
                {
                    HttpContext.Current.Response.Cookies["authcoolie"]["UserName"] = username;
                    HttpContext.Current.Response.Cookies["authcoolie"]["Password"] = password;
                    HttpContext.Current.Response.Cookies["authcoolie"].Expires = DateTime.Now.AddDays(+30);
                }
                else
                {
                    HttpContext.Current.Response.Cookies["authcoolie"].Expires = DateTime.Now.AddDays(-1);
                }
                HttpContext.Current.Session["username"] = username;
                check = true;
            }
            else
            {
                check = false;
            }
        }
        return check;
    }

    /// <summary>
    /// Logout
    /// </summary>
    /// <param name="idsp"></param>
    /// <param name="idmau"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static bool logout()
    {
        bool check;
        if (HttpContext.Current.Request.Cookies["authcoolie"] != null)
        {
            HttpContext.Current.Response.Cookies["authcoolie"].Expires = DateTime.Now.AddDays(-1);
        }
        HttpContext.Current.Session["username"] = null;
        check = true;
        return check;
    }

    [System.Web.Services.WebMethod]
    public static string ulli(string tensp)
    {
        ToolsDT tools = new ToolsDT();
        string li = "";

        for (int i = 0; i < tools.timKiemSP(tensp).Rows.Count; i++)
        {
            li = li + "<li><a href='ProductDetails.aspx?Detailspr=" + tools.timKiemSP(tensp).Rows[i]["idSP"].ToString() + "'><img src='" + tools.timKiemSP(tensp).Rows[i]["urlHinh"].ToString() + "' /><h3>" + tools.timKiemSP(tensp).Rows[i]["tenSP"].ToString() + "</h3><span class='price'>" + tools.timKiemSP(tensp).Rows[i]["GiaHienTai"].ToString() + "</span></a></li>";
        }

        return li;
    }
}