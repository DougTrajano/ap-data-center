(define (problem pb2)
    (:domain cluster)
    (:objects
        ; computers
        tesla newton einstein hawking - master
        w1 w2 w3 w4 w5 w6 w7 w8 w9 w10 w11 w12 - worker

        ; network
        router1 router2 - router
        switch1 switch2 switch3 switch4 - switch

        ; storages
        ebs1 ebs2 ebs3 ebs4 - ebs
        ebs5 ebs6 ebs7 ebs8 - ebs
        ebs9 ebs10 ebs11 ebs12 - ebs
        ebs13 ebs14 ebs15 ebs16 - ebs

        bucket1 bucket2 bucket3 bucket4 - bucket
    )

    (:init
        ; routers
        ( router-healthy router1)
        ( router-healthy router2)
        ( router-pair router1 router2)

        ; tesla
        ( not (master-healthy tesla)) ; issue
        ( not (switch-healthy switch1)) ; issue

        ( not (worker-healthy w1)) ; issue
        ( not (worker-healthy w2)) ; issue
        ( not (worker-healthy w3)) ; issue

        ( not (ebs-healthy ebs1)) ; issue
        ( not (ebs-locked ebs1)) ; issue
        ( not (ebs-healthy ebs2)) ; issue
        ( not (ebs-locked ebs2)) ; issue
        ( not (ebs-healthy ebs3)) ; issue
        ( not (ebs-locked ebs3)) ; issue
        ( not (ebs-healthy ebs4)) ; issue
        ( not (ebs-locked ebs4)) ; issue
        ( not (bucket-healthy bucket1)) ; issue
        ( not (bucket-locked bucket1)) ; issue

        ( switch-attach-router switch1 router1)
        ( switch-attach-master switch1 tesla)
        ( switch-attach-worker switch1 w1)
        ( switch-attach-worker switch1 w2)
        ( switch-attach-worker switch1 w3)
        ( bucket-attached bucket1 tesla)
        ( ebs-attached ebs1 tesla)
        ( ebs-attached ebs2 w1)
        ( ebs-attached ebs3 w2)
        ( ebs-attached ebs4 w3)

        ; newton
        ( master-healthy newton)
        ( switch-healthy switch2)

        ( worker-healthy w4)
        ( worker-healthy w5)
        ( worker-healthy w6)

        ( ebs-healthy ebs5)
        ( ebs-locked ebs5)
        ( ebs-healthy ebs6)
        ( ebs-locked ebs6)
        ( ebs-healthy ebs7)
        ( ebs-locked ebs7)
        ( ebs-healthy ebs8)
        ( ebs-locked ebs8)
        ( bucket-healthy bucket2)
        ( bucket-locked bucket2)

        ( switch-attach-router switch2 router1)
        ( switch-attach-master switch2 newton)
        ( switch-attach-worker switch2 w4)
        ( switch-attach-worker switch2 w5)
        ( switch-attach-worker switch2 w6)
        ( bucket-attached bucket2 newton)
        ( ebs-attached ebs5 newton)
        ( ebs-attached ebs6 w4)
        ( ebs-attached ebs7 w5)
        ( ebs-attached ebs8 w6)

        ; einstein
        ( master-healthy einstein)
        ( switch-healthy switch3)

        ( worker-healthy w7)
        ( worker-healthy w8)
        ( worker-healthy w9)

        ( ebs-healthy ebs9)
        ( ebs-locked ebs9)
        ( ebs-healthy ebs10)
        ( ebs-locked ebs10)
        ( ebs-healthy ebs11)
        ( ebs-locked ebs11)
        ( ebs-healthy ebs12)
        ( ebs-locked ebs12)
        ( bucket-healthy bucket3)
        ( bucket-locked bucket3)

        ( switch-attach-router switch3 router2)
        ( switch-attach-master switch3 einstein)
        ( switch-attach-worker switch3 w7)
        ( switch-attach-worker switch3 w8)
        ( switch-attach-worker switch3 w9)
        ( bucket-attached bucket3 einstein)
        ( ebs-attached ebs9 einstein)
        ( ebs-attached ebs10 w7)
        ( ebs-attached ebs11 w8)
        ( ebs-attached ebs12 w9)

        ; hawking
        ( master-healthy hawking)
        ( switch-healthy switch4)

        ( worker-healthy w10)
        ( worker-healthy w11)
        ( worker-healthy w12)

        ( ebs-healthy ebs13)
        ( ebs-locked ebs13)
        ( ebs-healthy ebs14)
        ( ebs-locked ebs14)
        ( ebs-healthy ebs15)
        ( ebs-locked ebs15)
        ( ebs-healthy ebs16)
        ( ebs-locked ebs16)
        ( bucket-healthy bucket4)
        ( bucket-locked bucket4)

        ( switch-attach-router switch4 router2)
        ( switch-attach-master switch4 hawking)
        ( switch-attach-worker switch4 w10)
        ( switch-attach-worker switch4 w11)
        ( switch-attach-worker switch4 w12)
        ( bucket-attached bucket4 hawking)
        ( ebs-attached ebs13 hawking)
        ( ebs-attached ebs14 w10)
        ( ebs-attached ebs15 w11)
        ( ebs-attached ebs16 w12)
    )

    (:goal
        (and
            ; routers
            ( router-healthy router1)
            ( router-healthy router2)
            ( router-pair router1 router2)

            ; tesla
            ( master-healthy tesla)
            ( switch-healthy switch1)

            ( worker-healthy w1)
            ( not (worker-high-cpu w1))
            ( not (worker-high-mem w1))
            ( not (worker-high-network w1))

            ( worker-healthy w2)
            ( not (worker-high-cpu w2))
            ( not (worker-high-mem w2))
            ( not (worker-high-network w2))

            ( worker-healthy w3)
            ( not (worker-high-cpu w3))
            ( not (worker-high-mem w3))
            ( not (worker-high-network w3))

            ( ebs-healthy ebs1)
            ( ebs-locked ebs1)
            ( ebs-healthy ebs2)
            ( ebs-locked ebs2)
            ( ebs-healthy ebs3)
            ( ebs-locked ebs3)
            ( ebs-healthy ebs4)
            ( ebs-locked ebs4)
            ( bucket-healthy bucket1)
            ( bucket-locked bucket1)

            ( switch-attach-router switch1 router1)
            ( switch-attach-master switch1 tesla)
            ( switch-attach-worker switch1 w1)
            ( switch-attach-worker switch1 w2)
            ( switch-attach-worker switch1 w3)
            ( bucket-attached bucket1 tesla)
            ( ebs-attached ebs1 tesla)
            ( ebs-attached ebs2 w1)
            ( ebs-attached ebs3 w2)
            ( ebs-attached ebs4 w3)

            ; newton
            ( master-healthy newton)
            ( switch-healthy switch2)

            ( worker-healthy w4)
            ( not (worker-high-cpu w4))
            ( not (worker-high-mem w4))
            ( not (worker-high-network w4))

            ( worker-healthy w5)
            ( not (worker-high-cpu w5))
            ( not (worker-high-mem w5))
            ( not (worker-high-network w5))

            ( worker-healthy w6)
            ( not (worker-high-cpu w6))
            ( not (worker-high-mem w6))
            ( not (worker-high-network w6))

            ( ebs-healthy ebs5)
            ( ebs-locked ebs5)
            ( ebs-healthy ebs6)
            ( ebs-locked ebs6)
            ( ebs-healthy ebs7)
            ( ebs-locked ebs7)
            ( ebs-healthy ebs8)
            ( ebs-locked ebs8)
            ( bucket-healthy bucket2)
            ( bucket-locked bucket2)

            ( switch-attach-router switch2 router1)
            ( switch-attach-master switch2 newton)
            ( switch-attach-worker switch2 w4)
            ( switch-attach-worker switch2 w5)
            ( switch-attach-worker switch2 w6)
            ( bucket-attached bucket2 newton)
            ( ebs-attached ebs5 newton)
            ( ebs-attached ebs6 w4)
            ( ebs-attached ebs7 w5)
            ( ebs-attached ebs8 w6)

            ; einstein
            ( master-healthy einstein)
            ( switch-healthy switch3)

            ( worker-healthy w7)
            ( not (worker-high-cpu w7))
            ( not (worker-high-mem w7))
            ( not (worker-high-network w7))

            ( worker-healthy w8)
            ( not (worker-high-cpu w8))
            ( not (worker-high-mem w8))
            ( not (worker-high-network w8))

            ( worker-healthy w9)
            ( not (worker-high-cpu w9))
            ( not (worker-high-mem w9))
            ( not (worker-high-network w9))

            ( ebs-healthy ebs9)
            ( ebs-locked ebs9)
            ( ebs-healthy ebs10)
            ( ebs-locked ebs10)
            ( ebs-healthy ebs11)
            ( ebs-locked ebs11)
            ( ebs-healthy ebs12)
            ( ebs-locked ebs12)
            ( bucket-healthy bucket3)
            ( bucket-locked bucket3)

            ( switch-attach-router switch3 router2)
            ( switch-attach-master switch3 einstein)
            ( switch-attach-worker switch3 w7)
            ( switch-attach-worker switch3 w8)
            ( switch-attach-worker switch3 w9)
            ( bucket-attached bucket3 einstein)
            ( ebs-attached ebs9 einstein)
            ( ebs-attached ebs10 w7)
            ( ebs-attached ebs11 w8)
            ( ebs-attached ebs12 w9)

            ; hawking
            ( master-healthy hawking)
            ( switch-healthy switch4)

            ( worker-healthy w10)
            ( not (worker-high-cpu w10))
            ( not (worker-high-mem w10))
            ( not (worker-high-network w10))

            ( worker-healthy w11)
            ( not (worker-high-cpu w11))
            ( not (worker-high-mem w11))
            ( not (worker-high-network w11))

            ( worker-healthy w12)
            ( not (worker-high-cpu w12))
            ( not (worker-high-mem w12))
            ( not (worker-high-network w12))

            ( ebs-healthy ebs13)
            ( ebs-locked ebs13)
            ( ebs-healthy ebs14)
            ( ebs-locked ebs14)
            ( ebs-healthy ebs15)
            ( ebs-locked ebs15)
            ( ebs-healthy ebs16)
            ( ebs-locked ebs16)
            ( bucket-healthy bucket4)
            ( bucket-locked bucket4)

            ( switch-attach-router switch4 router2)
            ( switch-attach-master switch4 hawking)
            ( switch-attach-worker switch4 w10)
            ( switch-attach-worker switch4 w11)
            ( switch-attach-worker switch4 w12)
            ( bucket-attached bucket4 hawking)
            ( ebs-attached ebs13 hawking)
            ( ebs-attached ebs14 w10)
            ( ebs-attached ebs15 w11)
            ( ebs-attached ebs16 w12)
        )
    )
)