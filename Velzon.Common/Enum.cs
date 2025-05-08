using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Common
{
    public enum ValidationDataType
    {
        [Description(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$")]
        EmailId,

        [Description(@"^([0]|\+91)?[6,7,8,9]\d{9}$")]
        IndiaMobileNo,
        [Description(@"^(?=(?:\D*\d){10,12}\D*$)[0-9 \-()\\\/]{1,16}$")]
        FaxOrPhoneNo,
        [Description(@"^([a-zA-Z]|([^\u0000-\u0080]*[^\u0000-\u0080]*))+$")]
        LettersOnly,

        [Description(@"^([a-zA-Z ]|([^\u0000-\u0080]*[^\u0000-\u0080]*))+$")]
        LettersWithWhiteSpace,
        [Description(@"^([\w\-\.\,]|([^\u0000-\u0080]*[^\u0000-\u0080]*))+$")]
        AlphanumericOnly,
        [Description(@"^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$")]
        Url,

        [Description(@"^([\w ]|([^\u0000-\u0080]+\s*[^\u0000-\u0080]+\s*))+$")]
        AlphanumericSpace,
        [Description(@"^(?=[a-zA-Z0-9[()_\.,/]]*$)")]
        Alphanumericslash,
        [Description(@"^[a-zA-Z0-9]|([^\u0000-\u0080]*[^\u0000-\u0080]*)[\w\d\s-()_,./\\]*$")]
        TitleString,
        
        [Description(@"^[0-9]*$")]
        NumberOnly,
        [Description(@"^([0-9]*\.?[0-9]*)$")]
        DecimalOnly,
        [Description(@"^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$")]
        GSTNumber,
        [Description(@"[A-Z]{5}[0-9]{4}[A-Z]{1}")]
        PANNumber,
        [Description(@"^[A-Z]{4}0[A-Z0-9]{6}$")]
        IFSCCode,
        [Description(@"(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((17|18|19|20)\d\d))$")]
        DateOnly,
        [Description(@"^[1-9]{1}[0-9]{2}\s{0,1}[0-9]{3}$")]
        Pincode,

    }
}
