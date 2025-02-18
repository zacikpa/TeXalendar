for signature in range(7):
    for p in [16,1,2,15,14,3,4,13,12,5,6,11,10,7,8,9]:
        print(p + 16 * signature, end = ",")
    print()