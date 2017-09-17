using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
/// <summary>
/// Summary description for Carts
/// </summary>
public class Carts
{
    private List<Items> danhSach = new List<Items>();

    public long tongTien
    {
        get;
        set;
    }
	public Carts()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public Items luaChon(int chiSo)
    {
        return danhSach[chiSo];
    }
    public void addToGioHang(Items item)
    {
        bool daco = false;
        foreach (Items i in danhSach)
        {
            if (i.idSP == item.idSP && i.idMau == item.idMau)
            {
                i.soLuong += item.soLuong;
                daco = true;
                break;
            }
        }
        if (daco == false)
        {
            danhSach.Add(item);
        }
    }
    public void xoaItem(string idSP, string idMau)
    {
        foreach (Items i in danhSach)      
            if(i.idSP == idSP && i.idMau == idMau)
                danhSach.Remove(i);
            return;    
    }
    public void capnhatItem(Items item)
    {
        foreach(Items i in danhSach){
            if (i.idSP == item.idSP && i.idMau == item.idMau)
            {
                i.soLuong = item.soLuong;
                if (item.soLuong == 0)
                    danhSach.Remove(i);
                return;
            }
        }
    }
    public DataTable vebang(){
        tongTien = 0;
        DataTable dt = new DataTable();

        dt.Columns.Add("idSP");
        dt.Columns.Add("tenSP");
        dt.Columns.Add("soLuong");
        dt.Columns.Add("giaTien");
        dt.Columns.Add("mau");
        dt.Columns.Add("ngayDat");
        dt.Columns.Add("thanhTien");
        dt.Columns.Add("urlHinh");
        dt.Columns.Add("mamau");
        String sDate = DateTime.Now.ToString();

        DateTime datevalue = (Convert.ToDateTime(sDate.ToString()));

        String dy = datevalue.Day.ToString();
        String mn = datevalue.Month.ToString();
        String yy = datevalue.Year.ToString();
        foreach(Items i in danhSach){
            DataRow dr = dt.NewRow();

            
            DataSet ds = new DataSet();
            ds=layThongTinItem(i.idSP,i.soLuong,i.idMau);
            dr["idSP"] = ds.Tables[0].Rows[0]["idSP"].ToString();
            dr["mamau"] = ds.Tables[0].Rows[0]["mamau"].ToString();
            dr["tenSP"] = ds.Tables[0].Rows[0]["tenSP"].ToString();
            dr["soLuong"] = i.soLuong;
            dr["giaTien"] = ds.Tables[0].Rows[0]["Gia"].ToString();
            dr["mau"] = ds.Tables[0].Rows[0]["tenMau"].ToString();
            dr["ngayDat"] = dy + "/" + mn + "/" + yy;
            dr["thanhTien"] = ds.Tables[0].Rows[0]["thanhTien"].ToString();
            dr["urlHinh"] = ds.Tables[0].Rows[0]["urlHinh"].ToString();
            dt.Rows.Add(dr);
            tongTien += long.Parse(ds.Tables[0].Rows[0]["thanhTien"].ToString());
        }

        return dt;
    }

    public DataSet layThongTinItem(string idSP, int SL, string idMau){
        ConnectDatabase con = new ConnectDatabase();
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();
        string sql = @"SELECT        SanPhamDT.idSP, SanPhamDT.tenSP, SanPham_Mau_ChiTiet.Gia, SanPham_Mau.TenMau,SanPham_Mau_ChiTiet.Gia*'" + SL + @"' as thanhTien,SanPhamDT.urlHinh, SanPham_Mau_ChiTiet.idMau as mamau
                         FROM            SanPhamDT INNER JOIN
                         SanPham_Mau_ChiTiet ON SanPhamDT.idSP = SanPham_Mau_ChiTiet.idSP INNER JOIN
                         SanPham_Mau ON SanPham_Mau_ChiTiet.idMau = SanPham_Mau.idMau
						 where SanPhamDT.idSP = '" + int.Parse(idSP) + "' and SanPham_Mau.idMau = '" + int.Parse(idMau) + "' ";
        SqlConnection conn = new SqlConnection();
        conn = con.getConnection();
        try{
            conn.Open();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
        }
        finally{
            conn.Close();
        }
        return ds;
    }
}

/// <summary>
/// lớp các đối tượng sản phẩm
/// </summary>
public class Items
{
    public string idSP
    {
        get;
        set;
    }
    public int soLuong
    {
        get;
        set;
    }
    public string idMau
    {
        get;
        set;
    }
    public Items()
    {

    }
    public Items(string idSP, int SL,string idMau)
    {
        this.idSP = idSP;
        this.soLuong = SL;
        this.idMau = idMau;
    }
}