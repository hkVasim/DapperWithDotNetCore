using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DapperSolution.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace DapperSolution.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmployeeController : ControllerBase
    {
        /// <summary>
        /// Get All Employees.
        /// </summary>
        /// <returns>List of Employees.</returns>
        [HttpGet]
        public ActionResult<IEnumerable<Employee>> GetEmployee()
        {
            var empList = EmployeeHelper.GetEmployeeList();
            return this.Ok(empList);
        }

        /// <summary>
        /// Get Employee by Id.
        /// </summary>
        /// <param name="id">EmployeeID.</param>
        /// <returns>Employee Record.</returns>
        [HttpGet("{id}")]
        public ActionResult<Employee> GetEmployee(int id)
        {
            var employee = EmployeeHelper.GetEmployeeById(id);

            if (employee == null)
            {
                return NotFound();
            }

            return employee;
        }

        /// <summary>
        /// Update Employee.
        /// </summary>
        /// <param name="id">Employee ID.</param>
        /// <param name="employee">employee object.</param>
        /// <returns>Update Employee Record.</returns>
        [HttpPut("{id}")]
        public IActionResult PutEmployee(int id, Employee employee)
        {
            if (id != employee.EmployeeId)
            {
                return BadRequest();
            }
            EmployeeHelper.UpdateEmployee(employee);
            return NoContent();
        }

        /// <summary>
        /// Create New Employee.
        /// </summary>
        /// <param name="employee">employee.</param>
        /// <returns>New Employee Record.</returns>
        [HttpPost]
        public ActionResult<Employee> PostEmployee(Employee employee)
        {
            EmployeeHelper.AddEmployee(employee);
            return CreatedAtAction("GetEmployee", new { id = employee.EmployeeId }, employee);
        }

        /// <summary>
        /// Delete employee.
        /// </summary>
        /// <param name="id">Employee ID.</param>
        /// <returns>Delete Employee Record.</returns>
        [HttpDelete("{id}")]
        public ActionResult<Employee> DeleteEmployee(int id)
        {
            var employee = EmployeeHelper.GetEmployeeById(id);
            if (employee == null)
            {
                return NotFound();
            }
            EmployeeHelper.DeleteEmployee(id);
            return employee;
        }

    }
}