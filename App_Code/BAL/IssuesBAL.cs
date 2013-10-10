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

/// </summary>
public class IssuesBAL
{
    private IssuesDAL ob = new IssuesDAL();
    public IssuesBAL()
    {
    }
    public void updateReportAbuseIssue(issuesBO issuesBO)
    {
        try
        {
            ob.updateReportAbuseIssue(issuesBO);
        }
        catch
        {

        }
        finally
        {

        }

    }
    public DataTable fetchAbuseIssueReport()
    {
        try
        {
            return ob.fetchAbuseIssueReport();

        }
        catch
        {
            throw;
        }
        finally
        {

        }
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
 }
