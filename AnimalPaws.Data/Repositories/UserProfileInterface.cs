using AnimalPaws.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AnimalPaws.Data.Repositories
{
    public interface UserProfileInterface
    {
        Task<IEnumerable<UserProfile>> GetUserProfiles();
        Task<bool> CreateProfileUser(UserProfile userProfile);
        Task<bool> UpdateProfileUser(UserProfile userProfile);
        Task<bool> DeleteProfileUser(UserProfile userProfile);
    }
}
