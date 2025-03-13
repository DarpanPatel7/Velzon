namespace Velzon.Webs.Areas.Admin.Models
{
    public class ChangeSMTPModel
    {
        public string TestSentEmail { get; set; }

        public string SMTPServer { get; set; }
        public bool SMTPPortNull { get; set; }
        public string SMTPPort { get; set; }
        public string? SMTPAccount { get; set; }
        public string? SMTPPassword { get; set; }
        public string SMTPFromEmail { get; set; }
        public bool SMTPIsTestNull { get; set; }
        public bool  SMTPIsSecure { get; set; }

        public bool SMTPIsTest { get; set; }

        public string TestSMTPServer { get; set; }
        public bool TestSMTPPortNull { get; set; }
        public string TestSMTPPort { get; set; }
        public string? TestSMTPAccount { get; set; }
        public string? TestSMTPPassword { get; set; }
        public string TestSMTPFromEmail { get; set; }
        public bool TestSMTPIsTestNull { get; set; }
        public bool  TestSMTPIsSecure { get; set; }
    }
    public class SMTPEmailModel
    {
        public string TestSentEmail { get; set; }
        public bool IsTest { get; set; } = false;
    }
    public class SMTPEmailEnvoiromentModel
    {
        public bool SMTPIsTest { get; set; }
    }
    public class ChangeSMTPFormModel
    {

        public string SMTPServer { get; set; }
        public bool SMTPPortNull { get; set; }
        public string? SMTPPort { get; set; }
        public string? SMTPAccount { get; set; }
        public string? SMTPPassword { get; set; }
        public string SMTPFromEmail { get; set; }
        public bool? SMTPIsSecure { get; set; }
        public bool SMTPIsTestNull { get; set; }

        public bool SMTPIsTest { get; set; }

        public string TestSMTPServer { get; set; }
        public bool TestSMTPPortNull { get; set; }
        public string? TestSMTPPort { get; set; }
        public string? TestSMTPAccount { get; set; }
        public string? TestSMTPPassword { get; set; }
        public string TestSMTPFromEmail { get; set; }
        public bool TestSMTPIsTestNull { get; set; }
        public bool? TestSMTPIsSecure { get; set; }
    }

}
