;Header and description

(define (domain cluster)

;remove requirements that are not needed
(:requirements :strips :typing :conditional-effects :negative-preconditions :equality)

(:types
    worker master - computer
    router switch - network
    ebs object-storage - storage
    application - system
)

(:predicates
    ; computer
    
    ;; worker
    (worker-healthy ?worker - worker)
    
    ;; master
    (master-healthy ?master - master)
    (master-deploy-apps ?master - master ?worker - worker)

    ; network    
    
    ;; router
    (router-healthy ?router - router)
    (router-pair ?router1 ?router2 - router)
    
    ;; switch
    (switch-healthy ?switch - switch)
    (switch-attach-router ?switch - switch ?router - router)
    (switch-attach-master ?switch - switch ?master - master)
    (switch-attach-worker ?switch - switch ?worker - worker)

    ; storage

    ;; ebs
    (ebs-healthy ?ebs - ebs)
    (ebs-locked ?ebs - ebs)
    (ebs-attached ?computer - computer ?ebs - ebs)

    ;; object-storage
    (bucket-healthy ?bucket - object-storage)
    (bucket-locked ?bucket - object-storage)
    (bucket-attached ?master - master ?bucket - object-storage)

    ; system
    
    ;; application
    (app-healthy ?app - application)
    (app-host ?app - application ?master - master)
)

    (:action worker-turn-on
        :parameters (?worker - worker ?switch - switch ?ebs - ebs)
        :precondition (and 
            (not (worker-healthy ?worker))
            (ebs-healthy ?ebs)
            (not (ebs-locked ?ebs))
            (switch-attach-worker ?switch ?worker)
        )
        :effect (and
            (worker-healthy ?worker)
            (ebs-attached ?worker ?ebs)
            (ebs-locked ?ebs)
        )
    )
    
    (:action worker-turn-off
        :parameters (?worker - worker ?switch - switch ?ebs - ebs)
        :precondition (and
            (switch-attach-worker ?switch ?worker)
            (ebs-attached ?worker ?ebs)
        )
        :effect (and
            (not (ebs-attached ?worker ?ebs))
            (not (ebs-locked ?ebs))
            (not (worker-healthy ?worker))
        )
    )

    (:action master-turn-on
        :parameters (?master - master ?switch - switch ?ebs - ebs ?bucket - object-storage)
        :precondition (and
            (not (master-healthy ?master))
            (ebs-healthy ?ebs)
            (not (ebs-locked ?ebs))
            (bucket-healthy ?bucket)
            (not (bucket-locked ?bucket))
            (switch-attach-master ?switch ?master)
        )
        :effect (and 
            (master-healthy ?master)
            (ebs-attached ?master ?ebs)
            (ebs-locked ?ebs)
            (bucket-attached ?master ?bucket)
            (bucket-locked ?bucket)
        )
    )

    (:action master-turn-off
        :parameters (?master - master ?switch - switch ?ebs - ebs ?bucket - object-storage)
        :precondition (and
            (switch-attach-master ?switch ?master)
            (ebs-attached ?master ?ebs)
            (bucket-attached ?master ?bucket)
        )
        :effect (and
            (not (ebs-attached ?master ?ebs))
            (not (ebs-locked ?ebs))
            (not (bucket-attached ?master ?bucket))
            (not (bucket-locked ?bucket))
            (not (master-healthy ?master))
        )
    )
    
    (:action app-deploy
        :parameters (?app - application ?master - master)
        :precondition (and
            (not (app-healthy ?app))
            (master-healthy ?master)
        )
        :effect (and
            (app-host ?app ?master)
            (app-healthy ?app)
        )
    )
    
)