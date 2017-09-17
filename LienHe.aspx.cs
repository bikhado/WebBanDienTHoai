using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LienHe : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    /// <summary>
    /// Liên Hệ
    /// </summary>
    /// <param name="idsp"></param>
    /// <param name="idmau"></param>
    /// <param name="soluong"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static bool khLienHe(string hoten, string email, string tieude, string ykien)
    {
        ToolsDT tools = new ToolsDT();
        SqlCommand cmd = new SqlCommand();
        String sDate = DateTime.Now.ToString("dd-MM-yyyy hh:mm");
        bool check;
        check = tools.lienHe(hoten, email, tieude, ykien,sDate);

        return check;
    }
}