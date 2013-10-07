using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SupportDenyBAL
/// </summary>
public class SupportDenyBAL
{
    supportDenyDAL supportdenydal = new supportDenyDAL();
	public SupportDenyBAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public void updateData(supportDenyBO supportdenybo)
    {
        try
        {
            supportdenydal.updateData(supportdenybo);
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