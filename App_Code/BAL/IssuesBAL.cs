using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
/// <summary>
/// Author:		<Ajay Singh >
/// Email :      <meajaysingh@hotmail.com>
/// Create date: <Create Date,5/10/2013> 
/// </summary>


public class IssuesBAL
{
    private IssuesDAL ob = new IssuesDAL();
    public IssuesBAL()
    {
    }
    public DataTable getIssues(Int64 number, Int16 type)
    {
        try
        {
            return ob.getIssues(number, type);
        }
        catch
        {
            throw;
        }
        finally
        {
        }
    }
    public DataTable getIssue(Int64 issueId)
    {
        try
        {
            return ob.getIssue(issueId);
        }
        catch
        {
            throw;
        }
        finally
        {
        }
    }
    public DataTable getVoters(Int64 issueId)
    {
        try
        {
            return ob.getVoters(issueId);
        }
        catch
        {
            throw;
        }
        finally
        {
        }
    }
    public void postIssue(issuesBO issuesbo)
    {
        try
        {
            ob.postIssues(issuesbo);
        }
        catch
        {
            throw;
        }
        finally
        {
        }
    }
    public DataTable Issues_Numbers(Int64 mpId)
    {
        try
        {
            return ob.Issues_Numbers(mpId);
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
