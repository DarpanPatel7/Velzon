namespace Velzon.Model.System
{
    public class FileDownloadModel
    {
        public string Filename { get; set; }
        public string FileExtension { get; set; }
        public byte[] DataBytes { get; set; }
    }
}
