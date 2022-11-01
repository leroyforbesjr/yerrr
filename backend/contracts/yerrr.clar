;; Yerrr
;; A mart contract to handle writing a message to the blockchain in exchange for a small fee in STX

;; constants
(define-constant receiver-address 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)

;; data maps and vars
(define-data-var total-yerrrs uint u0)

(define-map messages principal (string-utf8 500))

;; private functions


;; public functions
(define-read-only (get-yerrrs)
    (var-get total-yerrrs)
)

(define-read-only (get-message (who principal))
    (map-get? messages who)
)

(define-public (write-yerrr (message (string-utf8 500)) (price uint))
    (begin
        (try! (stx-transfer? price tx-sender receiver-address))
        
        ;; #[allow(unchecked_data)]
        (map-set messages tx-sender message)
        (var-set total-yerrrs (+ (var-get total-yerrrs) u1))
        (ok "All good! Message was written!")
    )
)