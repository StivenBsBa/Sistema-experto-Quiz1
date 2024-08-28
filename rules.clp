(defrule recommend-beach
    (client (preference beach))
    =>
    (assert (destination (name "Hawaii") (type beach) (price 1200)))
    (assert (destination (name "Maldives") (type beach) (price 1500)))
)

(defrule recommend-mountain
    (client (preference mountain))
    =>
    (assert (destination (name "Swiss Alps") (type mountain) (price 1400)))
    (assert (destination (name "Rocky Mountains") (type mountain) (price 1300)))
)

(defrule recommend-city
    (client (preference city))
    =>
    (assert (destination (name "New York") (type city) (price 1000)))
    (assert (destination (name "Tokyo") (type city) (price 1400)))
)

(defrule recommend-adventure
    (client (preference adventure))
    =>
    (assert (destination (name "Amazon Rainforest") (type adventure) (price 1100)))
    (assert (destination (name "Patagonia") (type adventure) (price 1600)))
)

(defrule recommend-culture
    (client (preference culture))
    =>
    (assert (destination (name "Rome") (type culture) (price 1200)))
    (assert (destination (name "Kyoto") (type culture) (price 1300)))
)

(defrule budget-filter
    (client (budget ?budget))
    (destination (name ?name) (type ?type) (price ?price))
    (test (<= ?price ?budget))
    =>
    (printout t "Recommended destination: " ?name crlf)
)

(defrule no-recommendation
    (client (budget ?budget))
    (not (destination (price ?price) (test (<= ?price ?budget))))
    =>
    (printout t "No destinations available within your budget." crlf)
)

(defrule recommend-luxury-beach
    (client (preference beach) (budget ?budget))
    (test (> ?budget 2000))
    =>
    (assert (destination (name "Bora Bora") (type beach) (price 2500)))
)

(defrule recommend-budget-city
    (client (preference city) (budget ?budget))
    (test (<= ?budget 800))
    =>
    (assert (destination (name "Bangkok") (type city) (price 700)))
)

(defrule recommend-wildlife-adventure
    (client (preference adventure))
    =>
    (assert (destination (name "Serengeti") (type adventure) (price 1800)))
)
