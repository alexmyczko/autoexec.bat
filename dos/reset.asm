reset: 
     call kbd 
     mov al,0xfe 
     out 0x64,al 

kbd0:   
     jmp short $+2 
     in al,60h 
kbd:
     jmp short $+2 
     in al,64h 
     test al,1 
     jnz kbd0 
     test al,2 
     jnz kbd 
     ret
