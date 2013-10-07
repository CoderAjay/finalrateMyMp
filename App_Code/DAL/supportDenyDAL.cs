using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Author:		<Ajay Singh >
/// Email :      <meajaysingh@hotmail.com>
/// Create date: <Create Date,7/10/2013> 
/// </summary>


public class supportDenyDAL
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["rateMyMPConnectionString"].ConnectionString);
    SqlCommand cmd;
    SqlDataAdapter dap;
    SqlDataReader drd;
    string query;

	public supportDenyDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public void updateData(supportDenyBO supportdenybo)
    {
        try
        {

            query = "SUPPORT_DENY_CLICK";
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
            cmd = new SqlCommand(query, con);
           
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@issueId", supportdenybo.issueId);
            cmd.Parameters.AddWithValue("@guid",supportdenybo.guid);
            cmd.Parameters.AddWithValue("@supportDenyValue",supportdenybo.supportDeny);
            cmd.ExecuteNonQuery();
            
        }
        catch
        {
            throw;
        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();
            cmd.Dispose();
        }
    }
}