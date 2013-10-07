using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for LikeDislikeDAL
/// </summary>
public class LikeDislikeDAL
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["rateMyMPConnectionString"].ConnectionString);
    SqlCommand cmd;
    SqlDataAdapter dap;
    SqlDataReader drd;
    string query;

	public LikeDislikeDAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public Int64 updateData(likeDislikeBo likedislikebo)
    {
        try
        {

            query = "LIKE_DISLIKE_CLICK";
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
            cmd = new SqlCommand(query, con);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@commentId",likedislikebo.commentId);
            cmd.Parameters.AddWithValue("@guid",likedislikebo.guId);
            cmd.Parameters.AddWithValue("@likeDislike",likedislikebo.likeDislike);
             Int64 issueId = Convert.ToInt64( cmd.ExecuteScalar());
             return issueId;
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