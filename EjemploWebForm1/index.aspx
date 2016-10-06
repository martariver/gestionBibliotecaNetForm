﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="WebApplication1.index" %>

<!DOCTYPE html>
<html lang="es-es">
<head runat="server">
    <meta charset="utf-8" />
    <title></title>
   
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <script src="http://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager" runat="server" />
        <div>
            <asp:Menu ID="Menu1" runat="server">
                <Items>
                    <asp:MenuItem NavigateUrl="~/index.aspx" Text="Pagina principal" Value="Pagina principal"></asp:MenuItem>
                </Items>
            </asp:Menu>
            
            
            <asp:UpdatePanel runat="server">
            <ContentTemplate> 
                <asp:Button ID="btncrearUsuario" runat="server" CssClass="btn btn-default" Text="Crear Usuario"  OnClick="btncrearUsuario_Click"/>   
                <asp:GridView DataKeyNames="id" OnRowCommand="grdv_Usuarios_RowCommand" ID="grdv_Usuarios" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="id" Visible="false" />
                            <asp:BoundField DataField="nombre" HeaderText="NOMBRE" Visible="True" />
                            <asp:BoundField DataField="apellidos" HeaderText="APELLIDOS" Visible="True" />
                            <asp:BoundField DataField="fNacimiento" HeaderText="FECHA DE NACIMIENTO" Visible="True" />

                             <asp:ButtonField CommandName="editUsuario" Text="Editar" ControlStyle-CssClass="btn btn-info" >
                                <ControlStyle CssClass="btn btn-info"/>
                            </asp:ButtonField>
                            <asp:ButtonField CommandName="deleteUsuario" Text="Borrar" ControlStyle-CssClass="btn btn-danger">
                                <ControlStyle CssClass="btn btn-danger" />
                            </asp:ButtonField>
                        </Columns>
                    </asp:GridView>
              </ContentTemplate>
              </asp:UpdatePanel>


            <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="exampleModalLabel">Formulario</h4>
                        </div>
                        <div class="modal-body">
                            <asp:Label runat="server" ID="lblIdUsuario" Visible="false" Text="" ></asp:Label>

                            <asp:Label runat="server" ID="lblNombreUsuario" Visible="true" Text="Nombre:"></asp:Label>
                            <asp:TextBox ID="txtNombreUsuario"  runat="server" Text=""></asp:TextBox>

                            <asp:Label runat="server" ID="lblApellidosUsuario" Visible="true" Text="Apellidos:"></asp:Label>
                            <asp:TextBox ID="txtApellidosUsuario"  runat="server" Text=""></asp:TextBox>

                            <asp:Label runat="server" ID="lblfNacimiento" Visible="true" Text="Fecha de nacimiento"></asp:Label>
                            <asp:TextBox ID="txtfNacimiento"  runat="server" Text=""></asp:TextBox>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button> 
                            <asp:Button runat="server" OnClick="btnGuardarUsuario_Click" ID="btnGuardarUsuario" Text="Guardar" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="deleteConfirm" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="">Borrar</h4>
                        </div>
                        <div class="modal-body">
                             <asp:Label ID="lblMensaje" runat="server" Text="¿Esta usted seguro que desea borrar?"></asp:Label>
                             <asp:TextBox ID="txtIdUsuario" runat="server" Enabled="false" Visible="false"></asp:TextBox>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                            <asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Borrar" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
