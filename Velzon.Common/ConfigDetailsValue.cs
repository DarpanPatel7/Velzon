using System;
using System.Collections.Generic;
using System.Linq;
using Velzon.Model.Service;
using System.Threading.Tasks;

namespace Velzon.Common
{
    
    public class ConfigDetailsValue
    {
        private static T GetFromTable<T>(string key)
        {
            object obj ;
            try
            {
                var configDetailsModel = new ConfigDetailsModel();
                DapperConnection dapperConnection = new DapperConnection();
                {
                    Dictionary<string, object> dictionary = new Dictionary<string, object>();
                    dictionary.Add("ParameterNames", key);

                    ConfigDetailsModel objConfigDetailsModel = dapperConnection.GetListResult<ConfigDetailsModel>("cmsGetConfigdetailsByName", System.Data.CommandType.StoredProcedure, dictionary).FirstOrDefault();
                    if (objConfigDetailsModel != null)
                    {
                        obj = (objConfigDetailsModel.ParameterValue == null ? "" : objConfigDetailsModel.ParameterValue).ToString();
                        return (T)obj;
                    }
                    else
                    {
                        obj = ("DataNotFound" + "|" + false).ToString();
                        return (T)obj;
                    }
                }
            }catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), "ConfigDetailsValue", "GetFromTable", ("Key " + key + " Details have Issue In Parse"));
                obj = ("Key " + key + " Details have Issue In Parse");
                return (T)obj;
            }

        }

        #region Email SMTP

        public static string SMTPServer
        {
            get
            {
                return GetFromTable<string>("SMTPServer");
            }
        }

        public static string AnswerKeyResentationURL
        {
            get
            {
                return GetFromTable<string>("AnswerKeyResentationURL");
            }
        }

        public static string SMTPPort
        {
            get
            {
                return GetFromTable<string>("SMTPPort");
            }
        }

        public static string SMTPAccount
        {
            get
            {
                return GetFromTable<string>("SMTPAccount");
            }
        }

        public static string SMTPPassword
        {
            get
            {
                return GetFromTable<string>("SMTPPassword");
            }
        }

        public static string SMTPFromEmail
        {
            get
            {
                return GetFromTable<string>("SMTPFromEmail");
            }
        }

        public static string SMTPIsSecure
        {
            get
            {
                return GetFromTable<string>("SMTPIsSecure");
            }
        }

        public static string Email
        {
            get
            {
                return GetFromTable<string>("Email");
            }
        }

        public static string SMTPIsTest
        {
            get
            {
                return GetFromTable<string>("SMTPIsTest");
            }
        }

        public static string TestSMTPServer
        {
            get
            {
                return GetFromTable<string>("TestSMTPServer");
            }
        }

        public static string TestSMTPPort
        {
            get
            {
                return GetFromTable<string>("TestSMTPPort");
            }
        }

        public static string TestSMTPAccount
        {
            get
            {
                return GetFromTable<string>("TestSMTPAccount");
            }
        }

        public static string TestSMTPPassword
        {
            get
            {
                return GetFromTable<string>("TestSMTPPassword");
            }
        }

        public static string TestSMTPFromEmail
        {
            get
            {
                return GetFromTable<string>("TestSMTPFromEmail");
            }
        }

        public static string TestSMTPIsSecure
        {
            get
            {
                return GetFromTable<string>("TestSMTPIsSecure");
            }
        }

        #endregion

        #region CouchDB

        public static bool AllowCouchDBStore
        {
            get
            {
                var data = GetFromTable<string>("AllowCouchDBStore");
                if(data == null || string.IsNullOrWhiteSpace(data))
                {
                    return false;
                }
                else
                {
                    return GetFromTable<string>("AllowCouchDBStore") == "1" ? true : false;
                }
            }
        }

        public static string CouchDBURL
        {
            get
            {
                return GetFromTable<string>("CouchDBURL");
            }
        }

        public static string CouchDBDbName
        {
            get
            {
                return GetFromTable<string>("CouchDBDbName");
            }
        }
        public static string CouchDBUser
        {
            get
            {
                return GetFromTable<string>("CouchDBUser");
            }
        }

        #endregion

        #region Pagination

        public static string UpcommingEventPerPage
        {
            get
            {
                return GetFromTable<string>("UpcommingEventPerPage");
            }
        }

        public static string PastEventPerPage
        {
            get
            {
                return GetFromTable<string>("PastEventPerPage");
            }
        }

        public static string GovernmentResolutionPerPage
        {
            get
            {
                return GetFromTable<string>("GovernmentResolutionPerPage");
            }
        }

        public static string NotificationCircularPerPage
        {
            get
            {
                return GetFromTable<string>("NotificationCircularPerPage");
            }
        }
        public static string TenderPerPage
        {
            get
            {
                return GetFromTable<string>("TenderPerPage");
            }
        }

        public static string NewsPerPage
        {
            get
            {
                return GetFromTable<string>("NewsPerPage");
            }
        }

        public static string RightToInformationPerPage
        {
            get
            {
                return GetFromTable<string>("RightToInformationPerPage");
            }
        }

        public static string ActAndRulePerPage
        {
            get
            {
                return GetFromTable<string>("ActAndRulePerPage");
            }
        }

        public static string DownloadPerPage
        {
            get
            {
                return GetFromTable<string>("DownloadPerPage");
            }
        }

        public static string OtherPerPage
        {
            get
            {
                return GetFromTable<string>("OtherPerPage");
            }
        }

        public static string PhotoGalleryPerPage
        {
            get
            {
                return GetFromTable<string>("PhotoGalleryPerPage");
            }
        }
        public static string ProjectsPerPage
        {
            get
            {
                return GetFromTable<string>("ProjectsPerPage");
            }
        }

        public static string VideoGalleryPerPage
        {
            get
            {
                return GetFromTable<string>("VideoGalleryPerPage");
            }
        }

        #endregion

        #region SuperAdmin

        public static string SuperAdminRoleId
        {
            get
            {
                return GetFromTable<string>("SuperAdminRoleId");
            }
        }

        #endregion

        #region Login

        public static string WrongLoginAttemtLimit
        {
            get
            {
                return GetFromTable<string>("WrongLoginAttemtLimit");
            }
        }

        public static string IntervalWrongAttemptInMinutes
        {
            get
            {
                return GetFromTable<string>("IntervalWrongAttemptInMinutes");
            }
        }

        #endregion

    }
}
