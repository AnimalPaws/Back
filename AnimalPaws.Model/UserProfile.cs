using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AnimalPaws.Model
{
    public class UserProfile
    {
        public int id { get; set; }
        public string username { get; set; }
        public string picture { get; set; }
        public string biography { get; set; }
        public int notification_id { get; set; }
        public int pet_id { get; set; }
    }
}
