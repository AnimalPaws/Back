using AnimalPaws.Model;
using Dapper;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AnimalPaws.Data.Repositories
{
    public class UserProfileRepository : UserProfileInterface
    {
        private MySqlConfiguration _connectionString;
        public UserProfileRepository(MySqlConfiguration connectionString)
        {
            _connectionString = connectionString;
        }

        protected MySqlConnection DbConnection()
        {
            return new MySqlConnection(_connectionString.ConnectionString);
        }
        public async Task<IEnumerable<UserProfile>> GetUserProfiles()
        {
            var db = DbConnection();
            var sql = @"
                        SELECT id, username, picture, biography, notification_id, pet_id
                        FROM user_profile";
            return await db.QueryAsync<UserProfile>(sql, new { });
        }

        public async Task<bool> CreateProfileUser(UserProfile userProfile)
        {
            var db = DbConnection();

            var sql = @"
                        INSERT INTO USER (username, picture, biography, notification_id, pet_id)
                         VALUES (@username, @picture, @biography, @notification_id, @pet_id)";
            var result = await db.ExecuteAsync(sql, new { userProfile.username, userProfile.picture, userProfile.biography, userProfile.notification_id, userProfile.pet_id});

            return result > 0;
        }

        public Task<bool> UpdateProfileUser(UserProfile userProfile)
        {
            throw new NotImplementedException();
        }

        public Task<bool> DeleteProfileUser(UserProfile userProfile)
        {
            throw new NotImplementedException();
        }
    }
}
