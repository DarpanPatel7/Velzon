using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Common
{
    public class ValidationType
    {
        public string FieldName { get; set; }

        public string? FieldType { get; set; }

        public string? StrTypeMessage { get; set; }

        public string? RegExVAlidation { get; set; }

        public string? StrRegExMessage { get; set; }

        public bool IsRequired { get; set; } = false;

        public bool IsFormClickTab { get; set; } = false;

        public long? CharacterMinLength { get; set; }

        public long? CharacterMaxLength { get; set; }

        public string? StrMessage { get; set; }

        public long? TabNumber { get; set; }

        public long? TotalTabNumber { get; set; }

        public string? strTabName { get; set; }

        public string? FrontFormName { get; set; }

        public string? BackEndFormName { get; set; }

    }
}
