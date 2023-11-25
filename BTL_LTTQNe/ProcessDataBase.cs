using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BTL_LTTQNe
{

    internal class ProcessDataBase
    {
       
        //SqlConnection conn = new SqlConnection("Data Source=DESKTOP-QDCMI8G\\SQLEXPRESS;Initial Catalog=Lttq_SinhVien_Demo;Integrated Security=True");
        SqlConnection conn;
        public ProcessDataBase(string connectionString)
        {
            conn = new SqlConnection(connectionString);
        }
        public void OpenConnection()
        {
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
        }

        public void CloseConnection()
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
        }
        public DataTable DocBang(string sql)
        {
            OpenConnection();
            DataTable tb = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            da.Fill(tb);
            CloseConnection();
            return tb;
        }
        public void RunSQL(string sql)
        {
            SqlCommand cmd = new SqlCommand();
            OpenConnection();
            cmd.CommandText = sql;
            cmd.Connection = conn;
            try
            {
                cmd.ExecuteNonQuery();
            }

            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
            OpenConnection();
            cmd.Dispose();
        }


    }
}
