import tkinter as tk
from tkinter import messagebox
import clips

# Definir los rangos de presupuesto en función de las categorías
presupuesto_rangos = {
    "bajo 0 - 1000": (0, 1000),
    "medio-bajo 1001 - 3000": (1001, 3000),
    "medio 3001 - 5000": (3001, 5000),
    "medio-alto 5001 - 8000": (5001, 8000),
    "alto 8001 - 15000": (8001, 15000),
}

def cargar_reglas(env, archivo_reglas):
    """
    Carga un archivo de reglas en el entorno CLIPS.
    """
    try:
        env.load(archivo_reglas)
        print("Reglas cargadas exitosamente.")
    except clips.CLIPSError as error:
        print(f"Fallo al cargar reglas: {error}")

def agregar_hecho_cliente(env, nombre, presupuesto_min, presupuesto_max, tipo_viaje, preferencia):
    """
    Inserta un hecho en CLIPS basado en la información del cliente.
    """
    hecho = (f'(cliente (nombre "{nombre}") '
             f'(presupuesto-min {presupuesto_min}) (presupuesto-max {presupuesto_max}) '
             f'(tipo-viaje {tipo_viaje}) (preferencia {preferencia}))')
    env.assert_string(hecho)

def obtener_recomendaciones(env):
    """
    Ejecuta la inferencia y obtiene las recomendaciones.
    """
    env.run()
    recomendaciones = []
    for hecho in env.facts():
        if hecho.template.name == "salida":
            recomendaciones.append(hecho["mensaje"])
    return recomendaciones

def mostrar_dialogo_recomendaciones(recomendaciones):
    """
    Muestra las recomendaciones en un cuadro de mensaje.
    """
    if recomendaciones:
        mensaje = "\n".join(recomendaciones)
    else:
        mensaje = "No se encontraron recomendaciones para los datos proporcionados."
    messagebox.showinfo("Recomendaciones", mensaje)

def procesar_formulario():
    """
    Recoge los datos del formulario y obtiene las recomendaciones.
    """
    nombre = entrada_nombre.get().strip()
    categoria_presupuesto = categoria_presupuesto_seleccion.get()
    tipo_viaje = tipo_viaje_seleccion.get()
    preferencia = preferencia_seleccion.get()

    if not (nombre and categoria_presupuesto and tipo_viaje and preferencia):
        messagebox.showwarning("Advertencia", "Todos los campos son obligatorios.")
        return

    presupuesto_min, presupuesto_max = presupuesto_rangos[categoria_presupuesto]

    entorno_clips = clips.Environment()
    cargar_reglas(entorno_clips, 'rules.clp')
    agregar_hecho_cliente(entorno_clips, nombre, presupuesto_min, presupuesto_max, tipo_viaje, preferencia)
    recomendaciones = obtener_recomendaciones(entorno_clips)
    mostrar_dialogo_recomendaciones(recomendaciones)

# Configuración de la ventana principal
ventana_principal = tk.Tk()
ventana_principal.title("Sistema de Recomendaciones de Viajes")
ventana_principal.geometry("450x350")

# Variables de estado
tipo_viaje_seleccion = tk.StringVar(value="aventura")
preferencia_seleccion = tk.StringVar(value="playa")
categoria_presupuesto_seleccion = tk.StringVar(value="bajo 0 - 1000")

# Etiquetas y campos de entrada
tk.Label(ventana_principal, text="Nombre del Cliente:", font=("Arial", 12)).pack(pady=5)
entrada_nombre = tk.Entry(ventana_principal, font=("Arial", 12))
entrada_nombre.pack(pady=5)

tk.Label(ventana_principal, text="Categoría de Presupuesto:", font=("Arial", 12)).pack(pady=5)
categorias_presupuesto = list(presupuesto_rangos.keys())
menu_categoria_presupuesto = tk.OptionMenu(ventana_principal, categoria_presupuesto_seleccion, *categorias_presupuesto)
menu_categoria_presupuesto.config(font=("Arial", 12))
menu_categoria_presupuesto.pack(pady=5)

tk.Label(ventana_principal, text="Tipo de Viaje:", font=("Arial", 12)).pack(pady=5)
opciones_tipo_viaje = ["aventura", "cultura", "relajación", "gastronomía", "ecoturismo"]
menu_tipo_viaje = tk.OptionMenu(ventana_principal, tipo_viaje_seleccion, *opciones_tipo_viaje)
menu_tipo_viaje.config(font=("Arial", 12))
menu_tipo_viaje.pack(pady=5)

tk.Label(ventana_principal, text="Preferencia:", font=("Arial", 12)).pack(pady=5)
opciones_preferencia = ["playa", "montaña", "ciudad", "selva", "desierto"]
menu_preferencia = tk.OptionMenu(ventana_principal, preferencia_seleccion, *opciones_preferencia)
menu_preferencia.config(font=("Arial", 12))
menu_preferencia.pack(pady=5)

# Botón para procesar los datos
boton_recomendacion = tk.Button(ventana_principal, text="Obtener Recomendación", command=procesar_formulario, font=("Arial", 12))
boton_recomendacion.pack(pady=20)

# Ejecutar la interfaz gráfica
ventana_principal.mainloop()
