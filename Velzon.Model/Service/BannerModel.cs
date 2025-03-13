﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Model.Service
{
    public class BannerListResponse
    {
        public List<BannerModel> BannerList { get; set; }
    }

    public class BannerModel
    {
        public long Id { get; set; }
        public long BannerId { get; set; }
        public long LanguageId { get; set; } 
        public string? Title { get; set; }
        public string? URL { get; set; }
        public string? ImageName { get; set; } 
        public string ImagePath { get; set; }
        public string? Description { get; set; }
        public bool IsActive { get; set; }
        public long BannerRank { get; set; }
        public string CreatedBy { get; set; }
    }
}
