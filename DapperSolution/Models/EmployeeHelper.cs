using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace DapperSolution.Models
{
    public class EmployeeHelper
    {
        static string strConnectionString { get; set; } = "Server=.;Database=EmployeeDB;Trusted_Connection=True;";
        public static IEnumerable<Employee> GetEmployeeList()
        {
            List<Employee> employeeList = new List<Employee>();

            using (IDbConnection con = new SqlConnection(strConnectionString))
            {
                if (con.State == ConnectionState.Closed)
                    con.Open();

                employeeList = con.Query<Employee>("GetEmployeeList").ToList();
            }

            return employeeList;
        }

        public static Employee GetEmployeeById(int? id)
        {
            Employee employee = new Employee();
            if (id == null)
                return employee;

            using (IDbConnection con = new SqlConnection(strConnectionString))
            {
                if (con.State == ConnectionState.Closed)
                    con.Open();

                DynamicParameters parameter = new DynamicParameters();
                parameter.Add("@Id", id);
                employee = con.Query<Employee>("GetEmployeeByID", parameter, commandType: CommandType.StoredProcedure).FirstOrDefault();
            }

            return employee;
        }

        public static int AddEmployee(Employee employee)
        {
            int rowAffected = 0;
            using (IDbConnection con = new SqlConnection(strConnectionString))
            {
                if (con.State == ConnectionState.Closed)
                    con.Open();

                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@FirstName", employee.FirstName);
                parameters.Add("@LastName", employee.LastName);
                parameters.Add("@Email", employee.Email);
                parameters.Add("@Age", employee.Age);

                rowAffected = con.Execute("InsertEmployee", parameters, commandType: CommandType.StoredProcedure);
            }

            return rowAffected;
        }

        public static int UpdateEmployee(Employee employee)
        {
            int rowAffected = 0;

            using (IDbConnection con = new SqlConnection(strConnectionString))
            {
                if (con.State == ConnectionState.Closed)
                    con.Open();

                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@EmployeeId", employee.EmployeeId);
                parameters.Add("@FirstName", employee.FirstName);
                parameters.Add("@LastName", employee.LastName);
                parameters.Add("@Email", employee.Email);
                parameters.Add("@Age", employee.Age);
                rowAffected = con.Execute("UpdateEmployee", parameters, commandType: CommandType.StoredProcedure);
            }

            return rowAffected;
        }

        public static int DeleteEmployee(int id)
        {
            int rowAffected = 0;
            using (IDbConnection con = new SqlConnection(strConnectionString))
            {
                if (con.State == ConnectionState.Closed)
                    con.Open();
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@Id", id);
                rowAffected = con.Execute("DeleteEmployee", parameters, commandType: CommandType.StoredProcedure);

            }

            return rowAffected;
        }
    }
}
