import mysql.connector

class UserModel:
    def __init__(self):
        self.db = mysql.connector.connect(
            host="localhost",
            user="root",
            password="dante12345",
            database="Gestion_Usuarios"
        )
        self.cursor = self.db.cursor()

    def validate_user(self, username, password): #por medio de este metodo es que se comunican el controlador y el modelo
        query = "SELECT * FROM usuarios WHERE usuario = %s AND contraseña = %s"
        self.cursor.execute(query, (username, password))
        result = self.cursor.fetchone()
        return result is not None
