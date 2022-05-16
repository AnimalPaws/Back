using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AnimalPaws.Model
{
    public class User
    {
        public int id { get; set; }
        public string first_name { get; set; }
        public string middle_name { get; set; }
        public string surname { get; set; }
        public string last_name { get; set; }
        public string sex { get; set; }
        public string email { get; set; }
        public string password { get; set; }
        public string phone_number { get; set; }
        public string department { get; set; }
        public string city { get; set; }
        public int profile_id { get; set; }
    }
}
