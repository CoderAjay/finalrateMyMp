<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!doctype html>
<html>
    
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta charset="utf-8">
<title>Welcome to Rate My MP</title>
<link rel="stylesheet" type="text/css" href="CSS/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="CSS/bootstrap-responsive.min.css" />
<link rel="stylesheet" type="text/css" href="CSS/style.css" />
<%--<script type="text/javascript" src="JS/jquery.js"></script>--%>
    <script type="text/javascript" src="JS/jquery-1.9.1.js"></script>
<script type="text/javascript" src="JS/bootstrap.min.js"></script>
 <!--google analytics tool script -->
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

      <script src="https://apis.google.com/js/client.js"></script>
      
      <!-- this is a script for google login -->
<script type="text/javascript">
    (function () {
        var po = document.createElement('script');
        po.type = 'text/javascript';
        po.async = true;
        po.src = 'https://apis.google.com/js/client:plusone.js?onload=render';
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(po, s);
    })();

    function render() {
        gapi.signin.render('googlesignup', {
            'callback': 'signinCallback',
            'approvalprompt': 'force',
            'clientid': '724686509082.apps.googleusercontent.com',
            'cookiepolicy': 'single_host_origin',
            'height': 'short',
            'requestvisibleactions': 'http://schemas.google.com/AddActivity',
            'scope': 'https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile'
        });
    }

    function signinCallback(authResult) {
        if (authResult) {
            if (authResult['access_token']) {
                // Successfully authorized
                // Hide the sign-in button now that the user is authorized, for example:
                gapi.auth.setToken(authResult);
                // document.getElementById('customBtn').setAttribute('style', 'display: none');
                // document.getElementById('logout').setAttribute('style', 'display: block');
                getemail();

            }
            else if (authResult['error']) {
                // There was an error.

            }
        }
    }
    function getemail() {

        gapi.client.load('oauth2', 'v2', function () {

            var request = gapi.client.oauth2.userinfo.get();

            request.execute(getEmailCallback);
        });

        // this is used for image also. 

        // gapi.client.load('plus', 'v1', function () {
        //    var request = gapi.client.plus.people.get({
        //        'userId': 'me'
        //    });
        //    request.execute(function (resp) {
        //        // console.log('Retrieved profile for:' + resp.displayName);
        //        alert(resp.displayName);
        //        // alert(resp.email);
        //       // alert(Object.keys(resp));
        //    });
        //});

    }

    function getEmailCallback(obj) {
        //alert(Object.keys(obj));
        // Here obj stores data in json format
        var picture = obj['picture'];
        //alert(picture);
        var email = '';
        var name = '';
        if (obj['email']) {

            email = obj['email'];
        }

        if (obj['name']) {

            name = obj['name'];
        }
        var socialtype = "GOOGLE";
        var social = "yes";
        document.location.href = "Web_Forms/homepage.aspx?email=" + email + "&name=" + name + "&social=" + social + "&socialType=" + socialtype + "&image=" + picture;
       // document.location.href = "Web_Forms/test.aspx?email=" + email + "&name=" + name + "&social=" + social + "&socialType=" + socialtype  + "&image=" + picture;
    }
  </script>
      
        <script>

            function userCreated() {
                alert("Your account is successfully created ");
                document.location.href = "Web_Forms/Homepage.aspx";
            }

            function userUpdated() {
                alert("Your account is successfully Updated ");
                document.location.href = "Web_Forms/Homepage.aspx";
            }

            function userNotCreated() {
                alert("Sorry this account already exists.");

            }

            function WrongCredential() {
                alert("Please give your right Credentials.");

            }
            function rightCredential() {
                document.location.href = "Web_Forms/Homepage.aspx";
                // document.location.href = "Web_Forms/test.aspx";
            }

          

            function wrongCredential() {
                $("#<%= txtPasscode.ClientID %>").val("");
                $("#<%= txtPassword.ClientID %>").val("");
                $("#<%= txtCPassword.ClientID %>").val("");
                $("#<%= signinemail.ClientID %>").val("");
                alert("Please enter the right passcode and password.");
            }

            function passwordUpdated() {
                alert("Password Successfully Updated. ");
                // setTimeout("redirect()", 3000); // cal the redirect function after 3 seconds
                $("#<%= txtPasscode.ClientID %>").val("");
                $("#<%= txtPassword.ClientID %>").val("");
                $("#<%= txtCPassword.ClientID %>").val("");
                $("#<%= signinemail.ClientID %>").val("");
               // $("#win-forgot").slideUp(500);
            }

            function validateUpdatePassword() {
                var xx = $("#<%= txtPassword.ClientID %>").val();
                var yy = $("#<%= txtCPassword.ClientID %>").val();
                var zz = $("#<%= txtPasscode.ClientID %>").val();

                if (xx !== '' && yy != '' && zz != '') {

                    if (xx.length < 8 || yy.length < 8 || zz.length <8) {

                        alert("Password  and passcode Must Contain at least 8 character");
                        return false;
                    }
                    else {
                        if (xx == yy) {
                            return true;
                        }
                        else {
                            alert("Password and confirm password must be same.");
                            return false;
                        }

                    }
                }
                else {
                    alert("Please fillup all the fields");
                    return false;
                }
                    
            }


            function signinValueCheck() {
                var email = $("#<%= signinemail.ClientID %>").val();
                var password = $("#<%= signinPassword.ClientID %>").val();
                if (email == "" || password == ""||password.length<8) {
                    alert("Please fillup email and Password having  at least 8 character.");
                    return false;
                }
                else {
                    return true;
                }

            }

            function signupValueCheck() {
                var email = $("#<%= email.ClientID %>").val();
                var password = $("#<%= password.ClientID %>").val();
                var lastName = $("#<%= lastName.ClientID %>").val();
                var firstName = $("#<%= firstName.ClientID %>").val();
                if (email == "" || password == "" || lastName == "" || firstName == ""|| password.length<8) {
                    alert("Please fillup all the field and password having at least 8 character.");
                    return false;
                }
                else {
                    return true;
                }
            }

        </script>

  <script>
 
      function email()
      {
          var emailID = $('#signinemail').val();
          if (emailID == '')
          {
              alert("Please Enter email");
              $("#forgotlink").attr('href', "#");
              return false;   
          }
          else
          {
              //PageMethods.generatePasscode(emailID);
              //$("#forgotlink").attr('href', "#forgot");
             
              return PageMethods.generatePasscode(emailID, function (result) {

                  if (result == "showdivs")
                  {
                      alert("Please use recent passcode  given in your email to  reset new password yourself");
                      $("#forgotlink").attr('href', "#forgot");

                  }
                  else if(result=="invalidEmails")
                  {

                      $("#forgotlink").attr('href', "#");
                      //alert("angel");
                  }
                  else if (result == "enterEmail")
                  {
                      $("#forgotlink").attr('href', "#");
                      //alert("pathak");
                    }
              });
          }
      }
</script>
</head>
<body>
<!-- Forgot Password Modal Starts-->
     <form id="form1" runat="server">
<section id="forgot" class="modal hide fade">
    <header class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h3>Forgot Password?</h3>
    </header>
    <div id="kp" class="modal-body">
        <h4>Enter Code and Reset Password</h4>
        <p>
        <div id="login">
        	<table align="center">
           		<tr>
                	<td>CODE</td>
                    <td>
                        <%--<input type="text" required="true">--%>
                         <asp:TextBox ID="txtPasscode"  placeholder="Passcode" runat="server" MaxLength="8" TextMode="Password" ></asp:TextBox>
                    </td>
                </tr>
            	<tr>
                	<td>NEW PASSWORD</td>
                    <td>
                        <%--<input type="email" required="true">--%>
                         <asp:TextBox ID="txtPassword"  placeholder="New Password" runat="server" TextMode="Password" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>CONFIRM PASSWORD</td>
                    <td>
                        <%--<input type="password" required="true">--%>
                        <asp:TextBox ID="txtCPassword"  placeholder="Confirm Password" runat="server" TextMode="Password" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                   	<td colspan="2"><center>
                           <%--<button class="btn btn-primary" >SUBMIT</button>--%>
                           <asp:LinkButton ID="PasswordUpdate" class="btn btn-primary" runat="server" OnClick="PasswordUpdate_Click" Height="23px" Width="60px">Update</asp:LinkButton>
                   	                </center></td>
                </tr>  
			</table>
		</div>
        </p>  
    </div>
    <footer class="modal-footer">
	    <%--<button class="btn btn-primary" data-dismiss="modal">CANCEL</button>--%>
         <button class="btn btn-primary" id="forgot-cancel">Cancel</button>
    </footer>
</section>
<!-- Forgot Password Modal Ends-->

<!-- Main Container Starts-->
<section class="container-fluid padding0">

	<!-- Header Starts-->
	<section class="row-fluid">
    	<header class="span12 bgcolor-navyblue">
        	<span class="pull-right  padding-bottom20 mg-top10 bgcolor-navyblue mg-right40">
				<%--<button class="btn"><b>LOGIN</b></button>--%>
                 <asp:LinkButton ID="btnSingin" class="btn" runat="server" OnClick="btnSingin_Click" TabIndex="2">Login</asp:LinkButton>
            </span>
            
            <span class="pull-right mg-top10 bgcolor-navyblue mg-right58">
            	<table class="pull-right color-white span12">
                  	<tr>
                       	<td><%--<input type="text"  placeholder="Email" class="input-large"/>--%>
                            <asp:TextBox ID="signinemail" class="input-large" placeholder="email" runat="server" TextMode="Email" MaxLength="49"></asp:TextBox>
                       <asp:RegularExpressionValidator ID="signinEmailValidation"  runat="server" ErrorMessage="Please enter valid email id" ControlToValidate="signinemail" ForeColor="#FF0066" SetFocusOnError="True" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>  
                           </td>
                        <td><%--<input type="password"  placeholder="Password" class="input-large"/>--%>
                            <asp:TextBox ID="signinPassword"  class="input-large mg-left8" placeholder="password" runat="server" TextMode="Password" MaxLength="49" TabIndex="1"></asp:TextBox>
                        
                        </td>
                	</tr>
             	   	<tr>
                      	<td><asp:CheckBox ID="chkRememberMe" Class="chckpad-right4" runat="server" TabIndex="3" />Remember me</td>
                        <td>
                           <!-- <a  id="kkk" href="#forgot" data-toggle="modal" onclick="email()" class="color-white">Forgot Password?</a> -->
                            <a  id="forgotlink" href="#" data-toggle="modal" onclick="email()" class="color-white mg-left8">Forgot Password?</a>
                            <%--<asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>--%>
                            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" EnablePageMethods="true"></asp:ScriptManager>
                        </td>
                    </tr>
            	</table>
            </span> 
		</header>
	</section>
	<!-- Header Starts-->

	<!-- Middle Starts-->
    <section class="row-fluid">
    	<section class="span12">
        	<aside class="span7 mg-top40">
            	<span class="thumbnails">
                	<span class="thumbnail offset2 span7 padding-bottom60 padding-top40">
                    	<img src="images/rpm1.png" />
					</span>
              	</span>
         	</aside>
        	<article class="span5 mg-top40 pull-right mg-bottom40">
           	
            	<table class="pull-right padding-top50 span12">
                  	<tr>
                       	<td>
                                <div id="fb-root"></div> 
                                    <script type="text/javascript" src="JS/fb.js"></script>
                                    <script src="http://connect.facebook.net/en_US/all.js" type="text/javascript"></script>
                               
      <script>

          // Init the SDK upon load
          window.fbAsyncInit = function () {
              FB.init({
                  appId: '158860384321647', // App ID  214812398681584
                  channelUrl: '//' + window.location.hostname + '/channel', // Path to your Channel File
                  status: true, // check login status
                  cookie: true, // enable cookies to allow the server to access the session
                  xfbml: true  // parse XFBML

              });
          };

          // Load the SDK Asynchronously

          (function (d) {
              var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
              if (d.getElementById(id)) { return; }
              js = d.createElement('script'); js.id = id; js.async = true;
              js.src = "//connect.facebook.net/en_US/all.js";
              ref.parentNode.insertBefore(js, ref);
          }(document));


          function login() {

              FB.login(function (response) {
                  // if (response.authResponse) {
                  //'/me',
                  FB.api('/me', function (response) {
                      if (response.name) {
                          //alert(Object.keys(response));

                          var picture = "http://graph.facebook.com/" + response.id + "/picture";
                          var name = "";
                          var email = "";
                          var social = "yes";

                          var socialtype = "FACEBOOK";
                          name = response.name;
                          email = response.email;
                          // alert(email);
                          // username = response.username 
                          if (email == undefined) {
                              alert("Please allow access to email.");
                              FB.logout(function () {
                                  window.location.reload();
                                  document.location.href = "Default.aspx";
                              });
                          }
                          else {
                              // alert(email);
                              document.location.href = "Web_Forms/homepage.aspx?email=" + email + "&name=" + name + "&social=" + social + "&socialType=" + socialtype + "&image=" + picture;

                              //document.location.href = "Web_Forms/test.aspx?email=" + email + "&name=" + name + "&social=" + social + "&socialType=" + socialtype + "&image=" + picture;
                              // document.location.href = "test.aspx?emailsval=" + email + "&nameval=" + name + "&socialornot=" + social + "&socialtype=" + socialtype;
                          }
                      }
                      // }

                  })

              }, { scope: 'email' });
          }
          </script>
                               <div  id="facebooksingup" class="btn btn-primary btn-large padding-left68 padding-right68" onclick="login()"><img src="images/facebook-btn.png" /><b>Sign Up With Facebook</b></div>

                       	</td>
                    </tr>
                    <tr>
                      	<td><div id="googlesignup" class="btn btn-danger mg-top10 btn-large padding-left75 padding-right86"><img src="images/google-btn.png" /><b>Sign Up With Google</b></div>

                      	</td>
                    </tr>
                    <tr>
                      	<td><div class="mg-top10"><center><h4>OR</h4></center> <center>create a Rate My MP account below</center></div></td>
                	</tr>
          		</table>
      		
                <table class="pull-right mg-top10 padding-bottom20 span12">
        
                  	<tr>
                       	<td>
                               <%--<input type="text"  placeholder="First Name" class="input-large"/>--%>
                                <asp:TextBox ID="firstName" class="input-large" placeholder="First Name" runat="server" MaxLength="49" TabIndex="8"></asp:TextBox>
                       	</td>
                        <td>
                            <%--<input type="text" placeholder="Last Name" class="input-large"/>--%>
                            <asp:TextBox ID="lastName" class="input-large" placeholder="Last Name" runat="server" TabIndex="9"></asp:TextBox>
                        </td>
                	</tr>
             	   	
                    <tr>
                       	<td>
                               <%--<input type="text" placeholder="Email" class="input-large"/>--%>
                               <asp:TextBox ID="email" class="input-large" placeholder="Email" runat="server" MaxLength="49" TabIndex="10" TextMode="Email"></asp:TextBox>
                       	 
                           </td>
                        <td>
                            <%--<input type="password" placeholder="Password" class="input-large"/>--%>
                             <asp:TextBox  ID="password" class="input-large" placeholder="Password" runat="server" MaxLength="49" TabIndex="11" TextMode="Password"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <asp:RegularExpressionValidator ID="signupEmailValidation" runat="server" ErrorMessage="Enter valid email " ControlToValidate="email" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" SetFocusOnError="True"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                      	<td colspan="2">
                              <%--<button class="btn btn-success bgcolor-navyblue slowtrasition btn-large padding-left100 padding-right100"><b>Sign Up</b><img src="images/arrow.png" /></button>--%>
                                 <asp:LinkButton ID="btnSignup" class="btn btn-success bgcolor-navyblue slowtrasition btn-large padding-left100 padding-right100" runat="server"  OnClick="btnSignup_Click" TabIndex="12"><b>Sign Up</b><img src="images/arrow.png" /></asp:LinkButton>
                      	</td>
                    </tr>
            	</table>
    		</article>
		</section>
	</section>
   	<!-- Middle Ends-->
    
   	<!-- Footer Starts-->    
	<section class="row-fluid">
       	<footer class="span12 bgcolor-navyblue">
           	<nav class="nav">
               	<ul class="nav nav-tabs padding-top20 span3 bottom-border-none mg-left10">
                   	<li><a href="#" class="transition color-white">About Us</a></li>
                   	<li><a href="#" class="transition color-white">Our Mission</a></li>
                   	<li><a href="#" class="transition color-white">Contact Us</a></li>
    	         </ul>
        	     <span class="pull-left mg-right40 padding-top15 mg-top15 bgcolor-navyblue padding-top15  padding-left50 padding-right50">
                 	<span class="color-white mg-top50 padding-top20">&copy; 2013 Rate My MP | <a href="#" class="color-white">Terms & Privacy</a></span>	
                 </span>
                    
                 <span class="pull-right mg-right40 padding-top15 bgcolor-navyblue padding-top15  ">
                    	<span class=""><a href="https://facebook.com"><img src="images/facebook-square.png" /></a></span>
                       	<span class=""><a href="https://gmail.com" ><img src="images/google-square.png" /></a></span>
                       	<span class=""><a href="https://twitter.com"><img src="images/twitter-square.png" /></a></span> 
                 </span>
                    <!--<span class="span10 offset1">
                    	<span class="color-white">&copy; 2013 Rate My MP | <a href="#" class="color-white">Terms & Privacy</a></span>
                    </span>-->
                
			</nav>
   		</footer>
 	</section>	
   	<!-- Footer Ends-->
  <asp:HiddenField ID="HiddenField1" runat="server" />  
    <asp:HiddenField ID="HiddenField2" runat="server" />
</section>
<!-- Main Container Endss-->
</form>
    
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
