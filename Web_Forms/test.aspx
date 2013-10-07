<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="rateMyMp_Web_Forms_test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
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

        }

    </script> 

    <!-- script to logout from facebook session -->
   <script type="text/javascript" src="/JS/fb.js"></script>
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

            $("#Button2").click(function () {
                alert("kamal");
                FB.logout(function () {
                    window.location.reload();
                    document.location.href = "../Default.aspx";

                });
            });

        }

    </script>
    <script>
        function hidefacebook()
        {
            document.getElementById('Button2').style.display = 'none';
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        &nbsp;Comming Soon.........<br />
        <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Button" />
        <br />
        <asp:Button ID="Button1" runat="server" Text="google logout" OnClick="Button1_Click" Visible="False" />
    &nbsp;
        <input id="Button2" type="button"  value="facebook logout" />
        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="local user logout" Visible="False" /><br />

        </div>
        <asp:HiddenField ID="HiddenField1" runat="server" />
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <br />
        <br />
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