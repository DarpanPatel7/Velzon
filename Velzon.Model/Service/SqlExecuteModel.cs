using System.Data;

namespace Velzon.Model.Service
{
    public class SqlExecuteModel
    {
        public string SqlQuery { get; set; }
        public DataTable ReportResults { get; set; }
    }
}
