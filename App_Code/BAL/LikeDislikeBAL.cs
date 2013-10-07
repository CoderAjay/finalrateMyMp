using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


/// <summary>
/// Summary description for LikeDislikeBAL
/// </summary>
public class LikeDislikeBAL
{
    LikeDislikeDAL likedislikedal = new LikeDislikeDAL();
	public LikeDislikeBAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public Int64 updateData(likeDislikeBo likedislikebo)
    {
        try
        {
            return likedislikedal.updateData(likedislikebo);
        }
        catch
        {
            throw;
        }
        finally
        {
        }

    }
}