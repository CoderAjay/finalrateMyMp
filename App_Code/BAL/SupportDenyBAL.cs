using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
/// <summary>
/// Author:		<Ajay Singh >
/// Email :      <meajaysingh@hotmail.com>
/// Create date: <Create Date,5/10/2013> 
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