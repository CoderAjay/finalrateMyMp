<%@ Page Language="C#" AutoEventWireup="true" CodeFile="mpprofile.aspx.cs" Inherits="mpprofile" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
<meta http-equiv="Content-Type" content="2text/html; charset=utf-8" />
<title>Rate my MP</title>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="../css/bootstrap-responsive.css" />
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="../css/style1.css" />
<script type="text/javascript" src="../js/bootstrap.js"></script>
</head>
<body>
    <form id="mpprofilefrm" runat="server">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnablePartialRendering="true"/>
<div id="main"> 
	<div id="main_container">
    	<div id="main_left">
        	<div class="logo">
            	<a href="index.aspx"><img src="../images/LOG.png" /></a>
            </div>
         <div class="mp_info">
          <div class="heading">
               		<h5>15th Lok Sabha <br />Member of Parliament profile</h5>
               </div>
          	 <div class="mp_info_inner">
              	<div class="mp_img">
                  <div class="mp_pic"> 
                     <asp:Image ID="imgMpProfile" runat="server" />
                  </div>
               </div>
           <div class="up_labels">
           <div class="name1">
                  <h5>Name:</h5><label><asp:Label ID="lblname" runat="server" /></label>
                  </div>
                  <div class="name1">
                  <h5>Constituency:</h5><label><asp:Label ID="lblconstituency" runat="server" /></label>
                  </div>
                  <div class="name1">
                  <h5>Party:</h5><label><asp:Label ID="lblparty" runat="server" /></label>
                  </div>
               </div>
             </div>
          <div class="down_labels">
          <div class="name1">
               <h5>Contact:</h5><label><asp:Label ID="lblcntct" runat="server" /></label>
               </div>
               <div class="name1">
                 <h5>E-mail:</h5><label><asp:Label ID="lblmail" runat="server" /></label>
                 </div>
                 <div class="name1">
                   <h5>Educational Qualification:</h5><label><asp:Label ID="lbleducational_q" runat="server" /></label>
                   </div>
                   <div class="name1">
                 <h5>Profession:</h5><label><asp:Label ID="lblprofession" runat="server" /></label>
                 </div>
                 <div class="name1">
               <h5>Permanent Address:</h5><label><asp:Label ID="lblp_address" runat="server" /></label>
               </div>
               <div class="name1">
             <h5>Present Address:</h5><label><asp:Label ID="lblpresent_address" runat="server" /></label>
             </div>
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
                	<label class="user_outr">Hi User,</label>
                	<input type="button" class="btn btn_home" value="Home" />
                    <input type="button" class="btn btn_home" value="Logout" />
                   
                </div>
                 <div class="solve_issue_container">
                 	<div class="issue_constituency">
                    	<label class="num1"> <asp:Label ID="lblissuesno" runat="server"/> </label> <h4> Issues in your Constituency</h4>
                    </div>
                    <div class="issue_constituency">
                    	<label class="num1"><asp:Label ID="lblsolvedissuesno" runat="server"/></label> <h4> Issues Solved</h4>
                    </div>
                 </div>
              </div>

      <%-- Issues start--%>
             <div class="random_issue">
 <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>
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
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional"><ContentTemplate>  
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
                        <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional"><ContentTemplate>
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
     		   <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional"><ContentTemplate>     
                          <div class="user_outer">
                                <asp:Repeater runat="server" ID="ListComments" OnItemCommand="ListComments_ItemCommand" OnItemDataBound="ListComments_ItemDataBound" > <ItemTemplate>     
                                 <div class="img_outer">
                              <asp:Image ID="Image1" runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem,"profilePic") %>'/>
                          </div>	
                                      <div class="comm_section">
                                    <div class="name_label">
                                       <asp:Label ID="Label1" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"firstName") + " " %> '/><asp:Label ID="Label2" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"lastName") %>'/> 
                                     </div>
                             <div class="date_label">
                                 <asp:Label ID="Label3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"postedOn","{0:d/MMM/yyyy hh:mm tt}") %>'/>
                               </div>
                       <div class="comment_label">
                           <asp:Label ID="Label4" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"comment") %>'/>
                         </div>
                      </div>
                    <asp:HiddenField runat="server" ID="HFcommentId" Value='<%# DataBinder.Eval(Container.DataItem,"commentId") %>' />
                     <asp:UpdatePanel ID="UpdatePanel6" runat="server" UpdateMode="Conditional"><ContentTemplate>
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
 </asp:UpdatePanel> 
               </div>
           
            <%-- Issues end--%>
     
  
               
               
               
     </div>
         
   </div>
   </div>
  </form>
</body>

</html>
