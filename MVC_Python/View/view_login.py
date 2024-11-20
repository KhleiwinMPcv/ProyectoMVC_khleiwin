import tkinter as tk
from tkinter import messagebox
from PIL import Image, ImageTk

class LoginView:
    def __init__(self, controller):
        self.controller = controller
        self.root = tk.Tk()
        self.root.title("Inicio de Sesión")
        self.root.geometry("400x320")  # Tamaño de la ventana

        # Cambiar el color de fondo de la ventana
        self.root.configure(bg="#00BFFF")  # Color azul claro

        # Cargar imagen desde la carpeta 'img'
        try:
            image_path = "img/icono_inicio.png"  # Ruta a la imagen
            img = Image.open(image_path)  # Abrir la imagen con PIL
            img = img.resize((100, 100))  # Ajustar tamaño (sin ANTIALIAS)
            self.photo = ImageTk.PhotoImage(img)  # Convertirla para Tkinter
        except Exception as e:
            messagebox.showerror("Error", f"No se pudo cargar la imagen: {e}")
            self.photo = None

        # Si la imagen se cargó correctamente, mostrarla
        if self.photo:
            self.image_label = tk.Label(self.root, image=self.photo, bg="#B0E0E6")  # Fondo del label
            self.image_label.pack(pady=10)  # Añadir margen vertical

        # Etiquetas y campos de texto
        self.label_user = tk.Label(self.root, text="Usuario:", bg="#00BFFF", fg="#333333", font=("Arial", 14))
        self.label_user.pack(pady=5)

        self.entry_user = tk.Entry(self.root, font=("Arial", 14))
        self.entry_user.pack(pady=5)

        self.label_password = tk.Label(self.root, text="Contraseña:", bg="#00BFFF", fg="#333333", font=("Arial", 14))
        self.label_password.pack(pady=5)

        self.entry_password = tk.Entry(self.root, show="*", font=("Arial", 14))
        self.entry_password.pack(pady=5)

        # Botón para iniciar sesión con colores personalizados
        self.login_button = tk.Button(self.root, text="Iniciar Sesión", command=self.login, 
                                      bg="#4CAF50", fg="black", font=("Arial", 14))
        self.login_button.pack(pady=10)

    def login(self): #metodo de comunicacion
        username = self.entry_user.get()
        password = self.entry_password.get()
        # Llamar al método login del controlador y obtener el resultado
        user = self.controller.login(username, password)
        if user:  # Si el login es exitoso
            self.show_success(user)  # Pasar el usuario a show_success
        else:  # Si el login falla
            self.show_error()

    def show_error(self):
        messagebox.showerror("Error", "Usuario o contraseña incorrectos")
        self.entry_user.delete(0,'end')
        self.entry_password.delete(0,'end')

    def show_success(self, user):
        if self.root.destroy():
            messagebox.showinfo("Finalizado", "Programa finalizado")
        messagebox.showinfo("Éxito", "Inicio de sesión exitoso")    
        self.controller.show_management_view(user)

    def start(self):
        self.root.mainloop()
