using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Script.Serialization;// name space to use the concept of json

public partial class webservices : System.Web.UI.Page
{
    private ConstituencyBAL constituency = new ConstituencyBAL();
    private StateBAL statebal = new StateBAL();
    private mpDetailsBAL mpdetails = new mpDetailsBAL();
    protected void Page_Load(object sender, EventArgs e)
    {


        if (Request.QueryString["Key"] != null)
        {
            if (Request.QueryString["Key"] == "state")
            {
                Response.Write(selectState());
            }
            else if (Request.QueryString["Key"] == "mp")
            {
                if (Request.QueryString["constituency"] != null)
                {
                    Response.Write(selectmp(Convert.ToInt16(Request.QueryString["constituency"])));
                }
            }
            else if (Request.QueryString["Key"] == "constituency")
            {
                if (Request.QueryString["stateId"] != null)
                {
                    Response.Write(selectConstituency(Convert.ToInt16(Request.QueryString["stateId"].ToString())));
                }
            }
        }
    }
    public string selectState()
    {
        DataTable dt = new DataTable();
        dt = (DataTable)statebal.getData();
        JavaScriptSerializer js = new JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row = null;

        foreach (DataRow dr in dt.Rows)
        {
            row = new Dictionary<string, object>();
            foreach (DataColumn col in dt.Columns)
            {
                row.Add(col.ColumnName.Trim(), dr[col]);
            }
            rows.Add(row);
        }
        return js.Serialize(rows);

    }

    public string selectConstituency(Int16 stateId)
    {
        DataTable dt = new DataTable();
        dt = (DataTable)constituency.getData(stateId);
        JavaScriptSerializer js = new JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row = null;

        foreach (DataRow dr in dt.Rows)
        {
            row = new Dictionary<string, object>();
            foreach (DataColumn col in dt.Columns)
            {
                row.Add(col.ColumnName.Trim(), dr[col]);
            }
            rows.Add(row);
        }
        return js.Serialize(rows);

    }
    public string selectmp(Int16 constituency)
    {
        DataTable dt = new DataTable();
        dt = (DataTable)mpdetails.getData(constituency);
        JavaScriptSerializer js = new JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row = null;

        foreach (DataRow dr in dt.Rows)
        {
            row = new Dictionary<string, object>();
            foreach (DataColumn col in dt.Columns)
            {
                row.Add(col.ColumnName.Trim(), dr[col]);
            }
            rows.Add(row);
        }
        return js.Serialize(rows);

    }
}

