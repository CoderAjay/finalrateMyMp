using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

/// <summary>
/// Author:		<Ajay Singh >
/// Email :      <meajaysingh@hotmail.com>
/// Create date: <Create Date,5/10/2013> 
/// Authentication Part Done By : <Kamal Pathak>
/// </summary>
public partial class Homepage : System.Web.UI.Page
{
    private ConstituencyBAL constituency = new ConstituencyBAL();
    private StateBAL statebal = new StateBAL();
    private IssuesBAL issuesbal = new IssuesBAL();
    private SupportDenyBAL supportdenybal = new SupportDenyBAL();
    private LikeDislikeBAL likedislikebal = new LikeDislikeBAL();
    private CommentBAL commentbal = new CommentBAL();
    userMasterBO userMasterBO = new userMasterBO();
    userMasterBAL userMasterBAL = new userMasterBAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        googleLogout.Attributes.Add("OnClick", "javascript: return logout()");// registering the javascript function for onclick event of linkbutton
       if (!Page.IsPostBack)
       {
           //Btnsearch.Enabled = false;
           //LBsearch.Enabled = false;
           userCreateAndSession();
            loadStates();
            loadlist(50,0);  
        }
    }
    private void userCreateAndSession()
    {
        string ss = "";
        string fname = "";
        string lname = "";
        if (Request.Cookies["UserCookies"] == null)
        {
            if (Request.UrlReferrer != null)
            {
                ss = Request.UrlReferrer.AbsoluteUri.ToString();
                ss = ss.Substring(ss.LastIndexOf("/") + 1);
                if (ss == "Default.aspx")
                {
                    if (Session["userEmail"] == null)
                    {   //creat the session for user
                        if (Request["social"].ToString() == "yes")
                        {
                            Session["userEmail"] = Request["email"].ToString();
                            Session["socialType"] = Request["socialType"].ToString();  //google or facebook
                            Session["socialOrNot"] = 1; // 1 for login through social network 0 for local login
                            string tnameval = Request["name"].ToString();
                            string[] tnamearray = tnameval.Split(' ');
                            fname = tnamearray[0];
                            if (tnamearray.Length > 1)
                            {
                                lname = tnamearray[1];
                            }
                            else
                            {
                                lname = "";
                            }
                            userMasterBO.password = "";
                        }

                        //give the code to insert data into the usermaster table.
                        userMasterBO.email = Session["userEmail"].ToString();
                        userMasterBO.lastName = lname;
                        userMasterBO.firstName = fname;
                        userMasterBO.middleName = "";
                        if (int.Parse(Session["socialOrNot"].ToString()) == 1)
                        {
                            userMasterBO.socialNetwork = true;
                        }
                        else
                        {
                            userMasterBO.socialNetwork = false;
                        }
                        userMasterBO.status = true;
                        userMasterBO.roleId = 3;  //3 for user , 2 for mp,1 for admin, 4  for moderator
                        userMasterBO.snTypeId = userMasterBAL.getSocialNetworkId(Session["socialType"].ToString()); //fetch the corresponding id of socialnetwork
                        userMasterBO.profilePicPath = Request["image"].ToString();
                        //insert data into the database.
                        HiddenField1.Value = userMasterBAL.insertUser(userMasterBO);
                        Session["guid"] = (userMasterBAL.getGuid(userMasterBO)).ToString();
                        // Label1.Text = Session["guid"].ToString();

                    }
                    else
                    {
                        // Label1.Text = Session["guid"].ToString();
                    }

                }
                else //every this is already done(session and storing of data in database is already done)
                {

                }
            }
            else
            {
                Response.Redirect("../Default.aspx");
            }
        }

        if (Session["userEmail"] != null)
        {
            if (int.Parse(Session["socialOrNot"].ToString()) == 1)
            {
                if (Session["socialType"].ToString() == "GOOGLE")
                {
                    // for google login
                    googleLogout.Visible = true;
                    facebookLogout.Visible = false;
                }
                else if (Session["socialType"].ToString() == "FACEBOOK")
                {
                    facebookLogout.Visible = true;
                }
            }
            else
            {
                // for local userlogin
                localLogout.Visible = true;
                facebookLogout.Visible = false;
             }
        }

    }

    private void loadStates()
    { 
        //loading states in drop dow list 
       DDListState.DataSource = (DataTable)statebal.getData();
        DDListState.DataTextField = "state";
        DDListState.DataValueField = "stateId";
        DDListState.DataBind();
    }

    protected void DDListState_SelectedIndexChanged(object sender, EventArgs e)
    {
        Int16 stateId = Convert.ToInt16(DDListState.SelectedValue);
        DDListConstituency.Items.Clear();
        DDListConstituency.Items.Add("Constituency");
        DDListConstituency.DataSource = (DataTable)constituency.getData(stateId);
        DDListConstituency.DataTextField = "constituency";
        DDListConstituency.DataValueField = "constituencyId";
        DDListConstituency.DataBind();
    }

    protected void Btnsearch_Click(object sender, EventArgs e)
    {

        Int16 constituencyId = Convert.ToInt16(DDListConstituency.SelectedValue);
        HFconstituencyId.Value = constituencyId.ToString();
        Server.Transfer("usercomment.aspx", true);

    }
    protected void LBtrending_Click(object sender, EventArgs e)
    {
        loadlist(50,0);
    }
    protected void LBrecent_Click(object sender, EventArgs e)
    {
        loadlist(50, 1);
    }
    protected void LBpopular_Click(object sender, EventArgs e)
    {
        loadlist(50, 2);
    }
    private void loadlist(Int64 number,Int16 type)
    {
        ListIssues.DataSource =(DataTable) issuesbal.getIssues(number,type); /* type 0,1,2 */
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
        ((Repeater)e.Item.FindControl("ListComments")).DataSource =(DataTable)commentbal.getComments(Convert.ToInt64(issueId.Value));
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
                supportdenybo.guid = int.Parse(Session["guid"].ToString()); ; /** from session **/
                supportdenybo.issueId = issueId;
                supportdenybo.supportDeny = true;
                supportdenybal.updateData(supportdenybo);
                DataTable dt = issuesbal.getIssue(issueId);
                ((Label)e.Item.FindControl("LBLsupportCount")).Text = dt.Rows[0]["supportCount"].ToString();
                ((Label)e.Item.FindControl("LBLdenyCount")).Text = dt.Rows[0]["denyCount"].ToString();
            }
            else if (btncmdname == "deny")
            {
                supportdenybo.guid = int.Parse(Session["guid"].ToString()); ; /** from session **/
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
                commentsbo.guid = int.Parse(Session["guid"].ToString()); ; /** from session **/
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
                likedislikebo.guId = int.Parse(Session["guid"].ToString()); /*** from session ***/
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
                likedislikebo.guId = int.Parse(Session["guid"].ToString());
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

    protected void googleLogout_Click(object sender, EventArgs e)
    {
        if (Session["userEmail"] != null)
        {
            Session.Abandon();

        }
        // ClientScript.RegisterStartupScript(this.GetType(), "myfunction", "logout()", true);
        Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "myfunction", "logout()", true);
    }
    protected void localLogout_Click(object sender, EventArgs e)
    {
        if (Request.Cookies["UserCookies"] != null)
        {   // here we are deleting the cookie.
            Response.Cookies["UserCookies"].Expires = DateTime.Now.AddDays(-1);
            if (Session["userEmail"] == null)
            {
                Response.Redirect("../Default.aspx");
            }
        }
        if (Session["userEmail"] != null)
        {
            Session.Abandon();
            Response.Redirect("../Default.aspx");
        }
    }
}