namespace Velzon.Webs.Models
{
    public class SecuritySettings
    {
        public string[] CorsOrigins { get; set; } = Array.Empty<string>();
        public string[] CspOrigins { get; set; } = Array.Empty<string>();
    }

}
