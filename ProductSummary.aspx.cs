using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ProductSummary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["cart"] == null && Session["username"] == null)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Chưa có sản phẩm nào trong giỏ hàng !');", true);
        }
    }

    /// <summary>
    /// Cập nhật lại giỏ hàng
    /// </summary>
    /// <param name="idsp"></param>
    /// <param name="idmau"></param>
    /// <param name="soluong"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static bool soLuong(string idsp, string idmau, string soluong)
    {
        ToolsDT tools = new ToolsDT();
        bool check;
        if (int.Parse(tools.getSLbyidSP(idmau, idsp).Rows[0]["SoLuongTonKho"].ToString()) >= int.Parse(soluong))
        {
            Carts cart = (Carts)HttpContext.Current.Session["cart"];
            if (cart != null) { 
            Items item = new Items();
            item.soLuong = int.Parse(soluong);
            item.idSP = idsp;
            item.idMau = idmau;
            cart.capnhatItem(item);

            //for (int i = 0; i < cart.vebang().Rows.Count; i++)
            //{
            //    if (HttpContext.Current.Session["username"] != null)
            //        tools.updateGH(HttpContext.Current.Session["username"].ToString(), cart.vebang().Rows.Count.ToString(), cart.tongTien.ToString(), cart.vebang().Rows[i]["soLuong"].ToString(), cart.vebang().Rows[i]["giaTien"].ToString(), cart.vebang().Rows[i]["thanhTien"].ToString(), cart.vebang().Rows[i]["idSP"].ToString(), cart.vebang().Rows[i]["mamau"].ToString());
            //}
            if (HttpContext.Current.Session["username"] != null)
                tools.updateSLGH(idsp, idmau, soluong, HttpContext.Current.Session["username"].ToString());
            }
            else
            {
                if (HttpContext.Current.Session["username"] != null)
                    tools.updateSLGH(idsp, idmau, soluong, HttpContext.Current.Session["username"].ToString());
            }
            

            check = true;
        }
            
        else check =false;
        
        return check;
    }

    /// <summary>
    /// Cập nhật lại giỏ hàng
    /// </summary>
    /// <param name="idsp"></param>
    /// <param name="idmau"></param>
    /// <param name="soluong"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static bool deleteSPofGH(string idsp, string idmau, string userName)
    {
        if (HttpContext.Current.Session["username"] != null)
        userName = HttpContext.Current.Session["username"].ToString();
        ToolsDT tools = new ToolsDT();
        tools.xoaSPofGH(idsp,idmau,userName);
        return true;
    }

    /// <summary>
    /// Xóa sản phẩm
    /// </summary>
    /// <param name="idsp"></param>
    /// <param name="idmau"></param>
    /// <param name="soluong"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static bool xoaSanPham(string idsp, string idmau, string soluong)
    {
        ToolsDT tools = new ToolsDT();
        bool check =false;
        if (int.Parse(tools.getSLbyidSP(idmau, idsp).Rows[0]["SoLuongTonKho"].ToString()) >= int.Parse(soluong))
        {
            Carts cart = (Carts)HttpContext.Current.Session["cart"];
            Items item = new Items();
            if (cart != null)
            {
                item.soLuong = int.Parse(soluong);
                item.idSP = idsp;
                item.idMau = idmau;
                cart.capnhatItem(item);
                if (cart.vebang().Rows.Count == 0)
                    HttpContext.Current.Session["cart"] = null;
                check = true;
            }
        }

        else check = false;

        return check;
    }

    /// <summary>
    /// Kiểm tra đăng nhập
    /// </summary>
    /// <param name="idsp"></param>
    /// <param name="idmau"></param>
    /// <param name="soluong"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static bool kiemtraDangNhap(string user, string pass)
    {
        ToolsDT tools = new ToolsDT();
        bool check;
        if (tools.kiemTraDangNhap(user,pass).Rows.Count > 0)
            check = true;
        else check = false;
        return check;
    }

    /// <summary>
    /// Kiểm tra mã code
    /// </summary>
    /// <param name="idsp"></param>
    /// <param name="idmau"></param>
    /// <param name="soluong"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static bool getMaCode(string macode,string idsp, string idmau)
    {
        ToolsDT tools = new ToolsDT();
        bool check;
        if (tools.getMaCode(macode, idsp, idmau).Rows.Count > 0)  
            check = true;    
        else check = false;
        return check;
    }

    /// <summary>
    /// Lấy % giảm giá
    /// </summary>
    /// <param name="idsp"></param>
    /// <param name="idmau"></param>
    /// <param name="soluong"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string getPhanTramGiamGia(string macode, string idsp, string idmau)
    {
        ToolsDT tools = new ToolsDT();
        string phantramgiamgia;
        phantramgiamgia = tools.getMaCode(macode, idsp, idmau).Rows[0]["giamGia"].ToString();
        return phantramgiamgia;
    }

    /// <summary>
    /// Tính ra phí code
    /// </summary>
    /// <param name="idsp"></param>
    /// <param name="idmau"></param>
    /// <param name="soluong"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int tinhPhiCode(string macode, string tongTien, string ship, string idsp, string idmau)
    {
        int tongTienKhiTruCode;
        ToolsDT tools = new ToolsDT();
        if (macode == null)
            tongTienKhiTruCode = int.Parse(tongTien) + int.Parse(ship);
        else
            tongTienKhiTruCode = int.Parse(tongTien) - ((int.Parse(tongTien) * int.Parse(tools.getMaCode(macode, idsp, idmau).Rows[0]["giamGia"].ToString())) / 100) + int.Parse(ship);

        return tongTienKhiTruCode;
    }

    /// <summary>
    /// Tính ra số tiền giảm giá
    /// </summary>
    /// <param name="idsp"></param>
    /// <param name="idmau"></param>
    /// <param name="soluong"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int tinhSoTienGiam(string macode, string tongtien, string idsp, string idmau)
    {
        int sotiengiagia;
        ToolsDT tools = new ToolsDT();
        sotiengiagia = ((int.Parse(tongtien) * int.Parse(tools.getMaCode(macode, idsp, idmau).Rows[0]["giamGia"].ToString())) / 100);

        return sotiengiagia;
    }

    /// <summary>
    /// Kiểm tra số lượng
    /// </summary>
    /// <param name="idsp"></param>
    /// <param name="idmau"></param>
    /// <param name="soluong"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string kiemTraSoLuong()
    {
        string soLuong = "";
        string soluong1 = "";
        ToolsDT tools = new ToolsDT();
        Carts cart = (Carts)HttpContext.Current.Session["cart"];
        if (HttpContext.Current.Session["cart"] != null)
        {
            if (HttpContext.Current.Session["username"] == null)
            {
                for (int i = 0; i < cart.vebang().Rows.Count; i++)
                {
                    if (int.Parse(tools.getSLbyidSP(cart.vebang().Rows[i]["mamau"].ToString(), cart.vebang().Rows[i]["idSP"].ToString()).Rows[0]["SoLuongTonKho"].ToString()) < int.Parse(cart.vebang().Rows[i]["soLuong"].ToString()))
                    {
                        soLuong = soLuong + "'" + tools.getSanPhamByID(cart.vebang().Rows[i]["idSP"].ToString()).Rows[0]["tenSP"].ToString() + "' màu '" + tools.getMauByID(cart.vebang().Rows[i]["idSP"].ToString()).Rows[0]["tenmau"].ToString() + "' số lượng chỉ còn " + tools.getSLbyidSP(cart.vebang().Rows[i]["mamau"].ToString(), cart.vebang().Rows[i]["idSP"].ToString()).Rows[0]["SoLuongTonKho"].ToString() + ";" + " ";
                    }
                }
            }
            else
            {
                for (int e = 0; e < tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows.Count; e++)
                {
                    if (int.Parse(tools.getSLbyidSP(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[e]["idMau"].ToString().ToString(), tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[e]["idSP"].ToString()).Rows[0]["SoLuongTonKho"].ToString()) < int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[e]["SoLuongSP"].ToString()))
                    {
                        soLuong = soLuong + "'" + tools.getSanPhamByID(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[e]["idSP"].ToString().ToString()).Rows[0]["tenSP"].ToString() + "' màu '" + tools.getMauByID(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[e]["idSP"].ToString().ToString()).Rows[0]["tenmau"].ToString() + "' số lượng chỉ còn " + tools.getSLbyidSP(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[e]["idMau"].ToString().ToString(), tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[e]["idSP"].ToString().ToString()).Rows[0]["SoLuongTonKho"].ToString() + ";" + " ";
                    }
                }
            }
        }
        else
        {
            for (int j = 0; j < tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows.Count; j++)
            {
                if (int.Parse(tools.getSLbyidSP(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[j]["idMau"].ToString().ToString(), tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[j]["idSP"].ToString()).Rows[0]["SoLuongTonKho"].ToString()) < int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[j]["SoLuongSP"].ToString()))
                {
                    soLuong = soLuong + "'" + tools.getSanPhamByID(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[j]["idSP"].ToString().ToString()).Rows[0]["tenSP"].ToString() + "' màu '" + tools.getMauByID(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[j]["idSP"].ToString().ToString()).Rows[0]["tenmau"].ToString() + "' số lượng chỉ còn " + tools.getSLbyidSP(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[j]["idMau"].ToString().ToString(), tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[j]["idSP"].ToString().ToString()).Rows[0]["SoLuongTonKho"].ToString() + ";" + " ";
                }
            }
        }
        soluong1 = "Sản phẩm" + " " + soLuong + " " + "không đủ số lượng trong kho, quý khách vui lòng giảm số lượng sản phẩm";

        return soluong1;
    }

    /// <summary>
    /// Đặt hàng
    /// </summary>
    /// <param name="idSP"></param>
    /// <param name="idMau"></param>
    /// <param name="gioiTinh"></param>
    /// <param name="hoTenn"></param>
    /// <param name="soDT"></param>
    /// <param name="Email"></param>
    /// <returns></returns>
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static bool datHang(string username,string email, string tongtien, string idpttt, string idptgh, string loikhachdan, string shipping, string macode, string datratien)
    {
        bool InsertData;
        ToolsDT tools = new ToolsDT();
        Carts cart = (Carts)HttpContext.Current.Session["cart"];
        String sDate = DateTime.Now.ToString("dd-MM-yyyy hh:mm");
        int result = 0;
        int result1 = 0;
        ConnectDatabase con = new ConnectDatabase();
        SqlCommand cmd = new SqlCommand();
        string sql = "declare @idUser int, @tenNguoiNhan nvarchar(100), @dtNguoiNhan nvarchar(255), @dcGiaoHang nvarchar(255),@temp int,@idDH int,@tempDH int begin set @idUser = (select idUser from Users where Username = '" + username + "' or Email = '" + email + "'); set @tenNguoiNhan = (select HoTen from Users where Username = '" + username + "' or Email = '" + email + "'); set @dtNguoiNhan = (select DienThoai from Users where Username = '" + username + "' or Email = '" + email + "'); set @dcGiaoHang = (select DiaChiGiaoHang from Users where Username = '" + username + "' or Email = '" + email + "'); set @idDH = (select top 1 idDH from DonHang where idUser = @idUser order by idDH desc); set @tempDH = (select count(*) from DonHang where idDH = @idDH);if (@tempDH = 0)begin insert into DonHang(idUser,ThoiDiemDatHang,TenNguoiNhan,DTNguoiNhan,DiaChi,TongTien,idPTTT,idPTGH,LoiKhachDan,Shipping,MaCode,DaTraTien,DaXuLy) values(@idUser,'" +sDate+ "',@tenNguoiNhan,@dtNguoiNhan,@dcGiaoHang,'" + int.Parse(tongtien) + "', '" + int.Parse(idpttt) + "' ,'" + int.Parse(idptgh) + "',N'" + loikhachdan + "','" + int.Parse(shipping) + "','" + macode + "','" + int.Parse(datratien) + "',0);end set @temp = (select count(*) from DonHangChiTiet dhct, DonHang dh where dhct.idDH = @idDH); if(@temp > 0)begin insert into DonHang(idUser,ThoiDiemDatHang,TenNguoiNhan,DTNguoiNhan,DiaChi,TongTien,idPTTT,idPTGH,LoiKhachDan,Shipping,MaCode,DaTraTien,DaXuLy) values(@idUser,'" +sDate+ "',@tenNguoiNhan,@dtNguoiNhan,@dcGiaoHang,'" + int.Parse(tongtien) + "', '" + int.Parse(idpttt) + "' ,'" + int.Parse(idptgh) + "',N'" + loikhachdan + "','" + int.Parse(shipping) + "','" + macode + "','" + int.Parse(datratien) + "',0);end else begin update DonHang set ThoiDiemDatHang = '" + sDate + "' where idDH = @idDH end end";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();

        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            result = cmd.ExecuteNonQuery();
            if (result > 0)
            {
                if (cart != null) {
                    if (HttpContext.Current.Session["username"] == null)
                    {
                        for (int e = 0; e < cart.vebang().Rows.Count; e++)
                        {
                            SqlCommand cmd1 = new SqlCommand();
                            string sql1 = "declare @idDH int, @idUser int, @soLuong int,@cartID int begin set @idUser = (select idUser from Users where Username = '" + username + "' or Email = '" + email + "'); set @idDH = (select top 1 idDH from DonHang where idUser = @idUser order by idDH desc); set @soLuong = (select SoLuongTonKho from SanPham_Mau_ChiTiet where idSP = '" + int.Parse(cart.vebang().Rows[e]["idSP"].ToString()) + "' and idMau = '" + int.Parse(cart.vebang().Rows[e]["mamau"].ToString()) + "'); if(@soLuong >= '" + int.Parse(cart.vebang().Rows[e]["soLuong"].ToString()) + "')begin insert into DonHangChiTiet(idDH,idSP,idMau,SoLuong) values(@idDH, '" + int.Parse(cart.vebang().Rows[e]["idSP"].ToString()) + "', '" + int.Parse(cart.vebang().Rows[e]["mamau"].ToString()) + "', '" + int.Parse(cart.vebang().Rows[e]["soLuong"].ToString()) + "' ); set @cartID = (select CartID from ShoppingCarts where idUser = @idUser); end end ";
                            cmd1.CommandText = sql1;
                            cmd1.Connection = conn;
                            result1 = cmd1.ExecuteNonQuery();
                        }
                    }
                    else
                    {
                        if (tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows.Count > 0 && tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows.Count >0)
                        {
                        for (int j = 0; j < tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows.Count; j++)
                        {
                            SqlCommand cmd1 = new SqlCommand();
                            string sql1 = "declare @idDH int, @idUser int, @soLuong int,@cartID int begin set @idUser = (select idUser from Users where Username = '" + HttpContext.Current.Session["username"].ToString() + "' or Email = '" + HttpContext.Current.Session["username"].ToString() + "'); set @idDH = (select top 1 idDH from DonHang where idUser = @idUser order by idDH desc); set @soLuong = (select SoLuongTonKho from SanPham_Mau_ChiTiet where idSP = '" + int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[j]["idSP"].ToString()) + "' and idMau = '" + int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[j]["idMau"].ToString()) + "'); if(@soLuong >= '" + int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[j]["SoLuongSP"].ToString()) + "')begin insert into DonHangChiTiet(idDH,idSP,idMau,SoLuong) values(@idDH, '" + int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[j]["idSP"].ToString()) + "', '" + int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[j]["idMau"].ToString()) + "', '" + int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[j]["SoLuongSP"].ToString()) + "' ); set @cartID = (select CartID from ShoppingCarts where idUser = @idUser);  end end ";
                            cmd1.CommandText = sql1;
                            cmd1.Connection = conn;
                            result1 = cmd1.ExecuteNonQuery();
                        }
                        }
                    }
                }
                else
                {
                    if (HttpContext.Current.Session["username"] != null && tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows.Count > 0)
                    {
                        for (int ie = 0; ie < tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows.Count; ie++)
                        {
                            SqlCommand cmd1 = new SqlCommand();
                            string sql1 = "declare @idDH int, @idUser int, @soLuong int,@cartID int begin set @idUser = (select idUser from Users where Username = '" + HttpContext.Current.Session["username"].ToString() + "' or Email = '" + HttpContext.Current.Session["username"].ToString() + "'); set @idDH = (select top 1 idDH from DonHang where idUser = @idUser order by idDH desc); set @soLuong = (select SoLuongTonKho from SanPham_Mau_ChiTiet where idSP = '" + int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ie]["idSP"].ToString()) + "' and idMau = '" + int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ie]["idMau"].ToString()) + "'); if(@soLuong >= '" + int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ie]["SoLuongSP"].ToString()) + "')begin insert into DonHangChiTiet(idDH,idSP,idMau,SoLuong) values(@idDH, '" + int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ie]["idSP"].ToString()) + "', '" + int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ie]["idMau"].ToString()) + "', '" + int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[ie]["SoLuongSP"].ToString()) + "' ); set @cartID = (select CartID from ShoppingCarts where idUser = @idUser); end end ";
                            cmd1.CommandText = sql1;
                            cmd1.Connection = conn;
                            result1 = cmd1.ExecuteNonQuery();
                        }
                    }
                }
            }
        }
        finally
        {
            conn.Close();
        }

        if (result1 > 0)
        {
            if (cart != null) {
                if (HttpContext.Current.Session["username"] == null)
                {
                    for (int i = 0; i < cart.vebang().Rows.Count; i++)
                    {
                        tools.updateSLTonKho(cart.vebang().Rows[i]["idSP"].ToString(), cart.vebang().Rows[i]["mamau"].ToString(), int.Parse(cart.vebang().Rows[i]["soLuong"].ToString()));
                        tools.updateSLMua(cart.vebang().Rows[i]["idSP"].ToString());
                        
                    }
                }
                else
                {
                    for (int inn = 0; inn < tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows.Count; inn++)
                    {
                        tools.updateSLTonKho(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[inn]["idSP"].ToString(), tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[inn]["idMau"].ToString(), int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[inn]["SoLuongSP"].ToString()));
                        tools.updateSLMua(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[inn]["idSP"].ToString());
                        
                    }
                }
            }
            else
            {

                for (int innn = 0; innn < tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows.Count; innn++)
                {
                    tools.updateSLTonKho(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[innn]["idSP"].ToString(), tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[innn]["idMau"].ToString(), int.Parse(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[innn]["SoLuongSP"].ToString()));
                    tools.updateSLMua(tools.getChiTietGH(tools.getGioHang(HttpContext.Current.Session["username"].ToString()).Rows[0]["CartID"].ToString()).Rows[innn]["idSP"].ToString());
               
                }
            }
            tools.xoaGH(HttpContext.Current.Session["username"].ToString());
            HttpContext.Current.Session["cart"] = null;
            InsertData = true;
        }
        else InsertData = false;

        return InsertData;

    }

    /// <summary>
    /// get phương thức thanh toán
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static List<ListItem> getPTTT()
    {
        ToolsDT tools = new ToolsDT();
        List<ListItem> items = new List<ListItem>();
        for (int i = 0; i < tools.getPTGH().Rows.Count; i++)
        {
            items.Add(new ListItem
            {
                Value = tools.getPTGH().Rows[i]["idPTGH"].ToString(),
                Text = tools.getPTGH().Rows[i]["TenPhuongThucGH"].ToString()
            });
        }
        return items;
    }
}