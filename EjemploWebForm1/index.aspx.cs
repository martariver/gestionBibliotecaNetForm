using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace WebApplication1
{
    public partial class index : System.Web.UI.Page
    {
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            
                cargaDatos();
            
        }

        private void cargaDatos()
        {
            try
            {
                string cadenaConexion = ConfigurationManager.ConnectionStrings["GESLIBRERIAConnectionString"].ConnectionString;
                string SQL = "SELECT * FROM usuario";
                SqlConnection conn = new SqlConnection(cadenaConexion);
                conn.Open();
                DataSet ds = new DataSet();
                SqlDataAdapter dAdapter = new SqlDataAdapter(SQL, conn);
                dAdapter.Fill(ds);
                dt = ds.Tables[0];

                grdv_Usuarios.DataSource = dt;
                grdv_Usuarios.DataBind();
                conn.Close();
            }
            catch (SqlException ex)
            {
                Console.Error.Write(ex.Message);
            }
        }

        protected void grdv_Usuarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string comand = e.CommandName;
            int index = Convert.ToInt32(e.CommandArgument); //para saber el registro que se ha pinchado
            string codigo = grdv_Usuarios.DataKeys[index].Value.ToString(); //recojo el codigo de la fila en la que he pinchado
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            switch (comand)
            {
                case "editUsuario":
                    lblIdUsuario.Text = codigo;
                    sb.Append(@"<script>");
                    sb.Append("$('#editModal').modal('show')");
                    sb.Append(@"</script>");
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ConfirmarEdicion", sb.ToString(), false);
                    break;

                case "deleteUsuario":
                    
                    txtIdUsuario.Text = codigo;
                    sb.Append(@"<script>");
                    sb.Append("$('#deleteConfirm').modal('show')");
                    sb.Append(@"</script>");
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ConfirmarBorrado", sb.ToString(), false);

                    
                    break;
            }
        }


        protected void btnDelete_Click(object sender, EventArgs e)
        {
            SqlConnection conn = null;
            string cadenaConexion = ConfigurationManager.ConnectionStrings["GESTLIBRERIAConnectionString"].ConnectionString;

            string codigo = txtIdUsuario.Text;
            string SQL = "DELETE FROM usuarios WHERE id=" + codigo;
            try
            {
                conn = new SqlConnection(cadenaConexion);
                conn.Open();
                SqlCommand sqlcmm = new SqlCommand();
                sqlcmm.Connection = conn;
                sqlcmm.CommandText = SQL;
                sqlcmm.CommandType = CommandType.Text;
                // sqlcmm.CommandType = CommandType.StoredProcedure;
                sqlcmm.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                conn.Close();
            }
            cargaDatos();
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script>");
            sb.Append("$('#deleteConfirm').modal('hide')");
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "OcultarCreate", sb.ToString(), false);
        }


        protected void btnGuardarUsuario_Click(object sender, EventArgs e)
        {
            string cadenaConexion = ConfigurationManager.ConnectionStrings["GESLIBRERIAConnectionString"].ConnectionString;
            string codigo = lblIdUsuario.Text;
            string nombre = txtNombreUsuario.Text;
            string apellidos = txtApellidosUsuario.Text;
            string fNacimiento = txtfNacimiento.Text;
            string SQL = "INSERT INTO usuario(nombre,apellidos,fNacimiento) VALUES('"+nombre+"','"+apellidos+"','"+fNacimiento+"')";
            int cod; 

            if(Int32.TryParse(codigo, out cod) && cod >-1)
            {
                SQL = "UPDATE usuarios SET nombre = '" + nombre + "' WHERE id =" + codigo;
            }

            SqlConnection conn = null;

            try
            {
                conn = new SqlConnection(cadenaConexion);
                conn.Open();
                SqlCommand sqlcmm = new SqlCommand();
                sqlcmm.Connection = conn;
                sqlcmm.CommandText = SQL;
                sqlcmm.CommandType = CommandType.Text;
                sqlcmm.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                Console.Error.Write(ex.Message);
            }
            finally
            {
                conn.Close();
            }
            cargaDatos();
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script>");
            sb.Append("$('#editModal').modal('hide')");
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "OcultarCreate", sb.ToString(), false);
        }

        protected void btncrearUsuario_Click(object sender, EventArgs e)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            lblIdUsuario.Text = "-1";
            txtNombreUsuario.Text = "";
            sb.Append(@"<script>");
            sb.Append("$('#editModal').modal('show')");
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "MostrarCreate", sb.ToString(), false);
        }



    }
}