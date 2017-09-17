using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for ToolsDT
/// </summary>
public class ToolsDT
{
	public ToolsDT()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// Lấy ra Tên nhà sản xuất
    /// </summary>
    public string getTenNSX(string idNSX)
    {
        string tenNSX;
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from NhaSanXuat where idNSX = '" + idNSX + "'";
        conn = con.getConnection();
        try
        {           
            
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            tenNSX = dt.Rows[0]["TenNhaSanXuat"].ToString();
        }
        finally
        {
            conn.Close();
        }
        
        return tenNSX;
    }


    /// <summary>
    /// xóa sản phẩm trong giỏ hàng
    /// </summary>
    /// <summary>
    /// update số lượng giỏ hàng
    /// </summary>
    /// <param name="idSP"></param>
    /// <param name="idMau"></param>
    /// <param name="soLuong"></param>
    /// <returns></returns>
    public SqlCommand xoaSPofGH(string idsp, string idmau, string userName)
    {
        string ngayOrder = DateTime.Now.ToString("dd-MM-yyyy hh:mm");
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "declare @idUser int, @cartID int,@userName nvarchar(50),@tongTien int,@soLuong int begin set @userName = '" + userName + "' if(@userName != '') begin set @idUser = (select us.idUser from Users us where us.Username = @userName or us.Email = @userName); set @cartID = (select sc.CartID from ShoppingCarts sc where sc.idUser = @idUser); delete from CartDetails where idSP = '" + idsp + "' and idMau = '" + idmau + "' set @tongTien = (select sum(ThanhTien) from CartDetails where CartID = @cartID); update ShoppingCarts set TongTien = @tongTien where CartID = @cartID set @soLuong = (select count(*) from CartDetails where CartID = @cartID); update ShoppingCarts set SoLuong = @soLuong where CartID = @cartID;  end end";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();

        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
        }
        finally
        {
            conn.Close();
        }
        return cmd;
    }

    /// update số lượng giỏ hàng
    /// </summary>
    /// <param name="idSP"></param>
    /// <param name="idMau"></param>
    /// <param name="soLuong"></param>
    /// <returns></returns>
    public int goiLaiMatKhau(string email, string password)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        int temp;
        SqlCommand cmd = new SqlCommand();
        string sql = "declare @temp int begin set @temp = (select count(*) from Users where Email = '" + email + "'); if(@temp > 0) begin update Users set Users.Password = '" + password + "'  where Email = '" + email + "' end end";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();

        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            temp = cmd.ExecuteNonQuery();
        }
        finally
        {
            conn.Close();
        }
        return temp;
    }

    /// đăng ký thành viên
    /// </summary>
    /// <param name="idSP"></param>
    /// <param name="idMau"></param>
    /// <param name="soLuong"></param>
    /// <returns></returns>
    public int dangKyThanhVien(string hoten, string username, string password, string diachi, string gioitinh, string dienthoai, string email, string ngaydangky, string tinh, string quan, string huyen)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        int temp;
        SqlCommand cmd = new SqlCommand();
        string sql = "declare @username nvarchar(50), @email nvarchar(255), @temp1 int, @temp2 int begin set @username = '" + username + "'; set @email = '" + email + "'; set @temp1 = (select count(*) from Users where Username = @username); set @temp2 = (select count(*) from Users where Email = @email); if(@temp1 = 0 and @temp2 = 0) begin insert into Users values(N'" + hoten + "','" + username + "','" + EnCrypt(password,"bikha") + "',N'" + diachi + "','" + gioitinh + "','" + dienthoai + "','" + email + "','" + ngaydangky + "',3,'" + tinh + "','" + quan + "','" + huyen + "') end end";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();

        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            temp = cmd.ExecuteNonQuery();
        }
        finally
        {
            conn.Close();
        }
        return temp;
    }

    public string EnCrypt(string strEnCrypt, string key)
    {
        try
        {
            byte[] keyArr;
            byte[] EnCryptArr = UTF8Encoding.UTF8.GetBytes(strEnCrypt);
            MD5CryptoServiceProvider MD5Hash = new MD5CryptoServiceProvider();
            keyArr = MD5Hash.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
            TripleDESCryptoServiceProvider tripDes = new TripleDESCryptoServiceProvider();
            tripDes.Key = keyArr;
            tripDes.Mode = CipherMode.ECB;
            tripDes.Padding = PaddingMode.PKCS7;
            ICryptoTransform transform = tripDes.CreateEncryptor();
            byte[] arrResult = transform.TransformFinalBlock(EnCryptArr, 0, EnCryptArr.Length);
            return Convert.ToBase64String(arrResult, 0, arrResult.Length);
        }
        catch (Exception ex) { }
        return "";
    }

    public string DeCrypt(string strDecypt, string key)
    {
        try
        {
            byte[] keyArr;
            byte[] DeCryptArr = Convert.FromBase64String(strDecypt);
            MD5CryptoServiceProvider MD5Hash = new MD5CryptoServiceProvider();
            keyArr = MD5Hash.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
            TripleDESCryptoServiceProvider tripDes = new TripleDESCryptoServiceProvider();
            tripDes.Key = keyArr;
            tripDes.Mode = CipherMode.ECB;
            tripDes.Padding = PaddingMode.PKCS7;
            ICryptoTransform transform = tripDes.CreateDecryptor();
            byte[] arrResult = transform.TransformFinalBlock(DeCryptArr, 0, DeCryptArr.Length);
            return UTF8Encoding.UTF8.GetString(arrResult);
        }
        catch (Exception ex) { }
        return "";
    }

    /// update mật khẩu
    /// </summary>
    /// <param name="idSP"></param>
    /// <param name="idMau"></param>
    /// <param name="soLuong"></param>
    /// <returns></returns>
    public int updatePassword(string username, string pass, string passcu)
    {
        int result;
        string ngayOrder = DateTime.Now.ToString("dd-MM-yyyy hh:mm");
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "declare @passWord nvarchar(50) begin set @passWord = (select us.Password from Users us where Username = '" + username + "' or Email = '" + username + "') if(@passWord = '" + passcu + "') begin update Users set Users.Password = '" + EnCrypt(pass,"bikha") + "' where Users.Username = '" + username + "' end  end";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();

        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            result = cmd.ExecuteNonQuery();
        }
        finally
        {
            conn.Close();
        }
        return result;
    }
    /// update Email
    /// </summary>
    /// <param name="idSP"></param>
    /// <param name="idMau"></param>
    /// <param name="soLuong"></param>
    /// <returns></returns>
    public int updatEmail(string username, string email)
    {
        int result;
        string ngayOrder = DateTime.Now.ToString("dd-MM-yyyy hh:mm");
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "declare @temp int begin set @temp = (select count(*) from Users where Email = '" + email + "'); if(@temp = 0) begin Update Users set Email = '" + email + "' where Username = '" + username + "' end end";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();

        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            result = cmd.ExecuteNonQuery();
        }
        finally
        {
            conn.Close();
        }
        return result;
    }
    /// <summary>
    /// Lấy ra Nhà sản Xuất
    /// </summary>
    public DataTable getNSX(string idNSX)
    {
        string tenNSX;
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from NhaSanXuat where idNSX = '" + idNSX + "'";
        conn = con.getConnection();
        try
        {

            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            tenNSX = dt.Rows[0]["TenNhaSanXuat"].ToString();
        }
        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// <summary>
    /// chheck username
    /// </summary>
    public DataTable checkUsername(string username)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from Users where Username = '" +username+ "' ";
        conn = con.getConnection();
        try
        {

            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// <summary>
    /// chheck username
    /// </summary>
    public DataTable checkEmail(string email)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from Users where Email = '" + email + "' ";
        conn = con.getConnection();
        try
        {

            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;
    }
    /// <summary>
    /// Lấy ra số lượng nhà sản xuất
    /// </summary>
    /// <returns></returns>
    public DataTable getSoLuongNSX()
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from NhaSanXuat";
        conn = con.getConnection();
        try
        {
            
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }
        
        return dt;
    }

    /// <summary>
    /// Lấy ra 6 sản phẩm mới nhất
    /// </summary>
    /// <returns></returns>
    public DataTable getSanPham(){
       
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        string sql = "SELECT top 6 * FROM SanPhamDT where AnHien = 1 ORDER BY idSP desc";
        conn = con.getConnection();
        try
        {
            
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }
               
        return dt;

    }

    /// <summary>
    /// Tìm kiếm theo tên sản phẩm
    /// </summary>
    /// <returns></returns>
    public DataTable timKiemSP(string tensp)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        string sql = "SELECT Top 6 * FROM SanPhamDT where UPPER(tenSP) like UPPER('%"+tensp+"%') and AnHien = 1 order by SoLanMua desc";
        conn = con.getConnection();
        try
        {

            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;

    }

    /// <summary>
    /// Lấy hình của từng sản phẩm
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getHinhBySanPham(string idSP)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        string sql = "SELECT * FROM SanPham_Hinh where idSP='" + idSP + "'";
        conn = con.getConnection();
        try
        {
            
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }

        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// <summary>
    /// Lấy sản phẩm ByID
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getSanPhamByID(string idSP)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        string sql = "SELECT * FROM SanPhamDT where idSP = '" + int.Parse(idSP) + "' and AnHien = 1";
        conn = con.getConnection();
        try
        {          
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }
        
        

        return dt;

    }

    /// <summary>
    /// format định dạng tiền việt nam
    /// </summary>
    /// <param name="money"></param>
    /// <param name="strFormart"></param>
    /// <returns></returns>
    public string formatMoney(string money, string strFormart)
    {

        StringBuilder strB = new StringBuilder(money);
        int j = 0;
        string str = "";
            for (int i = strB.Length - 1; i > 0; i--)
            {
                j++;
                if (j % 3 == 0)
                {
                    strB.Insert(i, strFormart);
                    j = 0;
                }
            }

            str = strB.ToString();
            return str;
    }

    /// <summary>
    /// Lấy thuộc tính sản phẩm ByID
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getTTSPByID(string idSP)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from SanPham_ThuocTinh where idSP= '" + idSP + "'";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }
        
        return dt;
    }

    /// <summary>
    /// Lấy thuộc tính tóm tắt sản phẩm ByID
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getTTSPTTByID(string idSP)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from SanPham_ThuocTinh_TomTat where idSP= '" + idSP + "'";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// <summary>
    /// Lấy ra màu của từng sản phẩm
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getMauByID(string idSP)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select spm.TenMau as tenmau,spm.idMau as mamau from SanPham_Mau spm where spm.idMau in ( select spbg.idMau from SanPham_Mau_ChiTiet spbg where spbg.idSP = '" + int.Parse(idSP) + "')";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }
        
        return dt;

    }

    /// <summary>
    /// Lấy ra màu của từng sản phẩm the mã code
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getMauByID1(string idSP)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select spm.TenMau as tenmau,spm.idMau as mamau from SanPham_Mau spm where spm.idMau in ( select spbg.idMau from SanPham_Mau_ChiTiet spbg where spbg.idSP = '" + idSP + "') and spm.idMau in ( select ctc.idMau from ChiTiet_Code ctc where ctc.idSP = '" + idSP + "')";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;

    }

    /// <summary>
    /// Lấy ra màu của từng sản phẩm the mã code
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getMauByIdMau(string idMau)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from SanPham_Mau where idMau = '" +int.Parse(idMau)+ "'";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;

    }

    /// <summary>
    /// Lấy ra phương thức thanh toán
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getPTTTT()
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from PhuongThucThanhToan";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;

    }

    /// <summary>
    /// Lấy ra số lượng của từng sản phẩm thuộc màu khác nhau
    /// </summary>
    /// <param name="idMau"></param>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getSLbyidSP(string idMau, string idSP)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();    
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            if (idMau != null && idSP != null) {
                string sql = "select * from SanPham_Mau_ChiTiet where idMau = '" + int.Parse(idMau) + "' and idSP = '" + int.Parse(idSP) + "'";
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            }
        }
        finally
        {
            conn.Close();
        }
        
        return dt;

    }

    public SqlCommand themDatNgayTuVan(string idSP, string idMau, string sex, string hoTen, string soDT, string Email)
    {
        String sDate = DateTime.Now.ToString("dd-MM-yyyy hh:mm");
       
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "insert into TuVan_DatNgay values('" + int.Parse(idSP) + "','" + int.Parse(idMau) + "','" + int.Parse(sex) + "','" + hoTen + "','" + soDT + "','" + Email + "','" + sDate + "')";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();

        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
        }
        finally
        {
            conn.Close();
        }
        return cmd;
    }

    /// <summary>
    /// update số lượng tồn kho
    /// </summary>
    /// <param name="idSP"></param>
    /// <param name="idMau"></param>
    /// <param name="soLuong"></param>
    /// <returns></returns>
    public SqlCommand updateSLTonKho(string idSP, string idMau, int soLuong)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "declare @slTonKho int begin update SanPham_Mau_ChiTiet set SoLuongTonKho = SoLuongTonKho - '" + soLuong + "'  where idMau = '" + idMau + "' and idSP = '" + idSP + "' set @slTonKho = (select sum(spct.SoLuongTonKho) from SanPham_Mau_ChiTiet spct where spct.idSP = '" + idSP + "') update SanPhamDT set SoLuongTonKho = @slTonKho where idSP = '" + idSP + "' end";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();

        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
        }
        finally
        {
            conn.Close();
        }
        return cmd;
    }

    /// <summary>
    /// xóa giỏ hàng
    /// </summary>
    /// <param name="idSP"></param>
    /// <param name="idMau"></param>
    /// <param name="soLuong"></param>
    /// <returns></returns>
    public SqlCommand xoaGH(string username)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "declare @idUser int, @cartID int begin if('" + username + "' != '')begin set @idUser = (select idUser from Users where Username = '" + username + "' or Email = '" + username + "');  set @cartID = (select CartID from ShoppingCarts where idUser = @idUser); delete from CartDetails where CartID = @cartID; delete from ShoppingCarts where CartID = @cartID; end end";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();

        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
        }
        finally
        {
            conn.Close();
        }
        return cmd;
    }

    /// <summary>
    /// update giỏ hàng
    /// </summary>
    /// <param name="idSP"></param>
    /// <param name="idMau"></param>
    /// <param name="soLuong"></param>
    /// <returns></returns>
    public SqlCommand updateGH(string userName, string soLuongChung,string tongTien, string soLuongSP, string giaTien, string thanhTien, string idSP, string idMau)
    {
        string ngayOrder = DateTime.Now.ToString("dd-MM-yyyy hh:mm");
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "declare @idUser int, @temp int, @cartID int, @giaTien int, @userName nvarchar(50),@temp1 int, @tongTien int,@soLuongChung int begin set @userName = '" + userName + "' if(@userName != '') begin set @idUser = (select us.idUser from Users us where us.Username = @userName or us.Email = @userName); set @temp = (select count(*) from ShoppingCarts sc where sc.idUser = @idUser); if(@temp > 0) begin set @cartID = (select sc.CartID from ShoppingCarts sc where sc.idUser = @idUser); update ShoppingCarts set NgayOrder = '" + ngayOrder + "' where CartID = @cartID set @temp1 = (select count(*) from CartDetails where CartID = @cartID and idSP = '" + idSP + "' and idMau = '" + idMau + "'); if(@temp1 > 0) begin update CartDetails set SoLuongSP = '" + int.Parse(soLuongSP) + "', GiaTien = '" + int.Parse(giaTien) + "', ThanhTien = '" + int.Parse(thanhTien) + "' where CartID = @cartID and idSP = '" + int.Parse(idSP) + "' and idMau = '" + int.Parse(idMau) + "' set @tongTien = (select sum(ThanhTien) from CartDetails where CartID = @cartID); set @soLuongChung = (select count(*) from CartDetails where CartID = @cartID); update ShoppingCarts set TongTien = @tongTien where CartID = @cartID update ShoppingCarts set SoLuong = @soLuongChung where CartID = @cartID end else begin insert into CartDetails values(@cartID,'" + idSP + "','" + idMau + "','" + soLuongSP + "','" + giaTien + "', '" + thanhTien + "'); set @tongTien = (select sum(ThanhTien) from CartDetails where CartID = @cartID); set @soLuongChung = (select count(*) from CartDetails where CartID = @cartID); update ShoppingCarts set TongTien = @tongTien where CartID = @cartID update ShoppingCarts set SoLuong = @soLuongChung where CartID = @cartID end end else begin insert into ShoppingCarts values('" + ngayOrder + "','" + int.Parse(soLuongChung) + "','" + int.Parse(tongTien) + "',@idUser); set @cartID = (select sc.CartID from ShoppingCarts sc where sc.idUser = @idUser); set @temp1 = (select count(*) from CartDetails where CartID = @cartID and idSP = '" + idSP + "' and idMau = '" + idMau + "'); if(@temp1 > 0)begin update CartDetails set SoLuongSP = '" + int.Parse(soLuongSP) + "', GiaTien = '" + int.Parse(giaTien) + "', ThanhTien = '" + int.Parse(thanhTien) + "' where CartID = @cartID and idSP = '" + int.Parse(idSP) + "' and idMau = '" + int.Parse(idMau) + "' set @tongTien = (select sum(ThanhTien) from CartDetails where CartID = @cartID); set @soLuongChung = (select count(*) from CartDetails where CartID = @cartID); update ShoppingCarts set TongTien = @tongTien where CartID = @cartID update ShoppingCarts set SoLuong = @soLuongChung where CartID = @cartID end else begin insert into CartDetails values(@cartID,'" + int.Parse(idSP) + "','" + int.Parse(idMau) + "','" + int.Parse(soLuongSP) + "','" + int.Parse(giaTien) + "', '" + int.Parse(thanhTien) + "'); set @tongTien = (select sum(ThanhTien) from CartDetails where CartID = @cartID); set @soLuongChung = (select count(*) from CartDetails where CartID = @cartID); update ShoppingCarts set TongTien = @tongTien where CartID = @cartID update ShoppingCarts set SoLuong = @soLuongChung where CartID = @cartID end end  end end ";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();

        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
        }
        finally
        {
            conn.Close();
        }
        return cmd;
    }


    /// <summary>
    /// update số lượng giỏ hàng
    /// </summary>
    /// <param name="idSP"></param>
    /// <param name="idMau"></param>
    /// <param name="soLuong"></param>
    /// <returns></returns>
    public SqlCommand updateSLGH(string idsp, string idmau, string soluong, string userName)
    {
        string ngayOrder = DateTime.Now.ToString("dd-MM-yyyy hh:mm");
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "declare @giaTien int, @cartID int, @userName nvarchar(50), @idUser int, @tongTien int begin set @userName = '" + userName + "' if(@userName != '') begin set @idUser = (select us.idUser from Users us where us.Username = @userName or us.Email = @userName); set @cartID = (select sc.CartID from ShoppingCarts sc where sc.idUser = @idUser); set @giaTien = (select Gia from SanPham_Mau_ChiTiet where idSP = '" + int.Parse(idsp) + "' and idMau = '" + int.Parse(idmau) + "'); update CartDetails set SoLuongSP = '" + int.Parse(soluong) + "' where idSP = '" + int.Parse(idsp) + "' and idMau = '" + int.Parse(idmau) + "' and CartID = @cartID update CartDetails set ThanhTien = SoLuongSP*@giaTien where idSP = '" + int.Parse(idsp) + "' and idMau = '" + int.Parse(idmau) + "' and CartID = @cartID set @tongTien = (select sum(ThanhTien) from CartDetails where CartID = @cartID);    update ShoppingCarts set TongTien = @tongTien where CartID = @cartID end end  ";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();

        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
        }
        finally
        {
            conn.Close();
        }
        return cmd;
    }
    /// <summary>
    /// update số lượng mua
    /// </summary>
    /// <param name="idSP"></param>
    /// <param name="idMau"></param>
    /// <param name="soLuong"></param>
    /// <returns></returns>
    public SqlCommand updateSLMua(string idSP)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "update SanPhamDT set SoLanMua = SoLanMua + 1 where idSP = '" + idSP + "'";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();

        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
        }
        finally
        {
            conn.Close();
        }
        return cmd;
    }

    /// <summary>
    /// Kiểm tra đăng nhập
    /// </summary>
    /// <param name="idMau"></param>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable kiemTraDangNhap(string user, string pass)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from Users where Username = '" +user+ "' and Password = '" +pass+ "'";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;

    }

    /// <summary>
    /// Kiểm tra đăng nhập
    /// </summary>
    /// <param name="idMau"></param>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable layThongTinUser(string user)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from Users where Username = '" + user + "'";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;

    }

    /// <summary>
    /// Lấy ra tỉnh và thành phố
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getTinhThanhPho()
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from province";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;

    }

    /// <summary>
    /// Lấy ra quận và huyện
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getQuanHuyen(string provinceid)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from district where provinceid= '" + provinceid + "'";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;

    }

    /// <summary>
    /// Lấy ra phường và xã
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getPhuongXa(string districtid)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from ward where districtid= '" + districtid + "'";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;

    }

    /// Lấy ra phường và xã
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getMaCode(string macode, string idsp, string idmau)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from CODE c where c.idCode = ( select ct.idCode from ChiTiet_Code ct where ct.idSP = '" +idsp+ "' and ct.idMau = '" +idmau+ "' ) and CONVERT(DATE, getdate(), 101) <= Convert(date,DATEADD(DAY,cast(apdungmayngay as int),convert(varchar,cast(c.ngayapdung as date),103)),101) and c.maCode = '" +macode+ "'";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection(); 
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;

    }

    /// Get code by ID
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getCodeByID(string macode)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from CODE where idCode = '" +macode+ "'";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;

    }

    /// <summary>
    /// create random password
    /// </summary>
    /// <param name="PasswordLength"></param>
    /// <returns></returns>
    public string CreateLostPassword(int PasswordLength)
    {
        string _allowedChars = "abcdefghijk0123456789mnopqrstuvwxyz";
        Random randNum = new Random(); char[] chars = new char[PasswordLength];
        int allowedCharCount = _allowedChars.Length;
        for (int i = 0; i < PasswordLength; i++)
        {
            chars[i] = _allowedChars[(int)((_allowedChars.Length) * randNum.NextDouble())];
        }
        return new string(chars);
    } 

    /// Lấy ra phương thức giao hàng
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getPTGH()
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from PhuongThucGiaoHang";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;

    }

    /// Lấy ra Top seller
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getTopSeller()
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "SELECT top 2 * FROM SanPhamDT where AnHien = 1 order by SoLanMua desc";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;

    }

    /// Lấy ra sản phẩm có số lượt xem nhiều và mớt nhất
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getSanPhamXemNhieu()
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "SELECT top 4 * FROM SanPhamDT where AnHien = 1 order by SoLanXem,idSP desc";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// Lấy ra sản phẩm mua nhiều và xem nhiều
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getSanPhamXemNhieuMuaNhieu()
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "SELECT top 4 * FROM SanPhamDT where AnHien = 1 order by SoLanXem,SoLanMua desc";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// <summary>
    /// Phân trang bằng store procedure
    /// </summary>
    /// <param name="strTenStore"></param>
    /// <param name="currentPage"></param>
    /// <param name="recordPerpage"></param>
    /// <param name="pageSize"></param>
    /// <param name="CateID"></param>
    /// <returns></returns>
    public DataSet GetPhanTrang_DataSet(
    string strTenStore,
    int currentPage,
    int recordPerpage,
    int pageSize,
    int CateID,
    int sapXep,
        int idTinhTrang)
    {
        DataSet ds = new DataSet();
        ConnectDatabase con = new ConnectDatabase();
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            //Mo ket noi
            conn.Open();
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = conn;
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = strTenStore;
            sqlCmd.Parameters.Add(new SqlParameter("@currPage", currentPage));
            sqlCmd.Parameters.Add(new SqlParameter("@recodperpage", recordPerpage));
            sqlCmd.Parameters.Add(new SqlParameter("@Pagesize", pageSize));
            sqlCmd.Parameters.Add(new SqlParameter("@CateID", CateID));
            sqlCmd.Parameters.Add(new SqlParameter("@sapXep", sapXep));
            sqlCmd.Parameters.Add(new SqlParameter("@idTinhTrang", idTinhTrang));
            SqlDataAdapter sqlDa = new SqlDataAdapter();
            sqlDa.SelectCommand = sqlCmd;
            sqlDa.Fill(ds);
        }
        catch { }
        finally
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
            conn.Dispose();
        }
        return ds;
    }

    /// <summary>
    /// lấy ra tình trạng sản phẩm
    /// </summary>
    /// <returns></returns>
    public DataTable getTinhTrangSanPham()
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "SELECT * from TinhTrang";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// <summary>
    /// lấy ra tình trạng sản phẩm by idtt
    /// </summary>
    /// <returns></returns>
    public DataTable getTinhTrangSanPhamByidTT(string idtt)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "SELECT * from TinhTrang where idTinhTrang = '" + idtt + "'";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// <summary>
    /// lấy ra idUser
    /// </summary>
    /// <returns></returns>
    public DataTable getIdUser(string username)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "SELECT * from Users where Username = '" +username+ "' or Email = '" +username+ "' ";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// <summary>
    /// lấy ra đơn hàng
    /// </summary>
    /// <returns></returns>
    public DataTable getDH(string idUser)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select Top 5 ThoiDiemDatHang,idDH, case when DaXuLy = 0 then N'Chưa xử lý' when DaXuLy = 1 then N'Đã xử lý' end as 'TinhTrang',TongTien from DonHang where idUser = '" + idUser + "' order by idDH desc";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;
    }
    
    /// lấy ra đơn hàng
    /// </summary>
    /// <returns></returns>
    public DataTable getChiTietDH(string idDH)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select *  from DonHangChiTiet where idDH = '" + int.Parse(idDH) + "'";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// lấy ra đơn hàng
    /// </summary>
    /// <returns></returns>
    public DataTable getSlChiTietDonHang(string idSP, string idMau, string idDH)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select *  from DonHangChiTiet where idSP = '" + int.Parse(idSP) + "' and idMau = '" +int.Parse(idMau)+ "' and idDH = '" +int.Parse(idDH)+ "'";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// <summary>
    /// Kiểm tra đăng nhập
    /// </summary>
    /// <returns></returns>
    public DataTable checkLogin(string username, string password)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "SELECT * from Users where (Username = '" + username + "' and Password = '" + password + "') or (Email = '" + username + "' and Password = '" + password + "')";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;
    }


    /// <summary>
    /// lấy ra giỏ hàng
    /// </summary>
    /// <returns></returns>
    public DataTable getGioHang(string username)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from ShoppingCarts where idUser = (select idUser from Users where Username = '" +username+ "' or Email = '" +username+ "' )";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;
    }


    /// <summary>
    /// lấy ra chi tiết giỏ hàng
    /// </summary>
    /// <returns></returns>
    public DataTable getChiTietGH(string cartID)
    {
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from CartDetails where CartID = '" +int.Parse(cartID)+ "'";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// <summary>
    /// Lấy ra sản phẩm khuyến mãi với code nào đó
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getSanPhamByIdcode(string idcode)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from SanPhamDT sp, SanPham_Mau_ChiTiet spct where sp.idSP = spct.idSP and spct.idMau in (select ctc.idMau from ChiTiet_Code ctc where ctc.idCode = '" + int.Parse(idcode) + "') and spct.idSP in (select ctc.idSP from ChiTiet_Code ctc where ctc.idCode = '" + int.Parse(idcode) + "')";
        conn = con.getConnection();
        try
        {

            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }

        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// <summary>
    /// Lấy ra sản phẩm khuyến by idNSX
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getSanPhamByIdNsx(string idnsx)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        string sql = "select top 6 * from SanPhamDT where idNSX = '" + int.Parse(idnsx) + "' and AnHien = 1 order by idSP desc";
        conn = con.getConnection();
        try
        {

            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }

        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// <summary>
    /// Lấy ra Slider
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getSlider()
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        string sql = "select top 4 * from Slider where AnHien = 1 order by ThuTu asc";
        conn = con.getConnection();
        try
        {

            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }

        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// <summary>
    /// Lấy ra chi tiết code by ID
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getChiTietCodeByID(string idcode)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        string sql = "select * from ChiTiet_Code where idCode = '"+idcode+"' ";
        conn = con.getConnection();
        try
        {

            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }

        finally
        {
            conn.Close();
        }

        return dt;
    }

    /// <summary>
    /// insert liên hệ
    /// </summary>
    /// <param name="idSP"></param>
    /// <param name="idMau"></param>
    /// <param name="soLuong"></param>
    /// <returns></returns>
    public bool lienHe(string hoten, string email,string tieude,string ykien, string nam)
    {
        bool check = false;
        int temp;
        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "insert into LienHe values('" + hoten + "','" + email + "','" + tieude + "','" + ykien + "','" + nam + "')";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();

        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
           temp= cmd.ExecuteNonQuery();

           if (temp > 0) check = true;
           else check = false;
        }
        finally
        {
            conn.Close();
        }

        return check;
    }

    /// Lấy ra chủng loại
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getChungLoai()
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "SELECT * from ChungLoai";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;

    }

    /// Lấy ra loại
    /// </summary>
    /// <param name="idSP"></param>
    /// <returns></returns>
    public DataTable getLoai(string idCL)
    {

        ConnectDatabase con = new ConnectDatabase();
        DataTable dt = new DataTable();
        SqlCommand cmd = new SqlCommand();
        string sql = "SELECT * from LoaiSanPham where idCL = '" +int.Parse(idCL)+ "' ";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }
        finally
        {
            conn.Close();
        }

        return dt;

    }

    /// <summary>
    /// Phân trang bằng store procedure
    /// </summary>
    /// <param name="strTenStore"></param>
    /// <param name="currentPage"></param>
    /// <param name="recordPerpage"></param>
    /// <param name="pageSize"></param>
    /// <param name="CateID"></param>
    /// <returns></returns>
    public DataSet GetPhanTrangAdmin_DataSet(
    string strTenStore,
    int currentPage,
    int recordPerpage,
    int pageSize,
        int sapXep)
    {
        DataSet ds = new DataSet();
        ConnectDatabase con = new ConnectDatabase();
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try
        {
            //Mo ket noi
            conn.Open();
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = conn;
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = strTenStore;
            sqlCmd.Parameters.Add(new SqlParameter("@currPage", currentPage));
            sqlCmd.Parameters.Add(new SqlParameter("@recodperpage", recordPerpage));
            sqlCmd.Parameters.Add(new SqlParameter("@Pagesize", pageSize));
            sqlCmd.Parameters.Add(new SqlParameter("@sapxep", sapXep));
            SqlDataAdapter sqlDa = new SqlDataAdapter();
            sqlDa.SelectCommand = sqlCmd;
            sqlDa.Fill(ds);
        }
        catch { }
        finally
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
            conn.Dispose();
        }
        return ds;
    }
}