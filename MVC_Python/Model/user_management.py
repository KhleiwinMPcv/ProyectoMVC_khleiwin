import mysql.connector
from tkinter import messagebox

class UserManagement:
    def __init__(self):
        self.conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="dante12345",
            database="Gestion_Usuarios"
        )
        self.cursor = self.conn.cursor()

    def show_users(self, tree):
        try:
            self.cursor.execute("SELECT id, usuario, nombre, email, fecha_creacion FROM usuarios")
            rows = self.cursor.fetchall()

            for row in tree.get_children():
                tree.delete(row)

            for row in rows:
                tree.insert("", "end", values=row)

        except mysql.connector.Error as err:
            messagebox.showerror("Error", f"Error al mostrar usuarios: {err}")

    def add_user(self, usuario, contraseña, nombre, email):
        if usuario and contraseña and nombre and email:
            try:
                self.cursor.execute("INSERT INTO usuarios (usuario, contraseña, nombre, email) VALUES (%s, %s, %s, %s)",
                                    (usuario, contraseña, nombre, email))
                self.conn.commit()
                return True
            except mysql.connector.Error as err:
                messagebox.showerror("Error", f"Error al agregar usuario: {err}")
                return False
        else:
            messagebox.showerror("Error", "Por favor, complete todos los campos")
            return False

    def delete_user(self, user_id):
        try:
            self.cursor.execute("DELETE FROM usuarios WHERE id = %s", (user_id,))
            self.conn.commit()
            return True
        except mysql.connector.Error as err:
            messagebox.showerror("Error", f"Error al eliminar usuario: {err}")
            return False

    def update_user(self, user_id, usuario, contraseña, nombre, email):
        try:
            self.cursor.execute("UPDATE usuarios SET usuario=%s, contraseña=%s, nombre=%s, email=%s WHERE id=%s",
                                (usuario, contraseña, nombre, email, user_id))
            self.conn.commit()
            return True
        except mysql.connector.Error as err:
            messagebox.showerror("Error", f"Error al actualizar usuario: {err}")
            return False

    def __del__(self):
        self.conn.close()
