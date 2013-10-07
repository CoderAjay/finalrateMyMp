<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Homepage.aspx.cs" Inherits="Homepage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rate My MP</title>
<link rel="stylesheet" type="text/css" href="../CSS/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="../CSS/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="../CSS/bootstrap-responsive.css" />
<link rel="stylesheet" type="text/css" href="../CSS/style1.css" />
<script type="text/javascript" src="../JS/jquery-1.9.1.js"></script>


<script type="text/javascript" src="../JS/bootstrap.js"></script>
     <!-- google analytics script -->
    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
            m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

        ga('create', 'UA-44359262-1', 'venturepact.com');
        ga('send', 'pageview');

</script>
    <!-- script to logout from  google session  -->
    <script>
        function logout() {

            document.location.href = " https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://localhost:11771/Default.aspx";
            return true;
        }

    </script> 
    
    <!-- script to logout from facebook session -->
   <script type="text/javascript" src="/JS/fb.js"></script>
   <script src="http://connect.facebook.net/en_US/all.js" type="text/javascript"></script>
       <script>
           //Load the SDK Asynchronously
           (function (d) {
               var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
               if (d.getElementById(id)) { return; }
               js = d.createElement('script'); js.id = id; js.async = true;
               js.src = "//connect.facebook.net/en_US/all.js";
               ref.parentNode.insertBefore(js, ref);
           }(document));

           // Init the SDK upon load
           var fbl;
           window.fbAsyncInit = function () {
               fb1 = FB.init({
                   appId: '158860384321647', // App ID 
                   channelUrl: '//' + window.location.hostname + '/channel', // Path to your Channel File
                   status: true, // check login status  
                   cookie: true, // enable cookies to allow the server to access the session
                   xfbml: true  // parse XFBML
               });

               $("#facebookLogout").click(function () {
                   kpfb();

               });
           };

           function kpfb() {
               FB.getLoginStatus(function (response) {
                   if (response.status == 'connected') {
                       //alert(response.status);
                       FB.logout(function (response) {

                           kpredirect();
                       });
                   }
               });
           }

           function kpredirect() {
               window.location.reload();
              // alert("test3");
               document.location.href = "../Default.aspx";
           }

    </script>
    
</head>
<body>
    <form id="frmhomepage" runat="server">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnablePartialRendering="true"/>
<div id="main"> 
	<div id="main_container">
    	<div id="main_left">
        	<div class="logo">
            	<a href="index.aspx"><img src="../images/LOG.png" /></a>
            </div>
            <div class="search_bar">
            	<h3>Select a Member</h3>
             <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" ><ContentTemplate>
                <div class="select_outr">
                    <asp:DropDownList ID="DDListState" runat="server" AutoPostBack="true" AppendDataBoundItems="true" CssClass="member_select" OnSelectedIndexChanged="DDListState_SelectedIndexChanged">
                        <items><asp:ListItem>State</asp:ListItem></items>
                    </asp:DropDownList>
                </div>
                <div class="select_outr">
                <asp:DropDownList ID="DDListConstituency" runat="server" CssClass="member_select">
                        <items><asp:ListItem>Constituency</asp:ListItem></items>
                    </asp:DropDownList>
                </div>
               </ContentTemplate></asp:UpdatePanel>
                <asp:HiddenField ID="HFconstituencyId" runat="server" />
                <div class="search_button">
                    <asp:Button ID="Btnsearch" CssClass="btn" runat="server" Text="Search" OnClick="Btnsearch_Click" />
                </div>
               
               
            </div>
            <div class="main_left_links">
            	<ul class="nav nav_inner">
                	<li><a href="javascript:void(0);">About Us</a></li>
                    <li><a href="javascript:void(0);">Our Mission</a></li>
                    <li><a href="javascript:void(0);">Contact Us</a></li>
                </ul>
            </div>
        </div>
        <div id="main_right">
            <div id="home_container">
            	<div class="home_right">
                	<label class="user_outr"><asp:Label ID="LBLuserName" runat="server" Text="Hi Singh"/></label>
                	<input type="button" class="btn btn_home" value="Home" />
                    <input type="button" id="facebookLogout" class="btn btn_home" value="Logout"  runat="server"/>
                    <asp:Button ID="googleLogout" class="btn btn_home" runat="server" Text="Logout" Visible="false" OnClick="googleLogout_Click" />
                    <asp:Button ID="localLogout" class="btn btn_home" runat="server" Text="Logout"  Visible="false" OnClick="localLogout_Click"/>
                </div>
                	<div class="issue_links">
                    	<ul class="nav nav-pills">
                            <li><asp:LinkButton ID="LBtrending" runat="server" Text="Trending Issues" OnClick="LBtrending_Click" /></li>
                            <li><asp:LinkButton ID="LBrecent" runat="server" Text="Recent Issues" OnClick="LBrecent_Click" /></li>
                            <li><asp:LinkButton ID="LBpopular" runat="server" Text="Most Popular Tags" OnClick="LBpopular_Click" /></li>
                          <%--  <li><a href="javascript:void(0);">Trending Issues</a></li>
                            <li><a href="javascript:void(0);">Recent Issues</a></li>
                            <li><a href="javascript:void(0);">Most Popular Tags</a></li>--%>
                        </ul>
                	</div>
                    <div class="search_box">
                        <asp:LinkButton ID="LBsearch" runat="server" class="icon-search search_icon"/>
                        <asp:TextBox ID="txtsearchBox" class="search-query seach_box_inner" runat="server"/>
                        <asp:TextBoxWatermarkExtender runat="server" TargetControlID="txtsearchBox" WatermarkText="Search for Member, Constituency or state" 
                           />
                    </div>
            </div>
              
            <%-- Issues start--%>
             <div class="random_issue">
 <asp:UpdatePanel runat="server" UpdateMode="Conditional"><ContentTemplate>
 <asp:Repeater runat="server" ID="ListIssues" OnItemDataBound="ListIssues_ItemDataBound" OnItemCommand="ListIssues_ItemCommand"><ItemTemplate>    
 <asp:HiddenField ID="HFIssueId" runat="server" Value='<%# Eval("issueId") %>' />                   	
<asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional"><ContentTemplate> 
                  <div class="home_issue_outr">
                	<div class="home_left_pic"><asp:Image ID="IMGprofilePic" runat="server" /></div>
                    <div class="home_right_detail">
                    	<div class="home_right_top">
                            <asp:Label ID="LBLpostedBy" runat="server"/>
                            <asp:Label ID="LBLpstate" runat="server" /> 
                            <asp:Label ID="LBLdt" CssClass="date_time" runat="server" />
                        </div>
                        <asp:UpdatePanel runat="server" UpdateMode="Conditional"><ContentTemplate>  
                            <div class="home_right_top">
                        	<p>Votes By</p>
                            <label><asp:Label ID="LBLfpname" runat="server"/></label>
                            <label><asp:Label ID="LBLspname" runat="server"/></label>
                            <asp:LinkButton ID="LBmore" runat="server" Text="more.."/>
                        </div>
                        </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="LBmore" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>

                    </div>
                    <div class="issue_outr">
                        <asp:Label ID="LBLIssue" runat="server"/>
                    </div>
                    <div class="likebutton">
                        <asp:UpdatePanel runat="server" UpdateMode="Conditional"><ContentTemplate>
                        <div class="bound1">
                        <i class="icon-thumbs-up"></i><label><asp:Label ID="LBLsupportCount" runat="server"/></label><asp:LinkButton ID="LBsupport" runat="server" Text="Support" CommandName="support"/>
                        <i class="icon-thumbs-down"></i><label><asp:Label ID="LBLdenyCount" runat="server"/></label><asp:LinkButton ID="LBdeny" runat="server" Text="Deny" CommandName="deny"/>
                        <i class="icon-comment"></i><label><asp:Label ID="LBLcommentCount" runat="server"/></label>
                        </div>
                           </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger EventName="Click" ControlID="LBsupport" />
                                <asp:AsyncPostBackTrigger EventName="Click" ControlID="LBdeny" />
                                <asp:AsyncPostBackTrigger EventName="Click" ControlID="btnPost" />
                            </Triggers>
                        </asp:UpdatePanel>
                            <div class="bound2">
                                <asp:LinkButton ID="LBcomment" runat="server" Text="Comment"/>
                            </div>
                        </div>
                       

                    </div>
    <%-- Comments start--%>              
          <div class="comment_cont">
                    <asp:Panel ID="Panel1" runat="server">    
     		   <asp:UpdatePanel runat="server" UpdateMode="Conditional"><ContentTemplate>     
                          <div class="user_outer">
                                <asp:Repeater runat="server" ID="ListComments" OnItemCommand="ListComments_ItemCommand" OnItemDataBound="ListComments_ItemDataBound" > <ItemTemplate>     
                                 <div class="img_outer">
                              <asp:Image runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem,"profilePic") %>'/>
                          </div>	
                                      <div class="comm_section">
                                    <div class="name_label">
                                       <asp:Label runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"firstName") + " " %> '/><asp:Label runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"lastName") %>'/> 
                                     </div>
                             <div class="date_label">
                                 <asp:Label runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"postedOn","{0:d/MMM/yyyy hh:mm tt}") %>'/>
                               </div>
                       <div class="comment_label">
                           <asp:Label runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"comment") %>'/>
                         </div>
                      </div>
                    <asp:HiddenField runat="server" ID="HFcommentId" Value='<%# DataBinder.Eval(Container.DataItem,"commentId") %>' />
                     <asp:UpdatePanel runat="server" UpdateMode="Conditional"><ContentTemplate>
                        <div class="sub_icons"> 
                               <i class="icon icon-thumbs-up"></i><asp:Label runat="server" ID="LBLlikeCount"/><asp:LinkButton ID="LBlike" runat="server" Text="Like" CommandName="like"/> 
                               <i class="icon icon-thumbs-down"></i><asp:Label runat="server" ID="LBLdislikeCount"/> <asp:LinkButton ID="LBdislike" runat="server" Text="Dislike" CommandName="dislike"/>
                        </div>
                    </ContentTemplate>
                         <Triggers>
                             <asp:AsyncPostBackTrigger ControlID="LBlike" EventName="Click" />
                             <asp:AsyncPostBackTrigger ControlID="LBdislike" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnPost" EventName="Click" />
                         </Triggers>
                     </asp:UpdatePanel>
                   </ItemTemplate></asp:Repeater> 
                    
                    <div class="text_comment">
                            <asp:TextBox ID="txtcomment" runat="server" TextMode="MultiLine" style="width:95%" />
                             <asp:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtComment" WatermarkText="Puts Your Comments"/>
                        </div>
                       <div class="post_button">
                           <asp:Button ID="btnPost" runat="server" Text="Post" CommandName="post" style=" padding:  3px 15px 3px 15px;" />
                       </div> 
                        
                   
               </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="LBcomment" EventName="Click" />
                    </Triggers>
            	</asp:UpdatePanel>
                         <asp:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="Server"
                         TargetControlID="Panel1"
                         ExpandControlID="LBComment"
                         CollapseControlID="LBComment" 
                         Collapsed="True"
                         SuppressPostBack="true"
                           />        
              </asp:Panel>
              </div>
      </div>
    <%-- Comments end--%>
</ContentTemplate>
</asp:UpdatePanel> 
</ItemTemplate></asp:Repeater>
</ContentTemplate>
     <Triggers>
         <asp:AsyncPostBackTrigger ControlID="LBtrending" EventName="Click" />
         <asp:AsyncPostBackTrigger ControlID="LBrecent" EventName="Click" />
         <asp:AsyncPostBackTrigger ControlID="LBpopular" EventName="Click" />
     </Triggers>
 </asp:UpdatePanel> 
               </div>
           
            <%-- Issues end--%>
                </div>
             </div>
        </div>

        <asp:HiddenField ID="HiddenField1" runat="server" />

     </form>
     <!-- user nap script--> 
      <script type="text/javascript">
          var _usersnapconfig = {
              apiKey: '4ad9c2d8-f944-4f85-adf1-2d118d7247ca',
              valign: 'bottom',
              halign: 'right',
              tools: ["pen", "highlight", "note"],
              lang: 'en',
              commentBox: true,
              emailBox: true
          };
          (function () {
              var s = document.createElement('script');
              s.type = 'text/javascript';
              s.async = true;
              s.src = '//api.usersnap.com/usersnap.js';
              var x = document.getElementsByTagName('head')[0];
              x.appendChild(s);
          })();
</script>
</body>

</html>
