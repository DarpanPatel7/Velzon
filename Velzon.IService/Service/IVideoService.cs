using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    // Retrieves a video model by its unique identifier.
    public interface IVideoService : IDisposable
    {
        // Retrieves a list of video models based language IDs.
        VideoModel Get(long i, long lgLangId);

        // Retrieves a list of video models for the front category based language IDs.
        List<VideoModel> GetList(long lgLang);

        // Retrieves a list of video models for the front category based language IDs.
        //List<VideoModel> GetListFront(long lgLangId);

        // Retrieves a list of video models for the front category based on domain and language IDs.
        List<VideoModel> GetFrontcategory(long languageID);

        // Retrieves a list of video models for the front category with detailed information.
        List<VideoModel> GetFrontcategoryDetails(long id, long languageid);

        // Retrieves a list of video models for the front category based on domain and language IDs.
        List<VideoModel> GetListFront(long lgLangId);

        // Deletes a video model by its unique identifier and returns the result.
        JsonResponseModel Delete(long id, string username);

        // Adds or updates a video model based on the provided model.
        JsonResponseModel AddOrUpdate(VideoModel model);

        JsonResponseModel UpdateStatus(long id, string username, int isActive = 0);
    }
}
