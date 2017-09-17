using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class QuenMatKhau : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static bool goiLaiMatKhau(string Email)
    {
        ToolsDT tools = new ToolsDT();
        int temp;
        string password = tools.CreateLostPassword(8);
        temp = tools.goiLaiMatKhau(Email, tools.EnCrypt(password, "bikha"));
        if (temp > 0)
        {
            using (MailMessage mail = new MailMessage())
            {
                mail.From = new MailAddress("doduckha9d@gmail.com");
                mail.To.Add(""+Email+"");
                mail.Subject = "Mật khẩu mới từ BiKha Mobile";
                mail.Body = "<h1>Chào bạn,</h1> \n Mật khẩu mới của bạn là: " +password+ "";
                mail.IsBodyHtml = true;

                using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
                {
                    smtp.Credentials = new NetworkCredential("doduckha9d@gmail.com", "nguoidien");
                    smtp.EnableSsl = true;
                    smtp.Send(mail);
                }
            }
            return true;
        }
        else return false;
        
    }
}