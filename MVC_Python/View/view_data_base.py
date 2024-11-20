import tkinter as tk
from tkinter import ttk, messagebox
from Model.user_management import UserManagement  # Importar la nueva clase

class ManagementView:
    def __init__(self, controller, user):
        self.controller = controller
        self.user = user
        self.user_management = UserManagement()  # Instanciar UserManagement
        self.root = tk.Tk()
        self.root.title("Gestión de Usuarios")
        self.root.geometry("900x400")
        
        # Etiqueta de bienvenida
        self.label = tk.Label(self.root, text=f"Bienvenido {self.user} a la gestión de datos", font=("Helvetica", 14))
        self.label.pack(pady=10)

        # Tabla (Treeview)
        self.tree = ttk.Treeview(self.root, columns=("ID", "Usuario", "Nombre", "Email", "Fecha Creación"), show="headings")
        self.tree.heading("ID", text="ID")
        self.tree.heading("Usuario", text="Usuario")
        self.tree.heading("Nombre", text="Nombre")
        self.tree.heading("Email", text="Email")
        self.tree.heading("Fecha Creación", text="Fecha de Creación")

        self.tree.column("ID", width=50)
        self.tree.column("Usuario", width=100)
        self.tree.column("Nombre", width=150)
        self.tree.column("Email", width=150)
        self.tree.column("Fecha Creación", width=150)

        self.tree.pack(pady=20, fill=tk.BOTH, expand=True)

        # Botones CRUD
        if self.user == "juanp":
            self.add_button = tk.Button(self.root, text="Añadir", command=self.add_user)
            self.add_button.pack(side=tk.LEFT, padx=20, pady=10)

            self.delete_button = tk.Button(self.root, text="Eliminar", command=self.delete_user)
            self.delete_button.pack(side=tk.LEFT, padx=20, pady=10)

            self.update_button = tk.Button(self.root, text="Modificar", command=self.update_user)
            self.update_button.pack(side=tk.LEFT, padx=20, pady=10)

        self.logout_button = tk.Button(self.root, text="Cerrar Sesión", command=self.logout)
        self.logout_button.pack(pady=10)

        # Cargar datos automáticamente
        self.user_management.show_users(self.tree)

    def add_user(self):
        def save_user():
            usuario = entry_usuario.get()
            contraseña = entry_contraseña.get()
            nombre = entry_nombre.get()
            email = entry_email.get()
            if self.user_management.add_user(usuario, contraseña, nombre, email):
                messagebox.showinfo("Éxito", "Usuario añadido exitosamente")
                self.user_management.show_users(self.tree)
                add_window.destroy()
        
        add_window = tk.Toplevel(self.root)
        add_window.title("Añadir Usuario")
        add_window.geometry("300x350")

        tk.Label(add_window, text="Usuario").pack(pady=5)
        entry_usuario = tk.Entry(add_window)
        entry_usuario.pack(pady=5)

        tk.Label(add_window, text="Contraseña").pack(pady=5)
        entry_contraseña = tk.Entry(add_window, show="*")
        entry_contraseña.pack(pady=5)

        tk.Label(add_window, text="Nombre").pack(pady=5)
        entry_nombre = tk.Entry(add_window)
        entry_nombre.pack(pady=5)

        tk.Label(add_window, text="Email").pack(pady=5)
        entry_email = tk.Entry(add_window)
        entry_email.pack(pady=5)

        tk.Button(add_window, text="Guardar", command=save_user).pack(pady=20)

    def delete_user(self):
    # Eliminar usuario (solo disponible para el administrador)
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("Eliminar", "Por favor, selecciona un usuario para eliminar.")
            return  # Salir de la función si no hay selección
        if selected_item:
            item = self.tree.item(selected_item)
            user_id = item['values'][0]  # El ID está en la primera columna

            # Confirmación antes de eliminar
            if messagebox.askyesno("Eliminar", "¿Estás seguro de eliminar este usuario?"):
                if self.user_management.delete_user(user_id):
                    messagebox.showinfo("Éxito", "Usuario eliminado exitosamente")
                    self.user_management.show_users(self.tree)
                else:
                    messagebox.showerror("Error", "No se pudo eliminar el usuario.")

    def update_user(self):
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("Modificar", "Por favor, selecciona un usuario para modificar.")
            return  # Salir de la función si no hay selección

        user_id = self.tree.item(selected_item)['values'][0]
        current_values = self.tree.item(selected_item)['values']

        def save_update():
            # Confirmación antes de guardar los cambios
            if messagebox.askyesno("Confirmar", "¿Estás seguro de guardar los cambios?"):
                usuario = entry_usuario.get()
                contraseña = entry_contraseña.get()
                nombre = entry_nombre.get()
                email = entry_email.get()

                if self.user_management.update_user(user_id, usuario, contraseña, nombre, email):
                    messagebox.showinfo("Éxito", "Usuario actualizado exitosamente")
                    self.user_management.show_users(self.tree)
                    update_window.destroy()
            else:
                # Si el usuario elige "No", simplemente cierra la ventana de actualización
                update_window.destroy()

        update_window = tk.Toplevel(self.root)
        update_window.title("Modificar Usuario")
        update_window.geometry("300x350")

        tk.Label(update_window, text="Usuario").pack(pady=5)
        entry_usuario = tk.Entry(update_window)
        entry_usuario.insert(0, current_values[1])  # Usuario actual
        entry_usuario.pack(pady=5)

        tk.Label(update_window, text="Contraseña").pack(pady=5)
        entry_contraseña = tk.Entry(update_window, show="*")
        entry_contraseña.insert(0, current_values[2])  # Contraseña actual
        entry_contraseña.pack(pady=5)

        tk.Label(update_window, text="Nombre").pack(pady=5)
        entry_nombre = tk.Entry(update_window)
        entry_nombre.insert(0, current_values[2])  # Nombre actual
        entry_nombre.pack(pady=5)

        tk.Label(update_window, text="Email").pack(pady=5)
        entry_email = tk.Entry(update_window)
        entry_email.insert(0, current_values[3])  # Email actual
        entry_email.pack(pady=5)

        tk.Button(update_window, text="Guardar", command=save_update).pack(pady=20)

    def logout(self):
        self.root.destroy()
        self.controller.show_login_view()

    def start(self):
        self.root.mainloop()
