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
    public class UserRepository : UserInterface
    {
        private MySqlConfiguration _connectionString;
        public UserRepository(MySqlConfiguration connectionString)
        {
            _connectionString = connectionString;
        }

        protected MySqlConnection DbConnection()
        {
            return new MySqlConnection(_connectionString.ConnectionString);
        }
        public async Task<IEnumerable<User>> GetUsers()
        {
            var db = DbConnection();
            var sql = @"
                        SELECT id, first_name, middle_name, surname, last_name, sex, email, password, phone_number,  department, city, profile_id
                        FROM user";
            return await db.QueryAsync<User>(sql, new { });
        }
        public async Task<bool> CreateUsers(User user)
        {
            var db = DbConnection();

            var sql = @"
                        INSERT INTO USER (first_name, middle_name, surname, last_name, sex, email, password, phone_number,  department, city)
                         VALUES (@first_name, @middle_name, @surname, @last_name, @sex, @email, @password, @phone_number,  @department, @city)";
            var result = await db.ExecuteAsync(sql, new { user.first_name, user.middle_name, user.surname, user.last_name, user.sex, user.email, user.password, user.phone_number, user.department, user.city});

            return result > 0;
        }

        public Task<bool> DeleteUsers(User user)
        {
            throw new NotImplementedException();
        }


        public Task<bool> UpdateUsers(User user)
        {
            throw new NotImplementedException();
        }
    }
}
