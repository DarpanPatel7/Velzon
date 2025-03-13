using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service;

public interface IProjectService : IDisposable
{
    JsonResponseModel AddOrUpdate(ProjectModel model);
    List<ProjectModel> GetList(long lgLangId = 1);
    ProjectModel Get(long id, long lgLangId = 1);

    JsonResponseModel Delete(long id, string username);
    JsonResponseModel SwapSequance(long rank, string dir, string username);
}

