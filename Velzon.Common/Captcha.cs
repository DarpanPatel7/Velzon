using Velzon.Webs.Models;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Common
{
    public class Captcha
    {
        public static string GenerateCaptchaCode(HttpContext http)
        {
            lable: Random random = new Random();

            string randomStr = "";

            string combination = "0123456789ABCDEFGHJKLMNOPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
            Random r = new Random();

            int a = r.Next(11, 99);
            int b = r.Next(11, 99);

            int c = a + b;

            randomStr = a.ToString() + " + " + b.ToString() + " = ";

            string strName = "CaptchaCode";
            StringBuilder captcha = new StringBuilder();
            for (int i = 0; i < 6; i++)
            {
                captcha.Append(combination[random.Next(combination.Length)]);
            }
            {

                if (http.Session.GetString("pastcaptcha") != null)
                {
                    if (http.Session.GetString("pastcaptcha").ToString() == c.ToString())
                    {
                        goto lable;
                    }
                }

                http.Session.SetString("CaptchaCode", captcha.ToString());
                http.Session.SetString("pastcaptcha", captcha.ToString());
            }
            return captcha.ToString();
        }


        public static bool ValidateCaptchaCode(string userInputCaptcha, HttpContext context)
        {
            ErrorLogger.Trace("userInputCaptcha=> "+ userInputCaptcha+ " \n\r CaptchaCode=>" + context.Session.GetString("CaptchaCode"), "");
            var isValid = userInputCaptcha == context.Session.GetString("CaptchaCode");
            return isValid;
        }

        public static bool ValidateFeedbackCaptchaCode(string userInputCaptcha, string strSessionname, HttpContext context)
        {
            ErrorLogger.Trace("userInputCaptcha=> " + userInputCaptcha + " CaptchaCode=>" + context.Session.GetString(strSessionname), "");
            var isValid = userInputCaptcha == context.Session.GetString(strSessionname);
            return isValid;
        }
        public static CaptchaResult GenerateCaptchaImage(int width, int height, string captchaCode)
        {
            using (Bitmap baseMap = new Bitmap(width, height))
            using (Graphics graph = Graphics.FromImage(baseMap))
            {
                Bitmap bmp = new Bitmap(width, height);

                RectangleF rectf = new RectangleF(10, 5, 0, 0);

                Graphics g = Graphics.FromImage(bmp);

                g.Clear(Color.White);

                g.SmoothingMode = SmoothingMode.AntiAlias;

                g.InterpolationMode = InterpolationMode.HighQualityBicubic;

                g.PixelOffsetMode = PixelOffsetMode.HighQuality;

                g.DrawString(captchaCode, new Font("Thaoma", 20, FontStyle.Bold), Brushes.Chocolate, rectf);

                g.DrawRectangle(new Pen(Color.Blue), 1, 1, width - 2, height - 2);
                MemoryStream ms = new MemoryStream();

                bmp.Save(ms, ImageFormat.Png);

                ErrorLogger.Trace("Generate CaptchaCode=> " + captchaCode, "");

                return new CaptchaResult { CaptchaCode = captchaCode, CaptchaByteData = ms.ToArray(), Timestamp = DateTime.Now };
            }
        }
    }
}
