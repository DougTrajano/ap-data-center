(define (problem pb1)
    (:domain cloud)
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
    
    bucket1 bucket2 bucket3 bucket4 - object-storage

    ; systems
    app1 app2 app3 app4 app5 - application
    app6 app7 app8 app9 app10 - application
    app11 app12 app13 app14 app15 - application
    app16 app17 app18 app19 app20 - application
    app21 app22 app23 app24 app25 - application
    app26 app27 app28 app29 app30 - application
    app31 app32 app33 app34 app35 - application
    app36 app37 app38 app39 app40 - application

    )

    (:init
        ;todo: put the initial state's facts and numeric values here
        
        ; routers
        ( router-healthy router1)
        ( router-healthy router2)
        ( router-pair router1 router2)

        ; tesla
        ( master-healthy tesla)
        ( switch-healthy switch1)
        ( switch-attach-router switch1 router1)
        ( switch-attach-master switch1 tesla)
        

        ; ebs
        ( ebs-healthy ebs1)
        ( not ( ebs-locked ebs1))
        ( ebs-healthy ebs2)
        ( not ( ebs-locked ebs2))
        ( ebs-healthy ebs3)
        ( not ( ebs-locked ebs3))
        ( ebs-healthy ebs4)
        ( not ( ebs-locked ebs4))
        ( ebs-healthy ebs5)
        ( not ( ebs-locked ebs5))
        ( ebs-healthy ebs6)
        ( not ( ebs-locked ebs6))
        ( ebs-healthy ebs7)
        ( not ( ebs-locked ebs7))
        ( ebs-healthy ebs8)
        ( not ( ebs-locked ebs8))
        ( ebs-healthy ebs9)
        ( not ( ebs-locked ebs9))
        ( ebs-healthy ebs10)
        ( not ( ebs-locked ebs10))
        ( ebs-healthy ebs11)
        ( not ( ebs-locked ebs11))
        ( ebs-healthy ebs12)
        ( not ( ebs-locked ebs12))
        ( ebs-healthy ebs13)
        ( not ( ebs-locked ebs13))
        ( ebs-healthy ebs14)
        ( not ( ebs-locked ebs14))
        ( ebs-healthy ebs15)
        ( not ( ebs-locked ebs15))
        ( ebs-healthy ebs16)
        ( not ( ebs-locked ebs16))

        ; bucket
        ( bucket-healthy bucket1)
        ( not ( bucket-locked bucket1))
        ( bucket-healthy bucket2)
        ( not ( bucket-locked bucket2))
        ( bucket-healthy bucket3)
        ( not ( bucket-locked bucket3))
        ( bucket-healthy bucket4)
        ( not ( bucket-locked bucket4))
    )

    (:goal
        (and
            ;todo: put the goal condition here
        )
    )

    ;un-comment the following line if metric is needed
    ;(:metric minimize (???))
)