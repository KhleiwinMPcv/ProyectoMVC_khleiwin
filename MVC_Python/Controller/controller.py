from Model.model import UserModel
from View.view_login import LoginView
from View.view_data_base import ManagementView

class LoginController:
    def __init__(self):
        self.user_model = UserModel()
        self.login_view = LoginView(self)

    def login(self, username, password):
        # Validar el usuario a través del modelo
        if self.user_model.validate_user(username, password):
            self.login_view.show_success(username)  # Pasar el usuario a la vista de login
            return username  # Retornar nombre del usuario autenticado
        else:
            self.login_view.show_error()
            return None  # Retornar None si la autenticación falla

    def show_management_view(self, user): # metodo con el que se comunica con la vista
        management_view = ManagementView(self, user)  
        management_view.start()  # Llama al método start de ManagementView

    def show_login_view(self):
        """Recrear y mostrar la ventana de login."""
        self.login_view = LoginView(self)  # Crear una nueva instancia de la vista de login
        self.login_view.start() 

    def start(self):
        self.login_view.start()
