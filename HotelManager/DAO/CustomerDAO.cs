using HotelManager.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HotelManager.DAO
{
    public class CustomerDAO
    {
        private static CustomerDAO instance;
        private CustomerDAO() { }
        #region Method
        public bool IsIdCardExists(string idCard)
        {
            string query = "USP_IsIdCardExists @idCard";
            int count = DataProvider.Instance.ExecuteQuery(query, new object[] { idCard }).Rows.Count;
            return count > 0;
        }
        public bool InsertCustomer(string idCard, string name,int idCustomerType,DateTime dateofBirth,string address,int phonenumber,string sex,string nationality)
        {
            string query = "USP_InsertCustomer_ @idCard , @name , @idCustomerType , @dateOfBirth , @address , @phoneNumber , @sex , @nationality";
            return DataProvider.Instance.ExecuteNoneQuery(query,new object[] { idCard, name, idCustomerType, dateofBirth, address, phonenumber, sex, nationality })>0;
        }
        public Customer GetInfoByIdCard(string idCard)
        {
            string query = "USP_IsIdCardExists @idCard";
            Customer customer =new Customer(DataProvider.Instance.ExecuteQuery(query, new object[] { idCard }).Rows[0]);
            return customer;

        }

        internal bool InsertCustomer(string customerName, int idCustomerType, string idCard, string address, DateTime dateOfBirth, int phoneNumber, string sex, string nationality)
        {
            string query = "exec USP_InsertCustomer @customerName , @idCustomerType , @idCard , @address , @dateOfBirth , @phoneNumber , @sex , @nationality";
            int count = DataProvider.Instance.ExecuteNoneQuery(query, new object[] { customerName, idCustomerType, idCard, address, dateOfBirth, phoneNumber, sex, nationality });
            return count > 0;
        }
        internal bool InsertCustomer(Customer customer)
        {
            return InsertCustomer(customer.Name, customer.IdCustomerType, customer.IdCard, customer.Address,
                customer.DateOfBirth, customer.PhoneNumber, customer.Sex, customer.Nationality);
        }


        internal bool UpdateCustomer(Customer customerNow, Customer customerPre)
        {
            string query = "USP_UpdateCustomer @id , @customerName , @idCustomerType ," +
                            " @idCardNow , @address , @dateOfBirth , " +
                            "@phoneNumber , @sex , @nationality , @idCardPre";
            object[] parameter = new object[] {customerNow.Id, customerNow.Name, customerNow.IdCustomerType, customerNow.IdCard,
                                    customerNow.Address, customerNow.DateOfBirth, customerNow.PhoneNumber,
                                    customerNow.Sex, customerNow.Nationality, customerPre.IdCard};
            return DataProvider.Instance.ExecuteNoneQuery(query, parameter) > 0;
        }
        public bool UpdateCustomer(int id,string name,string idCard,int idCustomerType, int phoneNumber,DateTime dateOfBirth,string address,string sex,string nationality)
        {
            string query = "USP_UpdateCustomer_ @id , @name , @idCard , @idCustomerType , @phoneNumber , @dateOfBirth , @address , @sex , @nationality";
            return DataProvider.Instance.ExecuteNoneQuery(query, new object[] { id,name,idCard,idCustomerType,phoneNumber,dateOfBirth,address,sex,nationality})>0;
        }

        internal DataTable LoadFullCustomer()
        {
            string query = "USP_LoadFullCustomer";
            return DataProvider.Instance.ExecuteQuery(query);
        }
        internal DataTable Search(string text, int phoneNumber)
        {
            string query = "USP_SearchCustomer @string , @int";
            return DataProvider.Instance.ExecuteQuery(query, new object[] { text, phoneNumber });
        }
        public int GetIDCustomerFromBookRoom(int idReceiveRoom)
        {
            string query = "USP_GetIDCustomerFromBookRoom @idReceiveRoom";
            return (int)DataProvider.Instance.ExecuteScalar(query, new object[] { idReceiveRoom });
        }
        public bool DeleteCustomer(int id)
        {
            string checkQuery = "SELECT COUNT(*) FROM BookRoom WHERE idCustomer = @id";
            int count = (int)DataProvider.Instance.ExecuteScalar(checkQuery, new object[] { id });

            if (count > 0)
            {
                // Xóa các bản ghi liên quan trong BookRoom trước
                string deleteBookRoomQuery = "DELETE FROM BookRoom WHERE idCustomer = @id";
                int bookRoomResult = DataProvider.Instance.ExecuteNoneQuery(deleteBookRoomQuery, new object[] { id });

                if (bookRoomResult < 0)
                {
                    return false; // Không thể xóa bản ghi trong BookRoom, trả về false
                }
            }

            // Tiếp tục xóa khách hàng trong Customer
            string deleteQuery = "DELETE FROM Customer WHERE id = @id";
            int result = DataProvider.Instance.ExecuteNoneQuery(deleteQuery, new object[] { id });
            return result > 0;
        }
        #endregion
        public static CustomerDAO Instance { get { if (instance == null) instance = new CustomerDAO();return instance; }
            private set => instance = value; }
        
    }
}
