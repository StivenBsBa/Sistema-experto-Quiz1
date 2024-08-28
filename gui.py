import tkinter as tk
from tkinter import messagebox
from clips import Environment

class TravelExpertSystem:
    def __init__(self, root):
        self.root = root
        self.root.title("Sistema Experto de Recomendaciones de Viajes")
        
        # Crear interfaz
        tk.Label(root, text="Preferencias de viaje").grid(row=0, column=0, columnspan=2, padx=10, pady=10)
        
        tk.Label(root, text="Tipo de preferencia:").grid(row=1, column=0, padx=10, pady=5)
        
        # Variable para almacenar la preferencia seleccionada
        self.preference = tk.StringVar(value="beach")  # Valor por defecto
        
        # Botones de radio para seleccionar la preferencia
        preferences = [("Playa", "beach"), ("Montaña", "mountain"), ("Ciudad", "city"), 
                       ("Aventura", "adventure"), ("Cultura", "culture")]
        
        for index, (text, value) in enumerate(preferences):
            tk.Radiobutton(root, text=text, variable=self.preference, value=value).grid(row=1, column=1+index, padx=5, pady=5)
        
        tk.Label(root, text="Presupuesto:").grid(row=2, column=0, padx=10, pady=5)
        self.budget_entry = tk.Entry(root)
        self.budget_entry.grid(row=2, column=1, padx=10, pady=5)
        
        tk.Button(root, text="Obtener Recomendaciones", command=self.get_recommendations).grid(row=3, column=0, columnspan=6, padx=10, pady=10)
        
        self.results_text = tk.Text(root, height=10, width=50)
        self.results_text.grid(row=4, column=0, columnspan=6, padx=10, pady=10)
        
    def get_recommendations(self):
        # Inicializar el entorno CLIPS
        env = Environment()
        env.load("rules.clp")
        
        # Obtener entradas del usuario
        preference = self.preference.get()
        budget = self.budget_entry.get()
        
        try:
            budget = int(budget)
        except ValueError:
            messagebox.showerror("Error", "Presupuesto debe ser un número entero.")
            return
        
        # Insertar hechos
        env.assert_string(f'(client (preference {preference}))')
        env.assert_string(f'(client (budget {budget}))')
        
        # Ejecutar el motor de inferencia
        env.run()
        
        # Obtener y mostrar resultados
        results = env.eval('(find-all-facts ((?f destination)) TRUE)')
        self.results_text.delete(1.0, tk.END)
        
        if not results:
            self.results_text.insert(tk.END, "No hay recomendaciones disponibles para los criterios proporcionados.")
        else:
            for result in results:
                destination = result[0]
                name = destination.get('name', 'Desconocido')
                self.results_text.insert(tk.END, f"Destino recomendado: {name}\n")
        
if __name__ == "__main__":
    root = tk.Tk()
    app = TravelExpertSystem(root)
    root.mainloop()
