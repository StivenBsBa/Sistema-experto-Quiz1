(deftemplate cliente
    (slot nombre)
    (slot presupuesto-min (type NUMBER))
    (slot presupuesto-max (type NUMBER))
    (slot tipo-viaje (type SYMBOL) 
        (allowed-symbols aventura cultura relajación gastronomía ecoturismo))
    (slot preferencia (type SYMBOL) 
        (allowed-symbols playa montaña ciudad selva desierto))
)

(deftemplate salida
    (slot mensaje)
)

;; Regla 1: Relajación en la playa
(defrule recomendar-playa-relajacion
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(< ?min 3000)) (presupuesto-max ?max&:(<= ?max 3000)) (tipo-viaje relajación) (preferencia playa))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Disfruta de unas vacaciones de relajación en una playa exótica con un presupuesto de hasta " ?max "."))))
)

;; Regla 2: Aventura en la montaña
(defrule recomendar-montaña-aventura
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(> ?min 3000)) (presupuesto-max ?max) (tipo-viaje aventura) (preferencia montaña))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Aventuras emocionantes en la montaña con un presupuesto a partir de " ?min "."))))
)

;; Regla 3: Cultura en la ciudad
(defrule recomendar-ciudad-cultura
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(<= ?min 5000)) (presupuesto-max ?max&:(<= ?max 5000)) (tipo-viaje cultura) (preferencia ciudad))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Sumérgete en la cultura urbana con un presupuesto de hasta " ?max "."))))
)

;; Regla 4: Gastronomía en la ciudad
(defrule recomendar-ciudad-gastronomia
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(<= ?min 5000)) (presupuesto-max ?max&:(<= ?max 5000)) (tipo-viaje gastronomía) (preferencia ciudad))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Disfruta de la gastronomía local en la ciudad con un presupuesto de hasta " ?max "."))))
)

;; Regla 5: Relajación en la montaña
(defrule recomendar-montaña-relajacion
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(<= ?min 4000)) (presupuesto-max ?max&:(<= ?max 4000)) (tipo-viaje relajación) (preferencia montaña))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Escapada de relajación en la montaña con un presupuesto de hasta " ?max "."))))
)

;; Regla 6: Ecoturismo en la selva
(defrule recomendar-selva-ecoturismo
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(> ?min 5000)) (presupuesto-max ?max) (tipo-viaje ecoturismo) (preferencia selva))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Experiencia de ecoturismo en la selva con un presupuesto a partir de " ?min "."))))
)

;; Regla 7: Aventura en el desierto
(defrule recomendar-desierto-aventura
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(< ?min 2000)) (presupuesto-max ?max&:(<= ?max 2000)) (tipo-viaje aventura) (preferencia desierto))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Safari de aventura en el desierto con un presupuesto de hasta " ?max "."))))
)

;; Regla 8: Cultura en la selva
(defrule recomendar-selva-cultura
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(<= ?min 3000)) (presupuesto-max ?max&:(<= ?max 3000)) (tipo-viaje cultura) (preferencia selva))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Explora la cultura de tribus en la selva con un presupuesto de hasta " ?max "."))))
)

;; Regla 9: Ecoturismo en la montaña
(defrule recomendar-montaña-ecoturismo
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(<= ?min 4000)) (presupuesto-max ?max&:(<= ?max 4000)) (tipo-viaje ecoturismo) (preferencia montaña))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Participa en ecoturismo en la montaña con un presupuesto de hasta " ?max "."))))
)

;; Regla 10: Relajación en el desierto
(defrule recomendar-desierto-relajacion
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(<= ?min 3000)) (presupuesto-max ?max&:(<= ?max 3000)) (tipo-viaje relajación) (preferencia desierto))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Relájate en el desierto con un presupuesto de hasta " ?max "."))))
)

;; Regla 11: Aventura en la selva
(defrule recomendar-selva-aventura
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(> ?min 6000)) (presupuesto-max ?max) (tipo-viaje aventura) (preferencia selva))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Explora la selva en una aventura con un presupuesto a partir de " ?min "."))))
)

;; Regla 12: Gastronomía en la playa
(defrule recomendar-playa-gastronomia
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(<= ?min 5000)) (presupuesto-max ?max&:(<= ?max 5000)) (tipo-viaje gastronomía) (preferencia playa))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Disfruta de la gastronomía en resorts de playa con un presupuesto de hasta " ?max "."))))
)

;; Regla 13: Cultura en el desierto
(defrule recomendar-desierto-cultura
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(< ?min 2500)) (presupuesto-max ?max&:(<= ?max 2500)) (tipo-viaje cultura) (preferencia desierto))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Descubre la cultura del desierto con un presupuesto de hasta " ?max "."))))
)

;; Regla 14: Ecoturismo en el desierto
(defrule recomendar-desierto-ecoturismo
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(> ?min 4500)) (presupuesto-max ?max) (tipo-viaje ecoturismo) (preferencia desierto))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Participa en ecoturismo en el desierto con un presupuesto a partir de " ?min "."))))
)

;; Regla 15: Gastronomía en la montaña
(defrule recomendar-montaña-gastronomia
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(<= ?min 5000)) (presupuesto-max ?max&:(<= ?max 5000)) (tipo-viaje gastronomía) (preferencia montaña))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Vive una experiencia gastronómica en la montaña con un presupuesto de hasta " ?max "."))))
)

;; Regla 16: Relajación en la ciudad
(defrule recomendar-ciudad-relajacion
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(<= ?min 3000)) (presupuesto-max ?max&:(<= ?max 3000)) (tipo-viaje relajación) (preferencia ciudad))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Relájate en un resort urbano con un presupuesto de hasta " ?max "."))))
)

;; Regla 17: Aventura en la playa
(defrule recomendar-playa-aventura
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(<= ?min 2000)) (presupuesto-max ?max&:(<= ?max 2000)) (tipo-viaje aventura) (preferencia playa))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Aventuras acuáticas en la playa con un presupuesto de hasta " ?max "."))))
)

;; Regla 18: Cultura en la montaña
(defrule recomendar-montaña-cultura
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(<= ?min 4000)) (presupuesto-max ?max&:(<= ?max 4000)) (tipo-viaje cultura) (preferencia montaña))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Descubre la cultura de montaña con un presupuesto de hasta " ?max "."))))
)

;; Regla 19: Ecoturismo en la ciudad
(defrule recomendar-ciudad-ecoturismo
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(<= ?min 3500)) (presupuesto-max ?max&:(<= ?max 3500)) (tipo-viaje ecoturismo) (preferencia ciudad))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Participa en ecoturismo urbano con un presupuesto de hasta " ?max "."))))
)

;; Regla 20: Gastronomía en la selva
(defrule recomendar-selva-gastronomia
    (cliente (nombre ?nombre) (presupuesto-min ?min&:(<= ?min 4000)) (presupuesto-max ?max&:(<= ?max 4000)) (tipo-viaje gastronomía) (preferencia selva))
    =>
    (assert (salida (mensaje (str-cat "Recomendación para " ?nombre ": Disfruta de la gastronomía local en la selva con un presupuesto de hasta " ?max "."))))
)
