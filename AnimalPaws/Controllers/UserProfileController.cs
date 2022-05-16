using AnimalPaws.Data.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace AnimalPaws.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserProfileController : ControllerBase
    {
        private readonly UserProfileInterface _userProfile;

        public UserProfileController(UserProfileInterface userProfileInterface)
        {
            _userProfile = userProfileInterface;
        }
        [HttpGet]
        public async Task<IActionResult> GetUserProfile()
        {
            return Ok(await _userProfile.GetUserProfiles());
        }
    }
}
