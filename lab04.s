
.globl str_ge, recCheck

.data

maria:    .string "Maria"
markos:   .string "Markos"
marios:   .string "Marios"
marianna: .string "Marianna"

.align 4  # make sure the string arrays are aligned to words (easier to see in ripes memory view)

# These are string arrays
# The labels below are replaced by the respective addresses
arraySorted:    .word maria, marianna, marios, markos

arrayNotSorted: .word marianna, markos, maria

.text

            la   a0, arrayNotSorted
            li   a1, 4
            jal  recCheck

            li   a7, 10
            ecall

str_ge:
#---------
# Write the subroutine code here
#  You may move jr ra   if you wish.
#---------
 
str_ge:
          lb t0 0(a0) # fortwse a0 sto t0 
          lb t1 0(a1) # fortwse a1 sto t1
          beq t0, zero, equalfinish # an t0 == 0 elegkse kai t1
          beq t1, zero, greater # an t1 == 0
          bgt t0, t1, greater # t0>t1, go greater
          blt t0, t1, less # t0<t1, go less
          addi a0, a0 ,1 # +1
          addi a1, a1 ,1 # +1
          
          j str_ge 
          

equalfinish:
          
          beq t1, zero, equal 
          j less         
          
equal:
          addi a0, zero, 1 
          
          
          jr ra
greater:
           
           
          addi a0, zero, 1 #
          jr ra
          
less:
          addi a0, zero, 1 #
          jr 
           
           
# ----------------------------------------------------------------------------
# recCheck(array, size)
# if size == 0 or size == 1
#     return 1
# if str_ge(array[1], array[0])      # if first two items in ascending order,
#     return recCheck(&(array[1]), size-1)  # check from 2nd element onwards
# else
#     return 0

recCheck:
#---------
# Write the subroutine code here
#  You may move jr ra   if you wish.
#---------
regCheck:
          addi t0, a1, -1 # t0 = size-1 
          blez t0, case1 # size <= 1, go sorted
 
 
          lw t1, 0(a0) #  fortwse a0 sto t1
          lw t2, 4(a0) #  fortwse a0 sto t2
  
          add a0, t1, zero # dieu8insi prwtou string
          add a1, t2, zero # dieu8insi prwtou string 
          jal ra, str_ge #
          
          beq a0, zero , case2 # an to a0 einai 0 , tote den einai taksinomimeno ara phgainei case2
          
            
            

          addi a0, a0, 4 # epomeno stoixeio
          
          addi a1, a1, -1 # meiwse megethos kata 1
          
          jal ra, recCheck # anadromh
          
          
          


case1:
          addi a0, zero, 1 # epistrefei 1 pinakas taksinomimenos 
          jr  ra

case2:
          
          addi a0, zero, 1 # epistrefei 0 pinakas oxi taksinomimenos 
          jr ra