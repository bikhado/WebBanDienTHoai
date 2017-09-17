using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ConnectDatabase
/// </summary>
public class ConnectDatabase
{
	public ConnectDatabase()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// Connect to database
    /// </summary>
    /// <returns></returns>
    public SqlConnection getConnection()
    {

        string strcon = ConfigurationManager.ConnectionStrings["BanDienThoai"].ConnectionString;
        SqlConnection con = new SqlConnection(strcon);

        return con;

    }

}