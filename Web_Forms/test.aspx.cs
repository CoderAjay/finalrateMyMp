using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class rateMyMp_Web_Forms_test : System.Web.UI.Page
{
    userMasterBO userMasterBO = new userMasterBO();
    userMasterBAL userMasterBAL = new userMasterBAL();
    protected void Page_Load(object sender, EventArgs e)
    {

       

        string ss = "";
        string fname = "";
        string lname = "";

        if (!IsPostBack) //if page is not postbacked then  ispostback return false.
        {
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
                            //insert data into the database.
                            userMasterBO.profilePicPath = Request["image"].ToString();
                            HiddenField1.Value = userMasterBAL.insertUser(userMasterBO);
                            Session["guid"] = (userMasterBAL.getGuid(userMasterBO)).ToString();
                            Label1.Text = Session["guid"].ToString();

                        }
                        else
                        {
                            Label1.Text = Session["guid"].ToString();
                        }

                    }
                    else //every this is already done(session and storing of data in database is already done)
                    {

                    }
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }

            if (Session["userEmail"] != null)
            {
                if (int.Parse(Session["socialOrNot"].ToString()) == 1)
                {
                    if (Session["socialType"].ToString() == "GOOGLE")
                    {
                        // for google login
                        Button1.Visible = true;
                        // Button3.Visible = false; // local user
                         ClientScript.RegisterStartupScript(this.GetType(), "myfunction", "hidefacebook()", true); //facebook
                    }
                    else if (Session["socialType"].ToString() == "FACEBOOK")
                    {
                        // for facebook logiin
                       // ClientScript.RegisterStartupScript(this.GetType(), "myfunction", "hidefacebook()", true); //facebook
                        // Button1.Visible = false; // google button
                        // Button3.Visible = false;// local user button
                    }
                }
                else
                {
                    // for local userlogin
                    Button3.Visible = true;
                    // Button1.Visible = false; //for google button
                    ClientScript.RegisterStartupScript(this.GetType(), "myfunction", "hidefacebook()", true); // for facebook button
                }
            }
        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Session["userEmail"] != null)
        {
            Session.Abandon();

        }
        ClientScript.RegisterStartupScript(this.GetType(), "myfunction", "logout()", true);
    }
    protected void Button3_Click(object sender, EventArgs e)
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
    protected void Button4_Click(object sender, EventArgs e)
    {
       // Response.Redirect("https://www.facebook.com/logout.php?next=REDIRECT_URI&access_token=LOGGEDINUSER_ACCESS_TOKEN");
        
    }
}