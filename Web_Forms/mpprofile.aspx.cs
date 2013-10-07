using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class mpprofile : System.Web.UI.Page
{

    private mpDetailsBAL mpdetailsbal = new mpDetailsBAL();
    private IssuesBAL issuesbal = new IssuesBAL();
    private SupportDenyBAL supportdenybal = new SupportDenyBAL();
    private LikeDislikeBAL likedislikebal = new LikeDislikeBAL();
    private CommentBAL commentbal = new CommentBAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            
            loadlist(50, 0);
            getMpdata(1);   
        }

    }

    public void getMpdata(Int16 constituencyId)
    {

        DataTable dt = new DataTable();
        dt = mpdetailsbal.getData(constituencyId); /** empid fetch throw ***/
        imgMpProfile.ImageUrl = dt.Rows[0]["profilePic"].ToString();
        lblname.Text = dt.Rows[0]["firstName"].ToString() + "  " + dt.Rows[0]["middleName"].ToString() + " " + dt.Rows[0]["lastName"].ToString();
        lblconstituency.Text = dt.Rows[0]["constituency"].ToString();
        lblparty.Text = dt.Rows[0]["partyName"].ToString() + "(" + dt.Rows[0]["Abbreviation"].ToString() + ")";
        lblmail.Text = dt.Rows[0]["email"].ToString();
        lblcntct.Text = dt.Rows[0]["mobile"].ToString();
        lbleducational_q.Text = dt.Rows[0]["qualification"].ToString();
        lblprofession.Text = dt.Rows[0]["profession"].ToString();
        lblp_address.Text = dt.Rows[0]["permanentAddress"].ToString() + ", " + dt.Rows[0][12].ToString() + ", " + dt.Rows[0][13].ToString();
        lblpresent_address.Text = dt.Rows[0]["currentAddress"].ToString() + ", " + dt.Rows[0][15].ToString() + ", " + dt.Rows[0][16].ToString();
        DataTable numDt = new DataTable();
        numDt = issuesbal.Issues_Numbers(Convert.ToInt64(dt.Rows[0]["mpId"]));
        lblissuesno.Text = numDt.Rows[0][0].ToString();
        lblsolvedissuesno.Text = numDt.Rows[0][1].ToString();
    }
    private void loadlist(Int64 number, Int16 type)
    {
        ListIssues.DataSource = (DataTable)issuesbal.getIssues(number, type); /* type 0,1,2 */
        ListIssues.DataBind();


    }
    protected void ListIssues_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        HiddenField issueId = (HiddenField)e.Item.FindControl("HFIssueId");
        DataTable dt = (DataTable)issuesbal.getIssue(Convert.ToInt64(issueId.Value));
        DataTable voterDt = (DataTable)issuesbal.getVoters(Convert.ToInt64(issueId.Value));
        /****Issues***/
        ((Image)e.Item.FindControl("IMGprofilePic")).ImageUrl = dt.Rows[0]["profilePic"].ToString();
        ((Label)e.Item.FindControl("LBLpostedBy")).Text = dt.Rows[0]["firstName"].ToString() + " " + dt.Rows[0]["lastName"].ToString();
        ((Label)e.Item.FindControl("LBLpstate")).Text = "Andheri East(Mumbai)";
        ((Label)e.Item.FindControl("LBLdt")).Text = ((DateTime)(dt.Rows[0]["postedOn"])).ToString("d/MMM/yyyy hh:mm tt");
        if (voterDt.Rows.Count == 2)
        {
            ((Label)e.Item.FindControl("LBLfpname")).Text = voterDt.Rows[0]["firstName"].ToString() + " " + voterDt.Rows[0]["lastName"].ToString() + ",";
            ((Label)e.Item.FindControl("LBLspname")).Text = voterDt.Rows[1]["firstName"].ToString() + " " + voterDt.Rows[1]["lastName"].ToString();
            ((LinkButton)e.Item.FindControl("LBmore")).Visible = false;
        }
        else if (voterDt.Rows.Count == 1)
        {
            ((Label)e.Item.FindControl("LBLfpname")).Text = voterDt.Rows[0]["firstName"].ToString() + " " + voterDt.Rows[0]["lastName"].ToString();
            ((LinkButton)e.Item.FindControl("LBmore")).Visible = false;
        }
        else if (voterDt.Rows.Count > 2)
        {
            ((Label)e.Item.FindControl("LBLfpname")).Text = voterDt.Rows[0]["firstName"].ToString() + " " + voterDt.Rows[0]["lastName"].ToString() + ",";
            ((Label)e.Item.FindControl("LBLspname")).Text = voterDt.Rows[1]["firstName"].ToString() + " " + voterDt.Rows[1]["lastName"].ToString() + " and ";
            ((LinkButton)e.Item.FindControl("LBmore")).Visible = true;

        }
        else
        {
            ((Label)e.Item.FindControl("LBLfpname")).Text = "(None) Be first to vote it";
            ((LinkButton)e.Item.FindControl("LBmore")).Visible = false;
        }
        ((Label)e.Item.FindControl("LBLIssue")).Text = dt.Rows[0]["issueText"].ToString();

        ///***** LinkButtonS *****/
        ((LinkButton)e.Item.FindControl("LBsupport")).CommandArgument = issueId.Value;
        ((LinkButton)e.Item.FindControl("LBdeny")).CommandArgument = issueId.Value;
        ((LinkButton)e.Item.FindControl("LBcomment")).CommandArgument = issueId.Value;
        ((Button)e.Item.FindControl("btnPost")).CommandArgument = issueId.Value;
        ///***** Counts values *****/
        //((Label)e.Item.FindControl("LBLvoteCount")).Text = dt.Rows[0]["voteCount"].ToString();
        ((Label)e.Item.FindControl("LBLsupportCount")).Text = dt.Rows[0]["supportCount"].ToString();
        ((Label)e.Item.FindControl("LBLdenyCount")).Text = dt.Rows[0]["denyCount"].ToString();
        ((Label)e.Item.FindControl("LBLcommentCount")).Text = dt.Rows[0]["commentCount"].ToString();

        ///*** post link button ***/
        //((LinkButton)e.Item.FindControl("btnpost")).CommandArgument = issueId.Value;
        ((Repeater)e.Item.FindControl("ListComments")).DataSource = (DataTable)commentbal.getComments(Convert.ToInt64(issueId.Value));
        ((Repeater)e.Item.FindControl("ListComments")).DataBind();

    }

    protected void ListIssues_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        supportDenyBO supportdenybo = new supportDenyBO();
        Int64 issueId = Convert.ToInt64(e.CommandArgument);
        string btncmdname;
        try
        {
            btncmdname = e.CommandName.ToString();
            if (btncmdname == "comment")
            {
                //    ((Repeater)e.Item.FindControl("ListComments")).DataSource = (DataTable)commentbal.getComments(Convert.ToInt64(issueId));
                //    ((Repeater)e.Item.FindControl("ListComments")).DataBind();
            }
            else if (btncmdname == "support")
            {
                supportdenybo.guid = 44; /** from session **/
                supportdenybo.issueId = issueId;
                supportdenybo.supportDeny = true;
                supportdenybal.updateData(supportdenybo);
                DataTable dt = issuesbal.getIssue(issueId);
                ((Label)e.Item.FindControl("LBLsupportCount")).Text = dt.Rows[0]["supportCount"].ToString();
                ((Label)e.Item.FindControl("LBLdenyCount")).Text = dt.Rows[0]["denyCount"].ToString();
            }
            else if (btncmdname == "deny")
            {
                supportdenybo.guid = 44; /** from session **/
                supportdenybo.issueId = issueId;
                supportdenybo.supportDeny = false;
                supportdenybal.updateData(supportdenybo);
                DataTable dt = issuesbal.getIssue(issueId);
                ((Label)e.Item.FindControl("LBLsupportCount")).Text = dt.Rows[0]["supportCount"].ToString();
                ((Label)e.Item.FindControl("LBLdenyCount")).Text = dt.Rows[0]["denyCount"].ToString();

            }
            else if (btncmdname == "post")
            {
                commentsBO commentsbo = new commentsBO();
                TextBox txtcomment = e.Item.FindControl("TxtComment") as TextBox;
                commentsbo.comment = ((TextBox)(e.Item.FindControl("TxtComment"))).Text;
                commentsbo.issueId = issueId;
                txtcomment.Text = "";
                commentsbo.guid = 44; /** from session **/
                commentbal.postComment(commentsbo);
                ((Repeater)e.Item.FindControl("ListComments")).DataSource = (DataTable)commentbal.getComments(Convert.ToInt64(issueId));
                ((Repeater)e.Item.FindControl("ListComments")).DataBind();
                DataTable dt = issuesbal.getIssue(issueId);
                ((Label)e.Item.FindControl("LBLcommentCount")).Text = dt.Rows[0]["commentCount"].ToString();
            }
        }
        catch
        {
            throw;
        }
        finally
        {

        }



    }

    protected void ListComments_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        HiddenField commentId = (HiddenField)e.Item.FindControl("HFcommentId");
        ((LinkButton)e.Item.FindControl("LBlike")).CommandArgument = commentId.Value;
        ((LinkButton)e.Item.FindControl("LBdislike")).CommandArgument = commentId.Value;
        DataTable dt = new DataTable();
        dt = (DataTable)commentbal.getComment(Convert.ToInt64(commentId.Value));
        ((Label)e.Item.FindControl("LBLlikeCount")).Text = dt.Rows[0]["likeCount"].ToString();
        ((Label)e.Item.FindControl("LBLdislikeCount")).Text = dt.Rows[0]["dislikeCount"].ToString();

    }
    protected void ListComments_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        likeDislikeBo likedislikebo = new likeDislikeBo();
        string btncmdname = e.CommandName.ToString();
        Int64 commentId;
        try
        {
            commentId = Convert.ToInt64(e.CommandArgument);
            if (btncmdname == "like")
            {
                likedislikebo.guId = 44; /*** from session ***/
                likedislikebo.commentId = commentId;
                likedislikebo.likeDislike = true;
                likedislikebal.updateData(likedislikebo);
                DataTable dt = new DataTable();
                dt = (DataTable)commentbal.getComment(commentId);
                ((Label)e.Item.FindControl("LBLlikeCount")).Text = dt.Rows[0]["likeCount"].ToString();
                ((Label)e.Item.FindControl("LBLdislikeCount")).Text = dt.Rows[0]["dislikeCount"].ToString();

            }
            if (btncmdname == "dislike")
            {
                likedislikebo.guId = 44;
                likedislikebo.commentId = commentId;
                likedislikebo.likeDislike = false;
                likedislikebal.updateData(likedislikebo);
                DataTable dt = new DataTable();
                dt = (DataTable)commentbal.getComment(commentId);
                ((Label)e.Item.FindControl("LBLlikeCount")).Text = dt.Rows[0]["likeCount"].ToString();
                ((Label)e.Item.FindControl("LBLdislikeCount")).Text = dt.Rows[0]["dislikeCount"].ToString();


            }


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