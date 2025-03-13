using Velzon.Common;
using Velzon.Model.CouchDB;
using Velzon.Webs.Controllers;
using Velzon.Webs.Filters;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class CounchDBController : BaseController<CounchDBController>
    {
        #region Controller Variable

        private IHttpClientFactory httpClientFactory { get; set; }
        private CoutchDBFileManagement fileManagement { get; set; }

        //private IAdminMenuMasterService objAdminMenuMasterService { get; set; }

        //private IMenuResourceMasterService objMenuResourceMasterService { get; set; }

        #endregion

        #region Controller Constructor

        public CounchDBController(IHttpClientFactory _httpClientFactory)
        {
            this.httpClientFactory = _httpClientFactory;
            this.fileManagement=new CoutchDBFileManagement(_httpClientFactory);
        }

        #endregion

        #region Public Methods

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/CouchDB/Index")]
        public async Task<IActionResult> Index()
        {
            GetCouchDBAttachments getInfo = new GetCouchDBAttachments();

            var findResult = await fileManagement.FindAttachments();

            if (findResult.IsSuccess && findResult.Result != null)
            {
                getInfo = JsonConvert.DeserializeObject<GetCouchDBAttachments>(findResult.Result);

            }
            return View(getInfo.Docs);
        }

        [Route("/Admin/CouchDB/SaveAttachment")]
        [HttpPost]
        public async Task<IActionResult> SaveAttachment([FromForm] SaveCouchDBAttachment attachment)
        {
            if (attachment.Id == null)
            {
                // Insert new attachment
                if (attachment == null || attachment.File.Length == 0)
                {

                    Functions.MessagePopup(this, "file not selected", Model.System.PopupMessageType.error);
                    return View();

                }

                var ms = new MemoryStream();
                attachment.File.OpenReadStream().CopyTo(ms);
                byte[] fileBytes = ms.ToArray();

                attachment.FileName = attachment.File.FileName;
                attachment.AttachmentData = fileBytes;
                attachment.FileExtension = System.IO.Path.GetExtension(attachment.File.FileName).Replace(".", "").ToUpper();
                var result = await fileManagement.AddAttachment(attachment);
                if (result.IsSuccess)
                {
                    Functions.MessagePopup(this, "File Uploaded Successfully.", Model.System.PopupMessageType.success);
                    return Redirect(Url.Content("~/Admin/CouchDB/Index"));
                }
                else
                {
                    Functions.MessagePopup(this, "File not Uploaded.", Model.System.PopupMessageType.success);
                }
            }
            else
            {
                // Update existing attachment
                var docData = await fileManagement.GetAttachmentByteArray(attachment.Id, attachment.FileName);
                var ms = new MemoryStream();
                attachment.File.OpenReadStream().CopyTo(ms);
                byte[] fileBytes = ms.ToArray();

                attachment.FileName = attachment.File.FileName;
                attachment.AttachmentData = fileBytes;
                var result = await fileManagement.UpdateAttachment(attachment);
                if (result.IsSuccess)
                {
                    Functions.MessagePopup(this, "File Uploaded Updated Successfully.", Model.System.PopupMessageType.success);
                    return Redirect(Url.Content("~/Admin/CouchDB/Index"));
                }
                else
                {
                    Functions.MessagePopup(this, "File not Updated.", Model.System.PopupMessageType.success);
                }
            }

            return View();
        }

        public IActionResult AddAttachment()
        {
            return PartialView(Url.Content("~/Areas/Admin/Views/CounchDB/_GridEditPartial.cshtml"), new SaveCouchDBAttachment());
        }

        public async Task<IActionResult> EditAttachment(string id)
        {
            AttachmentInfo getInfo = new AttachmentInfo();

            var httpClientResponse = await fileManagement.GetDocumentAsync(id);
            if (httpClientResponse.IsSuccess && httpClientResponse.Result != null)
            {
                getInfo = JsonConvert.DeserializeObject<AttachmentInfo>(httpClientResponse.Result);

            }

            if (getInfo != null)
            {
                SaveCouchDBAttachment model = new SaveCouchDBAttachment();

                model.Id = getInfo.Id;
                model.Rev = getInfo.Rev;
                model.FileName = getInfo.FileName;
                model.FileExtension = getInfo.FileExtension;
                return PartialView("~/Areas/Admin/Views/CounchDB/_GridEditPartial.cshtml", model);
            }

            return View();
        }

        public async Task<IActionResult> DeleteAttachment(string id)
        {
            var httpClientResponse = await fileManagement.GetDocumentAsync(id);

            if (httpClientResponse.IsSuccess)
            {
                AttachmentInfo sResult = JsonConvert.DeserializeObject<AttachmentInfo>(httpClientResponse.Result);
                httpClientResponse = await fileManagement.DeleteDocumentAsync(id, sResult.Rev);
                if (httpClientResponse.IsSuccess)
                {
                    ViewBag.DeleteMessage = sResult.FileName + " deleted successfully!";
                    Functions.MessagePopup(this, sResult.FileName + " deleted successfully!", Model.System.PopupMessageType.success);
                    return Redirect("/Admin/CouchDB/Index");
                }
                else
                {
                    Functions.MessagePopup(this, "Failed to delete the file!", Model.System.PopupMessageType.error);
                }
            }
            return View();
        }

        public async Task<FileResult> DownloadFile(string id, string fileName)
        {
            var docData = await fileManagement.GetAttachmentByteArray(id, fileName);
            byte[] fileBytes = docData.Result;
            return File(fileBytes, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
        }


        #endregion


    }
}
