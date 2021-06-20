;Header and description

(define (domain cluster)

    ;remove requirements that are not needed
    (:requirements :strips :typing :conditional-effects :negative-preconditions)

    (:types
        worker master - computer
        router switch - network
        ebs bucket - storage
    )

    (:predicates
        ; computer

        ;; worker
        (worker-healthy ?worker - worker)
        (worker-high-mem ?worker - worker)
        (worker-high-cpu ?worker - worker)
        (worker-high-network ?worker - worker)

        ;; master
        (master-healthy ?master - master)

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
        (ebs-attached ?ebs - ebs ?computer - computer)

        ;; bucket
        (bucket-healthy ?bucket - bucket)
        (bucket-locked ?bucket - bucket)
        (bucket-attached ?bucket - bucket ?master - master)

    )

    (:action worker-turn-on
        :parameters (?worker - worker ?switch - switch ?ebs - ebs)
        :precondition (and
            (not (worker-healthy ?worker))
            (ebs-healthy ?ebs)
            (switch-healthy ?switch)
            (not (ebs-locked ?ebs))
            (switch-attach-worker ?switch ?worker)
        )
        :effect (and
            (worker-healthy ?worker)
            (not (worker-high-cpu ?worker))
            (not (worker-high-mem ?worker))
            (not (worker-high-network ?worker))
            (ebs-attached ?ebs ?worker)
            (ebs-locked ?ebs)
        )
    )

    (:action worker-turn-off
        :parameters (?worker - worker ?switch - switch ?ebs - ebs)
        :precondition (and
            (switch-healthy ?switch)
            (switch-attach-worker ?switch ?worker)
            (ebs-attached ?ebs ?worker)
        )
        :effect (and
            (not (ebs-attached ?ebs ?worker))
            (not (ebs-locked ?ebs))
            (not (worker-healthy ?worker))
        )
    )

    (:action master-turn-on
        :parameters (?master - master ?switch - switch ?ebs - ebs ?bucket - bucket)
        :precondition (and
            (not (master-healthy ?master))
            (switch-healthy ?switch)
            (ebs-healthy ?ebs)
            (not (ebs-locked ?ebs))
            (bucket-healthy ?bucket)
            (not (bucket-locked ?bucket))
            (switch-attach-master ?switch ?master)
        )
        :effect (and
            (master-healthy ?master)
            (ebs-attached ?ebs ?master)
            (ebs-locked ?ebs)
            (bucket-attached ?bucket ?master)
            (bucket-locked ?bucket)
        )
    )

    (:action master-turn-off
        :parameters (?master - master ?switch - switch ?ebs - ebs ?bucket - bucket)
        :precondition (and
            (switch-healthy ?switch)
            (switch-attach-master ?switch ?master)
            (ebs-attached ?ebs ?master)
            (bucket-attached ?bucket ?master)
        )
        :effect (and
            (not (ebs-attached ?ebs ?master))
            (not (ebs-locked ?ebs))
            (not (bucket-attached ?bucket ?master))
            (not (bucket-locked ?bucket))
            (not (master-healthy ?master))
        )
    )

    (:action router-turn-on
        :parameters (?router - router)
        :precondition (and
            (not (router-healthy ?router))
        )
        :effect (and
            (router-healthy ?router)
        )
    )

    (:action router-turn-off
        :parameters (?router - router)
        :precondition (and
            (router-healthy ?router)
        )
        :effect (and
            (not (router-healthy ?router))
        )
    )

    (:action router-mesh-on
        :parameters (?router1 ?router2 - router)
        :precondition (and
            (router-healthy ?router1)
            (router-healthy ?router2)
            (not (router-pair ?router1 ?router2))
        )
        :effect (and
            (router-pair ?router1 ?router2)
        )
    )

    (:action router-mesh-off
        :parameters (?router1 ?router2 - router)
        :precondition (and
            (router-healthy ?router1)
            (router-healthy ?router2)
            (router-pair ?router1 ?router2)
        )
        :effect (and
            (not (router-pair ?router1 ?router2))
        )
    )

    (:action switch-turn-on
        :parameters (?switch - switch ?router - router)
        :precondition (and
            (not (switch-healthy ?switch))
            (router-healthy ?router)
        )
        :effect (and
            (switch-healthy ?switch)
            (switch-attach-router ?switch ?router)
        )
    )

    (:action switch-turn-off
        :parameters (?switch - switch ?router - router)
        :precondition (and
            (switch-healthy ?switch)
        )
        :effect (and
            (not (switch-healthy ?switch))
            (not (switch-attach-router ?switch ?router))
        )
    )

    (:action ebs-turn-on
        :parameters (?ebs - ebs)
        :precondition (and
            (not (ebs-healthy ?ebs))
        )
        :effect (and
            (ebs-healthy ?ebs)
            (not (ebs-locked ?ebs))
        )
    )

    (:action ebs-turn-off
        :parameters (?ebs - ebs)
        :precondition (and
            (ebs-healthy ?ebs)
        )
        :effect (and
            (not (ebs-healthy ?ebs))
        )
    )

    (:action bucket-turn-on
        :parameters (?bucket - bucket)
        :precondition (and
            (not (bucket-healthy ?bucket))
        )
        :effect (and
            (bucket-healthy ?bucket)
            (not (bucket-locked ?bucket))
        )
    )

    (:action bucket-turn-off
        :parameters (?bucket - bucket)
        :precondition (and
            (bucket-healthy ?bucket)
        )
        :effect (and
            (not (bucket-healthy ?bucket))
        )
    )

)