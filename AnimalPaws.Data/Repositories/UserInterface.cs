using AnimalPaws.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AnimalPaws.Data.Repositories
{
    public interface UserInterface
    {
        Task<IEnumerable<User>> GetUsers();
        Task<bool> CreateUsers(User user);
        Task<bool> UpdateUsers(User user);
        Task<bool> DeleteUsers(User user);
    }
}
